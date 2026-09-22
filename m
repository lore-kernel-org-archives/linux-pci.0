Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121A305670;
	Tue, 22 Sep 2026 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043345; cv=none; b=Ic4pRHC9fzszGGTZVloRhyTlIdbWUMWHy4fobhS0E5yOsX5H3ozPWSaj6GJq1i4GCyC+Zz6Uy7txqw++TpMeGm1L9am2y3a828vjnquzWV+6KnUUxcGaePMTWJsw/lTV6GKpOTGIkFiC9lRLI8C83WEAGa42PD1X4DSJsW+Cvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043345; c=relaxed/simple;
	bh=D6JihFIvDN7/S7qaBGohJeWPQ3vwwiIcj6NGjvuytxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TazwvhCWxIPwdkPxHN05c6742mdzJCynkWNY02uDTD5wmwTnabsA0kcxnxmmYvt3JVRE3Sdm5q7uMR/IQK5sswvju8qg7sE1IhpG7UFqsaIZyPumv4xnZKaBWTxOse7Y+Elz38OuokGfMFHPFQuGxHvBZXICpvD5oF74dPaacSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=E8RuDqi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vps1e22H; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="E8RuDqi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vps1e22H"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FDCE7A0040;
	Mon, 21 Sep 2026 22:15:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Sep 2026 22:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043341;
	 x=1790129741; bh=6CYRCVBx1L4V26Ru/RXdrkzjJ5/egmWpT9XizerV/z0=; b=
	E8RuDqi8C0rd10DmPZybHbpD+RvATDEnq2l1ooVm1A0WLmI8YBNElr1X4HhYluG1
	ZEqSakr/P0eta5ALRZKRLQP8cmGJ2DvFNF6rxcBBw6TJrQy8Ej3tCUKHGdS8ODqM
	dhj0QsLF/jaLfu+YhtieVFIyjT+Q/WcbG2AQzOVDiY7CWT6URDeig+/7/r3QUyGh
	CmLXR4prKADzaaju21zwvIRvPrCISIUukHnynCf8rJstmPAatMe3nTec++qjGZGq
	uLDlvWl9cs1SRhyIucbHzfX4PvwrRvgrsGscAZZ/f+1TI0VRQ5rWStzd2f2Vj6OS
	+elprqj7BRO0kqXTN6qXbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043341; x=
	1790129741; bh=6CYRCVBx1L4V26Ru/RXdrkzjJ5/egmWpT9XizerV/z0=; b=V
	ps1e22HyswDo/SBj5Vdtx/eLqmJghK8DdNK74nkmW8YJGBqThIy/p1DRUZN+slLs
	3S4JO3VO3Q78USu6UK8eFI4yqCBHRwWUd6yLmidFuEei4ApISHv+zEKJKGLH1kIZ
	GStWNGKPRa9xQ4FCebPUUm8aY8Kd12wvuVtEVj/aMY7JVQiXala76upfMfKZAz5K
	1zX3j42SlZYd+OZRf9KaTn4OJMYL94mb5QicYalIPc6Zuqp7TtsK4GTqfo0Py1pH
	paEUQ/rEGwLDS7oOBqKMusnB7TTyBFlMf2jFrS43bzOAO82pg7JlhKk+cBKXytqA
	kOG0Lt4Tho7qtCQxJZ4FA==
X-ME-Sender: <xms:zeSxalw1i2-u1soggkY58IblbdfiuKBtNf5aUBowPBcPAu6in3Cn9Q>
    <xme:zeSxai4bptb2Zy5xXqbGJpJyPJ3TfKPKoJ-jKZh-Dqx63KqvmJE7i5xHRKgSvnvj6
    oXgs7hnmCJL45pRHS6USNw8kOMXKvHhadt0uOLl2eQp2JBhuwvXhEW9>
