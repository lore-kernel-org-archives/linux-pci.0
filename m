Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C31C4338F
	for <linux-pci@archiver.kernel.org>; Wed, 18 Aug 2021 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19C5610A3
	for <linux-pci@archiver.kernel.org>; Wed, 18 Aug 2021 11:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhHRLi6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhHRLi6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Aug 2021 07:38:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5737F60FDA;
        Wed, 18 Aug 2021 11:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629286703;
        bh=aDzfwtEULpUKTJYRxiVnKDspw5jwJLol+Nu/stmLGaA=;
        h=Date:From:To:Cc:Subject:From;
        b=NPhTg2D9Edg2nA+5i65ORZv3IPK7Bs6COSJyqM2lmWinyVWpE0rYKiHlRU62xawgA
         iVDlpCFWUpd7V4IMGq4xIKsG7z+opebdsvr5qDssHsyp+zh7rE9ei34gVQNhQYa9sN
         H+kAcQSrPPdT4Yva2jyigJychlcpzX5yQEoCy/4HvOrMtcdkYcy4tqjBGqmsRGVtHY
         +pHdvFCAdcYI3X2g/rF+Ds00oJp+vC7/woZ5YKKy5qmZ0FMMfgGT04mgZRUnb+p+rs
         sIeY2Kk/mdo7am4oF09mzkdcVIsNzIPlPtp0eTfdsNLI0qj6eRPmQJybFG+yNvgYIQ
         mrep56/wpBJag==
Received: by pali.im (Postfix)
        id CCA6768A; Wed, 18 Aug 2021 13:38:20 +0200 (CEST)
Date:   Wed, 18 Aug 2021 13:38:20 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pcie-uniphier: race condition in masking/unmasking interrupts
Message-ID: <20210818113820.fzjeouy6tohbzuad@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

Marc pointed during review of pci-aardvark patches one issue which I see
that is available also in the current pcie-uniphier.c driver.

When masking or unmasking interrupts there is read-modify-write sequence
for PCL_RCV_INTX_MASK_SHIFT register without any locking:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-uniphier.c?h=v5.13#n171

So when trying to mask/unmask two interrupts at the same time there is
race condition as updating that PCL_RCV_INTX_MASK_SHIFT register is not
atomic.

Could you look at it?
