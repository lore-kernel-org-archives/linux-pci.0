Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836512;
	b=c02oketIWDEjA6EtKcZTsgvXuIKHFE5TpWtQCmfHp7xYyAASKaZNVGM19DXlBCdPk1JH
	 IglzSiYC2PObqGWsvNxldm+IlY2FjeZ+gtvxmK3mf1ipURyFb/oah3WJk8FvJn9GNBBwI
	 ZwMEydbnSU3xLJG5rzgAgov+X3nbpVWe8Bf/12GLvlR0HNTiteICEDfPCjOMEfXAesXVq
	 0OIKybhzaSuo/pBd9BahO3bz2zRMoetH8eP4nRGLfracg/Z73gmf07S0odF1DRLc3It5G
	 bVkh9FQaRY9MPDzlZNWkWPa9Le4K6z8IaavtLL2tPsIir4mX+MHuk6Se6T6LtOnpcuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836512;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Pdqghi/Hsjfp283ilYdqjHRoyabbxkVpexYmZMhDhdY=;
	b=z3qXEU4NW5l23Z5PzUqDMckMBlz+xj/uURfQBFpYTkjsrjSCLNQG2RS8SDwAScl0pNOr
	 5r89f3IGKQbM8Qc5FyYEg6kGlkFGwPXd+UslaMTHJ8a6nUtGCDcStVLYoy/rdCp24dGx9
	 ++xzLYTALyIZh0o8vfC5+75NtPOu8ydjGaO5aiQCwzFhyAFMFPFAhzPNpXyBnG3/BmLJH
	 vfBU+qvFIIYyg59SLbE4UvmH5kq4QfEvvr/w4RdVfPKvcqwBiKX4bb2+8Yv46f+LGQykl
	 HApCFC/SxNeibVBbS3p16dpDIqtGT7kb6fZB5dRFcLmKMN4yDviDrymXeL6PSmriXyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=zNTmUdCu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ufnaj8A1;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24E606D803
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB24E606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=zNTmUdCu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ufnaj8A1
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CB600EC0123
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:55:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 18:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793836510;
	 x=1793922910; bh=Pdqghi/Hsjfp283ilYdqjHRoyabbxkVpexYmZMhDhdY=; b=
	zNTmUdCuAzk5AH1ke3y7LGl+N1DTeLpQMr/u8xf87XC5JgWRH2jrv6vPyS02EzSG
	TjOh6VqG7cClyiYcelrMEBFPQ3tKh7o8S/YwRt7nArclLQYDQhLpCn+F9H+xItsG
	xbuSC+gCcu3v6yy087hbnzbs+qCy5mCcg9D4Z97d6WYh1IZEh07vowqZw2nbi8uZ
	HVSNqwqz5w93SYpaxODXk4gRTX/H+Bitr+jWxLKHhNSI6BRsbBJs/tXyATRyo+xK
	335XGkA8u2hhhFjy0ooMc/M8aRn1Hf7xQgC1yzjRC+q7cO/lDxBGbHgHMOVDL8P+
	feiOG2I1Am+zY6yINYsHkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793836510; x=
	1793922910; bh=Pdqghi/Hsjfp283ilYdqjHRoyabbxkVpexYmZMhDhdY=; b=U
	fnaj8A1hxajSrvbUY8A2oX+ObXUMht6Ai+C3HJ0N03hwNHbZHsB5FuFbOdgbR+p+
	Vthhe3er1YtgFB+nU+mRbaU8VFnShOo7MJhX/5HT5USmSPcTPL+GasKDxxjPOQXg
	rA/xDrsvOHOWdDENwQBPnwq3+HoERwQnU8SXpIJXa9vD+6eOXVPgfApTrNnmgROZ
	nESjDsaGIDBf8lhAU3HS+4rx8CHgNZqu42NfVtxhqd5FaZHPuqRi1USHt43P/EbT
	Zzl5mdXhOqLOn8Yi0GJONzhBWGtj3+At9IUflbkzjnsouC5ThhrAkr04g940zNw0
	HM0/6OuyW8lXY/USvOVRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793836510; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uoZUoEd2BbN+4i8bQXe+mymLyoZ9uUWOJgN9uwwfE643iqo
	JKiEGe93qNJcEiiRtrPVbMfTkHfjQLaoJM7wXgpqWOwu0QkyjZ969ascuflzutqm
	3e/13fk/aHTNHOwYN5YKK5VCk2kR2qfxUCYwouWHct5ye92jTrlfYa8d+or5n6Rg
	Mli1VBC5/4aEhIW35ICgGqE+1VfhsRUVG9lF5Mz4j7e9+OLy7YmXgbQN8hmaLl+P
	uQcobWTn9zvUjd8thUKgRFCQ0iMJcnMwhGIgAbyGmmLa0IaGNxo3BIBAa6LXzJAD
	OxwlE/NV+mWOQxL+jyoM1nsDYK9X86xcsKAedig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VdutSf7WooPCXQoXuer3NdVF7PRKt9A3AUJb+IYX6+A=:aI+WDWM7VeqR9QslZ0VneK6Aaji8eaR6RRm+IM960l0=;
