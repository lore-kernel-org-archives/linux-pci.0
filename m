Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE9C10F0C
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9A6218E0
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjN2yV00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCQAG1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:06:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54558 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCQAG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2019 20:06:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so9799222wmj.4;
        Sat, 16 Mar 2019 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8Ma/WL1YXhBXsJzZ6ueZraNvQHOb8cz2XymL8hJEnU=;
        b=LjN2yV00LUw5e2LR9wgNBwIu7nxF2WX3/mb79Q7H+YOLExDYHdA+NEzh1Oa+irKk3C
         BVQ4BFLk2HGdKsqYT8qp6WdC3f8goRMsTwVO6LGjL94KqM8T0SnBUJaU+BmL2dWors7s
         +e/Gygt5lBnq0E+2609jar6fb0iwOmE3ZluJxllZwGQudeAUCh+Q+NXwbt+vu+1/8K4D
         Pbiua8860jJKF+4i9yU15Eua6v/E4Wgs3wfIv/Va5qpSehEYVLSxqMHiiRFcBaD01CkG
         Obb2lJsA5Ni7QXrSYHTuAGcNP9pCdqoSSDGjGmZNvn+wx9iwSy69sVtgd20CdcFrJm1J
         oy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8Ma/WL1YXhBXsJzZ6ueZraNvQHOb8cz2XymL8hJEnU=;
        b=bkmurKxH+CIuMsyHA9bQFLWKxJtTIPYczwr8+tfkgYkUUXu9x0XLfusZJyq7a1g/6g
         Lw/F/PpmUE1VpTD9r5FXp/0y4WVf5BvnpTPrDtOqjfcIa8CViaYegQux2X5sj79hLwkj
         PydmSu3A0JU7+PWl3P7KVuZTYwEhd/KM6WS3XhodD+muFKntiL5M3KpDJSMElUJJ7etM
         yhB34SVDyo40yVLrnZjJBsPMa2jUg/tk4vkEtZVgTqBROqElubpvRFUyaQE06Dwwup+g
         0qrr+mMvHtIcpWuyqVcuyQwEor9pxAymZrAm2Rdkt1epYsGPPRQMkWyeTCA7N5QXQxOt
         XYJw==
X-Gm-Message-State: APjAAAV759azZcphEKnMCglh0kgzrCuKbC797ABG9M0kxVY940AmCzAD
        W0biG8h60PcXBtra8iGH45s6Kf7i
X-Google-Smtp-Source: APXvYqwKZOOlC5wR0luK4syF4t+BoHwa6QEq0sOi6oyRHPUtp/5EJhsp/SAZggvzYWayTjH0Ontq+Q==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr6508499wmg.101.1552781184543;
        Sat, 16 Mar 2019 17:06:24 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id b3sm6759016wrx.57.2019.03.16.17.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 17:06:23 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] PCI: rcar: Clean up debug messages
Date:   Sun, 17 Mar 2019 01:06:08 +0100
Message-Id: <20190317000608.24881-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317000608.24881-1-marek.vasut@gmail.com>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Drop useless casts from debug messages, they are no longer needed
due to the data type cleanup.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 801925a136ae..2a012654686e 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -283,8 +283,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	else if (size == 2)
 		*val = (*val >> (8 * (where & 2))) & 0xffff;
 
-	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)*val);
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, *val);
 
 	return ret;
 }
@@ -302,8 +302,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
-	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)val);
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, val);
 
 	if (size == 1) {
 		shift = 8 * (where & 3);
-- 
2.20.1

