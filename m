Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11013F1059;
	Fri, 28 Aug 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958578; cv=none; b=iAYpT2WG4yJppwlJPchEkFBLxNu9BXoUTEOGAiwp6NeK63mijexUhpXTF8pd230A4+/egCcyVsJa85JXLEQC6qdHwOP1nYjfRJfEgueS6MxtkhyQh7Gm7w7+d5PcgXWH/36UuuloYyzZAE+EjFIPGpRSKp5/ckFXHcRVUayZlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958578; c=relaxed/simple;
	bh=M+S0Qe6gzD2f2tpvWuC/m/Y9umqZ+IpuVrlzDdCBfAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/+0GEeYk5W9aUnnfZvXdYDxCMI468jBtSq3xJSJi3nNlzGXqMy13bj9Zh9L/iD/RtS0WKH3r2rbTUGD2VNe785lj9N3notEY0+d1yTX28SvxAYzdMjx7XaI6E9MMHYYLeto9Q/rt38GjwpaD2hx7TL3x7MtsPLEa74aMH86X9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=G9/iDDhJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwHO+Sja; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="G9/iDDhJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwHO+Sja"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 45F161D0016E;
	Fri, 28 Aug 2026 19:09:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 28 Aug 2026 19:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787958574;
	 x=1788044974; bh=pPZxrUyFD13EwfysWj3Rjbdl39HktBzOywgE979KReA=; b=
	G9/iDDhJ5zCdXb1HFR6J5nnrhtb24vvd8kqo8eBm3xkS/DYDlY+BY3mLPIXNvB5o
	4KJqiT5Khjm7AFOBkw9qTKZkYrZakmY5scuxvzI0vCQK3JzoXvmd+HQW03D7Z985
	XXLvi4ezZ5w9WXgRAe7ej4OFd1jpjqgIXmCPmstchYYjxw8T8zDtc3ZtjvmN3pMA
	qDozXplGFs8qxuQHNDpRJY2IFjoNFRETqcUmpKELwoAwHXP8eu7eWATW2jS91fK+
	Rxqle+sn14UlETAOhFvVNBMzLMYtM2NRAN+CT8ANXp/y/vNpLbHLAzthQs81JHue
	3gMl3ldEEXqecTy5HwuNow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787958574; x=
	1788044974; bh=pPZxrUyFD13EwfysWj3Rjbdl39HktBzOywgE979KReA=; b=K
	wHO+SjaA4YK1GpbZtamuZgUPY1yHgxkY7PUrC1SKOrID+emIeKzEK7cpkRpiBasT
	P324YwNOrgGsKyqmhNpeLJn/uHlQBOQrerpDXuk336GRuR/Wh6DHy40XSKEyFu8U
	/Mvgt+aMxVC9vcmE24CMMtpbu++jkv8XQzbdfrs57gsvYbSDlow5YiZIIV6rgVLp
	gzgTlJY7O+BmLVzScshclLC/icVsRQzoYWC9HyO1Fi2YVScFxt8Ls214RjNAwu0Q
	PQVMKhp90homZ0FZNQHugNDJrTPRatXJgoLYGQrzTochy2Ga8eHZgXUoeBJxeduC
	fSJLsQmxOjFjU4ldnslIA==
X-ME-Sender: <xms:LRWSajrKnWSm6PE-tIPPomR33drfWUa6EfGRuxJopTkeiqsgphGJyA>
    <xme:LRWSarTx9qG4q3mBLX9CVqs63wsGVQ5xXcwic8_YsGg6uv18MtvmFcs_fC2OyQr_i
    hPOHrDY44h4rrzXZHLsyKP-4QCPgyxwtGfl4vYivjY6J7YzHpeYtTo>
