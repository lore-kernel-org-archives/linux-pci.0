Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38540 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeFYVGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 17:06:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id c5-v6so2522784qth.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2018 14:06:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: update amd_pcie.h to include gen4 speeds
Date: Mon, 25 Jun 2018 16:06:03 -0500
Message-Id: <20180625210606.2736-3-alexander.deucher@amd.com>
In-Reply-To: <20180625210606.2736-1-alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Internal header used by the driver to specify pcie gen
speeds of the asic and chipset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_pcie.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_pcie.h b/drivers/gpu/drm/amd/include/amd_pcie.h
index 5eb895fd98bf..9cb9ceb4d74d 100644
--- a/drivers/gpu/drm/amd/include/amd_pcie.h
+++ b/drivers/gpu/drm/amd/include/amd_pcie.h
@@ -27,6 +27,7 @@
 #define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1        0x00010000
 #define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2        0x00020000
 #define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3        0x00040000
+#define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4        0x00080000
 #define CAIL_PCIE_LINK_SPEED_SUPPORT_MASK        0xFFFF0000
 #define CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT       16
 
@@ -34,6 +35,7 @@
 #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN1   0x00000001
 #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2   0x00000002
 #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3   0x00000004
+#define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4   0x00000008
 #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_MASK   0x0000FFFF
 #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_SHIFT  0
 
-- 
2.13.6
