Return-Path: <SRS0=J5oN=U6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74CEC0650E
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jul 2019 06:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF420B7C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jul 2019 06:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pj6y6zwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfGAGUw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:20:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfGAGUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RrOFns7vEPB9glYGnT15vcTk3dkoPLH+jZ0rXH1XhbY=; b=pj6y6zwWdYnnlShOohzj0+FeT
        ua95uB5pQbHGN7V1dXDgEO0XeP6NGP6wP9CsUw1MUxCczmfajEPQhpUmNuVemHicYTtOPwEIh4UZj
        haBcU1PuN/lbwsjtaumcMo2KOmzjIEUoauiWhV2s6QwwZAVMRb4f5gzsTcRERX7bZ7spwXs6dcJ43
        sRidW9kePUxliDSVB1n3yeaQo3+ui72nerrRiMi1f6EkTszO9712nLpu1yAs93if+p9DwRqXZ6zCd
        edma9n2V5pe+Luqle1eHfjwGFKvLPdkMzMs3gC2ttY0DPQRzYIJHcaA6t8Npl1EcNh3JUa+mKozuw
        56C4YQTVw==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgF-000304-Cn; Mon, 01 Jul 2019 06:20:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <iweiny@intel.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 11/22] mm/hmm: Do not use list*_rcu() for hmm->ranges
Date:   Mon,  1 Jul 2019 08:20:09 +0200
Message-Id: <20190701062020.19239-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This list is always read and written while holding hmm->lock so there is
no need for the confusing _rcu annotations.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <iweiny@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 0423f4ca3a7e..73c8af4827fe 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -912,7 +912,7 @@ int hmm_range_register(struct hmm_range *range,
 
 	range->hmm = hmm;
 	kref_get(&hmm->kref);
-	list_add_rcu(&range->list, &hmm->ranges);
+	list_add(&range->list, &hmm->ranges);
 
 	/*
 	 * If there are any concurrent notifiers we have to wait for them for
@@ -942,7 +942,7 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&hmm->lock);
-	list_del_rcu(&range->list);
+	list_del(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-- 
2.20.1

