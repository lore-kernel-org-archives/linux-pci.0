Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEE3B14D0
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582523; cv=none; b=cGxSAc4nOXPsUl3MElF8GOvUnP6Q36iQvmhH+OF6hlpcMtCdn/SMnrtoowwi7a7M3IhYQGTG+ElH6mmiW1DvdYznujX2L6uOWBLwl8TO2V2q5THkAlnQ7CNwuG3k6UT45EPLV+qrrTMgeJ71iinH0ZXMiAEDgR3QeQIUPDIKnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582523; c=relaxed/simple;
	bh=0U/8/cLO3rYLGqboY2xO60YXkhtK4fBdVmPj+Mq8yAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXcmnDw4LhkaDXhO1pJn7Bm0dEQEHjkRIo76c8ISbL6M8w1hd7d+WPyCX4I4o0HBcBQ90IUlC3cAwfR0GGKNj3wtCJmROS5uB6kQZAdrDALXPZ0TuBwXKI25nv+OznBpj3r5ZSBjwUY+pa4Kqn57cwLdeYbNiclKu6BilGdey6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxXAad66; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxXAad66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784582521; x=1816118521;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0U/8/cLO3rYLGqboY2xO60YXkhtK4fBdVmPj+Mq8yAo=;
  b=kxXAad66aJ3qooMrjucM3N0iXbNWghFzq+1kDAK7pzmM6r1kGwlnmesd
   A/N2IbN+M0MHSwrUsBZ6v+29YBa+O5oUP67QZjp89Y9t0DjEkpGq7wa/z
   gs/1Fio6pKNWR2zyJbAiaiB9zS/NlWJjPNxD9b5zzraK59dKA45g79ajD
   h3m2xktPEtSpFmMP6tWydquqI+wCODIX3AgbygQn7pfBuinZd0K9PwXVG
   +fcM2rvOpyPe6NnH5hrUwSuU3oJwrHUVDwVfawachdN3ckyuobKliUb2T
   +uU7rGv2IiJ3VPa2CmdqWJL8inB8Xlpfz2AdMuXHgq13renW7gQ3Zm7Hj
   Q==;
X-CSE-ConnectionGUID: PA05SsGyTWCjUJ5Qvfk0Bw==
X-CSE-MsgGUID: 6IdHM+0FSmKtRHVdVAGH4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85196320"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85196320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:22:01 -0700
X-CSE-ConnectionGUID: p27A16y6SxCVahq3T/dseA==
X-CSE-MsgGUID: QW/l5j/cQEy4NHXOkQu+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="287623413"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:22:01 -0700
Date: Mon, 20 Jul 2026 14:22:00 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Nirmal Patel <nirmal.patel@intel.com>
Cc: <linux-pci@vger.kernel.org>, bhelgaas@google.com,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 lpieralisi@kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] PCI: vmd: Only assign OSC features in bare metal OS
Message-ID: <20260720142200.00004842@linux.intel.com>
In-Reply-To: <20260713220844.561357-1-nirmal.patel@intel.com>
References: <20260713220844.561357-1-nirmal.patel@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 22:08:44 +0000
Nirmal Patel <nirmal.patel@intel.com> wrote:

> Copy valid OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled
> as hypervisor will not passthrough root bridge information to VM.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v3 : Removed period from commit and added a black line.
> v2 : Added descriptive boolean and removed period from commit message.
> ---
> ---
>  drivers/pci/controller/vmd.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index d4ae250d4bc6..7c7d110290d6 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -782,6 +782,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features) resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
>  	struct pci_dev *dev;
> +	bool vmd_in_guest;
>  	int ret;
>  
>  	/*
> @@ -862,14 +863,16 @@ static int vmd_enable_domain(struct vmd_dev
> *vmd, unsigned long features) .parent = res,
>  	};
>  
> +	/* Non-zero offset means guest/direct assign view. */
> +	vmd_in_guest = offset[0] || offset[1];
> +
>  	/*
>  	 * Currently MSI remapping must be enabled in guest
> passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is
> probably
>  	 * acceptable because the guest is usually CPU-limited and
> MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> -	    offset[0] || offset[1]) {
> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> vmd_in_guest) { ret = vmd_alloc_irqs(vmd);
>  		if (ret)
>  			return ret;
> @@ -910,8 +913,10 @@ static int vmd_enable_domain(struct vmd_dev
> *vmd, unsigned long features) return -ENODEV;
>  	}
>  
> -
> vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -
> to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy _OSC control flags in VM, it disables
> features. */
> +	if (!vmd_in_guest)
> +
> vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +
> to_pci_host_bridge(vmd->bus->bridge)); 
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)

Gentle reminder. 

Thanks
nirmal
