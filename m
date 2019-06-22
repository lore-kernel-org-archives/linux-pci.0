Return-Path: <SRS0=xdJP=UV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B4C43613
	for <linux-pci@archiver.kernel.org>; Sat, 22 Jun 2019 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0E2070B
	for <linux-pci@archiver.kernel.org>; Sat, 22 Jun 2019 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561220188;
	bh=sOelX0K4gWk6y8t5+w0Xe4HGl02QASsSknUsKPiEemk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=D1QJk+UVB2USgKw2Hn5N6LR8qfAr/0d82BzTFSLMhC57Zix9M/yhoLvxcEU6ttxHx
	 v+zw0T+JWBZPHEkrW10KcTMQullks79mOs84zqJxbBgxiB6+9YusZu0Cj+ur50ZatN
	 3QrTmKkObHVmGLNlou3OrNC+T/9ZrGrY6aqDdGoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFVQQ1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVQQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jun 2019 12:16:27 -0400
Received: from localhost (224.sub-174-234-138.myvzw.com [174.234.138.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8F620675;
        Sat, 22 Jun 2019 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561220186;
        bh=sOelX0K4gWk6y8t5+w0Xe4HGl02QASsSknUsKPiEemk=;
        h=Date:From:To:Cc:Subject:From;
        b=BnHqtreSGCgPbHxJloNzi2ybq5yVxXDdB0hcf66VoUA41+3/EN/MYM15LYvq/2FQr
         DMaEYRYvkvJXU/em7yCvAj7dcNbCoc7V389Vs/Z7IWcnmXXSyr5Rvgz3XMNJ3r5uuL
         TG+YOe1314SjBQ9yIZCE0jq+kFJw6Qe+l59XOlQc=
Date:   Sat, 22 Jun 2019 11:16:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] PCI fixes for v5.2
Message-ID: <20190622161623.GH127746@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - If an IOMMU is present, ignore the P2PDMA whitelist we added for v5.2
    because we don't yet know how to support P2PDMA in that case (Logan
    Gunthorpe)


The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.2-fixes-1

for you to fetch changes up to 6dbbd053e6aea827abde89ac9b9d6855dab1a66b:

  PCI/P2PDMA: Ignore root complex whitelist when an IOMMU is present (2019-06-19 16:43:42 -0500)

----------------------------------------------------------------
pci-v5.2-fixes-1

----------------------------------------------------------------
Logan Gunthorpe (1):
      PCI/P2PDMA: Ignore root complex whitelist when an IOMMU is present

 drivers/pci/p2pdma.c | 4 ++++
 1 file changed, 4 insertions(+)