X-ME-Received: <xmr:LRWSankzdYzjdVQuPWTt0niQrTiztDGKyAV891Z1bGDsnJZKexckUB1gTg23ug>
X-ME-Proxy-Cause: dmFkZTFp+PjQ+yrWQcI/ldrotP6wjSkrpbEa3IRbYr15x4p1TNwhEJOR+wAdrcWMZ9ZRFX
    nNVrBzCz6GMcaYxyTcwwjd6E4kH2ddYx1797xH3uiVG6KH7A2qXqRJiS1H3T6uoKLDAcUK
    l+04ChnlOaPdLEKB4Mzj/666ogNSW0grjdoTnaopX9SahQnp0wAa3SnVeFKcn7rbKSb5dn
    vVQsJR8IIZtil3ce5G0TD4F/Y+en0lUNJsxLtV+JGP4fT5j8pvl5BOuF2wHw9Ju1+WTCvX
    00BsQnJXZsZtfHuWGsLgqYgJvxL94ektu9D3su0AqKodLZVO/fDSrKupv3rC0qDsVpPZDC
    q0TXcG1fOacyymNA4zhpo3zu/MTx4ECic0NGfritqaEbeFISOti5UVt62qJYgZtR1ZBYPI
    jH6kxKh7/Y1TR6ztsTI6BODLdfZnMk+KnwBwuHvNTkMRuQEz3ce3NxZVEKgf2UhZIcxmUq
    Aovv0wjKPH1jtklMS2yE/U+X4p4QOCRwjkKESdJgHBIV0Tplfl90/fkBs8b41ssUj6akSp
    IxdxlsDy0IaSozy3qG4TpWzTYdgJP4iqvwPrsUoUabS/HsUccfVTP7z+MiAhp9frf2AMoY
    l9x87MoCM/+SXLXJFDzrbCqwHrGyUqyF9/ddGIw23T904eGWrYzfOb1JGvYg
X-ME-Proxy: <xmx:LRWSavFs2U1FvRo5e4s-3KiRmqxv93HYSgnI8uupHTwp7zMdQnaNlA>
    <xmx:LRWSaqmgh_PLfpY5ZzfCa10Frc8z3iOXGvwM6oFYeQ5d4UaIdY6fKg>
    <xmx:LRWSauS-chhhqz-INuCiqJ-2k1qRpeu_iqrzobAK054X_Qa8Puqvzw>
    <xmx:LRWSav5paj2voT6OJryCa0cGoenpSOVN-g3q4rSi12RHqS56sbOHvw>
    <xmx:LhWSavE44VGQeGzNv6viATaFPZ5tGPCp6GBSJDpw-8lmHFvjMO4WbrA9>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 19:09:31 -0400 (EDT)
