Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9131DF748;
	Fri, 28 Aug 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956413; cv=none; b=kvYHe89CgM7At6Ko0AFA4JibcNqn1YttZ5MJ0cd6VD/UBSSoE0W704UHEiikGra6vr9sefA6Z3/bGnTI30WGiNWdcAhxb642KeyBJ3hgo6a0tlZoyg60+dHVs96oMzVaqzhGKPbxpJyvFMb9NLh57T0DVEFmnob7FAn98cl0Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956413; c=relaxed/simple;
	bh=6rljSf2blq1IuWFPoteYTsefj2D3igoV8joWhKSdYsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUtNQvFLaRpuLZfi36zRO9vqQInHzCtUcpmNDm/U+ZuXCb318dgzxeH0j2LXYDxYhSHtvSlS06jIsBW1O9Xy/StNBIRHm8P7BN0sWHflTcVnP3GB25fRtlibIzhQfnNOsL5ge+u8r/qPQGPU9/hlIMSZSqcBwchruDo0TxZO4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=qZtByXnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdFe2dIa; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="qZtByXnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdFe2dIa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DE001D00160;
	Fri, 28 Aug 2026 18:33:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 28 Aug 2026 18:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787956409;
	 x=1788042809; bh=PCuhoGNop9xFU6pYipCLMjkZOpCJAx/06aOwcazXm6c=; b=
	qZtByXnzPf3pcPMVzA0srGeDgFQlzBWtc54Nr6a55xHKRsj5VAcMqglRK0yDKXJx
	16uG/Bb6aBiiEE82aTFxCV6X9sdmJCf323lx+9hjkOyZU68rPYAjnx93DunX/nGC
	XmbihOBYFn8t+jkF0IzQzfDI+zjl8vZNwZBLrs0/9P5x/TGVPKVOPmTgl9N1zNoA
	xwGj3pqndDa29tJwerHUoeW1UmkAPdColcV7kGxIHuDf4nVg5ccgtLTq4OMsELP9
	eS7JsdYcSC4eKvro44naHDN5GuR1yecvWECI2MLHBpzFjI6zq9JJrIp+ZA0n2aK2
	BwDC8uG4gUeU+l2ivgUA8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787956409; x=
	1788042809; bh=PCuhoGNop9xFU6pYipCLMjkZOpCJAx/06aOwcazXm6c=; b=S
	dFe2dIayd8+CuA3pJhf/K7YGYCTgjy2dPjtZNxgaiyOMRD81p9cuL5L/E7F5DMOW
	SU+edTxKDwhcRnHFZHREDkuxtXJTu21Q9frnOrH374OG0pNsgZBnE04WWPHw9dkt
	7BsT9ae2zy4EmGgX7iuQtW2cdtiuhxSVICuXF8Dw6KcDbXSyKfnNVtVA7UsOQJP6
	Bczpkh5EJX+SqWvcxF7TzLdII4OGIstPxZL9eLs8c6PCthvR1Qk3Pzqyirxr5C4V
	dVVeYdKv6dWwVti5SvkDWg7An6xfpJpXVU3GNYthA1fTsEiRhrqkmDO2uYl2AuGV
	fkE/jJW2quLajAPyybhog==
X-ME-Sender: <xms:uAySar4-3As1NX4oTrxoRX6L6xF8FpwdYNvqWPylcLlbp-B13j-Owg>
    <xme:uAySaugl7dUWl7tj6qE4mIFQtlZUN__lk8oBnmFnD5SrFv3f6OKmlQ1uUWcx0N22S
    dhWIEQZIY2x7zPkSxJ8ToBcuXt19yHVxLpYQgUYzzw8glW9NBl->
