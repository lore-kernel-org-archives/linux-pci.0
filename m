Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA89BC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FF2206DF
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SbYu6uHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDDLHO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:07:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41174 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfDDLHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 07:07:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34B7BIJ004918;
        Thu, 4 Apr 2019 06:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554376031;
        bh=9tFid7GAFl4WBXUVODa7Qf7LACXLRB23ou6j+MpxgOU=;
        h=From:To:CC:Subject:Date;
        b=SbYu6uHKWYiKU2iO3s66aHgp5Zjq/bPOEAfNpqRe9pNjieWs95P5hiVJ3eUQNniDj
         mQT7qY+5shNB21Qwttiah3gNkn/OO2s/X/2N0ks65/doFuB9iviQV3ICo8vBCIuCNc
         U3yRBPMyO0+2htVmJA0kGkKwn516LTjBg1jsFz7E=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34B7A2t077329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 06:07:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 06:07:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 06:07:10 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34B78dU106541;
        Thu, 4 Apr 2019 06:07:09 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/2] tools: Fixes for pcitest
Date:   Thu, 4 Apr 2019 16:36:07 +0530
Message-ID: <20190404110609.26158-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

This series includes a couple of patches, one which fixes
inadvertent removal of pcitest.sh from kernel repo when
doing a "clean" and other lets the user use 'h' option to
display the list of options supported by pcitest.

Thanks
Kishon

Kishon Vijay Abraham I (2):
  tools: PCI: Add 'h' in optstring of getopt()
  tools: PCI: Handle pcitest.sh independently from pcitest

 tools/pci/Makefile  | 8 +++++++-
 tools/pci/pcitest.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.17.1

