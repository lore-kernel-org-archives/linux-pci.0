Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB88C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 00:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4807521902
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 00:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCVAHp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:07:45 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54888 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbfCVAGx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Mar 2019 20:06:53 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h77hx-0002XA-Re; Thu, 21 Mar 2019 18:06:52 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h77hv-00044I-HQ; Thu, 21 Mar 2019 18:06:47 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 21 Mar 2019 18:06:38 -0600
Message-Id: <20190322000645.15580-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322000645.15580-1-logang@deltatee.com>
References: <20190322000645.15580-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 03/10] NTB: Introduce helper functions to calculate logical port number
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch introduces the "Logical Port Number" which is similar to the
"Port Number" in that it enumerates the ports in the system.

The original (or Physical) "Port Number" can be any number used by the
hardware to uniquley identify a port in the system. The "Logical Port
Number" enumerates all ports in the system from 0 to the number of
ports minus one.

For example a system with 5 ports might have the following port numbers
which would be enumareted thusly:

Port Number:           1  2  5  7  116
Logical Port Number:   0  1  2  3  4

The logical port number is useful when calculating which resources
to use for which peers. So we thus define two helper functions:
ntb_logical_port_number() and ntb_peer_logical_port_number() which
provide the "Logical Port Number" for the local port and any peer
respectively.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>
---
 include/linux/ntb.h | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 56a92e3ae3ae..52060b2130b6 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -616,7 +616,6 @@ static inline int ntb_port_number(struct ntb_dev *ntb)
 
 	return ntb->ops->port_number(ntb);
 }
-
 /**
  * ntb_peer_port_count() - get the number of peer device ports
  * @ntb:	NTB device context.
@@ -653,6 +652,58 @@ static inline int ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
 	return ntb->ops->peer_port_number(ntb, pidx);
 }
 
+/**
+ * ntb_logical_port_number() - get the logical port number of the local port
+ * @ntb:	NTB device context.
+ *
+ * The Logical Port Number is defined to be a unique number for each
+ * port starting from zero through to the number of ports minus one.
+ * This is in contrast to the Port Number where each port can be assigned
+ * any unqique physical number by the hardware.
+ *
+ * The logical port number is useful for calculating the resource indexes
+ * used by peers.
+ *
+ * Return: the logical port number or negative value indicating an error
+ */
+static inline int ntb_logical_port_number(struct ntb_dev *ntb)
+{
+	int lport = ntb_port_number(ntb);
+	int pidx;
+
+	if (lport < 0)
+		return lport;
+
+	for (pidx = 0; pidx < ntb_peer_port_count(ntb); pidx++)
+		if (lport <= ntb_peer_port_number(ntb, pidx))
+			return pidx;
+
+	return pidx;
+}
+
+/**
+ * ntb_peer_logical_port_number() - get the logical peer port by given index
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * The Logical Port Number is defined to be a unique number for each
+ * port starting from zero through to the number of ports minus one.
+ * This is in contrast to the Port Number where each port can be assigned
+ * any unqique physical number by the hardware.
+ *
+ * The logical port number is useful for calculating the resource indexes
+ * used by peers.
+ *
+ * Return: the peer's logical port number or negative value indicating an error
+ */
+static inline int ntb_peer_logical_port_number(struct ntb_dev *ntb, int pidx)
+{
+	if (ntb_peer_port_number(ntb, pidx) < ntb_port_number(ntb))
+		return pidx;
+	else
+		return pidx + 1;
+}
+
 /**
  * ntb_peer_port_idx() - get the peer device port index by given port number
  * @ntb:	NTB device context.
-- 
2.20.1

