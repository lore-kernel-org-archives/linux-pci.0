Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3EC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 08:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13102145D
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cS7cw5Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13102145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeIYOgK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:36:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37754 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYOgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 10:36:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8P8TYsg005177;
        Tue, 25 Sep 2018 03:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537864174;
        bh=/6IyBVzlR42G0qI9cpbwD5bIPz7BxC+PDyWbKInEmXA=;
        h=From:To:CC:Subject:Date;
        b=cS7cw5ZycEa7YUv1pNiseO5ShDJELwsCeW9ALo1NLAEJKAysqdNlg4ZkkEHMg1JrE
         hjccO02NugmzAInLStR4e/XhHpdWq+dgdSjv0V/Ag6hdC1hh0xqROX7twOTtdgw9FL
         bkZNlfAgPNl5lRxPjp/hufNlu3mVdSSSnEijsZ6E=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P8TYmI007255;
        Tue, 25 Sep 2018 03:29:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 03:29:33 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 03:29:33 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P8TU3k006331;
        Tue, 25 Sep 2018 03:29:31 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v5 0/2] pci-dra7xx: Enable errata i870 workaround for RC mode
Date:   Tue, 25 Sep 2018 14:00:22 +0530
Message-ID: <20180925083024.6960-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
Driver will continue to work with w/o applying errata in host mode when
using older DT, to maintain backward compatibility.

Tested on DRA72 EVM

Changes since v4:
Fail driver probe if DT binding is absent for EP(as it is in current
code)

Changes since v3:
Rebase onto latest next
Drop DT patches from this series. They will be sent separately once
driver changes in this series is merged.

Changes since v2:
Reorder patch 2 to appear at the last.
Collect all the ACKs

Changes since v1:
Drop IRQ handling rework (will be sent out separately)


Vignesh R (2):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 drivers/pci/controller/dwc/pci-dra7xx.c          | 11 ++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.19.0

