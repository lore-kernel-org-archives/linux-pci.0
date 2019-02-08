Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F2C282D7
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7310E20844
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549635841;
	bh=NyuR7vjKA9+mNS82qtwHGuir1nlBMSH618URsrT3kCY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Y4ojTe19jVytA0xB8KrWuXQs6vHz6qvTdlCHByQq9RVGR0DFXXcyr+gk8OkR7OBs/
	 uRoGP27/okdoCQzqbXTBOE5a0eQ0blyiZk+XfOKYzn/tsXlGCuuQxPZsFuTiRzkJP2
	 OuhyLoOLeCQopIVsM6a7yhTH3JWvAiERu4xrulmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBHOXz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbfBHOXz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 09:23:55 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BA82083B;
        Fri,  8 Feb 2019 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549635834;
        bh=NyuR7vjKA9+mNS82qtwHGuir1nlBMSH618URsrT3kCY=;
        h=Date:From:To:Cc:Subject:From;
        b=QCfznIxqnuYV/D1HgnesZejhW+80BZHqhYCb7xmkiasAAwX0Xq5U5kYX0l9JhXQkS
         HThp/1qKm6vHP8u7dLOH8S34qnfZBLajNLg0FsEdIio2iwG4xo3Ymc5rUmTejhyh3P
         6/F4ayDPKtYhzmjVtbPOA65aX+zzkZkW2vCfOKDQ=
Date:   Fri, 8 Feb 2019 08:23:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [GIT PULL] PCI fixes for v5.0
Message-ID: <20190208142353.GV7268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX) that
    breaks PCIe on I.MX SoCs (Thinh Nguyen)


The following changes since commit f14bcc0add3abecceca1a3fe538c4ec9566893f3:

  Revert "PCI: armada8k: Add support for gpio controlled reset signal" (2019-01-31 15:07:29 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-4

for you to fetch changes up to f57a98e1b71357713e44c57268a53d9c803f0626:

  PCI: Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX) (2019-02-06 17:17:27 -0600)

----------------------------------------------------------------
pci-v5.0-fixes-4

----------------------------------------------------------------
Thinh Nguyen (1):
      PCI: Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX)

 drivers/pci/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
