Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED2BC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD072086C
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393391AbfBMRzD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54524 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732721AbfBMRzD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:03 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykN-0001zD-5M; Wed, 13 Feb 2019 10:55:00 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykL-0001yI-K8; Wed, 13 Feb 2019 10:54:57 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 13 Feb 2019 10:54:49 -0700
Message-Id: <20190213175454.7506-8-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 07/12] NTB: Introduce functions to calculate multi-port resource index
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using multi-ports each port uses resources (dbs, msgs, mws, etc)
on every other port. Creating a mapping for these resources such that
each port has a corresponding resource on every other port is a bit
tricky.

Introduce the ntb_peer_resource_idx() function for this purpose.
It returns the peer resource number that will correspond with the
local peer index on the remote peer.

Also, introduce ntb_peer_highest_mw_idx() which will use
ntb_peer_resource_idx() but return the MW index starting with the
highest index and working down.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 include/linux/ntb.h | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 181d16601dd9..f5c69d853489 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1502,4 +1502,74 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_peer_resource_idx() - get a resource index for a given peer idx
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * When constructing a graph of peers, each remote peer must use a different
+ * resource index (mw, doorbell, etc) to communicate with each other
+ * peer.
+ *
+ * In a two peer system, this function should always return 0 such that
+ * resource 0 points to the remote peer on both ports.
+ *
+ * In a 5 peer system, this function will return the following matrix
+ *
+ * pidx \ port    0    1    2    3    4
+ * 0              0    0    1    2    3
+ * 1              0    1    2    3    4
+ * 2              0    1    2    3    4
+ * 3              0    1    2    3    4
+ *
+ * For example, if this function is used to program peer's memory
+ * windows, port 0 will program MW 0 on all it's peers to point to itself.
+ * port 1 will program MW 0 in port 0 to point to itself and MW 1 on all
+ * other ports. etc.
+ *
+ * For the legacy two host case, ntb_port_number() and ntb_peer_port_number()
+ * both return zero and therefore this function will always return zero.
+ * So MW 0 on each host would be programmed to point to the other host.
+ *
+ * Return: the resource index to use for that peer.
+ */
+static inline int ntb_peer_resource_idx(struct ntb_dev *ntb, int pidx)
+{
+	int local_port, peer_port;
+
+	if (pidx >= ntb_peer_port_count(ntb))
+		return -EINVAL;
+
+	local_port = ntb_port_number(ntb);
+	peer_port = ntb_peer_port_number(ntb, pidx);
+
+	if (peer_port < local_port)
+		return local_port - 1;
+	else
+		return local_port;
+}
+
+/**
+ * ntb_peer_highest_mw_idx() - get a memory window index for a given peer idx
+ *	using the highest index memory windows first
+ *
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * Like ntb_peer_resource_idx(), except it returns indexes starting with
+ * last memory window index.
+ *
+ * Return: the resource index to use for that peer.
+ */
+static inline int ntb_peer_highest_mw_idx(struct ntb_dev *ntb, int pidx)
+{
+	int ret;
+
+	ret = ntb_peer_resource_idx(ntb, pidx);
+	if (ret < 0)
+		return ret;
+
+	return ntb_mw_count(ntb, pidx) - ret - 1;
+}
+
 #endif
-- 
2.19.0