X-ME-Received: <xmr:uAySap0lIBf3Zs2V9hknb2M69BGotQR5uS3NflCMjfOpqPkiSbD3SkHw1geX5Q>
X-ME-Proxy-Cause: dmFkZTFmAobo8XsCAKwNanmqQTHJRfLCVW0AHhVIl3ZZngZ4sY3TkMe0r1t9mp/LT8Wkq6
    +CKzDDsPIT6Whm0Yx2bRCzj2MhVWdnYFOw+q/2m5TcuCuBlkDf9bz8jfXbDIJBAQBxLdMH
    AH4wx2RjzN2pP/NLDnaoio/QZ5zhsgREwLHbqx6Rl6se9oCo4/zLNU+QKo68ythyu7gF30
    R8caLdgjaJ7cLUDwLWKOl/FyGfmMIf1Z5OAMQISLQcjXNXNHsPvxKXh/d3YomD86pOTP1X
    Ooa/rrqMgMPt/Tag6TWIqGMhH7zp+efst2NUcNo3KPCB+XITIaPxPWIsn+h7t5GmKsXDil
    9H2sBJqCCcK5i6RkCS1z9nhRkXLAtqL2MFQ28TGTrvV6pexqInjsSY8a1783/r2YpG1PTG
    kM5ZLTl6lbINKlg1SoRWlQE9reKJxBnG/jM8x9yAWurDgZXDsFEKMqIpTrr6DJwsaFn8BF
    0giqXXIcUsz7FhKTNn351PNkd+qkMO8QC8iCvhmoQnLrGvmTfjIgkEL/h5b3mIk7mVXpPH
    3cByl/Yc3HD2b9x+XBzDKL1G9nZrc1NiIBcP/85xyCTnf/eeu3KoBecYhCe9YIEM+/6RCv
    PTIRO7iGczo1KHSq6epKpmgwLB3WN+NDHlVHtkxj+wVgHpy+p3n5XoVGsIKA
X-ME-Proxy: <xmx:uAySakXeXl9O-5kaP03c3YkKQCDfKpCyKo38nSu5zgfc0lgVgI3l6g>
    <xmx:uAySam1Zmp6-cnwayIfqDcYGPURrCcQBYr3mnnQPxC8d3rmUKSroDg>
    <xmx:uAySaliCGw5JprzNOizSS5pNrnJo7MMM8NRNhhttEwOCku6c9YkJGg>
    <xmx:uAySamLazzwQnZwYM3lC07Obipvkv-Zsxnr36tIMWmUXKEPR8iCKKQ>
    <xmx:uQySaoUH_Erhd1dm2Px5qeVWy79GZeYeK-b_hnPl8RB7NnqqA-rt8zPN>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:33:26 -0400 (EDT)
Date: Fri, 28 Aug 2026 16:33:24 -0600
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
Subject: Re: [PATCH v4 23/27] vfio/cxl: Refresh the decoder snapshot after a
 device reset
Message-ID: <20260828163324.72a685d1@shazbot.org>
In-Reply-To: <20260813093631.2288172-24-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-24-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:27 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A reset clears the HDM decoder registers, so the guest snapshot has to be
> resampled once the reset settles, on every path that can reset the
> function: the reset ioctl, an FLR driven through config space, and a bus
> hot reset. Re-enable Memory Space first, since a config restore can leave
> it off and the component-BAR read would then take an Unsupported Request.
> 
> The bus hot reset zaps BARs directly rather than through
> vfio_pci_zap_and_down_write_memory_lock(), so it also needs the HDM
> window zapped by hand; route both zap sites through a common helper.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 82 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_config.c   |  2 +
>  drivers/vfio/pci/vfio_pci_core.c     | 25 ++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h     | 20 +++++++
>  include/linux/vfio_pci_core.h        |  4 ++
>  5 files changed, 131 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index f1c6bf06c408..f45eaa60bad2 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -555,6 +555,86 @@ static void vfio_cxl_zap(struct vfio_pci_core_device *vdev)
>  			    range_len(&cxl->hpa_range), true);
>  }
>  
> +static void vfio_cxl_post_reset(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	struct pci_dev *pdev = vdev->pdev;
> +	bool re_enabled = false;
> +	int i, dwords;
> +	u16 cmd;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	if (!cxl || !cxl->hdm_shadow)
> +		return;
> +
> +	/*
> +	 * The decoder registers are read through the component BAR. A config
> +	 * restore can leave Memory Space disabled, and the read would then
> +	 * return an Unsupported Request, so re-enable it before sampling.
> +	 */
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	if (!(cmd & PCI_COMMAND_MEMORY)) {
> +		pci_write_config_word(pdev, PCI_COMMAND,
> +				      cmd | PCI_COMMAND_MEMORY);
> +		re_enabled = true;
> +	}
> +
> +	dwords = cxl->hdm_len / sizeof(u32);
> +	for (i = 0; i < dwords; i++)
> +		cxl->hdm_shadow[i] = cpu_to_le32(readl(cxl->hdm_regs +
> +						       i * sizeof(u32)));
> +	/*
> +	 * Leave Memory Space as it was found. The guest owns Memory Space
> +	 * through vconfig, so a physical enable done only to sample must not
> +	 * outlive the sampling or the function would decode while vconfig
> +	 * reports it off.
> +	 */
> +	if (re_enabled)
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);

