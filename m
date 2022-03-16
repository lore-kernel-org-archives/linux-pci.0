Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F51C433FE
	for <linux-pci@archiver.kernel.org>; Wed, 16 Mar 2022 04:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347897AbiCPEPN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Mar 2022 00:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbiCPEPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B734662;
        Tue, 15 Mar 2022 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404038; x=1678940038;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S6z3Dqt2+Gnw13+ORdVS1nQd9F97flyxW1Nnt/toTGE=;
  b=adtfe+3DHW0a8f7EfYTkUk7TMMrVylwUHPmbqgj2Y42hPSLu5jApVs1p
   po/nnn++TFlL9qEX9KlU5QdGXdsL7yQf5ftu5PvKPuB4tH3drGlHsieWf
   9CwTE8a8yR665w9Foluq+qV8aFrj2Bucn6NwMnmEkMbOfdFDCC5maYhEd
   tc3kttxBnLjN7P9QykDfhhGQiNRvpYllEJUZ/vTuZYNLKiXbbKn9j2uhb
   BdMLgG0hZ+peAFT2uJmmScm6c76aMUoldGSCk40ObW+E7U/JgCFQrDoVg
   Ng7pCB/dY1xNmu32YW2aYlrrr17yMlHAOfoNOHHhaQwIzX/W0H9ncHdsZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281265839"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="281265839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="644514748"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:58 -0700
Subject: [PATCH 3/8] cxl/pci: Kill cxl_map_regs()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:13:58 -0700
Message-ID: <164740403796.3912056.13648238900454640514.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The component registers are currently unused by the cxl_pci driver.
Only the physical address base of the component registers is conveyed to
the cxl_mem driver. Just call cxl_map_device_registers() directly.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 994c79bf6afd..0efbb356cce0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -346,27 +346,6 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
 	return 0;
 }
 
-static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *map)
-{
-	struct device *dev = cxlds->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	switch (map->reg_type) {
-	case CXL_REGLOC_RBI_COMPONENT:
-		cxl_map_component_regs(pdev, &cxlds->regs.component, map);
-		dev_dbg(dev, "Mapping component registers...\n");
-		break;
-	case CXL_REGLOC_RBI_MEMDEV:
-		cxl_map_device_regs(pdev, &cxlds->regs.device_regs, map);
-		dev_dbg(dev, "Probing device registers...\n");
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			  struct cxl_register_map *map)
 {
@@ -599,7 +578,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_regs(cxlds, &map);
+	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
 	if (rc)
 		return rc;
 

