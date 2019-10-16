Return-Path: <SRS0=vJ1S=YJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD3AFA372B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE55B2064B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Oct 2019 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571256415;
	bh=7LXmSpYu0TIOb3U260nXu6aczD/tNPybS8CI/ANc+wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVUMkQgAVv/ffU4MjsIbbpfjpCdBfGL/QIa771WT8RT7673YybCOuSuvbqtIrQJ5t
	 MXoruxqwqT/gUaZuS2pVK6Yxb9e3pvOLcz9kNeRpFw+gipTZmFUaoUa9BvRpxNkNVf
	 NLACltbzp54XX9rJjqV9wZVaup65XEDu26L+8uSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJPUGz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:06:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39717 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfJPUGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:06:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so21285648otr.6;
        Wed, 16 Oct 2019 13:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Btu/VlfytRZaY+6qjqJxR2pSL/YxyYxi3r5SfblrlQk=;
        b=kV5ZurOI8zI3EcL3/NynsvUoY3ZjRu95P2ulAIgt14V+uY6B4Wq/DZBOBr4FZetsYw
         xYOD2oXaqlUvnfSh9U783MqSWDml2MBHFduuixolClQLklTMLZdjWrxPL27NPeQiqnlw
         Iso5RWVW7ap+a0p9aKF/Y52VjaDKYiTKuk2PfmfY9cHmqb48/dMCGJ/I5ioybgdXrTc6
         Y49gosmDfddnuSoaVLqercjJVu6GD2Mnx/BmHC23zg82qiRnbW6q5yWHplWcOgHOPQ/G
         jlUcC/XwDX3BbiXQG0yazLW9O5f/CHKxh8ePX1gAG/O4KJWdswUM4RnOTKOyF39fKDIC
         j3Vg==
X-Gm-Message-State: APjAAAUFdY7P8dueyFNFAX59ayoOVxmSrFJzXTKVJOjrwIWYUCmpvOtP
        N8FayJO7rL3dIgm/uQ70AQ==
X-Google-Smtp-Source: APXvYqycFopfXI+GcKWWyYhxyLaMbDzafvCCT1NvwKVnttvQlkfb63DPNfCWWHL9V+mWFmlMEsy1Ow==
X-Received: by 2002:a05:6830:1da2:: with SMTP id z2mr46692oti.136.1571256414262;
        Wed, 16 Oct 2019 13:06:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:06:53 -0700 (PDT)
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
Subject: [PATCH v2 02/25] PCI: Export pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:24 -0500
Message-Id: <20191016200647.32050-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_parse_request_of_pci_ranges() is missing a module export, so add it.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- New patch

 drivers/pci/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 36891e7deee3..f3da49a31db4 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -530,6 +530,7 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	pci_free_resource_list(resources);
 	return err;
 }
+EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);

 #endif /* CONFIG_PCI */

--
2.20.1
