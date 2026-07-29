Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B9473C9E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325580; cv=none; b=C669sKFoPiPXrXstTyfhSWeq9SOZtB/BOrJntaaFHypef4LQXXvDYfxtpb/tmrKxqpz4/HG1HQw7IjSx5ZDvxFJ/vn6ENDnYKfv1Fu3T8CxJipKpaqLUhzpARuEYcyNMZQFYWD6kaEnN+4k/kiVY5VAF/EDZH1VvoszxTt4qEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325580; c=relaxed/simple;
	bh=RwRJuuLWowA8fpfaG0Pu/9v/thsh26H7NjVa9lVPzEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0zdPmYBE/CSogZW9sfscD3/50mleh2fPgwmx3JkEf6u/8ijYXH5p3oxkCQFyh07fGbX5QKIJkueL1NMk1bdbul7eH2SZisIxCmNoodCLGeDh6I6wBE+9OeScBU1rDSdxmgQubOihMUcEbX1PMhyhZ3KtJB53ANSRB/v2YvEE2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwDWM8IE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwDWM8IE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48391F000E9;
	Wed, 29 Jul 2026 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325578;
	bh=KV/wPStgOPxd6a9gqaRAz/tHhY403WEnxokDClO8+/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PwDWM8IE92lXX4a4TzEgDTwF0DMAmphnyVa214UIA9sInZVeir5K1bTauJW2TLgV8
	 xF0jd0xa9rM8r4+Qinrge5g2N5uW64Q8zgywlShr6Fb880Ci5wiuymaFq0+OeK+/1C
	 BdjZa0WhLxswpdqNXQK+Tn7BESrYZ7YNnfDPjQ1sdvpA80ZH4IRGkIQVyfiiagwhPZ
	 t8nvZyFBVQ7688v7KrtMQ6jgP49H0G7TyNvvNXo4TAyY0mjvIMwuv/LXkonESUfUzy
	 UOfzxz14POFF6viGv6Lju8wGoZQX9jqm1GYVoqAunCJoIShalGLC8GeUHuTLIg2qES
	 YdqY4ygyLU0zw==
Date: Wed, 29 Jul 2026 13:46:11 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nirmal Patel <nirmal.patel@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	robh@kernel.org, lpieralisi@kernel.org, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] PCI: vmd: Only assign OSC features in bare metal OS
Message-ID: <jm5tao5tdbfo4o6ivrhiwfl33xrislemr7ejnnbsmjsbq7pxaw@2xjdbaflro2c>
References: <20260713220844.561357-1-nirmal.patel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713220844.561357-1-nirmal.patel@intel.com>

On Mon, Jul 13, 2026 at 10:08:44PM +0000, Nirmal Patel wrote:
> Copy valid OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled as
> hypervisor will not passthrough root bridge information to VM.
> 

I changed the subject and description as below while applying:

PCI: vmd: Only copy root bridge _OSC control flags in bare metal OS

Only in a bare metal OS environment, the _OSC control flags like Hotplug,
PME, AER, etc... reflect the physical root bridge capabilities. But in a VM
environment, these flags reflect the hypervisor policy and in most cases,
the hypervisor disables all of these control flags to the Guest.

So copying these flags would needlessly disable these features in the VMD
owned Root Ports. Hence, copy the flags only when VMD is running in a bare
metal OS environment.

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
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6..7c7d110290d6 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -782,6 +782,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
>  	struct pci_dev *dev;
> +	bool vmd_in_guest;
>  	int ret;
>  
>  	/*
> @@ -862,14 +863,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		.parent = res,
>  	};
>  
> +	/* Non-zero offset means guest/direct assign view. */
> +	vmd_in_guest = offset[0] || offset[1];
> +
>  	/*
>  	 * Currently MSI remapping must be enabled in guest passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is probably
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> -	    offset[0] || offset[1]) {
> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || vmd_in_guest) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)
>  			return ret;
> @@ -910,8 +913,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		return -ENODEV;
>  	}
>  
> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy _OSC control flags in VM, it disables features. */

Also reworded this comment:

         /*
         * Don't copy _OSC control flags from root bridge if running in a VM, as
         * they don't reflect the physical root bridge capabilities.
         */

- Mani

-- 
மணிவண்ணன் சதாசிவம்
