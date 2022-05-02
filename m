Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC1C433EF
	for <linux-pci@archiver.kernel.org>; Mon,  2 May 2022 15:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiEBP5m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 May 2022 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEBP5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 11:57:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CDF6155
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651506852; x=1683042852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qoz3iTWhlFjjxtR0HCzqo1bjdBwAmPkkKQujNoMqefM=;
  b=jph5n+Pi6eEI9xLUXH9TbweOGaGmy08nSpWTGu7EUm83NGrVjS5kU0/F
   Fi6X7eGbIpjixQwvKvITrfN+BN1yigCuizsrnj+Y/tB6lUiClEPp9OMrw
   ESmMj501JIl/0FE2u/MGcAaFKDIgH1iII6yPu/9IVhP34xT2HwMeC1ex8
   gWeHtx0H0NJwOGcISIaBdv6zOnX5jDXdPtwqcQrWg8OhPrLPtqKQeSMXK
   pWZjIYMoE+Ii9DB8b+4LARof+usn/uTWJIbQKaw9onpy0kzZmA8zTag7m
   18TvWkmL4cK5X5JBTahILIGIzqZacidOmMK+Acrr2Fkw3fkHlGb4Db+M+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267398625"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="267398625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:54:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583761585"
Received: from unknown (HELO azvmdlinux1.ch.intel.com) ([10.2.230.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:54:00 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH 0/2] PCI: vmd: IRQ domain assignment to sub devices
Date:   Mon,  2 May 2022 01:48:58 -0700
Message-Id: <20220502084900.7903-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make sure VMD assigns proper IRQ domain to the child devices during
device enumeration. DMAR errors were observed when interrupt remapping
is enabled by intel_iommu because of the fact that VMD child devices
are on different IRQ domain than all other PCI devices.

Nirmal Patel (2):
  PCI: vmd: Assign VMD IRQ domain before enumeration
  PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X
    remapping if interrupt remapping is enabled by IOMMU.")

 drivers/pci/controller/vmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.26.2

