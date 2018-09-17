Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B88ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781142086E
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JyDL+Er2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781142086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIQXe3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:34:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52904 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 19:34:29 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8HI5nGj088040;
        Mon, 17 Sep 2018 13:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537207549;
        bh=5OkqdboIuXCb4P4/OgfXk1Bk2YMAeZq2/9wdfw/IsxA=;
        h=From:To:CC:Subject:Date;
        b=JyDL+Er20FOvQ/MuFooHKiuj+NQxTKnPUJ3l2jA5MRbnRNA8iWqt2wPvEy1beHvX6
         Am9gX4HraOU7zUzxaj3DbOP/p3ol/jg3s5IuVD1Slyb2D88dMQR/+3eoCnPtpC7ZXs
         kpRDQZu5RC06aks1ztP1s2L8RxfQMmjTPMFt/HFc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HI5nAv013166;
        Mon, 17 Sep 2018 13:05:49 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 17
 Sep 2018 13:05:49 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 17 Sep 2018 13:05:49 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HI5k1B004762;
        Mon, 17 Sep 2018 13:05:46 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 0/2] pci-dra7xx: Enable errata i870 workaround for RC mode
Date:   Mon, 17 Sep 2018 23:36:33 +0530
Message-ID: <20180917180635.26996-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917180633.D7qKhcCgUZYDKUaPQhQHNf0KxvBDNFIv6BRylx6OFGY@z>

Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
Driver will continue to work with w/o applying errata in host mode when
using older DT, to maintain backward compatibility.

Tested on DRA72 EVM

Changes since v3:
Rebase onto latest next
Drop DT patches from this series. They will be sent separately once
driver changes in this series is merged.

Changes since v2:
Reorder patch 2 to appear at the last.
Collect all the ACKs

Changes since v1:
Drop IRQ handling rework (will be sent out separately)

v2: https://patchwork.ozlabs.org/cover/935454/
v1: https://lkml.org/lkml/2017/12/1/59


Vignesh R (2):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.19.0

