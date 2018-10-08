Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24804C6787D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3B720882
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1U6mfkzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3B720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJHKgy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeJHKgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 06:36:54 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DAE2077C;
        Mon,  8 Oct 2018 03:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538969241;
        bh=kqvechI+pHkfFNCfTkBq/37g5ay98vkSKwva6T3iAbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1U6mfkzFeAhKCbBC5AFICHSpU4aO3VxU/fiPfavd3vVlBT5B7sFtDtBQRYtg2pAZG
         z6S9R71O8k5Xtzq/FIRgTNC1fxff+XWY0Rj1BhX4HBxGSeVDehY/BRw4+5P0yjUkj4
         Ddjx/eQOehyjS9kw79Pg7bBuK6Tx+8aFeUG6fbiA=
Date:   Mon, 8 Oct 2018 11:26:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH 2/3] PCI: imx: Add multi-pd support
Message-ID: <20181008032657.GF3587@dragon>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
 <5832128f3b1822839a0f0bbd1cf8313cf586f15f.1538426534.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5832128f3b1822839a0f0bbd1cf8313cf586f15f.1538426534.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 11:56:17PM +0300, Leonard Crestez wrote:
> On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> which can be power-gated independently. The driver needs to handle this
> by keeping both domain active.
> 
> This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
> it's own domain. Defining the DISPMIX domain requires a way for pcie to
> keep it active or it will break when displays are off.
> 
> The power-domains on imx6sx are meant to look like this:
> 	power-domains = <&pd_disp>, <&pd_pci>;
> 	power-domain-names = "pcie", "pcie_phy";
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Bindings document fsl,imx6q-pcie.txt should probably be updated for the
new power domain support.

Shawn
