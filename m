Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:40538 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab2LVTCI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 22 Dec 2012 14:02:08 -0500
Received: from /spool/local
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Sat, 22 Dec 2012 17:02:07 -0200
Message-ID: <50D6039D.4000001@linux.vnet.ibm.com>
Date: Sat, 22 Dec 2012 17:01:49 -0200
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	brking@linux.vnet.ibm.com, benh@au1.ibm.com,
	Betty Dall <betty.dall@hp.com>,
	Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: [PATCH] drm: fixed access to PCI host bridges
References: <50CA5EE2.30206@linux.vnet.ibm.com> <CAErSpo6BfWGYH+=ygS6qWT-YFKPuywooVgLWm+g_eB2dMw3iKQ@mail.gmail.com> <50D60349.7080400@linux.vnet.ibm.com>
In-Reply-To: <50D60349.7080400@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During the process of obtaining the speed cap for the device, it
attempts go get the PCI Host bus. However on architectures such as PPC
or IA64, those do not appear as devices.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
  drivers/gpu/drm/drm_pci.c |    5 +++++
  1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 754bc96..ea41234 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -479,8 +479,13 @@ int drm_pcie_get_speed_cap_mask(struct drm_device 
*dev, u32 *mask)
  	if (!pci_is_pcie(dev->pdev))
  		return -EINVAL;

+	// find PCI device for capabilities
  	root = dev->pdev->bus->self;

+	// some architectures might not have host bridges as PCI devices
+	if (root == NULL)
+		root = dev->pdev;
+
  	pos = pci_pcie_cap(root);
  	if (!pos)
  		return -EINVAL;

-- 
Lucas Kannebley Tavares
Software Engineer
IBM Linux Technology Center

