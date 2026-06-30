Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3713DB30A
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839406; cv=none; b=guTrd3j34hH7Uzfk2puUELD0lKw4ljpP+lf3ViccUlrICDlK/ZsMyreRzz9j2L6q3FidmtbDrvppi7VvGrxbR9oLtZJfTBx0FcbQY5E4h8jRELegzdqHcsln0+Fbi/rSMcH+soLS4dBiAFtbiU1iJHdj0NYRMTypPG6Z+05x0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839406; c=relaxed/simple;
	bh=8FWw8S5bqw0DsLWMF31ORdjdb+jkItZwXMLdMrp1C0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=umO9L+pi4cTBKqt6V+99SdLEHnuxlGUbsufUNdODWwEDzSzHJZKhD363vP86mDD26lqSp7hAKhDONJWtV9YpRmE0BKTeWZibBVGSZomVjWe8Jd+WulVLg8UY4ledF/rI825zjqvAjFOoB0JFauUZNO8yNBF1vOyf4mZ/1RkJ3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuHThuMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuHThuMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA1B1F000E9;
	Tue, 30 Jun 2026 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839405;
	bh=pY7+CCppThwMgRFb0hMbEGpH2YUJqMiagCOjcogYR5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZuHThuMd44wegRpEdkAyIVC4cB0t3psO8mEWl/HxHoeBAkzivk9BCgJQ5S4NRH+nD
	 F/whTEC6gISSqAsNScxqX/90tMsUB1csKzwWrpIQYBddpAD3w0gVpJSWtQspwukwLf
	 xcgj61PaJ+uqGAlx2ZC3boJjgGPduvecJIbgv0zMTu0UXdjyv65wz6f1tEgjHkLosi
	 g+RaNvVlsssygD9dYvA9LDy/HAWzAmn5dfmVO2BtTwuG88lrq/IwJL9X5yASiWZ0Gp
	 oWHs2XJwnBXcD4mlJR+paZvXqbF4VNREYzO+oPVpxmLCyKcHHW79U0u80/+/b5tJbI
	 vQ1SbzkFDBFww==
Date: Tue, 30 Jun 2026 12:10:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: nirmal.patel@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	lpieralisi@kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Message-ID: <20260630171003.GA143656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629170243.269830-1-nirmal.patel@linux.intel.com>

On Mon, Jun 29, 2026 at 05:02:43PM +0000, Nirmal Patel wrote:
> From: Nirmal Patel <nirmal.patel@intel.com>
> 
> Copy valid _OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled as
> hypervisor will not passthrough root bridge information to VM.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6..f9e38f2f926a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -910,8 +910,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		return -ENODEV;
>  	}
>  
> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy _OSC control flags in VM, it disables features.*/
> +	if (!offset[0] || !offset[1])

Drop period in subject line.

Replace period in comment with space.

Kind of a weird way to check for VM.  I see it's already done this way
earlier in the function, but maybe it's time to add a descriptive
boolean based on offset[0] and offset[1].

> +		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +					 to_pci_host_bridge(vmd->bus->bridge));
>  
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
> -- 
> 2.43.0
> 
