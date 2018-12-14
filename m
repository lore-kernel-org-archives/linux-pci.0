Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B7C43444
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D3C208C2
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 20:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544819447;
	bh=T/Kz7SQK7e/vpcoFtwwgemH7d/aZrtFdxpZmdl05Q7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sN/lBjG1+vkgc009N9YFcXNL+bEMKivz9D6jBVlYS7mACi+lgNXdQ1DcIOjbj5tQr
	 M9fLrnwqmQcjDONQwU/j8PwTWk1QAhCWHgPxm6RskiDHGxep2+qVBsqkbMcErhU57F
	 dgKrIRQGCI566XUABZetAxiyJ/v5cjVx0AQ1ggAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeLNUaq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:30:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbeLNUaq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 15:30:46 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECA62080F;
        Fri, 14 Dec 2018 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544819445;
        bh=T/Kz7SQK7e/vpcoFtwwgemH7d/aZrtFdxpZmdl05Q7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSXX1g+YKKt0l2EjofPGUwxuMIjAWquw8WWBrqI5MVxBKOT6HP1OB8FMCFiXp0CRA
         vsEuvbXTARog6vLvgbCY4AKoQd6Dl5PhAv6+BG2tzZ7+6bx8s1ZsPp7o1ncbe0eTAR
         oTEWqzn7vQhXD1HrZTG4Oa8Ra3NJaKvqkUMvUvjY=
Date:   Fri, 14 Dec 2018 14:30:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        cphealy@gmail.com, l.stach@pengutronix.de,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
Message-ID: <20181214203042.GC20725@google.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206073545.10967-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Gustavo for fallthrough annotation]

On Wed, Dec 05, 2018 at 11:35:45PM -0800, Andrey Smirnov wrote:
> Add code needed to support i.MX8MQ variant.

> @@ -245,7 +253,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 tmp;
>  
> -	if (imx6_pcie->variant == IMX7D)
> +	if (imx6_pcie->variant == IMX7D ||
> +	    imx6_pcie->variant == IMX8MQ)

This style looks like a maintenance problem: the code below is probably
IMX6-specific, and you should test for *that* instead of adding to this
list of things that are *not* IMX6, because that list is likely to
continue growing.  There are more occurrences below.

> @@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	switch (imx6_pcie->variant) {
>  	case IMX7D:
> +	case IMX8MQ: /* FALLTHROUGH */
>  		reset_control_assert(imx6_pcie->pciephy_reset);
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;

I'm not an expert on fallthrough annotation (Gustavo, cc'd, is), but
this looks wrong.  It's the IMX7D case that falls through, not the
IMX8MQ case.

The recent annotations added by Gustavo are at the point where the
"break" would normally be, e.g.,

  case IMX7D:
    /* fall through */                    <--- annotation
  case IMX8MQ:
    <code>
    break;

But in this case there's actually no IMX7D-specific *code* there, so I
suspect the annotation is unnecessary.  It's obvious that IMX7D and
IMX8MQ are handled the same, so there's really no opportunity for the
"forgotten break" mistake -Wimplicit-fallthrough is trying to find.

If we *do* want this annotation, we should spell it the same as
Gustavo has been, i.e., "fall through".

Again, more occurrences below.

Bjorn
