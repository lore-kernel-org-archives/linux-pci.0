Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107A560AD1;
	Tue,  8 Sep 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886398; cv=none; b=rI36WnlGNtPd6T1mA8Mp7ghUjhNcsUVeMNSy1ioQge/jXLOklsso2QSCDEnbGpalSTTFVcYh0kZgL/4BBPGC7n7lHAFUEmEZY6voBz7XaWBdMHpWE6HIFRKI2GgEcNkYRRmOtprj6Cp+2zhSNeNSb6mYOWu7wA2KgB34WzpOFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886398; c=relaxed/simple;
	bh=cpT7OQEPLNxVCz1TXyyDlKPePyp/fTmgSdMZ6xfSHs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M2TUxViYsClcsYqTV/cNEMVH5WbRMAy8Vp271tBF4U105sp5xfwDn1amNxVKcblWjDY03tBDn2YLQ+raehJAXzah+e9jwQjrpXfnnGflRDm65L1r/lHrEUtI5DhJQSCgD9Ge1fG3TEDJFbXB58RIw3axUxvffPa9xeObNtAxToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9qKwAOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9qKwAOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430171F00A3A;
	Tue,  8 Sep 2026 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788886396;
	bh=hvT35E+lvgJDmV+nQx8vU9ZX/qckYxRdIMTQp+jHHVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=H9qKwAOe+BUuFC02U2SC6ULn0nLehxLSDgPmwMFnKrywW6QE626adnk2D9JCLorRw
	 ISODwKduLr79f+uvFGo5Ota+XGq2hT3heynX9daRe8ai0hqq4UJjW61++A4c6hdtxn
	 XoNKxRnH21600kRRp/s0V3x5oKqu8B+hkwne1Bt1By2EHVzcai0uxZQkfwFZu7bRDR
	 K4Z8+Y52qxPlPADjLlzkJks3o42RDFk7WHfTUA+HaEmMAZtWrsHUgSWHtpPbIe9U7h
	 Thy5tMVgtAFPJIHjQ5aNFCo5zJLOhEJA33gouKImC//Wf8REf3hL5f68zlRmcV5aC0
	 E6mC0V1EU4mCw==
Date: Tue, 8 Sep 2026 11:53:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <20260908165315.GA2710333@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728172306.2751813-2-den@valinux.co.jp>

On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> vntb_epf_mw_set_trans() programs the memory-window BAR through
> pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> lands on the wrong function whenever the vNTB EPF is bound to anything
> but PF0. The other BAR programming sites in the vNTB driver already pass
> the EPF's own numbers.
> 
> Pass the EPF's own func_no/vfunc_no here as well.

We're referring to these as "PF" and "VF" in the subject and "physical
endpoint function" and "virtual endpoint function" in the
pci_epc_set_bar() kernel-doc, but I don't think these have anything to
do with the SR-IOV PF and VF concepts, do they?

I don't have a better naming suggestion, but this is slightly
confusing.

> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c3caec927d74..fba65abfb6b2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
>  
> -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, epf_bar);
>  	if (ret) {
>  		dev_err(dev, "failure set mw trans\n");
>  		return ret;
> -- 
> 2.51.0
> 