Date: Fri, 28 Aug 2026 17:09:30 -0600
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
Subject: Re: [PATCH v4 24/27] vfio/cxl: Service a guest-triggered CXL reset
Message-ID: <20260828170930.3bf438eb@shazbot.org>
In-Reply-To: <20260813093631.2288172-25-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-25-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:28 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> When the guest sets Initiate_CXL_Reset in the CXL DVSEC, run the reset on
> its behalf. The bit is not forwarded to hardware; the CXL core drives the
> state machine through cxl_reset_dvsec_sequence(). The memory_lock, mapping
> revoke and dma-buf quiesce are core-internal, so the core exposes a
> wrapper that runs them around the CXL-specific work.
> 
> A CXL reset can clear config like an FLR, so the sequence is bracketed by
> pci_save_state() and pci_restore_state(), with Bus Master dropped for the
> window and kept dropped if a step failed, so the function cannot DMA over
> decoders that were not restored. The guest owns Mem_Clr_Enable, read from
> the shadow, and the outcome is stamped into STATUS2 for it to poll.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 167 ++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_config.c   |   4 +-
>  drivers/vfio/pci/vfio_pci_core.c     | 215 +++++++++++++++++++++++++--
>  drivers/vfio/pci/vfio_pci_priv.h     |   2 +
>  include/linux/vfio_pci_core.h        |   3 +
>  5 files changed, 374 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index f45eaa60bad2..b3eaefa03479 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/cleanup.h>
>  #include <linux/memory-failure.h>
> +#include <linux/memregion.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -761,6 +762,16 @@ static u16 vfio_cxl_dvsec16(struct vfio_cxl_state *cxl, u32 off)
>  	return (dw >> (8 * (off % sizeof(u32)))) & 0xffff;
>  }
>  
> +/* Write a 16-bit DVSEC field into the shadow; the field must not straddle a dword. */
> +static void vfio_cxl_dvsec_write16(struct vfio_cxl_state *cxl, u32 off, u16 val)
> +{
> +	u32 shift = 8 * (off % sizeof(u32));
> +	u32 idx = off / sizeof(u32);
> +
> +	cxl->dvsec_shadow[idx] &= ~(0xffffU << shift);
> +	cxl->dvsec_shadow[idx] |= (u32)val << shift;
> +}
> +
>  /*
>   * Apply the CXL r4.0 8.1.3 write class for the 16-bit DVSEC register at @off.
>   * Control is programmable, Status is write-1-to-clear, and Capability, Lock and
> @@ -815,12 +826,14 @@ static int vfio_cxl_config_write(struct vfio_pci_core_device *vdev, int pos,
>  	int boff = (pos - cxl->dvsec) % sizeof(u32);
>  	u32 off = idx * sizeof(u32);
>  	__le32 le_wval = 0, le_wmask = 0;
> +	u16 before, after, lo, hi;
>  	u32 old, wval, wmask;
> -	u16 lo, hi;
>  
>  	if (pos < cxl->dvsec || pos >= cxl->dvsec + cxl->dvsec_len)
>  		return -ENODEV;
>  
> +	before = vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2);
> +
>  	/*
>  	 * Place the guest bytes and a matching byte mask at the write offset,
>  	 * then let the per-field class decide what actually lands in the shadow.
> @@ -836,9 +849,159 @@ static int vfio_cxl_config_write(struct vfio_pci_core_device *vdev, int pos,
>  	hi = vfio_cxl_dvsec_field(off + 2, old >> 16, wval >> 16, wmask >> 16);
>  	cxl->dvsec_shadow[idx] = lo | ((u32)hi << 16);
>  
> +	/*
> +	 * A 0->1 write of Initiate_CXL_Reset asks for a CXL reset. It is not
> +	 * forwarded to hardware; cxl_reset_dvsec_sequence() drives the state
> +	 * machine, and the outcome comes back through STATUS2.
> +	 */
> +	after = vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2);
> +	if (!(before & PCI_DVSEC_CXL_INIT_CXL_RST) &&
> +	    (after & PCI_DVSEC_CXL_INIT_CXL_RST) &&
> +	    cxl_reset_capable(vdev->pdev))
> +		vfio_pci_core_cxl_reset(vdev);
> +
>  	return count;
>  }
>  
> +static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct pci_saved_state *saved_state;
> +	bool mem_clr;
> +	u16 ctrl2, status2, cmd;
> +	int ret;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	/*
> +	 * The host cxl_reset PCI method cannot run for a vfio-owned device: it
> +	 * requests the HDM range that this driver already holds exclusively, so
> +	 * it always fails busy. Drive the DVSEC reset directly here. Report
> +	 * not-capable so the core reset path can fall back to a standard PCI
> +	 * reset for a device with no CXL reset, such as a multifunction device.
> +	 */
> +	if (!cxl_reset_capable(pdev))
> +		return -ENOTTY;
> +
> +	/*
> +	 * Mem_Clr_En comes from the guest shadow CTRL2 while the device is open.
> +	 * The core reset path also drives this reset at VM power on and off with
> +	 * no shadow present, so read it from the live DVSEC then.
> +	 */
> +	if (cxl->dvsec_shadow)
> +		ctrl2 = vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2);
> +	else
> +		pci_read_config_word(pdev, cxl->dvsec + PCI_DVSEC_CXL_CTRL2,
> +				     &ctrl2);
> +	mem_clr = ctrl2 & PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +
> +	/*
> +	 * Mem_Clr is guest-controlled (Mem_Clr_En in the DVSEC CTRL2), so honor it
> +	 * and pass it to cxl_reset_dvsec_sequence(). It zeroes the device memory,
> +	 * but that sequence does not write back host CPU caches over the HDM range
> +	 * the way the host cxl_reset method does. The range is mapped write-back,
> +	 * so a dirty host line could survive the clear and overwrite it; invalidate
> +	 * it first when the platform can.
> +	 *
> +	 * When cpu_cache_has_invalidate_memregion() is false proceed rather
> +	 * than abort. Unlike native CXL region invalidation, which the host
> +	 * manages and must fail safe, the host CPU never writes passthrough
> +	 * HDM range: the guest owns it through its stage-2 mapping, so there
> +	 * are no dirty host lines for the clear to lose.
> +	 * Warn once so the case is visible rather than silent.
> +	 */
> +	if (mem_clr) {
> +		if (cpu_cache_has_invalidate_memregion()) {
> +			ret = cpu_cache_invalidate_memregion(cxl->hpa_range.start,
> +							     range_len(&cxl->hpa_range));
> +			if (ret) {
> +				pci_err(pdev, "vfio-cxl: reset: CPU cache invalidate failed (%d), aborting reset\n",
> +					ret);
> +				return ret;
> +			}
> +		} else {
> +			pci_warn_once(pdev, "vfio-cxl: reset: no CPU cache invalidation available; proceeding with Mem_Clr (host does not cache the HDM range)\n");
> +		}
> +	}
> +
> +	/*
> +	 * A CXL reset can clear config like an FLR, so save state and drop Bus
> +	 * Master for the reset window; the function masters the bus again only
> +	 * once the decoders are restored.
> +	 *
> +	 * Sample the guest's Bus Master intent from live config before the reset
> +	 * perturbs it, so it can be reapplied after the decoder is known good with
> +	 * no window in which pci_restore_state() leaves Bus Master enabled.
> +	 */
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +
> +	saved_state = pci_store_saved_state(pdev);
> +	if (!saved_state && pdev->state_saved) {
> +		pci_err(pdev, "vfio-cxl: reset: saved-state stash failed (-ENOMEM), aborting reset\n");
> +		return -ENOMEM;
> +	}
> +	if (saved_state)
> +		pci_save_state(pdev);
> +	pci_clear_master(pdev);
> +	ret = cxl_reset_dvsec_sequence(pdev, mem_clr);
> +	pci_restore_state(pdev);
> +	pci_clear_master(pdev);
> +	/*
> +	 * pci_restore_state() reinstated the guest's PCI_COMMAND, which may have
> +	 * re-enabled Bus Master while the reset outcome, and thus decoder
> +	 * validity, is not yet known. The pci_clear_master() above is its
> +	 * immediate next statement, so there is no window in which a failed reset
> +	 * could DMA over decoders that were not restored.
> +	 */
> +	if (saved_state)
> +		pci_load_and_free_saved_state(pdev, &saved_state);
> +	/*
> +	 * Re-enable Bus Master only for a clean reset or -EBUSY (the reset never
> +	 * ran, so the firmware-committed decoder is intact), and only if the guest
> +	 * had it enabled (sampled before the reset).
> +	 */
> +	if ((!ret || ret == -EBUSY) && (cmd & PCI_COMMAND_MASTER))
> +		pci_set_master(pdev);
> +
> +	vfio_cxl_post_reset(vdev);
> +
> +	/*
> +	 * A clean reset restored the decoder, and -EBUSY means the reset never
> +	 * ran so the firmware-committed decoder is intact: both are known-good.
> +	 * Any other error may have left the decoder unrestored, so close the gate
> +	 * until the next open or restore. Faults cannot race this: the caller
> +	 * holds memory_lock for write across the whole reset.
> +	 */
> +	if (cxl->hdm_shadow) {
> +		if (!ret || ret == -EBUSY)
> +			cxl->hdm_valid = true;
> +		else
> +			cxl->hdm_valid = false;
> +	}
> +
> +	/*
> +	 * The guest-facing DVSEC bookkeeping only applies while the device is
> +	 * open. Initiate_CXL_Reset self-clears in hardware; mirror that and
> +	 * stamp the outcome onto a fresh hardware STATUS2 read for the polling
> +	 * guest. A contended -EBUSY reports as an error so the guest can reissue
> +	 * rather than poll a result that never comes.
> +	 */
> +	if (cxl->dvsec_shadow) {
> +		vfio_cxl_dvsec_write16(cxl, PCI_DVSEC_CXL_CTRL2,
> +				       vfio_cxl_dvsec16(cxl, PCI_DVSEC_CXL_CTRL2) &
> +				       ~PCI_DVSEC_CXL_INIT_CXL_RST);
> +
> +		pci_read_config_word(pdev, cxl->dvsec + PCI_DVSEC_CXL_STATUS2,
> +				     &status2);
> +		status2 &= ~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR);
> +		status2 |= ret ? PCI_DVSEC_CXL_RST_ERR : PCI_DVSEC_CXL_RST_DONE;
> +		vfio_cxl_dvsec_write16(cxl, PCI_DVSEC_CXL_STATUS2, status2);
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.init_device	= vfio_cxl_init_device,
>  	.release_device	= vfio_cxl_release_device,
> @@ -849,6 +1012,7 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.zap		= vfio_cxl_zap,
>  	.post_reset	= vfio_cxl_post_reset,
>  	.pm_restore	= vfio_cxl_pm_restore,
> +	.reset		= vfio_cxl_reset,
>  	.owner		= THIS_MODULE,
>  };
>  
> @@ -869,3 +1033,4 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
>  MODULE_ALIAS("vfio-cxl");
>  MODULE_IMPORT_NS("CXL");
> +MODULE_IMPORT_NS("DEVMEM");
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 01d808546a4c..f6509824988c 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -910,7 +910,7 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> +			vfio_pci_reset_function(vdev);
>  			vfio_pci_cxl_post_reset(vdev);
>  			if (__vfio_pci_memory_enabled(vdev))
>  				vfio_pci_dma_buf_move(vdev, false);
> @@ -996,7 +996,7 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> +			vfio_pci_reset_function(vdev);
>  			vfio_pci_cxl_post_reset(vdev);
>  			if (__vfio_pci_memory_enabled(vdev))
>  				vfio_pci_dma_buf_move(vdev, false);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index fc8235c8b4fc..0fed8e00bc1d 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -635,8 +635,26 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		goto out_power;
>  
>  	/* If reset fails because of the device lock, fail this path entirely */
> -	ret = pci_try_reset_function(pdev);
> -	if (ret == -EAGAIN)
> +	if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +		/*
> +		 * VM power-on resets a CXL Type-2 device through its DVSEC
> +		 * sequence. vconfig is not built yet here, so take memory_lock
> +		 * and call the op directly rather than the wrapper.
> +		 */
> +		down_write(&vdev->memory_lock);
> +		ret = vdev->cxl_ops->reset(vdev);
> +		up_write(&vdev->memory_lock);
> +	} else {
> +		ret = pci_try_reset_function(pdev);
> +	}
> +	/*
> +	 * -EAGAIN means the reset could not run. For a CXL device any reset
> +	 * error must also fail the open: a failed DVSEC reset can leave the HDM
> +	 * decoder cleared or unrestored, and continuing would expose the HDM
> +	 * region for host access through a decoder in an unknown state.
> +	 */
> +	if (ret == -EAGAIN ||
> +	    (vdev->cxl_ops && vdev->cxl_ops->reset && ret))
>  		goto out_disable_device;
>  
>  	vdev->reset_works = !ret;
> @@ -824,16 +842,30 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge = pci_upstream_bridge(pdev);
> -		if (bridge && !pci_dev_trylock(bridge))
> -			goto out_restore_state;
> -		if (pci_dev_trylock(pdev)) {
> -			if (!__pci_reset_function_locked(pdev))
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +			/*
> +			 * VM power-off resets a CXL Type-2 device through its
> +			 * DVSEC sequence. The sequence takes its own device lock,
> +			 * so run it outside the lock below.
> +			 * vconfig is already freed here, so call the op directly
> +			 * under memory_lock rather than the wrapper.
> +			 */
> +			down_write(&vdev->memory_lock);
> +			if (!vdev->cxl_ops->reset(vdev))
>  				vdev->needs_reset = false;
> -			pci_dev_unlock(pdev);
> +			up_write(&vdev->memory_lock);
> +		} else {
> +			bridge = pci_upstream_bridge(pdev);
> +			if (bridge && !pci_dev_trylock(bridge))
> +				goto out_restore_state;
> +			if (pci_dev_trylock(pdev)) {
> +				if (!__pci_reset_function_locked(pdev))
> +					vdev->needs_reset = false;
> +				pci_dev_unlock(pdev);
> +			}
> +			if (bridge)
> +				pci_dev_unlock(bridge);

We basically have the function below that would clean this up, but
we're open coding it still...

>  		}
> -		if (bridge)
> -			pci_dev_unlock(bridge);
>  	}
>  
>  out_restore_state:
> @@ -1441,6 +1473,20 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +/*
> + * Reset a function the way a guest asked for. A CXL Type-2 device resets
> + * through its DVSEC sequence: the host cxl_reset method would collide
> + * with the exclusive HDM range this driver holds and fail busy. Everything else
> + * takes a standard PCI function reset. The caller holds memory_lock, which the
> + * DVSEC sequence requires.
> + */
> +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev)
> +{
> +	if (vdev->cxl_ops && vdev->cxl_ops->reset)
> +		return vdev->cxl_ops->reset(vdev);
> +	return pci_try_reset_function(vdev->pdev);
> +}

