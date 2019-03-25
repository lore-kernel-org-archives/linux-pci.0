Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D090C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B5E20879
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfCYIYx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:24:53 -0400
Received: from p-mail-ext.rd.orange.com ([161.106.1.9]:40114 "EHLO
        p-mail-ext.rd.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfCYIYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:24:53 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 04:24:53 EDT
Received: from p-mail-ext.rd.orange.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 718AA5613B6
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 09:19:05 +0100 (CET)
Received: from p-mail-int.rd.francetelecom.fr (p-mail-int.rd.francetelecom.fr [10.192.117.12])
        by p-mail-ext.rd.orange.com (Postfix) with ESMTP id 6D667561363
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 09:19:05 +0100 (CET)
Received: from p-mail-int.rd.francetelecom.fr (localhost.localdomain [127.0.0.1])
        by localhost (Postfix) with SMTP id 2A5A218154A;
        Mon, 25 Mar 2019 09:19:06 +0100 (CET)
Received: from yd-CZC9059FTQ.rd.francetelecom.fr (yd-CZC9059FTQ.rd.francetelecom.fr [10.193.71.88])
        by p-mail-int.rd.francetelecom.fr (Postfix) with ESMTP id F11A818152B;
        Mon, 25 Mar 2019 09:19:05 +0100 (CET)
From:   =?UTF-8?q?Pierre=20Cr=C3=A9gut?= <pierre.cregut@orange.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Pierre=20Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: [PATCH] PCI/IOV: update num_VFs earlier
Date:   Mon, 25 Mar 2019 09:18:03 +0100
Message-Id: <20190325081803.30094-1-pierre.cregut@orange.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2019.3.25.80916, AntiVirus-Engine: 5.60.0, AntiVirus-Data: 2019.3.25.5600000
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1200_1299 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, LEGITIMATE_SIGNS 0, MULTIPLE_REAL_RCPTS 0, SINGLE_URI_IN_BODY 0, URI_WITH_PATH_ONLY 0, __ANY_URI 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FROM_DOMAIN_IN_ANY_CC1 0, __FROM_DOMAIN_IN_RCPT 0, __FROM_UTF_Q 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __HTTPS_URI 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __NO_HTML_TAG_RAW 0, __PHISH_PHRASE1_B 0, __PHISH_SPEAR_SUBJ_PREDICATE 0, __SANE_MSGID 0, __SINGLE_URI_TEXT 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_IN_BODY 0, __URI_NOT_IMG 0, __URI_NO_WWW 0, __URI_NS , __URI_WITH_PATH 0'
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ensure that iov->num_VFs is set before a netlink message is sent when
the number of VFs is changed. Otherwise /sys/.../sriov_numvfs is not
updated when read immediately after receiving the netlink message.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202991
Signed-off-by: Pierre Crégut <pierre.cregut@orange.com>
---
 drivers/pci/iov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3aa115ed3a65..a9655c10e87f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -351,6 +351,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		goto err_pcibios;
 	}
 
+	iov->num_VFs = nr_virtfn;
 	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
@@ -363,7 +364,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
-	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
@@ -379,6 +379,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
+	iov->num_VFs = 0;
 	pci_iov_set_numvfs(dev, 0);
 	return rc;
 }
-- 
2.17.1

