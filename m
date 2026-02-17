Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FE36E475
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344681; cv=none; b=mBpzp2TtxQv/zI+3bwt369tl3uKGgRNdVsdIkx4EhJM7rDuLkMsGCFXyANiJvKtcKjfODVgyxCj1SSd33QLwom/pcK2nM8JWiaIGS1la7i1k4pAS2xRTbKQHV19PocF/5HeV9t05BTCoIMPef6gb4JFteVAA+tLPVoDEJXbEbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344681; c=relaxed/simple;
	bh=28BzoBXIOX9p4kVAfbqN4gzQmpmGYGqOr6Sc5MMD8pA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Syv2fIuf2mq98TvqotepqEpSG6Fi53X4AeJzUWXQOtWxLLfZgcz2OI4LsDWPG7sS5GYHs39ec4odNCv+IUTaicVggDP+VuM7nTE2Km2ihwrvOaNKuCYoySxNmIBlnJr0J0dJnNrboheaiMJW6KIxhiDCZNHWgVnzJw+lNKXoEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CChDiZfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CChDiZfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28545C4CEF7;
	Tue, 17 Feb 2026 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771344681;
	bh=28BzoBXIOX9p4kVAfbqN4gzQmpmGYGqOr6Sc5MMD8pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CChDiZfndJ91zPxGJ3ooX3L2n0RklzFx+BfHxLWYS0PnaL+wTkOF8M6UUI97elLlv
	 nm59BFsgvZ5lW1udbltSg+Fhe8CxZd2/vkSqcr8X8A0H8eb+A8gI5113IqImJvBqz+
	 6hpP6WxFKYqd1ar/mDaR7bLPcL0K35OsvxsKO7hE8mJB1oWOQTk0ynzEAMwAB9znci
	 4mUdzgAVjxfnwwPkIiF96KYzWrcNVu5s0EVlxzsPIkpn7qH+dJIQLmAS01Xv2850wU
	 2OHMdyTwKM20LFCwEKpALJlt/nDXdVo1zPcZvQ1rwR+QtqDKDunGWIh1+tChzDzxVW
	 IMfbVy7cCxKhw==
Date: Tue, 17 Feb 2026 10:11:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Adria Vilanova Martinez <me@avm99963.com>
Subject: Re: [PATCH] PCI/ASPM: Fix pci_clear_and_set_config_dword() usage
Message-ID: <20260217161119.GA3378634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c1752d7512eed0f4ea57b84b12d7ee08ca61fc5.1771226659.git.lukas@wunner.de>

On Mon, Feb 16, 2026 at 08:46:13AM +0100, Lukas Wunner wrote:
> When aspm_calc_l12_info() programs the L1 PM Substates Control 1 register
> fields Common_Mode_Restore_Time, LTR_L1.2_THRESHOLD_Value and _Scale, it
> invokes pci_clear_and_set_config_dword() in an incorrect way:
> 
> For the bits to clear it selects those corresponding to the field.  So far
> so good.  But for the bits to set it passes a full register value.
> pci_clear_and_set_config_dword() performs a boolean OR operation which
> sets all bits of that value, not just the ones that were just cleared.
> 
> Thus, when setting the LTR_L1.2_THRESHOLD_Value and _Scale on the child of
> an ASPM link, aspm_calc_l12_info() also sets the Common_Mode_Restore_Time.
> That's a spec violation:  PCIe r7.0 sec 7.8.3.3 says this field is RsvdP
> for Upstream Ports.  On Adrià's Pixelbook Eve, Common_Mode_Restore_Time
> of the Intel 7265 "Stone Peak" wifi card is zero, yet aspm_calc_l12_info()
> does not preserve the zero bits but instead programs the value calculated
> for the Root Port into the wifi card.
> 
> Likewise, when setting the Common_Mode_Restore_Time on the Root Port,
> aspm_calc_l12_info() also changes the LTR_L1.2_THRESHOLD_Value and _Scale
> from the initial 163840 nsec to 237568 nsec (due to ORing those fields),
> only to reduce it afterwards to 106496 nsec.
> 
> Amend all invocations of pci_clear_and_set_config_dword() to only set bits
> which are cleared.
> 
> Finally, when setting the T_POWER_ON_Value and _Scale on the Root Port and
> the wifi card, aspm_calc_l12_info() fails to preserve bits declared RsvdP
> and instead overwrites them with zeroes.  Replace pci_write_config_dword()
> with pci_clear_and_set_config_dword() to avoid this.
> 
> Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220705#c22
> Tested-by: Adrià Vilanova Martínez <me@avm99963.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.11+

Applied to pci/aspm for v7.1, thanks!  Will be rebased after v7.0-rc1.

> ---
> Only a "Link" tag, not a "Closes" tag because this patch is just a
> byproduct that was created while working on the above-linked bugzilla.
> The actual root cause of the bugzilla seems to be an ASPM erratum
> of the Sunrise Point PCH which needs to be addressed in coreboot.
> 
>  drivers/pci/pcie/aspm.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cedea47..a1f2752 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -706,22 +706,29 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
>  	}
>  
>  	/* Program T_POWER_ON times in both ports */
> -	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
> -	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
> +	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
> +				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
> +				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
> +	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
> +				       PCI_L1SS_CTL2_T_PWR_ON_VALUE |
> +				       PCI_L1SS_CTL2_T_PWR_ON_SCALE, ctl2);
>  
>  	/* Program Common_Mode_Restore_Time in upstream device */
>  	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> -				       PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
> +				       PCI_L1SS_CTL1_CM_RESTORE_TIME,
> +				       ctl1 & PCI_L1SS_CTL1_CM_RESTORE_TIME);
>  
>  	/* Program LTR_L1.2_THRESHOLD time in both ports */
>  	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>  				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>  				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
> -				       ctl1);
> +				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
>  	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
>  				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>  				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
> -				       ctl1);
> +				       ctl1 & (PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +					       PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
>  
>  	if (pl1_2_enables || cl1_2_enables) {
>  		pci_clear_and_set_config_dword(parent,
> -- 
> 2.51.0
> 
