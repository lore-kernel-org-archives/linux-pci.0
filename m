Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67318C07E9D
	for <linux-pci@archiver.kernel.org>; Mon, 26 Sep 2022 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIZSKL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiIZSJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:09:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB51F61D
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 10:55:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28QHthQf097060;
        Mon, 26 Sep 2022 12:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664214943;
        bh=UdR3bIkAnTA+v1r1BDJ+WSGiuxRccrB018S2Y/swOvw=;
        h=From:To:CC:Subject:Date;
        b=i34E6avv0ThKMGu1u9f7gZtDGOvGux7jg8ulaYMnblaiQ1OGiz9AqvizLbeVobmXP
         of2/u2A3WXhwE7ZBCnisc4n6VN7UIsFXSf8wx2iuqGFn7WKdpu5JRJ8cTy488pgJPX
         w6A0SqwVTtqQsDEwghaSeiLmjAgua6ywO6xVUDyU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28QHthKP017316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Sep 2022 12:55:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 26
 Sep 2022 12:55:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 26 Sep 2022 12:55:43 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28QHteWW037317;
        Mon, 26 Sep 2022 12:55:42 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <kishon@ti.com>, <vigneshr@ti.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <lpieralisi@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <nm@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 0/3] PCI: add 4x lane support for pci-j721e controllers
Date:   Mon, 26 Sep 2022 10:55:35 -0700
Message-ID: <20220926175538.362018-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding of dditional support to Cadence PCIe controller (i.e. pci-j721e.c)
for up to 4x lanes, and reworking of driver to define maximum lanes per
board configuration.

Changes from v1:
* Reworked 'PCI: j721e: Add PCIe 4x lane selection support' to not cause
  regressions on 1-2x lane platforms

Matt Ranostay (3):
  PCI: j721e: Add PCIe 4x lane selection support
  PCI: j721e: Add per platform maximum lane settings
  PCI: j721e: Add warnings on num-lanes misconfiguration

 drivers/pci/controller/cadence/pci-j721e.c | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.38.0.rc0.52.gdda7228a83

