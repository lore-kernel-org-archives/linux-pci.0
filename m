Return-Path: <SRS0=wtdp=DJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2908C4363D
	for <linux-pci@archiver.kernel.org>; Fri,  2 Oct 2020 12:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6832420874
	for <linux-pci@archiver.kernel.org>; Fri,  2 Oct 2020 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601640056;
	bh=Sr90evd9gcNYgaoF17OoqAbGXM9qXNWcrxXuzdz7v40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WBtcub0KKrOXb/FPQ3PkpmR16kxNJFoU+dP0COV7tzivi+QF+u5jk+UWCF5XQVEkA
	 MHsipX9nzlrseiwgSw18P4IhoeM6ZqVNKEbiA0MG6Pu5zbP7tk4gSpm0+2VBbSuctn
	 XUSNZJ+CgBFITAQ1qchvM5P/YH3jEh6513Ut29cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBMAz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMAz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 08:00:55 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE09206C9;
        Fri,  2 Oct 2020 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601640055;
        bh=Sr90evd9gcNYgaoF17OoqAbGXM9qXNWcrxXuzdz7v40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhoNDI0F1WeWxvof9iTBiHlzUYB7yl/wCXUVMZBInL8gGWKaUvARFAAeoUmiPqv9H
         wAW/p2Vb4fKSS6SlDpPFTz/XLBbMN2rambZGagb8Y6o+AW8NYxJiW0mL5+KtExfc+z
         o8WFSJOo0aabEfkwCmiyM5HJdDbuHM5WCWb8j5Hs=
Received: by pali.im (Postfix)
        id 541DBE79; Fri,  2 Oct 2020 14:00:52 +0200 (CEST)
Date:   Fri, 2 Oct 2020 14:00:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
Message-ID: <20201002120052.jouqx6ap4wrskozs@pali>
References: <20200902144344.16684-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902144344.16684-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 September 2020 16:43:42 Pali Rohár wrote:
> This patch series fixes regression introduced in commit 366697018c9a
> ("PCI: aardvark: Add PHY support") which caused aardvark driver
> initialization failure on EspressoBin board with factory version of
> Arm Trusted Firmware provided by Marvell.
> 
> Second patch depends on the first patch, so please add appropriate
> Fixes/Cc:stable@ tags to have both patches correctly backported to
> stable kernels.
> 
> I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
> and with upstream ATF+uboot and aardvark was initialized successfully.
> Without this patch series on ebin-17.10-uart.zip aardvark initialization
> failed.

Lorenzo or Bjorn, could you review this patch series? I would like to
see this regression fixed in stable kernels.

> Pali Rohár (2):
>   phy: marvell: comphy: Convert internal SMCC firmware return codes to
>     errno
>   PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
>     Firmware
> 
>  drivers/pci/controller/pci-aardvark.c        |  4 +++-
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> -- 
> 2.20.1
> 
