Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEE2367D1;
	Mon,  9 Mar 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091026; cv=none; b=kgBaBdBWNP3mJYdyYuBelvWyVrdWyMeC7EuBVXoAikLdzw5R0LFDjWbgis8gBhFWQjF1z4O/mBlqtpR3HOOBCjp1e+sFniyTzHTTP8+EBjtTTn2zRTbgzfHA7hZvHTLBz7PWBiAZ2nba9iMoFwwGXPlHdJMB6P5dAd0mxywonTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091026; c=relaxed/simple;
	bh=tn1/lU61WqSbWzJVAG/wr8NXAg7L0KU9HuH4wLewMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F83YlRX9eKg2An8OfoE3qP4HB+2wZIkjDX7tOJqHI0bC+BAYfo89xImz2VdMTmonZY/b0OLbWJpfvL8Iv12OXg3QA+7Z3Myk4lmM7qhei5x91vbMUjUI54LUC2BVvS3vOr04chSP4HgNgsXVHVm0VsjYYMp2SwehKBflPeKQqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDqeKW5e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDqeKW5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5E4C4CEF7;
	Mon,  9 Mar 2026 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091025;
	bh=tn1/lU61WqSbWzJVAG/wr8NXAg7L0KU9HuH4wLewMjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pDqeKW5egxZ48x3lImZbHaIuBt4FQRTrUYB3iwNfAJsCOutO9FgoRIzQl4hd6B62r
	 xw0cmJi1D7NGV2D3PaXwjPOb/b0tht26dQUHpuwtdVqFLcxM2RsvCobZV8rbn6jBio
	 a/nUP0SOaQzH4LdqEbFdOiUOchb6nMsLoJmlT94lnTKCSlGIFdQ+4dZ2HKmjiZeWli
	 IgQfvtAthACrULkFRSbIj4bK4htk7+SEFq43EW4ep7WwpFT2JEVeLh7sRQwxw7kQxO
	 zjbdw9FspwaI83q2GWSG8l0i6qO2cusDUJnGzOI2EUN93jtFTryg8s9P99/wtMmCpJ
	 CZUsJyZ6BcH0w==
Date: Mon, 9 Mar 2026 16:17:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-pci@vger.kernel.org, herve.codina@bootlin.com,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: of: Reduce severity of missing of_root error message
Message-ID: <20260309211704.GA605986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309045930.21531-1-jeremy.linton@arm.com>

On Sun, Mar 08, 2026 at 11:59:30PM -0500, Jeremy Linton wrote:
> Arm64 kernels are frequently built dual ACPI/DT, and then boot in ACPI
> mode. In this case, there won't be an of_root, except for rare DT
> described PCIe boards.
> 
> As a result, users in the common case see this high priority worrying
> message, despite the machine working as expected.
> 
> Reduce this message to pr_debug() to avoid unnecessary noise.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied to pci/misc for v7.1, thanks!

> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..4115017f4139 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
>  
>  	/* Check if there is a DT root node to attach the created node */
>  	if (!of_root) {
> -		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> +		pr_debug("of_root node is NULL, cannot create PCI host bridge node\n");
>  		return;
>  	}
>  
> -- 
> 2.53.0
> 
