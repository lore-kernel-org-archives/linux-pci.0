Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jcornwall.me ([50.116.27.114]:50008 "EHLO jcornwall.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375AbbHJSrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Aug 2015 14:47:22 -0400
Received: from jcornwall.me (localhost.localdomain [127.0.0.1])
	by jcornwall.me (Postfix) with ESMTP id 2807C75B47
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 13:36:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 10 Aug 2015 13:36:46 -0500
From: Jay Cornwall <jay@jcornwall.me>
To: linux-pci@vger.kernel.org
Subject: PCIe 3.0 AtomicOp capabilities
Message-ID: <8c1e7f957cc5a6f0404b883c864b5145@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

There is some interest in using the PCIe 3.0 AtomicOp capability with a 
subset of devices supported by drm/amdgpu.

Adding this line to drm/amdgpu produced correct results in our tests:
pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, 0x40);

I have found only a handful of examples of capability use throughout 
drivers/. I see that the ARI capability is enabled if supported in 
drivers/pci/pci.c.

Should the AtomicOp capabilities be similarly enabled if available? Or 
might there be a reason for doing this on a per-driver basis?

-- 
Jay Cornwall
