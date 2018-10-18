Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E77C67863
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 23:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BA12098A
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 23:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BA12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJSHJM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:09:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:48659 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeJSHJM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 03:09:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 16:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="98670054"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2018 16:05:58 -0700
Date:   Thu, 18 Oct 2018 17:03:13 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/AER: Enable error reporting for all ports
Message-ID: <20181018230312.GB23301@localhost.localdomain>
References: <153989603841.78375.436243401553964151.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153989603841.78375.436243401553964151.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 18, 2018 at 03:53:58PM -0500, Bjorn Helgaas wrote:
> Change the AER service driver so it binds to *all* PCIe Ports, including
> Switch Upstream and Downstream Ports.  Enable AER error reporting for all
> these Ports, but not for any children.

I'm looking at this again and think enabling/disabling error reporting for
ports is the responsibility of the port driver, not the AER service.

The following should do the same as this patch, but without making AER
driver handle non-root ports.  The report enabling/disabling functions
are already stubbed for '!CONFIG_PCIE_AER' and have checks for aer_cap
and firmware first.

A real patch for this could even make this remove all the aer specific
error report enabling, so it'd be a net-loss in code lines. :)

---
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0acca3596807..f129a33c8303 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -122,12 +122,13 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		pm_runtime_put_autosuspend(&dev->dev);
 		pm_runtime_allow(&dev->dev);
 	}
-
+	pci_enable_pcie_error_reporting(dev);
 	return 0;
 }
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
+	pci_disable_pcie_error_reporting(dev);
 	if (pci_bridge_d3_possible(dev)) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
--