X-ME-Sender: <xms:3sXraljwBuwtxddo3nsGkrat8opKZCafFzWsPMbRGUMp4MRsfIJ_qg>
    <xme:3sXranogo-nu0JiMbtwGoq0-bSw3fy_L8szc1R7s7qSXbY2XSFnoPnVS1qT-eK_kT
    z72bawSLWYjySlTW-cibzrWBOxpTHxadxzxWQkUMhzah7nc9CDxNA>
X-ME-Received: <xmr:3sXrascBU5X-09wGXRUA00I5P8K_kqDn8hfA4rn-B8u_2mRv9fWDdRtAGoYhvw>
X-ME-Proxy-Cause: dmFkZTFU/kbVOsWxOTPcCpe6x61hsj1WNmmGso+RiYOPL9PXBn0IITeBo+AW6SFW+G4ekC
    /hzYoF162vC7PC2Mtt2USNZ/eCRzPfnSvLH4GpnZYykCQlv/g/2dfaxUihNQ2PdVnmznVt
    eyzTFpFT8ROSV9PpSF+vkXBd8GjUZhM6/FJB6rHUdJL+IEmDIn9qqg8D9AaoFAEgqB3zaI
    LQuuKEKLXGp7sIkYnu8IYt8f4dndp/+v360R0jn1bNCYEbWntuZR9TDLjZCVdVdTAj6SKy
    IHj9Y41QEBh5Iv1k5SCIJDAY7TVRfrnmdQbz1lqnEzzeOazcj9kVYNjTrGiFbntAEPcYeX
    6duqXQYi5Z8CokUmEWQafV1IgET6f9oJp+QFwdgPjBBgCgRoJ4AV/DRQRgalnKr+BsByEz
    /oKjQp5wiHN1ScigJptBQqxSxfjsV1jDxVD1bhdL/AJW6pOhCSAJguUUe0nkjjedWRl0wJ
    8Xpkd6qDRdwuTERhd+l0OX8pCNESHKdyubF6uKNGkPA9BrqlL/XFzTubjohZfboFoN8fHk
    79s3SnJfsAdhqlx+phocTufsnxRzhPs1GZXC6Iqepa0k1rXC7Otgax+JErgsPM2zEVXZa6
    blG+jDSbqiAzg3aaVPRZ4c/Nf+e8obJX4YznqSqvg/W2LcPK8JxetNG8viUA
X-ME-Proxy: <xmx:3sXraidYjC9trw5wmjcwZO52-1vRZrPNe6SnEmRmEz7CU6-leQjDPA>
    <xmx:3sXraqdK0HUpsznAdzSDrgt2KM2IzElSJxsSgWGUVBwE2yVTo1mlhw>
    <xmx:3sXragpURdT_NlceXMsSpRdNqyPURoOuAjEHljqG6PzFGLzpvZcp2g>
    <xmx:3sXraiwPHNtAOKkEsXjbwaAWrHaRQCNlr3XnmwuHARmuwbNg1s1WfA>
    <xmx:3sXratpWb8U5dEbr0JES6lSyTJPdfiEfUY-6tqoasHSZtKaZwNOXJhr3>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:55:08 -0500 (EST)
Date: Wed, 4 Nov 2026 16:52:47 -0700
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
Subject: Re: [PATCH v6 15/31] vfio/pci: Route every reset point through a
 try-reset helper
