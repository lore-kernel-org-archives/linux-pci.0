Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918481E86E;
	Fri,  6 Feb 2026 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417186; cv=none; b=M1z9YglAL9gq3peAhH4p7U926BnuJt4MvYoH2nWbfAkzKSbZZ10TIpoH0jv43YOk2CBubwreGz94C5va+jdALyd9uQse5npxloIy6enA6QHHoWttcqdNLXV64DvwyNJqgSjCXIJPFaYLS/5ZwBbuVKHZJWHLgnL4YiXP1vnlZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417186; c=relaxed/simple;
	bh=SFITzy0YISnXGbRnDmK7ToX7zhLF50C1EMCtcqxa2z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a2WkFfuHmWmHv73gVzbEiZ47ozsB5rPCj1k0rHXgf867+7a+FhjfhJ1TMO8qylZ+CvYJf48EW9YI5kLM1BbPxgQP4EQ26MfsrxJQojEeflfxLoGhEoRS+juCJzpwOtjTd1hqijgwEidFj29SpL8s52zK5qTuGPIH0YicyATngEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcvOUOO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcvOUOO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7419C116C6;
	Fri,  6 Feb 2026 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770417186;
	bh=SFITzy0YISnXGbRnDmK7ToX7zhLF50C1EMCtcqxa2z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bcvOUOO0n2PfrkzjVGspGwQ2Y96PfQVjvM73WFuxAhg/cEAUHwV2wxRnVPobjERdF
	 QX9XOW0eQIj3r12f+BbdZCcCjsILpfKyGEqY+XTyFC9/3mJezhpVQZqNR3L+IE1bgT
	 l84CtIs00O2Qx/AMjIVcZx2PZC/YgQXXZTPSI7k32IpKjhJ4pOEI2ga6su4rYhquti
	 fmTD8u6vgSlIRnT0cdfiNyEwPX5ZD1B6zbtvSiTAFKPbr6hsxFtvBlfzaWmgfmzuPi
	 NWRmJAn/EXKXUATktsqTIkSU1Fqo35s49DF3X/zyj5O5KleKAni1Gxdy2TBFx3vzoC
	 VwE+SHcyKdQRQ==
Date: Fri, 6 Feb 2026 16:33:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH] Documentation: PCI: Clarify pci_free_irq_vectors() usage
 for managed devices
Message-ID: <20260206223304.GA99007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1769396233-154698-1-git-send-email-shawn.lin@rock-chips.com>

[+cc Philipp, any comment? would like your ack if possible]

On Mon, Jan 26, 2026 at 10:57:13AM +0800, Shawn Lin wrote:
> Update the msi-howto.rst documentation to clarify that drivers using the
> resource-managed function pcim_enable_device() must not call pci_free_irq_vectors().
> This is because such devices have automatic IRQ vector management via pcim_msi_release(),
> which is registered by pci_setup_msi_context() when pdev->is_managed is true.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/PCI/msi-howto.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> index 667ebe2..dc85f1e 100644
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -113,8 +113,11 @@ vectors, use the following function::
>  
>    int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>  
> -Any allocated resources should be freed before removing the device using
> -the following function::
> +If the driver enables the device using the resource-managed function
> +pcim_enable_device(), the driver shouldn't call pci_free_irq_vectors()
> +because the IRQ vectors are automatically managed. Otherwise, the driver
> +should free any allocated IRQ vectors before removing the device using the
> +following function::
>  
>    void pci_free_irq_vectors(struct pci_dev *dev);
>  
> -- 
> 2.7.4
> 
