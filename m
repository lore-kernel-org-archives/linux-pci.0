Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C0397E60
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898391; cv=none; b=nZGWnobSkQAPWFaM4V6ItvRAHvgnykWmPbmb697lFk4DgZFbArEZMtH5eJ3USbP6ad39g7T6Uictwdje78u2Oz2KB/f2dvyxnUFZXFjG519wBElTJosaoUKMwch/QOHTiX5fnsqd+IScvwgtUFLOSnxrFuzvXQHbl9X99GojWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898391; c=relaxed/simple;
	bh=f2moM282vPvyLgsGb1zIT4CivF0cYkAINWw6P3Qsu3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e21MizCwwFgcr7YI4mxIttGPCepbUwuEj8pCtxEZFlyzhy63vj9Woa+Rputqso8Vw72zbnRJCNVECgT14CXKLEIMKMHAw/NVsDxS/kyNuazYgRvFqvXnuabz5PLWR0T0a9ELgdsqt0zVarfy0+tlFGD6YJn2huZHft8zmDr6aLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofwVknvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofwVknvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B17FC2BC9E;
	Mon, 30 Mar 2026 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774898391;
	bh=f2moM282vPvyLgsGb1zIT4CivF0cYkAINWw6P3Qsu3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ofwVknvcK53YQ8AnfEsD07hNUQYx9UMoC2QRm+p2b4iBIOkITweay5u2bpDph774S
	 fgYrhxg2/6b3p9sTyU5QSgY2RS3bHfpEA4f9+SSMhxRUDkvty3b8pj8t+RnPcGDC4x
	 SRL5Yj4Hm6GuzRSnPVZCfsciJxC0xKL+09ajChWnc+G7+r54MQwMkpEJlWT1u1y0AH
	 AhtG/Jxna1HCSVyof0WxnHt14ATr4QbqYtnHB06lKxZs4WfWZArIYbbXbvLdFS9ttz
	 iIFwcg9JxJq1giOE1undMWFh0zxXoXiD2cnZ6ha8oyTWr5Z8POQWev3LMWcfUrjvTf
	 lE3+jWGhyEuyA==
Date: Mon, 30 Mar 2026 14:19:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] PCI/AER: Stop ruling out unbound devices as error source
Message-ID: <20260330191949.GA90884@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>

On Fri, Mar 27, 2026 at 10:56:43AM +0100, Lukas Wunner wrote:
> When searching for the error source, the AER driver rules out devices
> whose enable_cnt is zero.  This was introduced in 2009 by commit
> 28eb27cf0839 ("PCI AER: support invalid error source IDs") without
> providing a rationale.
> 
> Drivers typically call pci_enable_device() on probe, hence the enable_cnt
> check essentially filters out unbound devices.  At the time of the commit,
> drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
> and so any AER-enabled device could be assumed to be bound to a driver.
> The check thus made sense because it allowed skipping config space
> accesses to devices which were known not to be the error source.
> 
> But since 2022, AER is universally enabled on all devices when they are
> enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
> AER is native").
> 
> Errors may very well be reported by unbound devices, e.g. due to link
> instability.  By ruling them out as error source, errors reported by them
> are neither logged nor cleared.  When they do get bound and another error
> occurs, the earlier error is reported together with the new error, which
> may confuse users.  Stop doing so.
> 
> Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+

Applied to pci/aer for v7.1, thanks!

> ---
>  drivers/pci/pcie/aer.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4299c55..384d026 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1039,8 +1039,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	 *      3) There are multiple errors and prior ID comparing fails;
>  	 * We check AER status registers to find possible reporter.
>  	 */
> -	if (atomic_read(&dev->enable_cnt) == 0)
> -		return false;
>  
>  	/* Check if AER is enabled */
>  	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
> -- 
> 2.51.0
> 
