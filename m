Return-Path: <SRS0=ulsO=4L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5D7C35671
	for <linux-pci@archiver.kernel.org>; Sun, 23 Feb 2020 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1078208C3
	for <linux-pci@archiver.kernel.org>; Sun, 23 Feb 2020 09:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgn/kwOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgBWJKB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:10:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34334 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2020 04:10:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so6845417wrm.1;
        Sun, 23 Feb 2020 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZNp+EvVTHUsQTuzdSBoBSK7Xad89HXC39l9IXgu0L6k=;
        b=qgn/kwOXb6rkHNyIZ6bRJng6LH3lH/HQl5AZwfwLmx0GS4J8ExGX9cHMVHTZ6gusnp
         IxdZB3kMaWI9O5J58icoAOeghd7kIJXFSaavCppXoXS0C5m3QARTQhU6Q57ozihS0u7K
         BM8LR6pw3Q2yk8nHMMjekoD5UTYdHdJ3hrjbUTWeJncaHnsoJk74/rvV9u/jbZD6CjH/
         1yjLIPRfXIQKpf6Bn68PMnc8yvQrLQ4yW+qAI90qtMXww/UmKLdkGUPgI9+ZqqmGRzWc
         bb2CfW3OuE9pYU3+GjUS0v/aUAcKONVTMl8Q7cxujjpxhnQwr0+XE1q+d9nSeEyDWDLr
         wSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZNp+EvVTHUsQTuzdSBoBSK7Xad89HXC39l9IXgu0L6k=;
        b=ivuiVWRwNkrKIbMf4gkkhVLkc35wYK5SRsyUDo/7jr5MBNSbz9E42Ci5/KYrZNZbRz
         KAJTZ2M1zkpu17QijUqp1UTNCiW6o41f9Yq8C4HQoy/CgYcYSPk6BmxLoRnLgjW+0F7+
         d09vpmfml4k/5Qo49nMRLUOWbCd716X0LyeyTB6tYfliXGNCVuPorfG1hzPxnY8Umy+7
         pVc10y3i83HQqaqdOf2MSdL9NxwHsSz04b3qCxN5kAjvP0n1bURJ7g4pyJb246VnqdPQ
         nGA/knF1W/NuXDrv9s4WB7/zlmUdDafemO3R0ICB6cDQR+FgQPY/usDLt/jKLa1VbC7V
         a4AQ==
X-Gm-Message-State: APjAAAU19n4qFUhYK89AV2QG66k7PquwzZrq77k5pWjeMZwaT98uhV7Y
        ET+mlXmUsKp5hbeIkqHsUnk=
X-Google-Smtp-Source: APXvYqynWcijyO/xnVA8R+8xgwTevrjbD+iuKtHMtHFQDIaNbai1TGHrC8jRZpNnLtRHAd/Ruv6k3g==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr58709265wrv.259.1582448998448;
        Sun, 23 Feb 2020 01:09:58 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de2:db00:5dbb:1717:2cb6:4104])
        by smtp.gmail.com with ESMTPSA id d9sm12657464wrx.94.2020.02.23.01.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 01:09:58 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Daney <david.daney@cavium.com>,
        Robert Richter <rrichter@marvell.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: clean up PCIE DRIVER FOR CAVIUM THUNDERX
Date:   Sun, 23 Feb 2020 10:09:50 +0100
Message-Id: <20200223090950.5259-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit e1ac611f57c9 ("dt-bindings: PCI: Convert generic host binding to
DT schema") combines all information from pci-thunder-{pem,ecam}.txt
into host-generic-pci.yaml, and deleted the two files in
Documentation/devicetree/bindings/pci/.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  no file matches F: Documentation/devicetree/bindings/pci/pci-thunder-*

As the PCIE DRIVER FOR CAVIUM THUNDERX-relevant information is only a
small part of the host-generic-pci.yaml, do not add this file to the
PCIE DRIVER FOR CAVIUM THUNDERX entry, and only drop the reference to
the removed files.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Robert, are you still the maintainer of this driver?
Rob Herring, please pick this patch.
applies cleanly on current master and next-20200221

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2af5fa73155e..d43a8f9769db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12953,7 +12953,6 @@ M:	Robert Richter <rrichter@marvell.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/pci-thunder-*
 F:	drivers/pci/controller/pci-thunder-*
 
 PCIE DRIVER FOR HISILICON
-- 
2.17.1

