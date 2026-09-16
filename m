Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE63D79FD;
	Wed, 16 Sep 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582643; cv=none; b=l1GnIYKpDER1wY9IMGB3UbMHFfzctP+FuiBmtkBbWEORrBtPbNzc1Ra+BkTpUVc60bleBo9DMCDFl9W/5MVRs5gIPG8bbTAOD1Bs3I7K2EK4iYBgkqyQrWWT1Z3YxDLY4G2V3EBeh0k4K1oDgQNNQdGgeusClIK3J1xNKplje5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582643; c=relaxed/simple;
	bh=ScI2G65sM//CM+f3nIL0oxJ3lrV8QR5SvKucYOlaBgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP3pktaHCoRZndvIJYc2ZKrm9tH8HWGBjmrPbJ1AXKvYGR4qqt9N8lEXr3wwHcGC8l4e3D9WrAwSqcMSFgBOCRTNN8X8hBLVFtLMKBmHri9MC18p0zxiwxRQ0lfqTG95SovxSQ8CPlCU3VibJMgnRG79ju3fJD4kK/IO+x+Gqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0m6naZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0m6naZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F91F000FF;
	Wed, 16 Sep 2026 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789582625;
	bh=xQl299OIcdoGcLSnKJmKZ4+XRPKt1RyOR0NcAsk8cxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N0m6naZD/lxG8pObZTwNFrnXZSW6+XOoKvHbNV/LvIkWlxx94JluNzO514SxbWEsd
	 1QfsVIDJDAxZj+xCAbnHSrcOf9czF3Ru+9Bmf2S+dWTdk3onM065w9PXDOT7/JsPFp
	 DrYGLXXRUtGQwHXEiSUw+BIAkvugbwTt7dCSnHepR8c2FGnCpPqSehhBuJKdWggppW
	 kaFkw89NsduneTZa0uqHOkQD2MOquwLIbtWUBSwVwANJ6HvikJoqCg5ynvO4QZH4hu
	 QAfif53H09G/TMF0x639FDAHISk6qCNvVTatXikaGNgb8JN8CB1R0Y5TNtQazpkCbn
	 ib6PB3DLIKXjQ==
Date: Wed, 16 Sep 2026 19:16:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>, Gregory Price <gourry@gourry.net>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl
 on demand
Message-ID: <20260916191659.1d3cb36b@jic23-hlaptop>
In-Reply-To: <20260813093631.2288172-8-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-8-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:11 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
> CXL core in unconditionally would bloat every vfio-pci setup. At bind,
> detect a CXL device with pcie_is_cxl() and request_module("vfio-cxl")
> only then, and hand the device to the registered ops.
> 
> Each bound CXL device pins vfio-cxl through try_module_get() and drops
> the reference at release, so vfio-cxl can unload once no CXL device is
> bound. If vfio-cxl is absent the device is driven as plain vfio-pci.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 81 ++++++++++++++++++++++++++++++--
>  include/linux/vfio_pci_core.h    |  3 ++
>  2 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 88e68d43af9a..0f9b5dfeea66 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2176,6 +2176,44 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
>  					      VGA_RSRC_LEGACY_MEM);
>  }
>  
> +static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
> +static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> +
> +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
> +{
> +	const struct vfio_cxl_ops *ops;
> +
> +	mutex_lock(&vfio_pci_cxl_ops_lock);
> +	ops = vfio_pci_cxl_ops;
> +	if (ops && !try_module_get(ops->owner))
> +		ops = NULL;
> +	mutex_unlock(&vfio_pci_cxl_ops_lock);
> +
> +	return ops;
> +}
> +
> +/*
> + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
> + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
> + * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
> + * identity before engaging it.

We don't expect to handle type 3 class code compliant devices, but what about
the things referred to sometimes as CXL Type 3+?
No CXL.cache support, but accelerators none the less - typically using back
invalidate to ensure what they are working on isn't held by the host and
CXL.IO (i.e. PCI) for control path.

It is also plausible we'd pass a full compressed RAM device through to the
guest without paravirtualizing like we currently plan to do for class
code Type 3 devices (for DCD, sharing etc). +CC Gregory to point out where
I am wrong on this ;)

Not sure what that means for this checking function.

More generally, why are we controlling usecases?  A class code complaint type 3
device 'could' be passed through I think if someone wanted to do that.
I'd not encourage it but why is it a linux policy to not support it?

Jonathan



> + */
> +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> +}

