Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34663 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeCMVys (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 17:54:48 -0400
Date: Wed, 14 Mar 2018 05:53:58 +0800
From: kbuild test robot <lkp@intel.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: kbuild-all@01.org, hch@lst.de, robin.murphy@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        m.szyprowski@samsung.com, bhelgaas@google.com,
        dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
        jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
        johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [RFC PATCH] dma-mapping: platform_dma_configure() can be static
Message-ID: <20180313215358.GA20099@lkp-wsm-ep1>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 9a019f425175 ("dma-mapping: move dma configuration to bus infrastructure")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index adf94eb..dc9c790 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1130,7 +1130,7 @@ int platform_pm_restore(struct device *dev)
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
-int platform_dma_configure(struct device *dev)
+static int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
 	int ret = 0;
@@ -1146,7 +1146,7 @@ int platform_dma_configure(struct device *dev)
 	return ret;
 }
 
-void platform_dma_deconfigure(struct device *dev)
+static void platform_dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
 	acpi_dma_deconfigure(dev);