X-ME-Received: <xmr:zeSxamt4xWJNwpDlONPRxJbArG1JvxwZwQ0dcRvbY6oVQRCw1XGakHLHzkEVDA>
X-ME-Proxy-Cause: dmFkZTGoxwBj3gMs8aP3OtSmH8fpa7GIvf4hOnqoko3B7f8pxqS5H7LxH77IXdR6d3WuI+
    Z9z3CfoUQKhUFniD7Rf7fiqvJvZaxwi23b3LKCM1FYo0YHUqTk8Ph54TXb76GBBy5fGyB3
    oqC5JJGe5LoDDFzfoji7WB0jMmg4fksDOtYNR4RWwGVFKCKNqGSM8QOjrKGULyw+HiamTo
    t8iuP5PRmNKtxUV0UzEwx799GdCwOuUjbS84g95p799m8GpkwTsVGsDH/1sUaqdQLLvc9D
    Z2z27IHWdZ/KXQJuUCkXpOXRK1wImm+otqigYdSypL/jkRx+L2NChAfP8UHBNbtB8aiQrI
    pN3OzyP1R/74braBypRADbmppZfGz6hDE9fjwNxDpZsaaaV+HWhcy0BKnAHF1WRyizQR9a
    VRmjEcKUm/d30KTgyPDlU41RDcbKCV/JhNMVmLM1xTSXdpdXZtzS/iEmVN+7XWYqAqcVLO
    iieaanYa6A5JSQSbfGt4nMAYjKkRFiheIoMQ+f7sk99/a/0zECzQ36qNS72FBfnszgFjUi
    jbbdT1F6558XQJb2FYLA7NlIiSKk0KsvKGzchqwhUONpe4873zERsdJva6fNgQpC0XIawr
    RreqWJemNkyVNzBNygXeRdRe9a1nPfNmqTiAReBeeFY6DTg7DnVRbWyu5vlw
X-ME-Proxy: <xmx:zeSxavszEBdik8zmpZnboBrHf71M6E_ELD7ONVA_D5jsFq8josfINw>
    <xmx:zeSxautb5f_ciYziPPQuqEy2viY-e_2lW0MkokGHzT-tik5NUNvaQw>
    <xmx:zeSxav7FcG_J-vJZBN7AUvzW1516sdPZ2E71DhJt6nDVFJ-wcoLZ-Q>
    <xmx:zeSxahDM7Jmi4fHGkDZfBh2RpB0lQvY_fi_JYvtHT5oQoXeKKUaO2A>
    <xmx:zeSxaptUaylE7Fb7azXoHL-xwqac14zbkcvr1QIYUpPtLBzKmKD54DPk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:15:34 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:13:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
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
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 20/27] vfio/cxl: Expose the HDM decoder registers
 read-only to the guest
