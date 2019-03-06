Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D4C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC36820684
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 21:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908081;
	bh=Frdu5OqBdFesZmgxE6dPVvj1FILXYQ6MERqeL4/k74U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N+nKyPn+PETJT0jkTIXYFEryMYbIbIs6Gq7sBlnQGgHwufUcBr4tY5iYFs9wACDlL
	 SbtifQ3M775CbS43NXQLPZB2R6qJubLXMD/76ob+rf3EuMGtpxvIxs8DYDaLKH8aZx
	 CB19yXe8gR10P4MvqAOUlxif/aTL6jaTcAKpnmpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfCFVek (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfCFVej (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Mar 2019 16:34:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BCD20657;
        Wed,  6 Mar 2019 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551908079;
        bh=Frdu5OqBdFesZmgxE6dPVvj1FILXYQ6MERqeL4/k74U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJVxs9+3JK9rWqqmNClEHQL18QpRcbe6UamKe35RAdL7SeZWmw0LZOMHSQ/l8gkgZ
         SG+6QvVw/D2wQe36FZRrPiqMY+I6KRZwR9KcJ5HhZ99eXAtGcx+1g5cAeSqEXQB6UZ
         rST4CFzQg0hnHwTPmun4V2hDXRuEB7HXNRYU2KoE=
Date:   Wed, 6 Mar 2019 15:34:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH] PCI: reword the description of kconfig symbol PCIEPORTBUS
Message-ID: <20190306213437.GA214730@google.com>
References: <20190306061026.25938-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306061026.25938-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 06, 2019 at 06:09:46AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The Virtual Channel service has been removed and Downstream
> Port Containment service has been added, so reword the symbol
> description to consist with the current code.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Applied to pci/misc for v5.1, thanks!

> ---
>  drivers/pci/pcie/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 44742b2e1126..3b7c6124147e 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -8,8 +8,8 @@ config PCIEPORTBUS
>  	help
>  	  This automatically enables PCI Express Port Bus support. Users can
>  	  choose Native Hot-Plug support, Advanced Error Reporting support,
> -	  Power Management Event support and Virtual Channel support to run
> -	  on PCI Express Ports (Root or Switch).
> +	  Power Management Event support and Downstream Port Containment
> +	  support to run on PCI Express Ports (Root or Switch).
>  
>  #
>  # Include service Kconfig here
> -- 
> 2.17.1
> 
