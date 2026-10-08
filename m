Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274048E0FF
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502334; cv=none; b=Z45GdKOUIFNx1xTIVJUp6iDtOBT1IcixRTNqkEiTLIH6M2qNbbh16ygdXg4Miui1W8cFgoTSgvCvId8sKvMWlsWin0cHhozXun9+vfoXNWx0fcDq/rma3CNDccm735OPAZ4f7NM8oL1APJJvNINAnII4Lc0ax5yYY5zHihYBdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502334; c=relaxed/simple;
	bh=jKACp5PIwwoMGdhZo8jXSNIaPvhgavWw0mD2H57QeY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eQ6G3Q2htYB4uUHd7h5ynzaMEJ0PbGP0wKX66Yh5fQCsIrTnNMXkdzRs0QvwCxtQrwHAsJe66CQ4LRYWZrWa0o+N6oHcik49gDHyNz5gErWJItV0uxCFsSi/MCcoag54b1yOZRd2z0V/l5fEZSYe1ybahawM+pU2Q8SCBo3da40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtQnSyx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtQnSyx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1307F1F000FF;
	Thu,  8 Oct 2026 23:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502332;
	bh=1N+w3WWSQNETMJX6ubIaAfmGPAYivUa4LtHLmaoK7+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OtQnSyx6o9tgMtlDRz2wBud6ogXjWstJtWKRUsogn/Rh6lvKTXMSTU/R/hwHBYizH
	 ld8di69yXhNwAXHQh1zkasrn9t6eNw/3fjBu4AJ5TcJ9n/j4NGbnmkGtA+bvAt9jjE
	 i2eSvx0QY4gKVD3wQdb+/J0WD2t/U6WvLMSvbB7M27myQJha1qB5nxjTs/4rvSucdI
	 P8fshxFPQmfDE8dATKgCKBn6bN1eTw7ruUR0SQamI2TCXABLA6xBAG9gt20tu2nMFd
	 c3THGMn+AinDMfrxdhBDaBHWO0VCq7O2+jiTQ2nl2HoC175xN7lwSQYZum3GrrCifA
	 M3/OxKKUSNUTA==
Date: Thu, 8 Oct 2026 18:32:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy devices created by pwrctrl core
Message-ID: <20261008233211.GA941209@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1791446700-100166-1-git-send-email-shawn.lin@rock-chips.com>

On Thu, Oct 08, 2026 at 04:05:00PM +0800, Shawn Lin wrote:
> pci_pwrctrl_create_device() only creates platform devices for OF nodes
> that pci_pwrctrl_is_required() accepts, but pci_pwrctrl_destroy_device()
> unregisters the platform device of every available child node without
> that check.
> 
> Nodes under a PCI host controller that are not pwrctrl devices may have
> been populated by another mechanism.  Destroying them here would tear
> down devices owned by other code.
> 
> Mirror the check done at creation time so that only devices created by
> the pwrctrl core are removed.
> 
> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/pwrctrl for v7.4, thanks!

Tearing down devices owned by other code sounds like an issue; maybe
this should have a cc: stable tag, since 4c4132489201 appeared in
v7.0?

> ---
> 
>  drivers/pci/pwrctrl/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 10d817a..c14df11 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -388,6 +388,9 @@ static void pci_pwrctrl_destroy_device(struct device_node *np)
>  	for_each_available_child_of_node_scoped(np, child)
>  		pci_pwrctrl_destroy_device(child);
>  
> +	if (!pci_pwrctrl_is_required(np))
> +		return;
> +
>  	pdev = of_find_device_by_node(np);
>  	if (!pdev)
>  		return;
> -- 
> 2.7.4
> 