"Reset a function the way a guest asked for", but we're actually
replacing FLR with a CXL reset.  That's not what the user (please don't
assume a VM use case in vfio kernel code) ask for.

> +
>  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  				void __user *arg)
>  {
> @@ -1463,7 +1509,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
>  	vfio_pci_dma_buf_move(vdev, true);
> -	ret = pci_try_reset_function(vdev->pdev);
> +	ret = vfio_pci_reset_function(vdev);
>  	vfio_pci_cxl_post_reset(vdev);
>  	if (__vfio_pci_memory_enabled(vdev))
>  		vfio_pci_dma_buf_move(vdev, false);
> @@ -2736,6 +2782,21 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  		goto err_unlock;
>  	}
>  
> +	/*
> +	 * A multifunction CXL Type-2 device cannot be bus reset: its DVSEC
> +	 * reset acts per function, so a shared secondary bus reset would reset
> +	 * sibling functions out from under their own state. Reject it, matching
> +	 * the cxl_reset bus method. A single-function device is quiesced through
> +	 * its DVSEC sequence just before the reset below.
> +	 */
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset &&
> +		    vdev->pdev->multifunction) {
> +			ret = -ENOTTY;
> +			goto err_unlock;
> +		}
> +	}

What?  The whole purpose of the hot reset is to handle bus resets
affecting multiple devices.  Affecting sibling functions is part of the
scope agreement of this interface.  This is what the dev_set does.