Message-ID: <20260921201354.05da09af@shazbot.org>
In-Reply-To: <20260916183540.3813685-21-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-21-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:33 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 guest reads the HDM decoder registers to learn the HDM
> region it was handed. Those registers live in the component BAR that
> vfio-pci owns.
> 
> Map the decoder block at bind: its location comes from the pdev->hdm
> enumeration cache, and vfio-pci owns the BAR, so map it without
> claiming the block and expose it as a second, read-only region under
> VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id, registered per
> open like the HDM memory region.
> 
> Serve reads live from the mapped block and absorb writes without
> forwarding them to hardware.
> 
> Registering a second region is the first point at which an open-time
> failure must unwind an already-registered region, so add
> vfio_pci_core_unregister_dev_region() to drop the most recently
> registered region, and use it to unwind the HDM memory region if the
> decoder region fails to register.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 81 +++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h            |  2 +
>  2 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index e099e9a70a5a..da04776356e4 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -24,6 +24,8 @@
>   * @cxlmd: memory device joined to the CXL topology at bind
>   * @hpa_range: host physical range of the HDM region
>   * @hdm_pfn_space: HDM-region pfn range registered with memory_failure()
> + * @hdm_regs: mapped HDM decoder registers, read live by the decoder region
> + * @hdm_len: length of the HDM decoder register block
>   * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
>   */
>  struct vfio_cxl_state {
> @@ -31,6 +33,8 @@ struct vfio_cxl_state {
>  	struct cxl_memdev *cxlmd;
>  	struct range hpa_range;
>  	struct pfn_address_space hdm_pfn_space;
> +	void __iomem *hdm_regs;
> +	u32 hdm_len;
>  	bool hdm_valid;
>  };
>  
> @@ -212,6 +216,56 @@ static int vfio_cxl_register_pfn_space(struct vfio_pci_core_device *vdev)
>  	return register_pfn_address_space(&cxl->hdm_pfn_space);
>  }
>  
> +static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
> +				char __user *buf, size_t count, loff_t *ppos,
> +				bool iswrite)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	void *tmp;
> +
> +	if (pos >= cxl->hdm_len)
> +		return -EINVAL;
> +
> +	/* The decoder registers take only aligned dword accesses. */
> +	if (pos % sizeof(u32) || count % sizeof(u32))
> +		return -EINVAL;
> +
> +	count = min_t(size_t, count, cxl->hdm_len - pos);
> +
> +	/*
> +	 * The host committed and locked the physical decoder before the guest
> +	 * saw the device, so the guest never drives it: absorb writes without
> +	 * forwarding them to hardware. The guest programs a GPA that the VMM
> +	 * virtualizes; reads return the live registers, which already report the
> +	 * decoder committed. BASE_LOW and BASE_HIGH carry the host HPA, visible
> +	 * only to the trusted VMM that virtualizes it away from the guest.
> +	 */
> +	if (iswrite) {
> +		*ppos += count;
> +		return count;
> +	}
> +
> +	tmp = kmalloc(count, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(tmp, cxl->hdm_regs + pos, count);

There's no memory-enabled gate on this access to mapped BAR space.

> +	if (copy_to_user(buf, tmp, count)) {
> +		kfree(tmp);
> +		return -EFAULT;
> +	}
> +	kfree(tmp);
> +
> +	*ppos += count;
> +	return count;
> +}
> +
> +static const struct vfio_pci_regops vfio_cxl_comp_regops = {
> +	.rw = vfio_cxl_comp_rw,
> +	.release = vfio_cxl_region_release,
> +};
> +
>  static void vfio_cxl_release_hpa(void *data)
>  {
>  	struct vfio_cxl_state *cxl = data;
> @@ -299,6 +353,21 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  		goto err;
>  	}
>  
> +	/*
> +	 * Map the HDM decoder registers so the decoder region can read them
> +	 * live. The block location comes from the enumeration cache in
> +	 * pdev->hdm; vfio-pci owns the BAR, so map without claiming the block.
> +	 */
> +	cxl->hdm_regs = devm_ioremap(&pdev->dev,
> +				     pci_resource_start(pdev, pdev->hdm->hdm_bar) +
> +				     pdev->hdm->hdm_offset, pdev->hdm->hdm_size);
> +	if (!cxl->hdm_regs) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	cxl->hdm_len = pdev->hdm->hdm_size;
> +
>  	/*
>  	 * A Type-2 accelerator has no mailbox and no media-ready register, so
>  	 * set media ready directly.
> @@ -381,6 +450,13 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
> +				  &vfio_cxl_comp_regops, cxl->hdm_len,
> +				  VFIO_REGION_INFO_FLAG_READ |
> +				  VFIO_REGION_INFO_FLAG_WRITE);
> +	if (ret)
> +		goto err_unregister_mem;
> +
>  	/*
>  	 * The HDM region is advertised mmap-able, so a fd holder can fault its
>  	 * struct-page-less device memory in from the host CPU. Register it with
> @@ -389,7 +465,7 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  	 */
>  	ret = vfio_cxl_register_pfn_space(vdev);
>  	if (ret && ret != -EOPNOTSUPP)
> -		goto err_unregister_mem;
> +		goto err_unregister_comp;
>  
>  	/*
>  	 * The decoder is firmware-committed, so host access to the HDM range is
> @@ -400,6 +476,9 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  
>  	return 0;
>  
> +err_unregister_comp:
> +	vfio_pci_core_unregister_dev_region(vdev);
> +
>  err_unregister_mem:
>  	vfio_pci_core_unregister_dev_region(vdev);

As noted previously, this is a bad interface, this is why.  Thanks,

Alex

>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1bf86763c0f7..8927a7a4e8e4 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -373,6 +373,8 @@ struct vfio_region_info_cap_type {
>  /* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
>  /* CXL.mem HDM region of a Type-2 device, mmap-able */
>  #define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
> +/* CXL HDM decoder registers: read live, guest writes are absorbed */
> +#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS	(2)
>  
>  /* sub-types for VFIO_REGION_TYPE_GFX */
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)

