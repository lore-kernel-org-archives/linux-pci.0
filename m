Return-Path: <SRS0=gy3g=6T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78A7C47247
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 11:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A6E20735
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 11:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgEELmU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 May 2020 07:42:20 -0400
Received: from foss.arm.com ([217.140.110.172]:37950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEELmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 07:42:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5315C30E;
        Tue,  5 May 2020 04:42:19 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D643F305;
        Tue,  5 May 2020 04:42:18 -0700 (PDT)
Date:   Tue, 5 May 2020 12:42:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: altera: clean up indentation issue on a return
 statement
Message-ID: <20200505114215.GE12543@e121166-lin.cambridge.arm.com>
References: <20200327134556.265411-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327134556.265411-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 27, 2020 at 01:45:56PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A return statment is indented incorrectly, remove extraneous space.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/altera, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index b447c3e4abad..24cb1c331058 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -193,7 +193,7 @@ static bool altera_pcie_valid_device(struct altera_pcie *pcie,
>  	if (bus->number == pcie->root_bus_nr && dev > 0)
>  		return false;
>  
> -	 return true;
> +	return true;
>  }
>  
>  static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> -- 
> 2.25.1
> 
