Return-Path: <SRS0=BFTA=5R=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05DEC2D0F1
	for <linux-pci@archiver.kernel.org>; Wed,  1 Apr 2020 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9802077D
	for <linux-pci@archiver.kernel.org>; Wed,  1 Apr 2020 03:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="KMo6oVLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgDADJs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Mar 2020 23:09:48 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17812 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731574AbgDADJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 23:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585710539;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=M9AG6YJZ1M+WKraGHw9VnEsvm+cbbYRG2eJ2kWp3UGU=;
        b=KMo6oVLLsQ9yNTJfow4o7J4LIeR3Z2B1b+bgIuykaGoNcnY1oCS47x9J3xRunquY
        OYQRPR7t+4guSAHZM5cjpNQr3p+St4Of0/BxvGh0Wt+lkSYGQwH1UNdKF/EDLtE4krI
        6oIZvcynYV3kZPh7vjnn1qIQE3XK3QH81X9B0XGU=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585710537953921.8430799380282; Wed, 1 Apr 2020 11:08:57 +0800 (CST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200401030658.1174045-2-jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/5] PCI: OF: Don't remap iospace on unsupported platform
Date:   Wed,  1 Apr 2020 11:06:45 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
References: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are some platforms doesn't support iospace remapping
like MIPS. However, our PCI code will try to remap iospace
unconditionally and reject io resources on these platforms.

So we should remove iospace remapping check and use a range
check instead on these platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..36e8761b66c6 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -547,12 +547,21 @@ int pci_parse_request_of_pci_ranges(struct device *de=
v,
=20
 =09=09switch (resource_type(res)) {
 =09=09case IORESOURCE_IO:
+#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 =09=09=09err =3D devm_pci_remap_iospace(dev, res, iobase);
 =09=09=09if (err) {
 =09=09=09=09dev_warn(dev, "error %d: failed to map resource %pR\n",
 =09=09=09=09=09 err, res);
 =09=09=09=09resource_list_destroy_entry(win);
 =09=09=09}
+#else
+=09=09=09/* Simply check if IO is inside the range */
+=09=09=09if (res->end > IO_SPACE_LIMIT) {
+=09=09=09=09dev_warn(dev, "resource %pR out of the IO range\n",
+=09=09=09=09=09res);
+=09=09=09=09resource_list_destroy_entry(win);
+=09=09=09}
+#endif
 =09=09=09break;
 =09=09case IORESOURCE_MEM:
 =09=09=09res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
--=20
2.26.0.rc2