> +
>  	/*
>  	 * Some of the devices in the dev_set can be in the runtime suspended
>  	 * state. Increment the usage count for all the devices in the dev_set
> @@ -2817,11 +2878,57 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
>  		vfio_pci_set_power_state(vdev, PCI_D0);
>  
> +	/*
> +	 * Quiesce each CXL Type-2 device through its DVSEC sequence before the
> +	 * secondary bus reset: the bus reset alone does not write back the
> +	 * device cache or tear down the HDM decoders. memory_lock is held. If a
> +	 * quiesce fails, abort before the bus reset: resetting an unquiesced CXL
> +	 * device risks data loss or a fabric error. Every device is locked here,
> +	 * so unwind from the last one.
> +	 */
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +			ret = vdev->cxl_ops->reset(vdev);
> +			if (ret) {
> +				pci_warn(vdev->pdev, "vfio-cxl: hot reset: DVSEC quiesce failed (%d), aborting before bus reset\n",
> +					 ret);
> +				vdev = list_last_entry(&dev_set->device_list,
> +						       struct vfio_pci_core_device,
> +						       vdev.dev_set_list);
> +				goto err_undo;
> +			}
> +		}
> +	}

Does writing back the device cache affect data beyond the scope of the
user that owns the device?  Preventing fabric errors that might
escalate to system errors is a concern.  Losing data that the device
might be caching outside the scope of the user data is a concern.
Preventing user data loss because they reset a device holding their own
data is not a concern.

