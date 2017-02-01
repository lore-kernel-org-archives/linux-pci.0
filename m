Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 0/2] drm amdgpu/radeon: clean up d3_delay usage
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@canonical.com>,
        Andreas Boll <andreas.boll.dev@gmail.com>
Date: Wed, 01 Feb 2017 10:22:11 -0600
Message-ID: <20170201162020.24314.27094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

amdgpu doesn't need to touch pdev->d3_delay at all.

radeon has a d3_delay quirk for MacBook Pro, but it only affects
radeon_switcheroo_set_state().  I think it should affect wakeups done by
the PCI core as well.

Changes from v1 to v2:
  - Fix accidental removal of "{ 0, 0, 0, 0, 0 }" quirk list termination
    (thanks, Andreas Boll!)
  - Add ack from Alex Deucher
---

Bjorn Helgaas (2):
      drm/amdgpu: remove unnecessary save/restore of pdev->d3_delay
      drm/radeon: make MacBook Pro d3_delay quirk more generic


 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    4 ----
 drivers/gpu/drm/radeon/radeon_device.c     |   11 -----------
 drivers/pci/quirks.c                       |   13 +++++++++++++
 3 files changed, 13 insertions(+), 15 deletions(-)
