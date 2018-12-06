Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3314C04EB9
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FB520645
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 10:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FB520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeLFKZF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:25:05 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:37222 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFKZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 05:25:05 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D7739A5663AA7401A91F;
        Thu,  6 Dec 2018 18:25:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB6AOqre022437;
        Thu, 6 Dec 2018 18:24:52 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120618252398-15119540 ;
          Thu, 6 Dec 2018 18:25:23 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Bob Copeland <me@bobcopeland.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH] PCI: endpoint: functions: Use kmemdup instead of duplicating its function
Date:   Thu, 6 Dec 2018 18:24:48 +0800
Message-Id: <20181206102448.57223-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 18:25:24,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 18:24:41
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB6AOqre022437
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

kmemdup has implemented the function that kmalloc() + memcpy().
We prefer to kmemdup rather than code opened implementation.

This issue was detected with the help of coccinelle.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Bob Copeland <me@bobcopeland.com>

CC: Kishon Vijay Abraham I <kishon@ti.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: Niklas Cassel <niklas.cassel@axis.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
CC: linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM)
CC: linux-kernel@vger.kernel.org (open list)
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/en=
dpoint/functions/pci-epf-test.c
index 3e86fa3c7da3..8df6c019f8a2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -169,14 +169,12 @@ static int pci=5Fepf=5Ftest=5Fread(struct pci=5Fepf=
=5Ftest *epf=5Ftest)
 		goto err=5Faddr;
 	}
=20
-	buf =3D kzalloc(reg->size, GFP=5FKERNEL);
+	buf =3D kmemdup(src=5Faddr, reg->size, GFP=5FKERNEL);
 	if (!buf) {
 		ret =3D -ENOMEM;
 		goto err=5Fmap=5Faddr;
 	}
=20
-	memcpy(buf, src=5Faddr, reg->size);
-
 	crc32 =3D crc32=5Fle(~0, buf, reg->size);
 	if (crc32 !=3D reg->checksum)
 		ret =3D -EIO;
--=20
2.19.1