> +
>  	ret = pci_reset_bus(pdev);
>  
> -	/* Re-sample decoder state for any CXL device the bus reset touched. */
> -	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
> -		vfio_pci_cxl_post_reset(vdev);
> +	/*
> +	 * pci_reset_bus() restored each device's PCI_COMMAND, which can re-enable
> +	 * Bus Master, but the secondary bus reset cleared the physical HDM decoder
> +	 * that the CXL quiesce above restored. Until it is restored a CXL device
> +	 * could DMA over cleared decode, so for each CXL device drop Bus Master,
> +	 * restore and re-sample the decoder, then re-enable Bus Master to the
> +	 * guest's intent only once the decoder is known good. Re-sampling alone
> +	 * would leave hdm_valid true over a cleared decoder. Keep the first restore
> +	 * error so a failed restore is reported instead of the bus reset's success.
> +	 */
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
> +		u16 cmd;
> +		int rret;
> +
> +		if (!(vdev->cxl_ops && vdev->cxl_ops->reset))
> +			continue;
> +
> +		pci_read_config_word(vdev->pdev, PCI_COMMAND, &cmd);
> +		pci_clear_master(vdev->pdev);
> +		rret = vfio_pci_cxl_pm_restore(vdev);
> +		if (rret) {
> +			if (!ret)
> +				ret = rret;
> +		} else if (cmd & PCI_COMMAND_MASTER) {
> +			pci_set_master(vdev->pdev);
> +		}
> +	}

