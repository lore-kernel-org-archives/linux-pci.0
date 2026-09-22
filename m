Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FC390613;
	Tue, 22 Sep 2026 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043380; cv=none; b=qfb7Hk0I/yVgcz9QS6t7X0VL+I6T1tkCbbIyZSFcZOaBJygmVvi5ijuuqqISCjwehHJkUyaWn1ZP1JZixoTglIFf0aTnov7mpvkyyeGGSZa1nwVHQwlJOqfvlOOyEVzU5cAWEaXHAQLh4WrtjlaXW4OuCLdjLISjdt8t99pgI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043380; c=relaxed/simple;
	bh=JChkfec2dEouOOaSiXifHUTvVwtWdzUwNG1WSc+jHPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcnTrPCvRw0jnFYVsXoFrSE5BmyS/1AGVBpUxlrghr1wRr4wt05QVY88fH6pUQnSEeykuTLzEdEZujwMQTsDfNhm7/H3DOAYXxarT97NAqG4QeazS3t8hP4YvHCpBrH/SqK8rlxTmYkHdOntGVA7n+56cHm/YTt+8DiipH2E49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Bw2UrYYu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQqDEhEM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Bw2UrYYu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQqDEhEM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C31951D00064;
	Mon, 21 Sep 2026 22:16:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 22:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043376;
	 x=1790129776; bh=bx+YxGdB1zL2GePgz8fydiK5eK1b9iCXWKONIMFQApY=; b=
	Bw2UrYYuemgcpPjqRVDbKrevE4p2Ji+DJNcvngYKTjv4FU39g/1xips+4r/dlXHg
	Xsd84nLWoVweiH6wrWIflMXK2U3FMuwQ0CtyS7FDJd76YNVwgVFp6n1q+FIhaBmi
	Zlf+L46VWPwP/6OFIZyFNvz3FWHDughyKV4yuH2yd0z9nPipd3Vam0+bHtVCI3k7
	33jDMSoMtVeCZL7SlQRw4sZ74QtQ8gDe9cnkxshX/zlUwY86ofmB+82wdRQVL9wd
	g/6d6KY08+kuPQmSi3fU8n5Ha+bEXP63KNCGV4VYKehoX1sA+cUyN3rwQiwiupPw
	uGgeryTA97R/qPOFZA2Y4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043376; x=
	1790129776; bh=bx+YxGdB1zL2GePgz8fydiK5eK1b9iCXWKONIMFQApY=; b=D
	QqDEhEMp4abgOo8jhOUh/g/kwyL2AGNOpr15sTuEru7C1Pnh4i24drbhVS5qXQsY
	rYXJEZJ/2Oez8yPsWSXI2F27yWNVd4vAwBWilbk0rrUpomDsa0+Y6UCPRGT9r8zC
	G938FbeREVan/bB4yGbUYFf1j7igL7hCmuK9lPQDfXJhCEhLBN8T9t9wZ4BuNtsw
	rS+i41lJDdT0w//x0fLwhk8th275EgaKRr2DTsIrQbBKgIulewvXjRxtXpk1yFnc
	Lv2K6ur97PAGDGdEp0doRNlPPhqBujgfb7HHHuP45dPyP+1OM9jjx49Co6DxQVQB
	6bUyk4WDhdEUKMWUTGH3g==
X-ME-Sender: <xms:8OSxag4HvxLDRc6B3NRGKcKDK15Y_Ghw3SJoldr49-yio_gBs9lyqQ>
    <xme:8OSxavhPNI4TM_oDx004dKWM7bMaW7VbWuANkY8uvkmAZyYQpeRz_D8A-pkwfX96t
    TINvV5ZVf4bvoZJdjyBAsm3RpuSj3ezf9ONlq7LAM4_Pt4egCdAhp0>
X-ME-Received: <xmr:8OSxam1u9yMoxi_vcOe8DZHs6JAMXg2zRqhQa6r464eNsq4DrMn-REW6COmiyQ>
X-ME-Proxy-Cause: dmFkZTGXJSHqMq/BnZYJ0YweOb4rS2VUXpPM7d5+lSYGhnppGFsNjl5Bysv+w6+cDnCJ/7
    /L3Cxi42gIwxQ2NUo+88ApQMAdaEv47yc8fAsLypxGx87oHF4HT7ama3q0ueulG4TPc0DY
    g9aq/+AIZ/88RBFY6z24OfxBW3WPjyGYAaKrF0WRpWdqsttcvGMxliaYSaCPsYHObnA4na
    kPveiLHd3CCXxarYrwtQo6T70Ls9xKt0FRJqIrLM1i8XMnEKMgqeJVG7tIy0ld86sgmRqY
    QTP1Xf0Z/CD0h9dlYVSVFIdwBL83CGpVR9ekjjvy4BxnnVieSYFxqs3RHn4BnowjRSHstg
    Y7k0oKLaAODy79OVG6nd69+sgXjApzG4DDOWQskBIWmAz1w6W/N/qy6E9pzrerum/FS2/F
    F2Fi8JrsNZmphKcohiBPe7AESDsoupPFgs1Ak0eE1X/sU/YbTGosiJ7/ovE1Hr9ZVDb5Gx
    Z9vkQAvSWIJoWaKfqshdioTCYP1NP1Dx/EqVV4OjMPW2yXo8q8f0qw+4Dp89B1McNh1xgv
    8J0BFyLA2565PFmZLx3+mmZtKcUcmHUyAiCtH/618qLL6VA4SwihLSoq2Vdgp5JlvIKO52
    SMtDU9EW/XbX/wzArk9Pgj6Pxs0ZVwOW72AIMxvnf/EJMOq6i9VKm9IXn68A
