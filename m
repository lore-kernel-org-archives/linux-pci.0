Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04542C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A320855
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 17:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBHRAR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:00:17 -0500
Received: from ale.deltatee.com ([207.54.116.67]:33666 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHRAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 12:00:17 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gs9Vf-0005UN-05; Fri, 08 Feb 2019 10:00:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gs9Ve-0005QK-Dq; Fri, 08 Feb 2019 10:00:14 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Date:   Fri,  8 Feb 2019 09:54:38 -0700
Message-Id: <20190208165439.19503-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com, helgaas@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/2] genirq/msi: Clean up usage of __u8/__u16 types
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The double underscore types are meant for compatibility in userspace
headers which does not apply here. Therefore, change to use the
standard no-underscore types.

The origin of the double underscore types dates back to before the
git era so I was not able to find a commit to see the original
justification.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
---
 include/linux/msi.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 784fb52b9900..7e9b81c3b50d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -83,12 +83,12 @@ struct msi_desc {
 		struct {
 			u32 masked;
 			struct {
-				__u8	is_msix		: 1;
-				__u8	multiple	: 3;
-				__u8	multi_cap	: 3;
-				__u8	maskbit		: 1;
-				__u8	is_64		: 1;
-				__u16	entry_nr;
+				u8	is_msix		: 1;
+				u8	multiple	: 3;
+				u8	multi_cap	: 3;
+				u8	maskbit		: 1;
+				u8	is_64		: 1;
+				u16	entry_nr;
 				unsigned default_irq;
 			} msi_attrib;
 			union {
-- 
2.19.0

