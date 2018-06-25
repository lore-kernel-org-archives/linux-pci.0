Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38536 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeFYVGQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2018 17:06:16 -0400
Received: by mail-qt0-f194.google.com with SMTP id c5-v6so2522684qth.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2018 14:06:15 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/5] drm: use core pcie functionality for pcie gen/width
Date: Mon, 25 Jun 2018 16:06:01 -0500
Message-Id: <20180625210606.2736-1-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series exports some pcie helper functions for use by drivers and
fixes up the amdgpu and radeon drivers to use this core functionality
rather than the duplicated functionality in the drm.  Finally we remove
the drm helpers since the duplicate the pcie functionality of the core.
This also adds proper pcie gen4 detection for amdgpu.

Alex Deucher (5):
  pci: export pcie_get_speed_cap and pcie_get_width_cap
  drm/amdgpu: update amd_pcie.h to include gen4 speeds
  drm/amdgpu: use pcie functions for link width and speed
  drm/radeon: use pcie functions for link width
  drm: drop drm_pcie_get_speed_cap_mask and drm_pcie_get_max_link_width

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 83 +++++++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    |  7 ++-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  3 +-
 drivers/gpu/drm/amd/include/amd_pcie.h     |  2 +
 drivers/gpu/drm/drm_pci.c                  | 58 ---------------------
 drivers/gpu/drm/radeon/ci_dpm.c            | 20 +++++--
 drivers/gpu/drm/radeon/cik.c               | 22 ++++----
 drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
 drivers/gpu/drm/radeon/radeon.h            |  4 ++
 drivers/gpu/drm/radeon/si.c                | 22 ++++----
 drivers/gpu/drm/radeon/si_dpm.c            | 20 +++++--
 drivers/pci/pci.c                          |  2 +
 include/drm/drm_pci.h                      |  7 ---
 include/linux/pci.h                        |  3 ++
 15 files changed, 132 insertions(+), 128 deletions(-)

-- 
2.13.6