More open coded calls that should be handled via .reset_done.

>  
>  	vdev = list_last_entry(&dev_set->device_list,
>  			       struct vfio_pci_core_device, vdev.dev_set_list);
> @@ -2876,6 +2983,16 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  	if (!pdev)
>  		return;
>  
> +	/*
> +	 * A multifunction CXL Type-2 device cannot be bus reset (its DVSEC
> +	 * reset is per function), so skip the automatic reset rather than reset
> +	 * sibling functions out from under their state.
> +	 */
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
> +		if (cur->cxl_ops && cur->cxl_ops->reset &&
> +		    cur->pdev->multifunction)
> +			return;
> +

Nope.

>  	/*
>  	 * Some of the devices in the bus can be in the runtime suspended
>  	 * state. Increment the usage count for all the devices in the dev_set
> @@ -2884,9 +3001,56 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  	if (vfio_pci_dev_set_pm_runtime_get(dev_set))
>  		return;
>  
> +	/*
> +	 * Quiesce each CXL Type-2 device through its DVSEC sequence before the
> +	 * bus reset, which alone does not write back the device cache or tear
> +	 * down the HDM decoders. Take memory_lock and zap the HDM window as the
> +	 * explicit hot reset does. On lock contention or a failed quiesce, skip
> +	 * the bus reset and leave needs_reset set for a later retry.
> +	 */
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
> +		if (!(cur->cxl_ops && cur->cxl_ops->reset))
> +			continue;
> +		if (!down_write_trylock(&cur->memory_lock))
> +			goto unwind;
> +		vfio_pci_cxl_zap(cur);
> +		if (cur->cxl_ops->reset(cur)) {
> +			up_write(&cur->memory_lock);
> +			goto unwind;
> +		}
> +	}

