Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52912 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094AbaDKPqo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Apr 2014 11:46:44 -0400
Message-ID: <53480E5D.1060809@wwwdotorg.org>
Date: Fri, 11 Apr 2014 09:46:37 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Duan Jiong <duanj.fnst@cn.fujitsu.com>, thierry.reding@gmail.com,
	bhelgaas@google.com
CC: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] ARM: tegra: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
References: <1397203000-16586-1-git-send-email-duanj.fnst@cn.fujitsu.com>
In-Reply-To: <1397203000-16586-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/11/2014 01:56 AM, Duan Jiong wrote:
> This patch fixes coccinelle error regarding usage of IS_ERR and
> PTR_ERR instead of PTR_ERR_OR_ZERO.

> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c

> @@ -1024,10 +1024,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
>  		return PTR_ERR(pcie->afi_rst);
>  
>  	pcie->pcie_xrst = devm_reset_control_get(pcie->dev, "pcie_x");
> -	if (IS_ERR(pcie->pcie_xrst))
> -		return PTR_ERR(pcie->pcie_xrst);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
>  }

To be honest, I prefer the existing code. If we needed to add some more
code between the call to devm_reset_control_get() and the return
statement, the diff would be much cleaner if the error-handling path and
the regular return path were kept separate, as they are today.

Why is coccinelle throwing an error? The compiler likely makes identical
code for both source representations.
