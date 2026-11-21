Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224688;
	b=wLwNctiQwZ1thkABnZ7ZpnmHs9k8sUE4c1MkVVEYyAWntqJiN84htw1tH2F3h8fR9Sz3
	 hxUl3cXEivqRjwVQdl4KrMLp/VXQSDoM1rqDIiBAYmJ6T4akP9LB4f3Hecc8nmuMMntgy
	 z3Fv14cgFOtLLMkvWy7BjfEAhM3ZZ3H+Rr9kUe7hfExwr/XdXml0k/q2eEf/TQzRgTIpX
	 DvXznYUknyogAxTAB2OvLutguRV9Hg574vgkRtbn0lNQqO5Vw7Mr+VMqfYzi2n3TjVG+Z
	 USrr3pUfmr2wvHpGXygHWAgsOMwNUU0RlJqq1NrZX4W82WU0DIQUY2ijtLmmp58vHeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224688;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kv8zyz3oTsWMY3au1ylZk+ZOVcWAEBo6ppr6ek9IPUA=;
	b=tQtt6vNGN6xajDzzx+OIh/0idPGZ7zxZuMNA0POghpbEUe41Unst8KFt1iJPtMfa1VQf
	 EJfmFQNn3VHu9ZsD6FgcTaRGLCPv3d3lKqCg+WzRy8xX518ss6mn0/gTvqzN0Iqm3byEg
	 IFeQHQczEpkvJBTHVIw104LAMOtzZKIzQb/XuQfbFzFBoVetJPW1nUjr7HCSUccOKov8X
	 sgZWt6KjSuw3h5gwrSyQEYbRkgo8OO9yxuYPfZSbn1aQrU6vgwUhfZig8QQYVijHaxrvl
	 89JR+Qf936QIOpAAc3nt9+XBmksQYNRXsm2RvMYvhOp/8pFOscdy7qMDuTZWNYttIBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIdPcVoa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC9606A6A6;
	Sat, 21 Nov 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIdPcVoa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAF51F000C0;
	Sat, 21 Nov 2026 01:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795224687;
	bh=kv8zyz3oTsWMY3au1ylZk+ZOVcWAEBo6ppr6ek9IPUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=EIdPcVoaF1MvnxP6Bg/QbJ9i2bdJIhz9b/GEBIGVn3KVpGaRj8cBmyUXYyOG0z/+q
	 ZEAUxv6mOgns9g3MjFZD4w/tQ3cJjtm8TQu57myIiMTiHkMv70XEwElmzq5drF+J0E
	 r2kcZL3ZzgplGppixs+4X+Hs6VcV7Acln0VNn421115Hf96gmFAi8XSMLcOjK4G98m
	 65uJ2omNKl53SMjKEZjTIf85ROqRCb/0N+s5BKvKwSsKDaPnhfqAufThNF09YJ8Huz
	 5J/2PRV3TMnozph7qQ1AffVGiF+cgkIJwEsXhy4tkiM0KMut2DJkL9Zozm5mChtJ7Z
	 opMbaPrPH1+KQ==
Date: Fri, 20 Nov 2026 19:31:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 4/4] PCI/AER: Hide the "aer" sysfs directory on devices
 without AER
Message-ID: <20261121013125.GA934416@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110215614.3931232-5-yazen.ghannam@amd.com>

[+cc Lukas]

On Tue, Nov 10, 2026 at 03:56:14PM -0600, Yazen Ghannam wrote:
> aer_attr_group is a named group, so sysfs creates an "aer" directory for
> every PCI device. aer_attrs_are_visible() hides the attributes when the
> device has no aer_info.
> 
> But this doesn't apply to the entire "aer" group. So devices without AER
> end up having an empty "aer" directory.

This applies specifically to the ratelimit-related things in the "aer"
directory, right?  If so I might amend this commit log to mention
that, since Lukas's subsequent "PCI/AER: Enable baseline capability
error reporting" enables aer_dev_correctable, aer_dev_fatal, etc even
for non-AER PCIe devices.

"aer_attrs" and "aer_attr_group" are kind of unfortunate names since
they're specific to ratelimiting.  But that's material for future
work.

At least they're internal so they're easier to change than
"aer_dev_correctable" etc, which are even more unfortunate now.  

> Switch to DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() which can use a single
> check for all the AER attributes.
> 
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 32a4c9101946..5ea81a506a06 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -778,22 +778,19 @@ static struct attribute *aer_attrs[] = {
>  	NULL
>  };
>  
> -static umode_t aer_attrs_are_visible(struct kobject *kobj,
> -				     struct attribute *a, int n)
> +static bool aer_group_visible(struct kobject *kobj)
>  {
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if (!pdev->aer_info)
> -		return 0;
> -
> -	return a->mode;
> +	return !!pdev->aer_info;
>  }
>  
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(aer);
> +
>  const struct attribute_group aer_attr_group = {
>  	.name = "aer",
>  	.attrs = aer_attrs,
> -	.is_visible = aer_attrs_are_visible,
> +	.is_visible = SYSFS_GROUP_VISIBLE(aer),
>  };
>  
>  static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
> -- 
> 2.55.0
> 
