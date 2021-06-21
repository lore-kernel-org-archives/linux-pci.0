Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E8C4743C
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jun 2021 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCAE60FF2
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jun 2021 14:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFUO0e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:26:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUO0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 10:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE8FBD6E;
        Mon, 21 Jun 2021 07:24:17 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C9C93F694;
        Mon, 21 Jun 2021 07:24:16 -0700 (PDT)
Date:   Mon, 21 Jun 2021 15:24:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] PCI: imx6: Limit DBI register length for imx6qp PCIe
Message-ID: <20210621142414.GB27516@lpieralisi>
References: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
 <1613789388-2495-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1613789388-2495-2-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 20, 2021 at 10:49:48AM +0800, Richard Zhu wrote:
> Define the length of the DBI registers and limit config space to its
> length. This makes sure that the kernel does not access registers beyond
> that point that otherwise would lead to an abort on the i.MX 6QuadPlus.
> 
> See commit 075af61c19cd ("PCI: imx6: Limit DBI register length") that
> resolves a similar issue on the i.MX 6Quad PCIe.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)

I'd like to merge this patch since I believe it is still required,
please let me know if that's not the case.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0cf1333c0440..853ea8e82952 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1175,6 +1175,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.variant = IMX6QP,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> +		.dbi_length = 0x200,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> -- 
> 2.17.1
> 