X-ME-Proxy: <xmx:8OSxatW-M8LahaXwOEuCKnvjrFdN4cQma3RglojhMwzVdGQNwGqLXA>
    <xmx:8OSxar1Wv9kfuZeMT-3hWldG6mPc8J1NheIMWDkRb5ox8-vGHsNRUA>
    <xmx:8OSxamg9MV6BtacWpkaOcQb6H10XOTCLFZG4z_AUUIwC0Kb6-A93_w>
    <xmx:8OSxajLg4C6Pkvlh2o5HqQIXLf9_Qs47rY6IYVxHkhjjKjfhvxCDjQ>
    <xmx:8OSxahWRuO-Y6OgcEaU3w8HcJqDMF8SYA1yPkM_G8mWp6j3D0sPxcbya>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:16:09 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:13:15 -0600
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
Subject: Re: [PATCH v5 22/27] vfio/cxl: Clear the HDM access gate after a
 hot reset
Message-ID: <20260921201315.6e237710@shazbot.org>
In-Reply-To: <20260916183540.3813685-23-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-23-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:35 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> The HDM memory fault inserts a PFN only when the decoder is in a
> known-good state (cxl->hdm_valid), so the host CPU never faults the
> coherent range into a disabled decoder.
> 
> VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset rather than
> the CXL reset sequence, so nothing restores the decoder in the
> reset_done handler. A secondary bus reset only reaches a CXL endpoint
> when the upstream port has SBR unmasked (CXL r3.1 sec 8.1.5.2); in that
> case the reset decommits the decoder, so clear cxl->hdm_valid to keep a
> later fault from inserting a PFN into a dead decoder.
> 
> A subsequent VFIO_DEVICE_RESET runs the CXL reset sequence and restores
> it, and a masked SBR is a no-op that leaves the decoder intact.
> 
> vfio_cxl_sbr_unmasked() mirrors the cxl_sbr_masked() check the PCI core
> uses (drivers/pci/pci.c) for its own CXL bus reset.

This all sounds very broken.  If a hot reset is masked, it should fail,
not silently do nothing.  If a hot reset is unmasked, we can't just
invent that the user needs to follow it with a reset ioctl, and the
decoder is dead for the remainder of their session otherwise.

So on one hand, we have a reset we can't use because it doesn't do
anything, and on the other we have a reset that we can't use because in
doing something it makes the device effectively unrecoverable, without
some assumption to perform a reset ioctl.

Are bus resets just not supported on CXL devices through vfio-pci?
Thanks,

Alex

 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 38 ++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 37e8a3b54cfb..395b4a5b0956 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -514,8 +514,46 @@ static void vfio_cxl_reset_prepare(struct vfio_pci_core_device *vdev)
>  {
>  }
>  
> +/*
> + * A secondary bus reset only reaches a CXL endpoint when the upstream port
> + * has SBR unmasked (CXL r3.1 sec 8.1.5.2); otherwise the Bridge Control SBR
> + * bit is ignored and the decoder is left intact. Mirrors the cxl_sbr_masked()
> + * check the PCI core uses for its own CXL bus reset.
> + */
> +static bool vfio_cxl_sbr_unmasked(struct pci_dev *pdev)
> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(pdev);
> +	u16 dvsec, ctl;
> +
> +	if (!bridge)
> +		return false;
> +
> +	dvsec = pci_find_dvsec_capability(bridge, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_PORT);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &ctl))
> +		return false;
> +
> +	return ctl & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
> +}
> +
>  static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	/*
> +	 * VFIO_DEVICE_PCI_HOT_RESET drives a plain secondary bus reset, not the
> +	 * CXL-aware cxl_reset_bus_function(), so nothing restores the HDM
> +	 * decoder here. When the upstream port has SBR unmasked the reset
> +	 * decommits the decoder; gate host access to the HDM range so a later
> +	 * fault cannot insert a PFN into a dead decoder. A VFIO_DEVICE_RESET
> +	 * then runs the CXL reset sequence and restores it. A masked SBR is a
> +	 * no-op and leaves the decoder intact.
> +	 */
> +	if (vfio_cxl_sbr_unmasked(vdev->pdev))
> +		cxl->hdm_valid = false;
>  }
>  
>  static const struct vfio_cxl_ops vfio_cxl_ops = {

