Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D966C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AB821872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puOa+Oa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfADRvi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:51:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34810 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfADRtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so17791758pga.1;
        Fri, 04 Jan 2019 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhqhT8k9cRoxWOByjnw4+D3pr2bPAqv3RKgBmGiID7Y=;
        b=puOa+Oa5mf9v7e1IlYNfFflOsFbHuywQvz56JQu5xhuT1CWhPCFLj5SYPYM0yYmSxf
         /3ltIOT1DOuf/cpIxyBhUhuMcaU4KjjEeEw1v4Vp+uJ3/5Wswg9DE0gIpvZBEf4NTwgG
         g/Z+0G0NDf6OlV+Ajjkw/F4DhmocblP0TRHEL3hokf2GHWJ5twOYmMsVgsUhoPqohYz7
         zbbrvcYT13Eyp+txwqEY8zgTO1SEd+AEvdzWdSzcHuZwLdtEfyg5o2uw7tTj3v0ngKwP
         hQfOk4ZWVwOUb0AxvHfRCFHbgaChQbx7CK2zY/tDmCMQZNrW/4FH8cjdhfuUu68LEUd7
         YgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhqhT8k9cRoxWOByjnw4+D3pr2bPAqv3RKgBmGiID7Y=;
        b=a1WtZqmv1gP53u1/FYll/7VURzn6hbo7Iq/dWrZnkBT+dX1m8lrZOc245wnQkUwuOh
         d1yzt4s5TA6DsGNJqd895mP6v/3UGiVC6SChDBtsj43qjaE7HEmaz9A2Ozc8v+g3kGbh
         mM2uHJSYGQrZIaebeS4JOPsynn+k1eC5/kvrGieTSoc37078eHYaYw5NuAW81LHv/+Hr
         s4z+eg+iAHZ1fvWmd5pkxw8uZ8pJfz3xs6Gqqw8bjnmbufWNVJDe1zWkhvE5EUYuSomQ
         rN7FFkTXOEi9FnkKxlKoamzmVyYdxAWcehzPNmll7YYqVqENCUIjfBFRVypYx+XfGtOV
         9KQA==
X-Gm-Message-State: AJcUukffKE2Ddvn4VfRrgaXcn/g4l7eAkRYdc87XYCuA/DF2LdTpML3u
        GSbDKXhzg5ykNwYtENidvcozq50ebw8=
X-Google-Smtp-Source: ALg8bN4LPvul9EoVP+PUo/2OYcZzz1whMoTFA5PuuZ/nPLmsezd3LBKPNU19q/O3Rnl3lTb/V3kfzg==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr2485051pgg.429.1546624193159;
        Fri, 04 Jan 2019 09:49:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:52 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 07/20] PCI: dwc: Make use of IS_ALIGNED()
Date:   Fri,  4 Jan 2019 09:49:12 -0800
Message-Id: <20190104174925.17153-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make the intent a bit more clear as well as get rid of explicit
arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
"size". No functional change intended.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 93ef8c31fb39..67236379c61a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -22,7 +22,7 @@
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
-	if ((uintptr_t)addr & (size - 1)) {
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
-	if ((uintptr_t)addr & (size - 1))
+	if (!IS_ALIGNED((uintptr_t)addr, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (size == 4)
-- 
2.20.1

