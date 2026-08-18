Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CB175A74
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092403; cv=none; b=NPNRMWDhedoQJVpkZLmV8JEqs+1zrnmLBSqq3hHpfJ++Ef5I5J2GTbviMud+2IUVZyaY5/GJZObyowJZsMpp9QlgnNphhGxw53YapNkpNYw6c2bm0RbPWwVMPo9PjKLatmd2Rv0ZCcHGklq+0LxlVlh42wsLhrj3966BlJiNEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092403; c=relaxed/simple;
	bh=Y6VUoe4sQOsaIVfIb3SSWkD8obRTW2FBtjyeuzeq9eM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fvr0LSTFPF4T4hU2N0mvAnFKzMcIEv+970noa418qmkkna+VxT2KxEaG2aMyRPE7niNpF9YMhSphcdXToBBwTgr+jGKY3u4Vji64SYOth5IzbOtZRbg5cjLItF1LS6NSku1VUoPstw/lfTMQy8AgJ7fkDsVUZpgoqOoh/RYoUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDKv/9ep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDKv/9ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F6A1F000E9;
	Tue, 18 Aug 2026 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787092401;
	bh=VzIoIlZm6E4Py29G+xr1f5KcVWWzvZl6UCHZeZxLjCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GDKv/9epMcQOnQr52iagRqKynBMi0oAe8yVGSpPK0pK5VDvwy2wAnz1+TJ+wM3USF
	 23JCrHcc6MGakkTC6ZG7+kTFeRyeIHjywRR/arR8K41O5cmuOAMSyDnjWq8jdi+qwO
	 JNI8a2wPBXzkhkMXB8ziutbCfDCqpx0d1VmeGbvKiUDLF9vwMf9dLIYZvhdT9SrnoI
	 lMbeLRIiWac59fwhuQjR72AG04y1NLWN9lLmu7DWkJZ/L4EbrAMg8qQcmMmDaQCyts
	 bHbQELngutqF6dhbhRYS1Drg9Ze6poXcNBQ4K3HrjTr8jyIxxazSCYEcVyyUsoykXm
	 etG89O6ffadgg==
Date: Tue, 18 Aug 2026 17:33:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH] PCI/AER: Fix ratelimit and log level of Advisory
 Non-Fatal Errors
Message-ID: <20260818223320.GA754605@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120da0565eac0157ffd913423c7cfa66e985ff59.1786800931.git.lukas@wunner.de>

On Sat, Aug 15, 2026 at 03:47:10PM +0200, Lukas Wunner wrote:
> When Advisory Non-Fatal Errors are reported, the Uncorrectable Error bits
> should be reported using the same ratelimit counter and log level as the
> accompanying Correctable Error.
> 
> This is done correctly when they are handled natively in aer_print_error()
> but it is not done correctly when they are handled in Firmware First mode
> in pci_print_aer().
> 
> Fix it.
> 
> Fixes: 21963e6e4e04 ("PCI/AER: Support Advisory Non-Fatal Errors")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> The offending commit is the top-most one on pci/aer (queued for v7.3-rc1).
> This fix could either be folded into or applied on top of it.

Folded in, thanks!

>  drivers/pci/pcie/aer.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2a380bb..dd2aa5d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1028,13 +1028,15 @@ int cper_severity_to_aer(int cper_severity)
>  EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		   struct aer_capability_regs *aer)
> +static void __pci_print_aer(struct pci_dev *dev, int aer_severity,
> +			    struct aer_capability_regs *aer,
> +			    bool ratelimit_print, const char *level)
>  {
>  	const char *bus_type, *sev;
>  	int tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info = {
> +		.level = level,
>  		.severity = aer_severity,
>  		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
>  	};
> @@ -1043,12 +1045,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
>  		sev = "cor";
> -		info.level = KERN_WARNING;
>  	} else {
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
>  		sev = "uncor";
> -		info.level = KERN_ERR;
>  		tlp_header_valid = tlp_header_logged(status & ~mask,
>  						     aer->cap_control);
>  	}
> @@ -1067,7 +1067,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	 * For Advisory Non-Fatal Errors, record statistics and tracing
>  	 * even if ratelimited
>  	 */
> -	if (!aer_ratelimit(dev, info.severity))
> +	if (!ratelimit_print)
>  		goto anfe;
>  
>  	aer_printk(info.level, dev,
> @@ -1094,10 +1094,25 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		if (anfe_status) {
>  			aer->uncor_status = anfe_status;
>  			aer->uncor_mask = 0;
> -			pci_print_aer(dev, AER_NONFATAL, aer);
> +			__pci_print_aer(dev, AER_NONFATAL, aer,
> +					ratelimit_print, level);
>  		}
>  	}
>  }
> +
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer)
> +{
> +	/*
> +	 * Precalculate ratelimit counter and log level so that Advisory
> +	 * Non-Fatal Errors are treated like the accompanying Correctable Error
> +	 */
> +	bool ratelimit_print = aer_ratelimit(dev, aer_severity);
> +	const char *level = aer_severity == AER_CORRECTABLE ? KERN_WARNING
> +							    : KERN_ERR;
> +
> +	__pci_print_aer(dev, aer_severity, aer, ratelimit_print, level);
> +}
>  EXPORT_SYMBOL_GPL(pci_print_aer);
>  
>  /**
> 
> base-commit: 21963e6e4e0425b12d3128eea5a5104a3bc909c4
> -- 
> 2.53.0
> 
