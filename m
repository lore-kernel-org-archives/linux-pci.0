Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DC3D6673;
	Tue,  8 Sep 2026 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901713; cv=none; b=sG4WabDJatWJFBc/C3S1fmC208n6jA2OoBD83gbcIrowSBkze/4DMBEVNXdfLmuXZMqoIsMlABQuvZmA703aEkRqPx3r1Yil7segzf2zONJ/BFs79YKz794+KO5TckOJA3OJZzUfuB7xzC6taHX4GnDh29+Z3iCVGcOQdG65myI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901713; c=relaxed/simple;
	bh=OVfxZkv4B2uDx1B3zBC60lt1WdKqVB4OBWAE7EKRN3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fx4znD0Kc1P38HN5axDxPWf8eieoMVD3gniqEa0rKRz8MY5zJCgxQn/Fim/R/3AIo7rJLm4Hf5lxbCxuWtcxYC6JOrHrxIg6HZh2wEHelV5rgzRV3rakPZjgNdlSekXEkJF1Ow3lqTOVOtawhQl+aNku6aXQPs3MHT19Cj+I/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVkG6iiM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVkG6iiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D001F00A3A;
	Tue,  8 Sep 2026 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901710;
	bh=AvijAGjlWdxir7kTHcVHLcAhd8ANMcgHiT+020OPmVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FVkG6iiMx7gX0L4unevIY0IWQ1Y5apqFaHuSw3XQR79K8QSVWK1oonMMr+kmP2/Kq
	 HodT9Ov9KPdhWZ113QrHT7ibFVmQwgjfcLvOoxVBWtizdIFIyVTlac6UAjhBh/7mRO
	 rmHtGwZ+PCs/O3NCJX4R/mJUIZ7kse6qaQ2B2obuwUnEgddyLZLo3uduX6itkss9Xq
	 tD2ZNqGqtepAig84SqxsoPyvFNvRgClft46eWhgKGTN7ktnk0MpyPD6U6zjkF8eCMa
	 42AxUXxGbJiP/8R94eiEUqa5DLt520RRbpLwLBa7piahijedOmkxQcYvl4irx8mCdj
	 VfQAZdv+HgTTA==
Date: Tue, 8 Sep 2026 16:08:29 -0500
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
Message-ID: <20260908210829.GA2745828@bhelgaas>
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
> 
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

Thanks for this fix!

If anybody is bored, I think this file could be somewhat improved by
adding local "epf = ntb->epf" variables to reduce the repetition of
"ntb->epf", as epf_ntb_config_spad_bar_alloc() does.

Even then there's a lot of repetition, but I think much of it is there
to make room for the PRIMARY_INTERFACE/SECONDARY_INTERFACE stuff for
NTBs.

>  	if (ret) {
>  		dev_err(dev, "failure set mw trans\n");
>  		return ret;
> -- 
> 2.51.0
> 
