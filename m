Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp02.br.ibm.com ([32.104.18.86]:39990 "EHLO
	e24smtp02.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab3CTFZX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2013 01:25:23 -0400
Received: from /spool/local
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Wed, 20 Mar 2013 02:25:21 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id E0C4C3520064
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 01:25:02 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2K5Mqjs2138332
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 02:22:52 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2K5P1Kk029675
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 02:25:02 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org
Cc: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@linux.ie>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Brian King <brking@linux.vnet.ibm.com>,
	Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCHv2 0/3] PCI Speed Cap Fixes for ppc64
Date: Wed, 20 Mar 2013 02:24:36 -0300
Message-Id: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series first implements a function called pcie_get_speed_cap_mask 
in the PCI subsystem based off from drm_pcie_get_speed_cap_mask in drm. Then 
it removes the latter and fixes all references to it. And ultimately, it
implements an architecture-specific version of the same function for ppc64.

The refactor is done because the function that was used by drm is more 
architecture goo than module-specific. Whilst the function also needed a 
platform-specific implementation to get PCIE Gen2 speeds on ppc64.

Lucas Kannebley Tavares (3):
  pci: added pcie_get_speed_cap_mask function
  drm: removed drm_pcie_get_speed_cap_mask function
  ppc64: implemented pcibios_get_speed_cap_mask

 arch/powerpc/platforms/pseries/pci.c |   35 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_pci.c            |   38 -----------------------------
 drivers/gpu/drm/radeon/evergreen.c   |    5 ++-
 drivers/gpu/drm/radeon/r600.c        |    5 ++-
 drivers/gpu/drm/radeon/rv770.c       |    5 ++-
 drivers/pci/pci.c                    |   44 ++++++++++++++++++++++++++++++++++
 include/drm/drmP.h                   |    6 ----
 include/linux/pci.h                  |    6 ++++
 8 files changed, 94 insertions(+), 50 deletions(-)

-- 
1.7.4.4

