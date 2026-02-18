Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE31FC7C5;
	Wed, 18 Feb 2026 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448340; cv=none; b=pW7t1/PfIMKwoR+O4BQ41x5u8HvQncX9QLJddaVlv/HrIBMbd93TGAy5PxrX7fbczgXZ+6oEtNO900DkXfDz9g+evK9OM6j0PdB0nbCj8DT1YxX2Za2Zf0Yxuuoj2rzCFoyMTpvsWwFWkOMA2NiGp1B+a3SsYRdUx6WnxUrJUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448340; c=relaxed/simple;
	bh=/ttJEItCc/N1SCo1cPgCWrMZiePvmzoXTIQZC7x//5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KHNPv1skZX8wcpjHixX0fYq+jBniecZWpw9lRY4SbIMXGRcIouXzSfWxbDYj4kFFMOML2FpV59G8xs4axyKLTJn5JBYIVcFkCPW1428eSWxEuFAmZ8A9vpKTEkEvbUTecEAYOmx4p/o/nd5u3stqQKfgwgo/VYfQUc7LoVV0jlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRc2Z5O5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRc2Z5O5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92358C116D0;
	Wed, 18 Feb 2026 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771448339;
	bh=/ttJEItCc/N1SCo1cPgCWrMZiePvmzoXTIQZC7x//5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qRc2Z5O5XWQWiiH1ENEIq/6n49zbNl8rdTVzjQl7ejxfAkgIVNOTc0jJ6aKCa39di
	 DLlJWavl8EZjR8EkdAG3FOITXosGf/bQgFJhFoHdGtGSV32k6SmqbbCVni8zCUl9vf
	 zSc7UNXf9Jcpx3y0n2m3F0dHCF0DJkK20xX625HY19yvJaTLiqouVJUCRJkEBBSMJY
	 mFbfn0EospZSTJVRJzuYfPa5B7zwpAnYzznFpBR9SEP7V1BII03WHWDvD8qwtQ5Js5
	 LXny4u1Ty2T+FDXTLTrOt1S8ajUS8C8bAM/GlLpLXPTHrNVDWoW2ELHKKVCqZJog+G
	 G3W7/iopo9Dhg==
Date: Wed, 18 Feb 2026 14:58:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: George Abraham P <george.abraham.p@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, giovanni.cabiddu@intel.com
Subject: Re: [PATCH V2 RESEND] PCI/TPH: Skip Root Port completer check for
 RC_END devices
Message-ID: <20260218205858.GA3443049@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109052923.1170070-1-george.abraham.p@intel.com>

On Fri, Jan 09, 2026 at 10:59:23AM +0530, George Abraham P wrote:
> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
> directly integrated into the root complex and do not have an
> associated Root Port in the traditional PCIe hierarchy. The current
> TPH implementation incorrectly attempts to find and check a Root Port's
> TPH completer capability for these devices.
> 
> Add a check to skip Root Port completer type verification for RC_END
> devices, allowing them to use their full TPH requester capability
> without being limited by a non-existent Root Port's completer support.
> 
> For RC_END devices, the root complex itself acts as the TPH completer,
> and this relationship is handled differently than the standard
> endpoint-to-Root-Port model.
> 
> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> Signed-off-by: George Abraham P <george.abraham.p@intel.com>

Applied to pci/enumeration with the following commit log for v7.1,
thanks!  This will be rebased after v7.0-rc1.

    PCI/TPH: Allow TPH enable for RCiEPs
    
    Previously, pcie_enable_tph() only enabled TLP Processing Hints (TPH) if
    both the Endpoint and its Root Port advertised TPH support.
    
    Root Complex Integrated Endpoints (RCiEPs) are directly integrated into a
    Root Complex and do not have an associated Root Port, so pcie_enable_tph()
    never enabled TPH for RCiEPs.
    
    PCIe r7.0 doesn't seem to include a way to learn whether a Root Complex
    supports TPH, but sec 2.2.7.1.1 says Functions that lack TPH support should
    ignore TPH, and maybe the same is true for Root Complexes:
    
      A Function that does not support the TPH Completer or Routing capability
      and receives a transaction with the TH bit [which indicates the presence
      of TPH in the TLP header] Set is required to ignore the TH bit and handle
      the Request in the same way as Requests of the same transaction type
      without the TH bit Set.
    
    Allow drivers to enable TPH for any RCiEP with a TPH Requester Capability.
    
> ---
> v1->v2:
>   - Added "Fixes:" tag to link the commit hash that introduced the code
> ---
>  drivers/pci/tph.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ca4f97be7538..e896b3958281 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -407,10 +407,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	else
>  		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
>  
> -	rp_req_type = get_rp_completer_type(pdev);
> +	/* Check if the device is behind a Root Port */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
> +		rp_req_type = get_rp_completer_type(pdev);
>  
> -	/* Final req_type is the smallest value of two */
> -	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +		/* Final req_type is the smallest value of two */
> +		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +	}
>  
>  	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
>  		return -EINVAL;
> -- 
> 2.40.1
> 