This is usually done by just saving the original and re-writing it, but
this whole patch is really just ammunition for why it should be read
live rather than shadowed.

See also the reset_done callback in pci_error_handlers, we shouldn't be
open coding calls to this everywhere, but of course this goes away if
we expose it live rather than shadow it.  Thanks,

Alex

> +}
> +
> +static int vfio_cxl_pm_restore(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	struct pci_dev *pdev = vdev->pdev;
> +	int rc;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	if (!cxl || !cxl->hdm_shadow) {
> +		pci_dbg(pdev, "vfio-cxl: pm_restore: no shadow (device not open), skipping\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * A D3hot->D0 transition can soft-reset the function and clear the HDM
> +	 * decoder. Restore the physical decoder before the fault gate re-inserts
> +	 * the mapping. The restore needs the device lock, taken here after
> +	 * memory_lock to match the reset path ordering. On failure the decoder is
> +	 * left unrestored, so close the access gate (zap no longer clears it) and
> +	 * return the error so the caller keeps the HDM range inaccessible.
> +	 */
> +	if (!pci_dev_trylock(pdev)) {
> +		pci_warn(pdev, "vfio-cxl: pm_restore: could not lock device, HDM not restored\n");
> +		cxl->hdm_valid = false;
> +		return -EBUSY;
> +	}
> +
> +	rc = cxl_restore_hdm_after_pci_reset(pdev);
> +	pci_dev_unlock(pdev);
> +	if (rc) {
> +		pci_err(pdev, "vfio-cxl: pm_restore: HDM restore failed: %d\n", rc);
> +		cxl->hdm_valid = false;
> +		return rc;
> +	}
> +
> +	vfio_cxl_post_reset(vdev);
> +	/* The decoder is restored and re-sampled, so reopen the access gate. */
> +	cxl->hdm_valid = true;
> +	return 0;
> +}
> +
>  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct vfio_cxl_state *cxl = vdev->cxl;
> @@ -767,6 +847,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.config_read	= vfio_cxl_config_read,
>  	.config_write	= vfio_cxl_config_write,
>  	.zap		= vfio_cxl_zap,
> +	.post_reset	= vfio_cxl_post_reset,
> +	.pm_restore	= vfio_cxl_pm_restore,
>  	.owner		= THIS_MODULE,
>  };
>  
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index f088e4ce5e07..01d808546a4c 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -911,6 +911,7 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
>  			pci_try_reset_function(vdev->pdev);
> +			vfio_pci_cxl_post_reset(vdev);
>  			if (__vfio_pci_memory_enabled(vdev))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
> @@ -996,6 +997,7 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
>  			pci_try_reset_function(vdev->pdev);
> +			vfio_pci_cxl_post_reset(vdev);
>  			if (__vfio_pci_memory_enabled(vdev))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1a54f15d1c2c..fc8235c8b4fc 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -362,6 +362,14 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
>  		} else if (needs_restore) {
>  			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
>  			pci_restore_state(pdev);
> +			/*
> +			 * A NoSoftRst- device soft-resets on D3hot->D0, which can
> +			 * clear a CXL HDM decoder. Restore it before the fault
> +			 * gate re-inserts the HDM mapping. memory_lock is held on
> +			 * this path (the PM config write and runtime PM entry both
> +			 * take it before the D0 transition).
> +			 */
> +			vfio_pci_cxl_pm_restore(vdev);
>  		}
>  	}
>  
> @@ -529,6 +537,13 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>  		eventfd_signal(vdev->pm_wake_eventfd_ctx);
>  		__vfio_pci_runtime_pm_exit(vdev);
>  	}
> +	/*
> +	 * A NoSoftRst- function can soft-reset on the runtime D3hot->D0
> +	 * transition and clear a CXL HDM decoder. Restore it while memory_lock
> +	 * is held, before the fault gate can re-insert the HDM mapping. PCI
> +	 * config restore alone does not restore the component decoder registers.
> +	 */
> +	vfio_pci_cxl_pm_restore(vdev);
>  	up_write(&vdev->memory_lock);
>  
>  	if (vdev->pm_intx_masked)
> @@ -1449,6 +1464,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  
>  	vfio_pci_dma_buf_move(vdev, true);
>  	ret = pci_try_reset_function(vdev->pdev);
> +	vfio_pci_cxl_post_reset(vdev);
>  	if (__vfio_pci_memory_enabled(vdev))
>  		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
> @@ -1838,8 +1854,7 @@ void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
>  	 * a runtime-PM entry, D3 transition, or reset would leave the guest
>  	 * with live mappings into a quiesced device.
>  	 */
> -	if (vdev->cxl_ops && vdev->cxl_ops->zap)
> -		vdev->cxl_ops->zap(vdev);
> +	vfio_pci_cxl_zap(vdev);
>  }
>  
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
> @@ -2780,6 +2795,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  
>  		vfio_pci_dma_buf_move(vdev, true);
>  		vfio_pci_zap_bars(vdev);
> +		/* zap_bars misses the HDM window; bus reset needs it too */
> +		vfio_pci_cxl_zap(vdev);
>  	}
>  
>  	if (!list_entry_is_head(vdev,
> @@ -2802,6 +2819,10 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  
>  	ret = pci_reset_bus(pdev);
>  
> +	/* Re-sample decoder state for any CXL device the bus reset touched. */
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
> +		vfio_pci_cxl_post_reset(vdev);
> +
>  	vdev = list_last_entry(&dev_set->device_list,
>  			       struct vfio_pci_core_device, vdev.dev_set_list);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 902d17815ab6..46e67573d264 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -82,6 +82,26 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
>  			     pci_power_t state);
>  
>  void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
> +
> +static inline void vfio_pci_cxl_zap(struct vfio_pci_core_device *vdev)
> +{
> +	if (vdev->cxl_ops && vdev->cxl_ops->zap)
> +		vdev->cxl_ops->zap(vdev);
> +}
> +
> +static inline void vfio_pci_cxl_post_reset(struct vfio_pci_core_device *vdev)
> +{
> +	if (vdev->cxl_ops && vdev->cxl_ops->post_reset)
> +		vdev->cxl_ops->post_reset(vdev);
> +}
> +
> +static inline int vfio_pci_cxl_pm_restore(struct vfio_pci_core_device *vdev)
> +{
> +	if (vdev->cxl_ops && vdev->cxl_ops->pm_restore)
> +		return vdev->cxl_ops->pm_restore(vdev);
> +	return 0;
> +}
> +
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
>  					u16 cmd);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 8b93949d4484..c438d968dc59 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -78,6 +78,10 @@ struct vfio_cxl_ops {
>  				int count, __le32 val);
>  	/* Revoke the HDM mapping; paired with the BAR zap */
>  	void    (*zap)(struct vfio_pci_core_device *vdev);
> +	/* Re-sample the decoder state once a reset has settled */
> +	void    (*post_reset)(struct vfio_pci_core_device *vdev);
> +	/* Restore the HDM decoder after a D3hot->D0 soft reset */
> +	int     (*pm_restore)(struct vfio_pci_core_device *vdev);
>  
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;