Message-ID: <20261104165247.2597f574@shazbot.org>
In-Reply-To: <20261016161839.2765592-16-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-16-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:22 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A provider such as vfio-cxl must reset its device itself: a CXL Type-2
> function must not take an FLR, and its reset changes what the provider
> lets the fault path map. vfio-pci-core resets a function at five points:
> enable, close, VFIO_DEVICE_RESET, a virtualized PCIe or AF FLR, and the
> guest's CXL Reset doorbell in the virtualized CXL DVSEC.

What substantiates the claim that a type-2 device must not take an FLR?

Here we're promoting all resets to a CXL reset, but a CXL reset and an
FLR have different scopes.  FLR is exposed to the user through config
space.  A user might reasonably expect an FLR scoped reset through the
PCIe/AF capabilities.  The CXL spec defines FLR vs CXL reset, so this
actually makes the device non CXL compliant through vfio-pci.  This is
a massive policy imposition.

What makes this necessary?
 
> Add a mandatory reset op to the provider ops, and refuse to register ops
> without it. Add vfio_pci_try_reset_function(), which keeps the trylock
> of pci_try_reset_function(): it returns -EAGAIN when the device lock is
> contended, and otherwise runs the provider's reset with the device lock
> and memory_lock held. The close path keeps its bridge and device trylock
> and calls a locked variant. vfio_pci_try_reset_function() saves the PCI
> state first, as pci_try_reset_function() does, for the provider's reset
> to restore. The locked variant does not save: on close the reset must
> restore the open-time state that vfio_pci_core_disable() has just
> loaded. A failed save is returned and the reset is not attempted.
> 
> The enable path still fails only on -EAGAIN. A provider checks at bind
> that it can reset the device, so reset_works is set for a provider
> device whatever the result of the first reset.
> 
> The CXL Reset doorbell now runs the reset and reports its result in
> Status2: Reset Error on failure, Reset Done on success.
> 
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 19 ++++++--
>  drivers/vfio/pci/vfio_pci_core.c   | 71 ++++++++++++++++++++++++++++--
>  drivers/vfio/pci/vfio_pci_priv.h   |  1 +
>  include/linux/vfio_pci_core.h      |  7 +++
>  4 files changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 1fc463540211..6fbece95cb9f 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -910,7 +910,7 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> +			vfio_pci_try_reset_function(vdev);
>  			if (__vfio_pci_memory_enabled(vdev))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
> @@ -995,7 +995,7 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> +			vfio_pci_try_reset_function(vdev);
>  			if (__vfio_pci_memory_enabled(vdev))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
> @@ -1786,9 +1786,20 @@ static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
>  	if (!(ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING))
>  		status2 &= ~PCI_DVSEC_CXL_CACHE_INV;
>  	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> +		int ret;
> +
>  		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
> -		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
> -		status2 |= PCI_DVSEC_CXL_RST_DONE;
> +
> +		/* Run the real reset here and report its result in Status2. */
> +		vfio_pci_zap_and_down_write_memory_lock(vdev);
> +		vfio_pci_dma_buf_move(vdev, true);
> +		ret = vfio_pci_try_reset_function(vdev);
> +		if (__vfio_pci_memory_enabled(vdev))
> +			vfio_pci_dma_buf_move(vdev, false);
> +		up_write(&vdev->memory_lock);
> +
> +		status2 &= ~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR);
> +		status2 |= ret ? PCI_DVSEC_CXL_RST_ERR : PCI_DVSEC_CXL_RST_DONE;
>  	}
>  
>  	*pctrl2 = cpu_to_le16(ctrl2);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1e0ac28b7564..6676c561465b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -605,6 +605,62 @@ static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
>  	}
>  }
>  
> +/**
> + * vfio_pci_try_reset_function() - reset the function without blocking
> + * @vdev: vfio PCI device, with memory_lock held for write
> + *
> + * Reset through the PCI core, or let the provider reset a device it serves.
> + * The provider resets the device with its PCI device lock held, so take that
> + * lock here, without waiting, as pci_try_reset_function() does.
> + *
> + * Return: 0 on success, -EAGAIN when the device lock is contended, or the
> + * reset error. For a provider device a failed pci_save_state() is also
> + * returned, and the reset is not attempted: unlike pci_try_reset_function(),
> + * the provider's reset needs a valid saved state to restore.
> + */
> +int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int ret;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	if (!vdev->cxl_ops)
> +		return pci_try_reset_function(pdev);
> +
> +	if (!pci_dev_trylock(pdev))
> +		return -EAGAIN;
> +
> +	/*
> +	 * The provider restores PCI state from the saved copy, so save the
> +	 * current state first, as pci_try_reset_function() does. The locked
> +	 * variant on the close path must not: it resets with the state that
> +	 * vfio_pci_core_disable() has just loaded.
> +	 */
> +	ret = pci_save_state(pdev);
> +	if (!ret)
> +		ret = vdev->cxl_ops->reset(vdev);
> +	pci_dev_unlock(pdev);
> +
> +	return ret;
> +}
> +
> +/*
> + * As vfio_pci_try_reset_function(), for a caller that holds the device lock.
> + * Only the close path calls this. It takes memory_lock with the device lock
> + * held, so user config access is blocked meanwhile: the order a sysfs reset
> + * uses. That cannot deadlock against a PCI_COMMAND write holding memory_lock
> + * because no user remains at close.

Please tell the AI not to add any comments, these are difficult to
parse and often unnecessary.  If there are specific locking
requirements for this function, they should be annotated.  If this
function cannot be annotated, and it not general, even within a static
context, maybe it shouldn't be a separate function.

> + */
> +static int vfio_pci_reset_function_locked(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops)
> +		return __pci_reset_function_locked(vdev->pdev);
> +
> +	guard(rwsem_write)(&vdev->memory_lock);
> +	return vdev->cxl_ops->reset(vdev);
> +}
> +
>  static void vfio_pci_core_free_dev_regions(struct vfio_pci_core_device *vdev)
>  {
>  	for (int i = 0; i < vdev->num_regions; i++)
> @@ -636,11 +692,14 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		goto out_power;
>  
>  	/* If reset fails because of the device lock, fail this path entirely */
> -	ret = pci_try_reset_function(pdev);
> +	down_write(&vdev->memory_lock);
> +	ret = vfio_pci_try_reset_function(vdev);
> +	up_write(&vdev->memory_lock);
>  	if (ret == -EAGAIN)
>  		goto out_disable_device;
>  
> -	vdev->reset_works = !ret;
> +	/* A provider checks at bind that it can reset the device. */
> +	vdev->reset_works = vdev->cxl_ops || !ret;

I suppose, but why is ret not still a valid indicator?

>  	pci_save_state(pdev);
>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)
> @@ -846,7 +905,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  		if (bridge && !pci_dev_trylock(bridge))
>  			goto out_restore_state;
>  		if (pci_dev_trylock(pdev)) {
> -			if (!__pci_reset_function_locked(pdev))
> +			if (!vfio_pci_reset_function_locked(vdev))
>  				vdev->needs_reset = false;
>  			pci_dev_unlock(pdev);
>  		}
> @@ -1541,7 +1600,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
>  	vfio_pci_dma_buf_move(vdev, true);
> -	ret = pci_try_reset_function(vdev->pdev);
> +	ret = vfio_pci_try_reset_function(vdev);
>  	if (__vfio_pci_memory_enabled(vdev))
>  		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
> @@ -2397,6 +2456,10 @@ int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
>  {
>  	guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
>  
> +	/* vfio-pci-core never resets a provider's device by itself. */

What a bizarre comment.  Relevance?

> +	if (!ops->reset)
> +		return -EINVAL;
> +
>  	if (vfio_pci_cxl_ops)
>  		return -EBUSY;
>  
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 09a68c99b43c..dbede6e24fa9 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -80,6 +80,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
>  			     pci_power_t state);
>  
>  void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
> +int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev);
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
>  					u16 cmd);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 991a3fcd84eb..cb9ba92b696a 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -87,6 +87,13 @@ struct vfio_cxl_ops {
>  	 */
>  	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
>  	int	(*reset_done)(struct vfio_pci_core_device *vdev);
> +	/*
> +	 * Reset the function in place of the PCI core; mandatory. Called with
> +	 * the PCI device lock and memory_lock (for write) held. The caller
> +	 * provides the saved PCI state the reset restores: the try-reset path
> +	 * saves it first, the close path keeps the open-time copy.
> +	 */

Reads like more AI generated comments.  These things like to talk,
please curb them.  Look at vfio_device_ops for an example how to
briefly and concisely document callback ops like a human.  Thanks,

Alex

PS - I'm still working on the remainder of the series.

> +	int	(*reset)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };

