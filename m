Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C447A86E;
	Fri, 25 Sep 2026 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374548; cv=none; b=eQddBHMwZjJ1Z3yldYrs9e0IQIcHBkF3ahw580ArrA1gsK3C0Rxe3Rown497jPtXqq/uXepEQXwO78k/wwaYSeMSeg/ujsp31ulbVtUBlwvR6yg67pwzDH5LNehMz0QDV47fVu3XJ4zU4LAAUR7zyRKybMfr56U7DULrRLQ9bKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374548; c=relaxed/simple;
	bh=x/uAG0FitG5iZp0v0Vp/9nBY/NOtuPTIO0fVuK3nucM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXbMN/QKFoa0xMLgs1K5r5ngS87jBrGz/I/av6bfdIVKzlSw+lqCPwnCwG03wPvU88VYc6+HXlZa6EZnLVoAXCtRrrgl7ciB+cswiFVe/nw+OE3Xx9jCubZTiki9B03O/JEymMLsI5dBIblG7XvejaF25JDfvW1LBdDQqkQpFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mREPbVWM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mREPbVWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A401F000FF;
	Fri, 25 Sep 2026 22:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790374546;
	bh=jvKsa/YXVFhRAptUPmeNIrjnuYg/JjP3HHUk0KSUo2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mREPbVWMUbVbHx93byJSxHP4NjQ9kSEKOYw5phXvqbq77VzO7JdXcPqIS9klisCXA
	 NS02aslwAkeBLfK0QtxfHCirTMNHhIvWG5Lf0teNnmGZVm1dkC9Ii++NTPsC48H222
	 dIpoFEO2blm7bjUcaK8M6A5tDikRy9xbDgUga3IEnac6nEYwm8Hb1F2kh5R+mXl05n
	 UDyW5yYOiGeG6RVkb2mMpkRetrnhKlgDu3TnMUcGCutxidh0Ss8kJlm4HkO1V05Wua
	 3Dqq+XE5tXc7yIcm0ytwk+Y7XCDZUojtk4O47L7pttAnok1XqsJXVmLmkVnKdD9fO1
	 zvy5M+rA7wK7A==
Date: Fri, 25 Sep 2026 23:15:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
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
Subject: Re: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Message-ID: <20260925231541.492d5407@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-12-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-12-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:24 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device is reprogrammable through its CXL DVSEC: a guest could
> set Config Lock, toggle CXL.cache and CXL.mem enable, or rewrite the HDM
> range registers that govern host memory decode. Virtualize the DVSEC so
> the guest sees a shadow it cannot use to reprogram the hardware.
> 
> Build a per-device cxl_perm permission map, modeled on msi_perm, when the
> device is bound through the CXL provider (e.g. vfio-cxl). The whole CXL
> DVSEC is served from the vconfig shadow; only Control and Control2 are
> guest programmable, while Capability, Status, Lock and the Range registers
> keep their firmware snapshot. A vendor DVSEC on the same device is
> unaffected: the map is selected only for the CXL DVSEC offset.
> 
> Control2 carries the CXL reset and cache write-back-invalidate initiate
> bits as self-clearing doorbells. vfio never forwards them to hardware, so
> a custom writefn synthesizes their completion in the shadow: the initiate
> bit self-clears and the matching Status2 bit (Cache Invalid or Reset Done)
> is set, so a guest following the spec reset sequence
> (INIT_CACHE_WBI, poll Cache Invalid, INIT_CXL_RST, poll Reset Done)
> progresses instead of timing out. The host performs the real cache
> write-back and reset at the vfio reset points.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
A few minor comments inline.

J
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 132 ++++++++++++++++++++++++++++-
>  include/linux/vfio_pci_core.h      |   3 +
>  2 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9914f3ac69ae..9a020a768055 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

