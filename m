Return-Path: <SRS0=NHSM=6H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BEAC54FCB
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F227920776
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587667457;
	bh=oH8i6inFuj5Rng6ApjOBTWHiTe3t7pOyuJtNWpC4a0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=RPIa9aPyXE9aEoCrV7B/KJ5hJINdCr+PTN7aMw2Ha4X55dQRY4RM64ekLSqVLmjpk
	 sKZEkZmSkWv8RAgVAoh0I+5zCmS46cCTcGJYxB82ovNueq6er3GChssX9DmytVy/3q
	 E5ROOBePV2Ezqx8gOJEXDzAdY0n3kMI5VYI9Qqqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgDWSoQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDWSoQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 14:44:16 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457C920704;
        Thu, 23 Apr 2020 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587667455;
        bh=oH8i6inFuj5Rng6ApjOBTWHiTe3t7pOyuJtNWpC4a0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YpZXepEhHlNZSPjCzpqUTY3unaPhtScEXHdtET5aPThZYMhI0xORsXgtR6iA05KPX
         mm94fslsO9ZvX5ec0pKSpUikLMwaYCCb6a0diBU0z8W/acJuhhKuUzcYigNX2k4mIY
         4INQ3b0BFtxin/2ZBo9xqxDzMGT+8exdDi29983M=
Date:   Thu, 23 Apr 2020 13:44:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/9] PCI: aardvark: add FIXME comment for
 PCIE_CORE_CMD_STATUS_REG access
Message-ID: <20200423184413.GA202435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-6-marek.behun@nic.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Tue, Apr 21, 2020 at 01:16:57PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Register PCIE_CORE_CMD_STATUS_REG is applicable only when the controller
> is configured for Endpoint mode, which is not the case for the current
> version of this driver.
> 
> Add a FIXME comment, since this needs to be explained, removed or fixed.

If it's not applicable, why not just remove it?

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index e2d18094d8ca..e893d7d8859f 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -429,6 +429,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  
>  	advk_pcie_train_link(pcie);
>  
> +	/*
> +	 * FIXME: Following code which access PCIE_CORE_CMD_STATUS_REG register
> +	 *        is suspicious. This register is applicable only when the PCI
> +	 *        controller is configured for Endpoint mode. And not when it
> +	 *        is configured for Root Complex.
> +	 */
>  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>  	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
>  		PCIE_CORE_CMD_IO_ACCESS_EN |
> -- 
> 2.24.1
> 
