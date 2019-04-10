Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B7C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ECC20818
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDJVFg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:05:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49430 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDJVFg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:05:36 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hEKPV-0000jz-TT; Wed, 10 Apr 2019 15:05:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hEKPV-0001Bw-9K; Wed, 10 Apr 2019 15:05:33 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 10 Apr 2019 15:05:30 -0600
Message-Id: <20190410210532.4538-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 0/2] Fix disable_acs_redir parameter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

This is v2 of my patch to fix the disable_acs_redir paramater.

Per our discussion I've found a much better way which can be
applied to the resource_alignment paramater. Thus, I've included
a second patch that removes the static buffer used there.

I'd appreciate it if the first patch can be applied quickly to
fix the bug I caused. The second patch can go in slowly.

Thanks,

Logan

Logan Gunthorpe (2):
  PCI: Fix issue with "pci=disable_acs_redir" parameter being ignored
  PCI: Clean up resource_alignment parameter to not require static
    buffer

 drivers/pci/pci.c | 96 +++++++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 32 deletions(-)

--
2.20.1
