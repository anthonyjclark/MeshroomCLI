#!/usr/bin/env sh

# Photogrammetry pipline (https://github.com/alicevision/meshroom/blob/develop/meshroom/multiview.py)
    # SfM pipeline
        # 01 cameraInit,
        # 02 featureExtraction,
        # 03 imageMatching,
        # 04 featureMatching,
        # 05 structureFromMotion
    # MVS pipeline
        # 06 prepareDenseScene,
        # 07 depthMap,
        # 08 depthMapFilter,
        # 09 meshing,
        # 10 meshFiltering,
        # 11 texturing

# Parameters for all steps
VerboseLevel="info"


# Step 01
ImageFolder="../dataset_monstree/mini6/"
SfMDataFile="cameraInit.sfm"

# aliceVision_cameraInit          \
#     --imageFolder $ImageFolder  \
#     --output $SfMDataFile       \
#     --sensorDatabase ""         \
#     --defaultFieldOfView 45.0   \
#     --allowSingleView 1         \
#     --verboseLevel $VerboseLevel


# Step 02
# TODO: output, forceCpuExtraction?, rangeSize

# aliceVision_featureExtraction   \
#     --input $SfMDataFile        \
#     --output .                  \
#     --forceCpuExtraction 1      \
#     --rangeStart 0              \
#     --rangeSize 6               \
#     --verboseLevel $VerboseLevel


# Step 03
# TODO: featuresFolder
ImagePairList="imageMatches.txt"

# aliceVision_imageMatching       \
#     --input $SfMDataFile        \
#     --featuresFolder .          \
#     --output $ImagePairList     \
#     --verboseLevel $VerboseLevel


# Step 04
# TODO: output (overwrites previous $ImagePairList? and cameraInit.sfm?), featuresFolder

# aliceVision_featureMatching             \
#     --input $SfMDataFile                \
#     --output .                          \
#     --featuresFolders .                 \
#     --imagePairsList $ImagePairList     \
#     --verboseLevel $VerboseLevel


# Step 05
# TODO: useLocalBA?, featuresFolders, mathcesFolders, extraInfoFolder, lockScenePreviouslyReconstructed?
SfMBundleFile="bundle.sfm"
ViewsAndPosesFile="cameras.sfm"

# aliceVision_incrementalSfM                      \
#     --input $SfMDataFile                        \
#     --output $SfMBundleFile                     \
#     --featuresFolders .                         \
#     --matchesFolders .                          \
#     --outputViewsAndPoses $ViewsAndPosesFile    \
#     --extraInfoFolder .                         \
#     --useLocalBA 1                              \
#     --lockScenePreviouslyReconstructed 0        \
#     --verboseLevel $VerboseLevel


# Step 06
# TODO: output

# aliceVision_prepareDenseScene   \
#     --input $SfMBundleFile      \
#     --output .                  \
#     --verboseLevel $VerboseLevel


######### # Step 06 <-- no longer used?
######### aliceVision_cameraConnection
#########     --verboseLevel info
#########     --ini "blah/05_PrepareDenseScene/mvs.ini"

# Step 07
# TODO: input (which sfm file), imagesFolder, output, rangeStart, rangeSize
aliceVision_depthMapEstimation \
    --input ? \
    --imagesFolder ? \
    --output . \
    --verboseLevel $VerboseLevel

# --rangeStart 0
# --rangeSize 3
# --ini "blah/05_PrepareDenseScene/mvs.ini"

# DepthMap Group 1/2: 3, 3
# aliceVision_depthMapEstimation --sgmGammaC 5.5 --sgmWSH 4 --refineGammaP 8.0 --refineSigma 15 --refineNSamplesHalf 150 --sgmMaxTCams 10 --refineWSH 3 --downscale 2 --refineMaxTCams 6 --verboseLevel info --refineGammaC 15.5 --sgmGammaP 8.0 --refineNiters 100 --refineNDepthsToRefine 31 --refineUseTcOrRcPixSize False --ini "blah/05_PrepareDenseScene/mvs.ini" --output "blah/07_DepthMap" --rangeStart 3 --rangeSize 3

# Step 08
# aliceVision_depthMapFiltering --minNumOfConsistensCamsWithLowSimilarity 4 --minNumOfConsistensCams 3 --verboseLevel info --pixSizeBall 0 --pixSizeBallWithLowSimilarity 0 --nNearestCams 10 --ini "blah/05_PrepareDenseScene/mvs.ini" --output "blah/08_DepthMapFilter" --depthMapFolder "blah/07_DepthMap"

# Step 09
# aliceVision_meshing --simGaussianSizeInit 10.0 --maxInputPoints 50000000 --repartition multiResolution --simGaussianSize 10.0 --simFactor 15.0 --voteMarginFactor 4.0 --contributeMarginFactor 2.0 --minStep 2 --pixSizeMarginFinalCoef 4.0 --maxPoints 5000000 --maxPointsPerVoxel 1000000 --angleFactor 15.0 --partitioning singleBlock --minAngleThreshold 1.0 --pixSizeMarginInitCoef 2.0 --refineFuse True --verboseLevel info --ini "blah/05_PrepareDenseScene/mvs.ini" --depthMapFilterFolder "blah/08_DepthMapFilter" --depthMapFolder "blah/07_DepthMap" --output "blah/09_Meshing/mesh.obj"

# Step 10
# aliceVision_meshFiltering --verboseLevel info --removeLargeTrianglesFactor 60.0 --iterations 5 --keepLargestMeshOnly True --lambda 1.0 --input "blah/09_Meshing/mesh.obj" --output "blah/10_MeshFiltering/mesh.obj"

# Step 11
# aliceVision_texturing --textureSide 8192 --downscale 2 --verboseLevel info --padding 15 --unwrapMethod Basic --outputTextureFileType png --flipNormals False --fillHoles False --inputDenseReconstruction "blah/09_Meshing/denseReconstruction.bin" --inputMesh "blah/10_MeshFiltering/mesh.obj" --ini "blah/05_PrepareDenseScene/mvs.ini" --output "blah/11_Texturing"
