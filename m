Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0EC433E0
	for <linux-pci@archiver.kernel.org>; Sat, 20 Feb 2021 03:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA6C64EDF
	for <linux-pci@archiver.kernel.org>; Sat, 20 Feb 2021 03:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhBTDCc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:02:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45538 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBTDCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 22:02:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0C001A0A9D;
        Sat, 20 Feb 2021 04:01:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA1351A0103;
        Sat, 20 Feb 2021 04:01:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F256040291;
        Sat, 20 Feb 2021 04:01:33 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] PCI: imx6: Limit DBI register length for imx6qp PCIe
Date:   Sat, 20 Feb 2021 10:49:47 +0800
Message-Id: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v1 to v2:
- Add reviewed by Lucas and Krzysztof.
- Refine the subject and commit refer to Krzysztof comments.

drivers/pci/controller/dwc/pci-imx6.c | 1 +
1 file changed, 1 insertion(+)

[PATCH v2] PCI: imx6: Limit DBI register length for imx6qp PCIe
