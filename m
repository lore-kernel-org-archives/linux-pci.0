Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F81CDFCA
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487028; cv=none; b=o+gzAvjGlKuiP3iTWCNU73uEMUo/u2HEs027mSlDn8gRf4rkSWA0aQUmq5BqC+qCd+4hZvuh68f537XXnPflGY0s79/5lPE3mx9SphmeyDBvYUrOBuo8650rZy4Or8qL1cinWCAWIFBakv8htJn73yN/gQugSrZGKp/a6n+1sbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487028; c=relaxed/simple;
	bh=CugGcu93ShOu0u+DOUHOJlLstDsCPc7zhrxSTwzfRN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iW7GXqR8FK8c76wRI4rAGH7ZeCIRzE15dC8K6tP7Lk3G3nXPKblFbH8T3VMnkKL9rFdOgnTL7qGYmaqI2QAbDU9htS0Xb4zWT9+J2HjZ5u1ARBWdr5j4MY+dx4HFXDKDDH+V9atv8KpmfgvLShtAlMPNc4/hHBGQG00xUrSZwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVcCJ68u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVcCJ68u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E29B1F000FF;
	Thu,  8 Oct 2026 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487026;
	bh=O1FWBfwWl6paSlptrDmIcyH9EcRMPkhHCGTApLaIGSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WVcCJ68uLOw+zUK6AYaH8Ii9Csm94aDXARP0lkpM9yxwzSLMyj2JxmOuzVfo+3SSn
	 1q2hqILrb8gI4bS2Ht+AUu0df4cCQZsEvFmUtb9b3xiYRybZvJLejhvDQDA66O/QnP
	 n6ShmPlpYHVSpIBykbeHjv64247vBdNZzJg32Tbc2AwncGuWNntpnLoj6ZaG9mUWsV
	 JUXFk1zLH6Z7dy7kK6Oa0e4jh8OpndkS7+pDgykPkOnUeZv1yssNNc0lIuuIaK8KlV
	 fPC+PnSwss3i1ZX05O6coajosFQ0xM6eDELkoUjkX1e4OaVfq8eUxKxZ7vPp4Mpb4g
	 oHmjU8CPWmjrg==
Date: Thu, 8 Oct 2026 14:17:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <20261008191705.GA917105@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>

[+cc Thorsten]

On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> Alex is seeing a probe failure of the amdgpu driver after the Root Port
> above an AMD Navi10 GPU has been reset.  The reset was performed to
> recover from a Firmware First reported Fatal Error.
> 
> However all status registers in the Root Port's AER Extended Capability
> are blank, so apparently the platform firmware raised a false alarm.
> 
> The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> Errors causes code paths to be exercised in platform firmware which
> were never validated before.
> 
> Skip error recovery on false alarms, i.e. if no unmasked errors were
> actually signaled.
> 
> Note that this will also skip recovery if both the Status and Mask
> registers are "all ones", as would be the case for inaccessible devices.
> However that seems justified because it would imply either a hot-unplug
> event or a Surprise Down Error further up in the hierarchy.  Interfering
> with recovery from that seems uncalled for.
> 
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222095
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
since he hasn't tested this change by itself.

If we're confident that this also fixes the MacBookPro16,1 power-off
issue reported by Jason (it would be ideal if you could test this,
Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
If so, I'd like to add Jason's Reported-by and link.

But if we're not sure whether this fixes the MacBookPro16,1 power-off
issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
it with this fix and try again for v7.4.

As far as I'm aware, the reports are:

  https://lore.kernel.org/all/CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW53m_ThtUQ@mail.gmail.com/
    Alex's report for AMD Navi10 and Vega20

  https://lore.kernel.org/all/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com
    Jason's report of power-off issue on MacBookPro16,1

> ---
>  When applied to pci/for-linus, this will cause a conflict during the
>  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
>  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
>  
>  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
>  and move the pci_dev_put() out of the if-clause (so that it gets
>  called if pdev != NULL but err == 0).
>  
>  If this is all too complicated and/or late, I can respin on top of
>  pci/aer or v7.4-rc1.
>  
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..922a726a52a5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_recover_entry,
>  
>  static void aer_recover_work_func(struct work_struct *work)
>  {
> +	struct aer_capability_regs *regs;
>  	struct aer_recover_entry entry;
>  	struct pci_dev *pdev;
> +	u32 err;
>  
>  	while (kfifo_get(&aer_recover_ring, &entry)) {
>  		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_struct *work)
>  		}
>  		pci_print_aer(pdev, entry.severity, entry.regs);
>  
> +		regs = entry.regs;
> +		if (entry.severity == AER_CORRECTABLE)
> +			err = regs->cor_status & ~regs->cor_mask;
> +		else
> +			err = regs->uncor_status & ~regs->uncor_mask;
> +
>  		/*
>  		 * Memory for aer_capability_regs(entry.regs) is being
>  		 * allocated from the ghes_estatus_pool to protect it from
> @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_struct *work)
>  		ghes_estatus_pool_region_free((unsigned long)entry.regs,
>  					    sizeof(struct aer_capability_regs));
>  
> -		if (entry.severity == AER_NONFATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_normal,
> -					 aer_root_reset);
> -		else if (entry.severity == AER_FATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_frozen,
> -					 aer_root_reset);
> +		if (err) {
> +			if (entry.severity == AER_NONFATAL)
> +				pcie_do_recovery(pdev, pci_channel_io_normal,
> +						 aer_root_reset);
> +			else if (entry.severity == AER_FATAL)
> +				pcie_do_recovery(pdev, pci_channel_io_frozen,
> +						 aer_root_reset);
> +		}
>  		pci_dev_put(pdev);
>  	}
>  }
> -- 
> 2.53.0
> 
