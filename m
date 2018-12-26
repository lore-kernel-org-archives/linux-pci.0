Return-Path: <SRS0=zpRJ=PD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A5AC43387
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 02:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5412173B
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 02:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="di+lNTNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLZCXG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:23:06 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:34248 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeLZCXG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Dec 2018 21:23:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D9543B26
        for <linux-pci@vger.kernel.org>; Wed, 26 Dec 2018 02:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TG5y8Z0AmOEY for <linux-pci@vger.kernel.org>;
        Tue, 25 Dec 2018 20:23:04 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id A2F9653C
        for <linux-pci@vger.kernel.org>; Tue, 25 Dec 2018 20:23:04 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id x3so17484196itb.6
        for <linux-pci@vger.kernel.org>; Tue, 25 Dec 2018 18:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cu8L5CSVbazjBHbPhWjYELagrYCmPrkJmVmLcFehgX0=;
        b=di+lNTNeBipjGXK+tGQNXQ/GFr0DTNwP7tNlRS97MCm6cG+SJmaRMJYXkzx717LzlG
         W1RNE0R1Yy4HYwhv4jcn36HSK76lNe800R/J9FL5VS+/1a+FC8iGODcMUGRFGer6O/ZE
         ab0brs1g54l3lFgcTXx8N+qVeHiWs3MHlX1v+kVmL7Kzd+NEyZxEij0xQrOGgRqEBrrk
         PDBfL7MAV348B/SnfBaD6dxPo8o6QFpSBsLtDVEpm+6lbwuROUdhtDoYOYF1ZL1Hi+yI
         TMDV6li1qKEMW5PhUJz0w6oBJ7gmHqDlzobyeHL4JKW/WL5YYlNpV5iXIHzjxCmS5T/6
         5t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cu8L5CSVbazjBHbPhWjYELagrYCmPrkJmVmLcFehgX0=;
        b=tpW3vePuZu3pOHd0WpO1ew2jIgB8yiLt9z+LS+nJPybu3h+n8UJ6oIr88m8fCpYnXt
         frHSo8vZiTJ9c4R75+lI79DJO21G1XPJB/t6xu5SJTOA4TpOslE/9ImPzF7ILlSMLujA
         e2jgNaaFU9rof+aku8auoGlCKKfLXfKJ5hUSsCLnq2ZDYZb6I5HgxyQ8CpK3Cim0/m7A
         OFSWpLDv+6qVblnP7wBzsre8AZsHtYo8VrqJsnXHRR3TDpNUFrQ2xAZKN+/PmygQ9bKx
         SiB1X0eJ3o1FolUvMRda+6HFDXyY+U2ANrsLX1lJvhckYrkwL8/4LMMTEYvSXqyDFYGS
         Ux8w==
X-Gm-Message-State: AJcUuke0aUQlUcLxFzYTNYyLb0Tf1i2N9ICBowPS2YJ6bht67lOXjsgP
        gRuKVbVhwLPS9vRtlAqyFYqFoU+uv61VConY7xghlUaI0xBXuoBTKD+9osveS4gkfUIOE8bIAbg
        0iriMIYQnDnz6NvJbk38zpY4G
X-Received: by 2002:a6b:b2d2:: with SMTP id b201mr12526870iof.303.1545790984285;
        Tue, 25 Dec 2018 18:23:04 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4Fd1qmDpyHH2kUifSAS2wjP7wQc3YVJ7Ux+5qwk3JxkaqBdiAev3dswZcM0W068jQf6A+LWg==
X-Received: by 2002:a6b:b2d2:: with SMTP id b201mr12526856iof.303.1545790984010;
        Tue, 25 Dec 2018 18:23:04 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id c21sm15343229iob.22.2018.12.25.18.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:23:03 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: dwc: add a check for resetting gpio
Date:   Tue, 25 Dec 2018 20:22:36 -0600
Message-Id: <20181226022236.71682-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

devm_gpio_request_one() could fail. The fix checks its status and issues
an error if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/controller/dwc/pci-exynos.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index cee5f2f590e2..e3a045e215d2 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -226,9 +226,12 @@ static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
 	struct dw_pcie *pci = ep->pci;
 	struct device *dev = pci->dev;
 
-	if (ep->reset_gpio >= 0)
-		devm_gpio_request_one(dev, ep->reset_gpio,
-				GPIOF_OUT_INIT_HIGH, "RESET");
+	if (ep->reset_gpio >= 0) {
+		if (devm_gpio_request_one(dev, ep->reset_gpio,
+				GPIOF_OUT_INIT_HIGH, "RESET"))
+			dev_err(dev, "Failed requesting reset gpio %d\n",
+					ep->reset_gpio);
+	}
 }
 
 static int exynos_pcie_establish_link(struct exynos_pcie *ep)
-- 
2.17.2 (Apple Git-113)

