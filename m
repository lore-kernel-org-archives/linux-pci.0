Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE1C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 23:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7D120659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547506846;
	bh=i17pFvBR8ne7ThjBH0wTqjJW56Lhg7jsgKQDWcWmoWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NnPt5qyaLMruIyTgp1tTCLR4Kg1wSu+mYuQX8PHy725yLqwjKdRqRYy1O4rYWnZQG
	 ZuoVyJGApj+v/bRawwZ9+Be8hEHtrkFqGDiG/RdlxDSUyLWOKig2teMz+h83CLRKty
	 KqsTMzoHG6wxNgRHx8s03i9hxxGaANHC5fTOkANE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfANXAp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfANXAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 18:00:45 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EECFC20657;
        Mon, 14 Jan 2019 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547506844;
        bh=i17pFvBR8ne7ThjBH0wTqjJW56Lhg7jsgKQDWcWmoWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRRT4rcnYqtzZhiEXbmarQ4Pk7hTeFEaXkI8usxFdEiaV7ypbZj8ihdtWzEoS7K6y
         qlQplLoUQR2nmsSG4k9kvA9lwLH9ZW/w+FeG0BHgbj47QeMl8mfzpxaR0NvH2w2dyi
         b3z9kscV5QcC2oOUytRBL3XeqLdB4w93vRGpmclU=
Date:   Mon, 14 Jan 2019 17:00:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: annotate implicit fall throughs
Message-ID: <20190114230042.GB33971@google.com>
References: <20190114204137.21094-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114204137.21094-1-malat@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 09:41:36PM +0100, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> In this particular case change a ‘:’ with either a ‘-’ or a ‘,’
> so as to match the regular expression expected by GCC.
> 
> This commit remove the following warnings:
> 
>   drivers/pci/pci.c:861:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/pci/pci.c:2261:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I squashed these and applied the result to pci/misc for v5.1, thanks!

> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c9d8e3c837de..94069fc35e91 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -861,7 +861,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
>  		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
>  			need_restore = true;
> -		/* Fall-through: force to D0 */
> +		/* Fall-through - force to D0 */
>  	default:
>  		pmcsr = 0;
>  		break;
> @@ -2260,7 +2260,7 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  		case PCI_D2:
>  			if (pci_no_d1d2(dev))
>  				break;
> -			/* else: fall through */
> +			/* else, fall through */
>  		default:
>  			target_state = state;
>  		}
> -- 
> 2.19.2
> 
