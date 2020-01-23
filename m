Return-Path: <SRS0=5Mj4=3M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26614C2D0DB
	for <linux-pci@archiver.kernel.org>; Thu, 23 Jan 2020 14:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEEE214AF
	for <linux-pci@archiver.kernel.org>; Thu, 23 Jan 2020 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579789893;
	bh=JYFEOMV9i7fMciXNWyzIDQncp61tLKvOlQwltu1/3w8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hbgD9gftxXYb11dcH7tUIsxCdw+Ww362x//+MiuqONesTCReqfNIO4SnTLG+UJsYC
	 5DIkm4XszpktdHNhvzI9xMuhHoK85mNMXTvragPsMa266ZS1lLIkoSB+896zReQV7J
	 GRjyMEGfeheY8sie8lhh5iqwkWe+ns267l+AlH1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgAWObc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:31:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgAWObc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 09:31:32 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA112087E;
        Thu, 23 Jan 2020 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579789891;
        bh=JYFEOMV9i7fMciXNWyzIDQncp61tLKvOlQwltu1/3w8=;
        h=Date:From:To:Cc:Subject:From;
        b=Q7LpRHaJSSwH5Q+NVTe/OKjUqebIypEG8WWQvYz/Bkitmy2wsHjX2IqdmnF6EgBJC
         GzSuSV5pDUnejC6kCt6Z08IhVPKIqjilG/EOmzYp6xWRKJ4j9I2dm5fJPdQ8Zjv37f
         asbOWYrNXuGBbFFJmg/2tj7FC8JvinUttjl0VNlw=
Date:   Thu, 23 Jan 2020 08:31:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [GIT PULL] PCI fixes for v5.5
Message-ID: <20200123143129.GA101517@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Mark ATS as broken on AMD Navi14 GPU rev 0xc5 (Alex Deucher)


The following changes since commit ca01e7987463e8675f223c366e262e82f633481a:

  PCI: rockchip: Fix IO outbound ATU register number (2019-12-12 15:25:37 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.5-fixes-2

for you to fetch changes up to 5e89cd303e3a4505752952259b9f1ba036632544:

  PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken (2020-01-15 16:23:04 -0600)

----------------------------------------------------------------
pci-v5.5-fixes-2

----------------------------------------------------------------
Alex Deucher (1):
      PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken

 drivers/pci/quirks.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
