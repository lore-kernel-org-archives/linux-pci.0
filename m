Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4FFA372B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D7A2064B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571256458;
	bh=xAMSDHJRu+klrBiWNLGGlkSoErpq59QmcEO+qE7uTrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z6jx/zSi5Mc0OyWzORDDWycd/+C2JmfpYHCx1q1hq05173DJysFga6mhfxG3dMPZq
	 XIhaFCfpbJGwwJLa7i2u1/WopkXk+/0VEjvvGIOCv2Snt6P2ZfKAK4kmOJfnML4mXt
	 RbmB3m0qMWSkgrTNEREG/+WWR0kkXTLA4jOzf5h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfJPUHh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:07:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39126 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbfJPUHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so120276oia.6;
        Wed, 16 Oct 2019 13:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gD14iI8UpOKj376Bq/txSzTZsSs0VToSMrptEdmjdQ=;
        b=DNfD7zRHAZOyZZHQ8E0bB6KN2HvAyk2YKDYXFVniSFSOj6RKjy5xwPZlTIe+riXm4U
         cq84xRRk3lYmbF7n1SjRHGPwPjDG8VTSsoXXeqV+ZW9+bpBn1UonGFZDnVkqpR31UyVm
         FVl5baEWBKiArhlyNq6+geDmtbCSrQHCv8kzrgZdaFTOEKlynk2Ko7xnOik5w4PW7O2m
         8y4A6lKUsisaGxFQYt07v2Q6yPlvAY7VyeN13pdk6HatX+RpWwH9l6+qoOaCULNSp2nk
         cZ2+Js8QRwsbdpwGGUgKCrVGAWLEFE2kmFf0EiIPKcc9bLOLNzBkXIQnYrDFuL+BcxFw
         3fsg==
X-Gm-Message-State: APjAAAUTi1wUkNhcbH/rOUZvOH0Eo2VxvYaMlqa1+rKkL5z83PZIEdbI
        7yQEIYcy+EZ6y8siORch4w==
X-Google-Smtp-Source: APXvYqwARWAGB+loxletdL6FrwiWyw5aEFkfQ6bbkwqrIvNHj0wJXVi7rbTCOJSVySk78uO9yqn8Ag==
X-Received: by 2002:aca:df41:: with SMTP id w62mr110576oig.90.1571256456105;
        Wed, 16 Oct 2019 13:07:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 25/25] PCI: Make devm_of_pci_get_host_bridge_resources() static
Date:   Wed, 16 Oct 2019 15:06:47 -0500
Message-Id: <20191016200647.32050-26-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all the PCI host drivers are using pci_parse_request_of_pci_ranges(),
make devm_of_pci_get_host_bridge_resources() static.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c  |  5 +----
 drivers/pci/pci.h | 17 -----------------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0b1e4623dfcf..00e4b9fcb41d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -236,7 +236,6 @@ void of_pci_check_probe_only(void)
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
-#if defined(CONFIG_OF_ADDRESS)
 /**
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
  *                                           host bridge resources from DT
@@ -255,7 +254,7 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * It returns zero if the range parsing has been successful or a standard error
  * value if it failed.
  */
-int devm_of_pci_get_host_bridge_resources(struct device *dev,
+static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources,
 			struct list_head *ib_resources,
@@ -384,8 +383,6 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 	pci_free_resource_list(resources);
 	return err;
 }
-EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
-#endif /* CONFIG_OF_ADDRESS */
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6692c4fe4290..118a4974537b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -630,23 +630,6 @@ static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 #endif /* CONFIG_OF */
 
-#if defined(CONFIG_OF_ADDRESS)
-int devm_of_pci_get_host_bridge_resources(struct device *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources,
-			struct list_head *ib_resources,
-			resource_size_t *io_base);
-#else
-static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources,
-			struct list_head *ib_resources,
-			resource_size_t *io_base)
-{
-	return -EINVAL;
-}
-#endif
-
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
-- 
2.20.1

