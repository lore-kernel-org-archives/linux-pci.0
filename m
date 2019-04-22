Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6B8C282CE
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 23:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B8C2073F
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 23:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfDVXu7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:50:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44476 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfDVXu5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 19:50:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hIii7-00071K-6A; Mon, 22 Apr 2019 17:50:57 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hIii6-0004Bz-Ii; Mon, 22 Apr 2019 17:50:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 22 Apr 2019 17:50:51 -0600
Message-Id: <20190422235053.16073-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kchow@gigaio.com, yinghai@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 0/2] Fix a pair of setup bus bugs.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey,

This is largely a resend to get some more attention. I've attempted to clean
up and expand on the commit message of the first commit because the
bug is a bit of a nightmare to explain and follow. There's a lot more
information on the first commit in the original thread here[1] including
instructions on how to reproduce it in QEMU.

The second patch fixes an unrelated bug, with similar symptoms, in
the same code. It was a lot easier to debug and the reasoning should
hopefully be easier to follow, but I don't think it was reviewed much
during the first posting due to the nightmare in the first patch.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/de3e34d8-2ac3-e89b-30f1-a18826ce5d7d@deltatee.com/T/#m96ba95de4678146ed46b602e8bfd6ac08a588fa2

Logan Gunthorpe (2):
  PCI: Prevent 64-bit resources from being counted in 32-bit bridge
    region
  PCI: Fix disabling of bridge BARs when assigning bus resources

 drivers/pci/setup-bus.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--
2.20.1
