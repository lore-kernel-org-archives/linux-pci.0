Return-Path: <SRS0=uEhh=YS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C72FCA9EBD
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3275721D81
	for <linux-pci@archiver.kernel.org>; Fri, 25 Oct 2019 13:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393643AbfJYNLa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:11:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:52736 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbfJYNLa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 09:11:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 06:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="198019323"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2019 06:11:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iNzNH-0005AV-1v; Fri, 25 Oct 2019 21:11:27 +0800
Date:   Fri, 25 Oct 2019 21:11:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     kbuild-all@lists.01.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [RFC PATCH] dwc: PCI: intel: intel_pcie_msi_init() can be static
Message-ID: <20191025131126.pp3k6nnwp7ee5mnb@4978f4969bb8>
References: <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Fixes: 3686a0f46840 ("dwc: PCI: intel: PCIe RC controller driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 pcie-intel-gw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 9142c70db8085..352d0d03171b2 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -494,13 +494,13 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
 	return intel_pcie_host_setup(lpp);
 }
 
-int intel_pcie_msi_init(struct pcie_port *pp)
+static int intel_pcie_msi_init(struct pcie_port *pp)
 {
 	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
 	return 0;
 }
 
-u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
+static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
 {
 	return cpu_addr + BUS_IATU_OFFS;
 }