> +
> +static int init_cxl_dvsec_perm(struct perm_bits *perm, int len)
> +{
> +	int i;
> +
> +	if (alloc_perm_bits(perm, len))
> +		return -ENOMEM;
> +
> +	perm->writefn = vfio_cxl_dvsec_write;
> +
> +	/* Serve the whole CXL DVSEC from the shadow. */
> +	for (i = 0; i < len; i++)
	for (int i = 0;

Is mostly acceptable in the kernel these days and keeps
the scope tightly defined.

> +		p_setb(perm, i, (u8)ALL_VIRT, NO_WRITE);
> +
> +	/*
> +	 * Control and Control2 are guest programmable; Capability, Status,
> +	 * Lock and the Range registers keep their firmware snapshot, so the
> +	 * guest cannot set Config Lock or rewrite the capability and ranges.
> +	 */
> +	p_setw(perm, PCI_DVSEC_CXL_CTRL, (u16)ALL_VIRT, (u16)ALL_WRITE);
> +	p_setw(perm, PCI_DVSEC_CXL_CTRL2, (u16)ALL_VIRT, (u16)ALL_WRITE);
> +
> +	return 0;
> +}
> +
> +/* Virtualize the CXL DVSEC so a guest cannot reprogram the device through it. */
> +static int vfio_cxl_dvsec_init(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 dword;
> +	u16 dvsec;
> +	int len, ret;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	ret = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &dword);
> +	if (ret)
> +		return pcibios_err_to_errno(ret);
> +	len = PCI_DVSEC_HEADER1_LEN(dword);
> +
> +	/*
> +	 * The virtualization writes fixed DVSEC offsets up to Status2 (the reset
> +	 * doorbell stamps it). A device that reports a shorter DVSEC is not a
> +	 * usable Type-2 function; leave it as plain vfio-pci rather than index the
> +	 * device-length-sized perm allocation past its end.
> +	 */
> +	if (len < PCI_DVSEC_CXL_STATUS2 + 2)
> +		return 0;
> +
> +	vdev->cxl_perm = kmalloc_obj(struct perm_bits, GFP_KERNEL_ACCOUNT);

I'd use *vdev->cxl_perm instead of struct perm_bits just because
that saves anyone checking types.

> +	if (!vdev->cxl_perm)
> +		return -ENOMEM;
> +
> +	ret = init_cxl_dvsec_perm(vdev->cxl_perm, len);
> +	if (ret) {
> +		kfree(vdev->cxl_perm);
> +		vdev->cxl_perm = NULL;
> +		return ret;
> +	}
> +
> +	vdev->cxl_dvsec = dvsec;
> +	vdev->cxl_dvsec_len = len;
> +
> +	return 0;
> +}
> +
>  int vfio_config_init(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -1842,6 +1955,12 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
>  	if (ret)
>  		goto out;
>  
> +	if (vdev->cxl_ops) {
> +		ret = vfio_cxl_dvsec_init(vdev);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	return 0;
>  
>  out:
> @@ -1863,6 +1982,12 @@ void vfio_config_free(struct vfio_pci_core_device *vdev)
>  		kfree(vdev->msi_perm);
>  		vdev->msi_perm = NULL;
>  	}
> +	if (vdev->cxl_perm) {
> +		free_perm_bits(vdev->cxl_perm);
> +		kfree(vdev->cxl_perm);
> +		vdev->cxl_perm = NULL;
> +		vdev->cxl_dvsec = 0;

I'd define a vfio_cxl_dvsec_exit() or _unint() for this so
it is clear it pairs with vfio_cxl_dvsec_init() above.


> +	}
>  }
>  
>  /*
> @@ -1926,12 +2051,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  			 * of the extended capability list.  Use default, ro
>  			 * access, which will virtualize the id and next values.
>  			 */
> +			cap_start = vfio_find_cap_start(vdev, *ppos);
> +
>  			if (cap_id > PCI_EXT_CAP_ID_MAX)
>  				perm = &direct_ro_perms;
> +			else if (cap_id == PCI_EXT_CAP_ID_DVSEC && vdev->cxl_perm &&
> +				 cap_start == vdev->cxl_dvsec)

If it is only used here (I haven't read on in series)
				 vfio_find_cap_start(vdev, *ppos) == vdev->cxl_dvsec)
seems fine to me.  It's only just over 80 chars and hopeful this bit of the kernel
is flexible on that!

> +				perm = vdev->cxl_perm;
>  			else
>  				perm = &ecap_perms[cap_id];
> -
> -			cap_start = vfio_find_cap_start(vdev, *ppos);
>  		} else {
>  			WARN_ON(cap_id > PCI_CAP_ID_MAX);
>  

