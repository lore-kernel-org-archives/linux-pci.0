Return-Path: <SRS0=taQ7=XW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA7C4360C
	for <linux-pci@archiver.kernel.org>; Fri, 27 Sep 2019 00:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD7920835
	for <linux-pci@archiver.kernel.org>; Fri, 27 Sep 2019 00:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569543950;
	bh=XiCTN29M9zpR9Gh2trmKYTPFx1Q5Bw5bm3kUcLU+ZgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3wZfdCZ1Dxtn5u6jhqVE8TdS+lJZx8gCMpYKIsLvMX3rGyZ1NMYW20kZ2WBAEDa5
	 wJo1Gd8JhZW+nUJIGxCj1jEK5M1rHlFExBb6k8DxINC6OjuW0SIsF6lBOJtOwTcXxI
	 viPeZHBTHJ0IZL9WztmAuR7JEfN5POSqCFYJwNbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfI0AZB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Sep 2019 20:25:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37191 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfI0AZB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id i16so3740969oie.4;
        Thu, 26 Sep 2019 17:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+w5IFIxhvLU+cAIOScJHHta0qaO4ZGZGm/wE8/ycgf8=;
        b=rJ8xxO+z4dT24fHthj0h9FrKmRoSWdet4bq92MPGKa+ydQYYgVLoe7mdZd8dyq+8+d
         tpItjzCHc4IUOVsZyAr0s4p5tG/m7dHfxeFTlJE42VohqtpDUSqVrFM5SU27t2x1rCPu
         VhEqOWjEgdDCRIN/EfxTa5ZSsje4P+1x3xronJL8ySpCVYvuZwjW8VIPAlDyv4IlIYTp
         OXZ6k9wS0cvWFxREoaNQHUVQFc3159Arqhzw6GHC4FeYsXR8DbEYec6YG4nWvO0ayO6h
         0BT8XuMPkFfXBNEG73Asw82dCTVSmiNmdtvrBLsBYauEtd01IoJ6Sl+ACszkAXNXKckA
         cVKg==
X-Gm-Message-State: APjAAAVx7jCk15PkIOrhr68qO9a00tFgXL4yFStxNgtcoeF38qxelt4O
        pnH46U4UNj4Wz7ONpVhXOtVitDI=
X-Google-Smtp-Source: APXvYqz440W6O64cgvCu2OYrAyaV4fHohe2E6X1Kaj+k2yyGSBSVQGkq2l9TDw1R1g0urlwMQ3JhwA==
X-Received: by 2002:aca:c0d6:: with SMTP id q205mr4827563oif.81.1569543898837;
        Thu, 26 Sep 2019 17:24:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:24:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 01/11] of: Remove unused of_find_matching_node_by_address()
Date:   Thu, 26 Sep 2019 19:24:45 -0500
Message-Id: <20190927002455.13169-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_find_matching_node_by_address() is unused, so remove it.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 19 -------------------
 include/linux/of_address.h | 12 ------------
 2 files changed, 31 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 978427a9d5e6..0c3cf515c510 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -826,25 +826,6 @@ int of_address_to_resource(struct device_node *dev, int index,
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
 
-struct device_node *of_find_matching_node_by_address(struct device_node *from,
-					const struct of_device_id *matches,
-					u64 base_address)
-{
-	struct device_node *dn = of_find_matching_node(from, matches);
-	struct resource res;
-
-	while (dn) {
-		if (!of_address_to_resource(dn, 0, &res) &&
-		    res.start == base_address)
-			return dn;
-
-		dn = of_find_matching_node(dn, matches);
-	}
-
-	return NULL;
-}
-
-
 /**
  * of_iomap - Maps the memory mapped IO for a given device_node
  * @device:	the device whose io range will be mapped
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 30e40fb6936b..e317f375374a 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -33,10 +33,6 @@ extern u64 of_translate_dma_address(struct device_node *dev,
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
-extern struct device_node *of_find_matching_node_by_address(
-					struct device_node *from,
-					const struct of_device_id *matches,
-					u64 base_address);
 extern void __iomem *of_iomap(struct device_node *device, int index);
 void __iomem *of_io_request_and_map(struct device_node *device,
 				    int index, const char *name);
@@ -71,14 +67,6 @@ static inline u64 of_translate_address(struct device_node *np,
 	return OF_BAD_ADDR;
 }
 
-static inline struct device_node *of_find_matching_node_by_address(
-					struct device_node *from,
-					const struct of_device_id *matches,
-					u64 base_address)
-{
-	return NULL;
-}
-
 static inline const __be32 *of_get_address(struct device_node *dev, int index,
 					u64 *size, unsigned int *flags)
 {
-- 
2.20.1

