Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCE3EAC8E;
	Tue, 17 Mar 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761229; cv=none; b=dmhpy116PJDn0N/8H3ny0Y04Mr0lnWTPHQM/OyHVZ+fz3++6+zxohdbE7T/qkue3tyAjudzrVOeh5tUO11FCftSixiYCRS3cS4D4BDAPf509PaGMJQkFfOici0IV/FJ59/uwB+tn++bZHFr7jrjt3JmlBtrWFClCC/siHAEkZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761229; c=relaxed/simple;
	bh=TWI3mDxBiNs4ovrYjxukV+mTM/P3+pNwm/n1hylBznU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R39FZ7VayLGHi7dsgTNJJ2k/qHt0NQS14EuXKiICfr0WxJlLxyZOKaT+ECr1Zpqqf5Uni6iIdRPcYwz8oJ3UW5Vwif2Gx3h6SfLz75SzmT2osK5znijQuycRPyOP+nrmGtTHLGOPY7KNm8fDA1ysd+aGAtUSiLyaawdob4NwSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgtDPysl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgtDPysl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76716C2BCB1;
	Tue, 17 Mar 2026 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773761228;
	bh=TWI3mDxBiNs4ovrYjxukV+mTM/P3+pNwm/n1hylBznU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RgtDPyslX9tZHdHuV0+W8rMQSWSFjea1a9r6L+NQFfDgAAbbF2We5/PboWSYiNAsG
	 1DwhHTThut9m0W1OLbMAJVc5YmbzbPYapf5kq8cBeqNwmlJC5V/BwwvahmhigzLJrf
	 RvlWzuq4FL4fLlrcz+nV5ESvI4rem+j1tuDuxCHN6S/wZqVkGzzDDIH9o0Re719dQX
	 mEStAtWQXJrjkD6UzPoQZCKIsqlqqi+HeIqGYXhRhF1CrNQwc+jp6xw/vE7Eg8otJM
	 Us1lvxCV0QegX2JhxvAbTfhN6VwRUJyJMY2zQYCbk28dj1qAfI0wkd2n9B8f2GEkf1
	 0KDIq62FCV3eQ==
Date: Tue, 17 Mar 2026 10:27:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
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
Message-ID: <20260317152707.GA85951@bhelgaas>
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

Applied to pci/for-linus for v7.0, thanks.

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
> +				 ret);
> +
>  		kfree(submap);
>  		goto err;
>  	}
>  	kfree(old_submap);
>  
>  	/*
>  	 * Fill deterministic signatures into the physical regions that
>  	 * each BAR subrange maps to. RC verifies these to ensure the
> -- 
> 2.51.0
> 