.reset_prepare?

> +
>  	if (!pci_reset_bus(pdev))
>  		reset_done = true;
>  
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
> +		u16 cmd;
> +
> +		if (!(cur->cxl_ops && cur->cxl_ops->reset))
> +			continue;
> +		/*
> +		 * pci_reset_bus() restored PCI_COMMAND, which can re-enable Bus
> +		 * Master, but the bus reset cleared the physical HDM decoder. Drop
> +		 * Bus Master, restore and re-sample the decoder, then re-enable Bus
> +		 * Master to the guest's intent once the decoder is known good.
> +		 * Re-sampling alone would leave hdm_valid true over a cleared
> +		 * decoder.
> +		 */
> +		pci_read_config_word(cur->pdev, PCI_COMMAND, &cmd);
> +		pci_clear_master(cur->pdev);
> +		if (!vfio_pci_cxl_pm_restore(cur) && (cmd & PCI_COMMAND_MASTER))
> +			pci_set_master(cur->pdev);
> +		up_write(&cur->memory_lock);
> +	}

.reset_done?  Thanks,

Alex

> +	goto out;
> +
> +unwind:
> +	list_for_each_entry_continue_reverse(cur, &dev_set->device_list,
> +					     vdev.dev_set_list)
> +		if (cur->cxl_ops && cur->cxl_ops->reset)
> +			up_write(&cur->memory_lock);
> +
> +out:
>  	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
>  		if (reset_done)
>  			cur->needs_reset = false;
> @@ -2919,6 +3083,29 @@ void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
>  
> +/*
> + * Drive a guest-requested CXL reset. The memory_lock, mapping revoke and
> + * dma-buf quiesce are core-internal, so vfio-cxl calls in here to run them
> + * around its DVSEC reset sequence.
> + */
> +int vfio_pci_core_cxl_reset(struct vfio_pci_core_device *vdev)
> +{
> +	int ret;
> +
> +	if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
> +		return -ENOTTY;
> +
> +	vfio_pci_zap_and_down_write_memory_lock(vdev);
> +	vfio_pci_dma_buf_move(vdev, true);
> +	ret = vdev->cxl_ops->reset(vdev);
> +	if (__vfio_pci_memory_enabled(vdev))
> +		vfio_pci_dma_buf_move(vdev, false);
> +	up_write(&vdev->memory_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_cxl_reset);
> +
>  static void vfio_pci_core_cleanup(void)
>  {
>  	vfio_pci_uninit_perm_bits();
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 46e67573d264..8055099cab03 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -102,6 +102,8 @@ static inline int vfio_pci_cxl_pm_restore(struct vfio_pci_core_device *vdev)
>  	return 0;
>  }
>  
> +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
> +
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
>  					u16 cmd);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index c438d968dc59..18e206a35d8c 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -82,6 +82,8 @@ struct vfio_cxl_ops {
>  	void    (*post_reset)(struct vfio_pci_core_device *vdev);
>  	/* Restore the HDM decoder after a D3hot->D0 soft reset */
>  	int     (*pm_restore)(struct vfio_pci_core_device *vdev);
> +	/* Run the CXL reset sequence; the core holds memory_lock across it */
> +	int     (*reset)(struct vfio_pci_core_device *vdev);
>  
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
> @@ -89,6 +91,7 @@ struct vfio_cxl_ops {
>  
>  int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
>  void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
> +int vfio_pci_core_cxl_reset(struct vfio_pci_core_device *vdev);
>  
>  #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
>  int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,

