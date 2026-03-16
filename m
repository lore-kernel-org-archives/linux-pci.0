Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A753314B7;
	Mon, 16 Mar 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677973; cv=none; b=HQop8F1icm+7iJuVa+GpFh8rczQStZgN9tqenzx72j62zNFdOw+kLf5xbqDcuxMQ5T2oiS1QSr2vm4MFRoyrQ1FGQ4zwGEo24RiQW7YAsrnRV5jdaJ213fY9eYZyUgHGjLWiyvOn6RLtAG5TpERok8sO+BMgzuIaSBjBkOBZl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677973; c=relaxed/simple;
	bh=5bjCo0TGDuo9742ToYwUkLPrClBbE9NRT6kZSQZEydw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6oFq6mtqV6Kw71dYp02PzVdUokPBZiyBJ/2kUdiCN0lba1m6dgtGn/KmAmn30d/xnyJV/AMll38ahYS7A38xfONBTcv+GRl5RhTI09u52nReqD99cv8BQR+kgJjzxI6brmkzJCFpnLb16OaYBaZOS87pQVzabjlAQ0vnwA+Q3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCwelen1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCwelen1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A19C19421;
	Mon, 16 Mar 2026 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773677973;
	bh=5bjCo0TGDuo9742ToYwUkLPrClBbE9NRT6kZSQZEydw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCwelen1ckcmq3UxUbo6m+GOGQhgrM+pHuoia68YNRFLRnJce+IFLurjFUabAg0Nw
	 9lBtJO4AvQPz5inCT4sB2n5spzQzqFJKRwcStJNAkqHYFDkRPEKEmLqDQY4DBJDc/I
	 1h1dNyXEh6Lx6EaD57ci6BKDy+7lPSPvu9RYm7ZN4Moe7kUPxks5Y6LPqCNqBJGmXV
	 OFn4Qr1+owRWI+up5doQXg3TUbpExGHpPCAPI9ss/1xnliuElWfnxswC94hF+IeECY
	 +Y4I3icBY78q2WiW6dDUOQyUoFk9AnHZ/h8sJj/yocnow7N1ydh4ftjjzFbnSrvwmr
	 +0ZYqAVGFHF0Q==
Date: Mon, 16 Mar 2026 17:19:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <abgtiT6aI9GMEADH@ryzen>
References: <20260316140225.1481658-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316140225.1481658-1-den@valinux.co.jp>

On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> When the BAR subrange mapping test on DWC-based platforms fails due to
> insufficient free inbound iATU regions,
> pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> not restore the original BAR mapping. This causes subsequent test runs
> to become confusing, since the failure may leave room for the next
> subrange mapping test to pass.
> 
> Fix this by restoring the original BAR mapping when preparation of the
> subrange mapping fails, so that no side effect remains regardless of the
> test success or failure.
> 
> Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 14e61ebe1f11..f44c36f5cac5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
>  	bar->submap = submap;
>  	bar->num_submap = nsub;
>  
>  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>  	if (ret) {
>  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
>  		bar->submap = old_submap;
>  		bar->num_submap = old_nsub;
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> +		if (ret)
> +			dev_warn(&epf->dev,
> +				 "failed to restore the original BAR mapping: %d\n",

Nit:
I would use a capitalized F:
"Failed to restore ..."

in order to match most other prints in this file.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
