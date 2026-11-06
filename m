Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003056;
	b=3as1E10bANVrkPR2UeIz7JCKMx9V5At3liJ5LHPMrsDTw3WyCfRHyjPT6z1xS/LFQFNP
	 u+KlPxokgSUpOqax+7omoL17BI6tuRBquaFpFNunUmEtZ1eYcI9YS/Bh+OwSdWEnlmOLc
	 LMjFDR5XCojSO2dGmzvU0gwbraieXJcThFYzBTn1eG7afi+ZQ3b6yAXv3YyiVRoWueJ6b
	 gfFmiL74JjS4Pe+PhYSOIMY8f5m666AKcpVHJFRNr0xJAv5Q5bZfZ5HAPqShiATyvb9K/
	 UQIZo6JP8pgQOLGPyVvD1EXGp5CLEYqcq1knk7bu6WQAMgNfN3d29XIgOZb/dYhla5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003056;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QccVIHCCeW+j3JKH26Y//JlAzW2DNSmEXbLjeGbZAa4=;
	b=dQ9piJrbsP9TSldh9FiTrY5rY0kYV6NTQiHCbFO3HnedOPtzKnwyiCQnke/zlBaFDnPG
	 YIk1IpvDo7roDvQxS2RDKfA2Q+B3230wL4oNhnULcBMAKp79uXdWUELENHAQBN0iRbNX5
	 tlqXwZMUPesV/W+oMJ6K1y1AcT/DpHRwTHFjEK/8ouO1LVbxJY2ks4pANO7ANp1S+2kkL
	 itX08y9e6dmW/iGPA4a5RxvUx0bQwD/szap/UuZIzkQGbW6cW66d1IMvRpoe1WuSWOgkF
	 UgGJU2s7hVIWCAwSbzsNxPOBfGCSj+MGDWnSqtwY1A67VcyACvf5N+KdqPb0V70JB5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=UqWEWw2G;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wq1B0bzJ;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83E606A32F
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 22:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC83E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=UqWEWw2G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wq1B0bzJ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CABDEC0216
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:10:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 17:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794003048;
	 x=1794089448; bh=QccVIHCCeW+j3JKH26Y//JlAzW2DNSmEXbLjeGbZAa4=; b=
	UqWEWw2GThoHEJKQfjEHOdcQALnA/VCr6x9lVMMMC71RoKJRbfK0srKiPF6XeIFw
	Pz56TDxJl9BvHN5ckSE3wGU2HPkQ0TQk94jBpsZjmn1ORGdTC3DGDHY3MvNdIxyI
	s+kCtN7Ej6JCPc/XPNmoH2hAOOjP9Rc/f7URbOc5stOfAQPq4wiIxkc7/XmIBf+f
	ZXzmHN7mG3ytv1Nyk0hY9l1pk4xcoJCSJeB+yldBbxBLSUMH+OqjmkxvQOL4wIej
	wZTGPs7S/78T79pK8UBCNLw9hzcnwX77Xv7SufDL0LkL2qCq0uMp2EY2uPolxWID
	f5Hzp8q1qh/V7pyMyC5E8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794003048; x=
	1794089448; bh=QccVIHCCeW+j3JKH26Y//JlAzW2DNSmEXbLjeGbZAa4=; b=W
	q1B0bzJxngvd5pxx1z8Hvhzh8EXp0hulAtSMvOThvCtFKm8zjbaYr4nqk1Wp+lzQ
	/ld4JBCtYlqq1qS09Bw+uyWC2dNGlBNQ7/LH1Y9BSpHAd2S2p6bEhYYLnGyftQrV
	eAPkB59GLXHIjL8/muu2wmHQknowY096n4iR30+yQSr3MQ8i9SE5kyorQbDAbY0P
	dfGs7qZVtvBMmwQevPcgxImyhdZoWvYHUopQC6lMyJbdHRZiVnLkCETHqXiEMJQD
	jFnKSa59fagVVVk/42vySejrWbOCKl6qZnAlmQwd+P1V0DbSC66My4earSd9ocHa
	4YLZMO1ITY9Xb87KrTogQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794003048; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Nia3kB4kDIhfIg/BHNA1ZAYRAAGjlOECVZvCZ5+RmddbZS/
	1KECYx9t8lxU8ux3BP7tQDAUDekXWXNNLigaLMWyStanRRS+XtRWk0Ii0wkZ97rT
	FzMjFSxiIyUsVqepMIDNk7rnlI2n6wtxh6LWFKeAiUq1A6IERBzWaEpKrVF+69Dy
	apjQMV6PkjF0Clzi+JWSw8bT6UAOFXlkyUIEWkgrZlNHlIyPDfjIAMxP54yhofd4
	7d3muvq9gFUXofq0s4kbczcbMeJ1sqyMP8sErj/H36gh/ePqCZPmQUIcWsZ+QQzf
	YJl5LwsrRN+72IZT8EECngkRAu+khSRJmf2/opA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uakpYHZNRFDsNZuJ/8u5kiVH2K39n3URm1dmZQoYTzk=:jx6GhieGqJzW+u2Qbw2RejWE42x0NhlAuL8kxBNmgcY=;
X-ME-Sender: <xms:aFDuamkMqkGei2S1R9k1GfJOVd99MhZqFJJoZPiuU9Qj6YD2HsogIA>
    <xme:aFDuaoowkgoHMmc1cj3qYSU1M7whBtB8u7w8Fxj28IT6cpPEAAl0TOuzzUcZ_IINF
    RaQ5M80Vq4is70IqX5_9IFJNP6Iu_sQwharag48bwRbmL1CWNPU1g>
X-ME-Received: <xmr:aFDuai5zOhXH7L-hw6ck12LEVnE5Xj-U-7kVxisHnU2RHy5WkF9fJzb06bIkJQ>
X-ME-Proxy-Cause: dmFkZTF6YVreCUYhzzKLlDVeG/7YeI1VDYvZ8MjzsWdEpydaVQgMvCsQCMOJIezXFfo1ZM
    xcwNLTI7Yq8fBZx2BpX9IyJHugdOW6C4ss+oT0iw0ZFClgtApOWdlLljryuA5JkOg6iins
    eQloH9nrnF6xd03wnx67JDcxKiB4wxXwXta2idirSp8KRsIvc9tHK4ZU3GH68GN2oSHN3p
    15v93jn/GdnEi3FKcDmnY4xXliG3LGd+jqSVQPp0YsRjKeCrUZqTprybumbfhYgFN10IPq
    f7mzuyt+nfq4qWSttf8h0o1aQLAetFI+sFGgdHb8BKxDXgiVlsVpGH3VR/5fvsmOoHojf3
    UaiPwXVxxbe5Ukgg6U4OKl/9ASvi1r0J6G0fuh2iutVvvdePH4xex2KDplCyWaJgePtyoQ
    fS2UaQpIvmIJK7S6j2LevBzBliosWRG/qS8TR7UWfK/gS0SdFGSMEYMJ6BLhbqDmKCFKkY
    Bn+gM/CXLCerU2kVOXQNY5b24Ze8KMcsmo6lmQcPeGADiDbXONyl+dcUmOBw7ff4Eta77T
    hANaWJlbKGww8odVkO1HjEF6Z8NoRcN6x0PqZ/isGe47TjZRO2hgXAKZnicGSWg3BYfAO1
    WC5CwjzPnmLLMoh2lR7anVc2rCM3cyGOql4QdJo4znkQRK6mfnatmgUWTHJQ
X-ME-Proxy: <xmx:aFDuaqIWrqlxbGIH76Pp-LvguoNAnb3RWsK2tlZqyMeInf-_KCx2Ow>
    <xmx:aFDuaumvXOQ2HKVievZm7Bn9ZCNMXuoFuMvSmWmdlWVPua3CWTIXQA>
    <xmx:aFDuah-HLMUTzbhn8_btzGP2pjzgoSdZQfvcNEV5YdrzyCABIHYLVQ>
    <xmx:aFDual5-RCURO6Vu61vYmI0-XSThO5Smg1EnN-LkR6Tu5gwaK7WiCA>
    <xmx:aFDuaoVw8b8tKPw6wSQjgMP1sH02DPEjQ-NyUv6FXYJQ5itR3V9z_Pkb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 17:10:45 -0500 (EST)
Date: Fri, 6 Nov 2026 15:10:43 -0700
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
Subject: Re: [PATCH v6 11/31] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Message-ID: <20261106151043.4f47679f@shazbot.org>
In-Reply-To: <20261016161839.2765592-12-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-12-mhonap@nvidia.com>
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

On Fri, 16 Oct 2026 21:48:18 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device is reprogrammable through its CXL DVSEC: a guest could
> set Config Lock, toggle CXL.cache and CXL.mem enable, or rewrite the HDM
> range registers that govern host memory decode. Virtualize the DVSEC so
> the guest sees a shadow it cannot use to reprogram the hardware.
> 
> Build a per-device cxl_perm permission map, modeled on msi_perm. When
> the device is bound through the CXL provider (e.g. vfio-cxl), the whole
> CXL DVSEC is served from the vconfig shadow; only Control and Control2
> are guest programmable, while Capability, Status, Lock and the Range
> registers keep their firmware snapshot. A vendor DVSEC on the same
> device is unaffected: the map is selected by the CXL DVSEC's range,
> since every DVSEC has the same ID in the config map and two DVSECs can
> be adjacent.
> 
> A Type-2 function bound without the provider (the provider is absent,
> its init failed, or the extensions are disabled) gets a guard map
> instead. The DVSEC reads from hardware, Control and Control2 stay
> writable and the RW1C status bits stay clearable, but writes to Lock and
> the Range registers are dropped, since they outlive the user. Initiate
> CXL Reset uses the same doorbell; a cache write-back goes to the device.

The guard map actually changes the device ABI.  This may be necessary,
but if so, it should be pulled out into a Fixes: patch.  The device
aspects that change need to be well justified.  Access to CXL reset
without coordination is certainly not good.  Config lock has side
effects that we may not want to deal with.  Is there value in exposing
the CXL DVSEC at all when we're operating in vfio-pci mode?  What do we
expect a type-2 driver does with the guarded capability?

Maybe the right answer is to drop it from the chain and make it
read-only.
 
> Control2 carries the CXL reset and cache write-back-invalidate initiate
> bits as self-clearing doorbells. With the provider, vfio never forwards
> them to hardware, so a custom writefn synthesizes their completion in
> the shadow: the initiate bit self-clears and the matching Status2 bit
> (Cache Invalid or Reset Done) is set, so a guest that writes back its
> cache (CXL r4.0 sec 9.6) and then runs CXL Reset (sec 9.7.2) progresses
> instead of timing out. Cache Invalid is reported only while Disable
> Caching is set, as the spec requires. The host performs the real cache
> write-back and reset at the vfio reset points. Until a later patch in
> this series runs the real reset from the doorbell, Initiate CXL Reset
> completes in the shadow only.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 206 ++++++++++++++++++++++++++++-
>  include/linux/vfio_pci_core.h      |   3 +
>  2 files changed, 205 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9914f3ac69ae..1fc463540211 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1747,6 +1747,194 @@ static const struct pci_device_id known_bogus_vf_intx_pin[] = {
>   * for each area requiring emulated bits, but the array of pointers
>   * would be comparable in size (at least for standard config space).
>   */

This comment above used to be attached to vfio_config_init() and now
it's miles away!

> +static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
> +				int count, struct perm_bits *perm,
> +				int offset, __le32 val)
> +{
> +	u16 start = vdev->cxl_dvsec;
> +	__le16 *pctrl2, *pstatus2;
> +	u16 ctrl2, status2;
> +
> +	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	if (count < 0)
> +		return count;
> +
> +	/* Only Control2 carries the self-clearing doorbells. */
> +	if (offset > PCI_DVSEC_CXL_CTRL2 ||
> +	    offset + count <= PCI_DVSEC_CXL_CTRL2)
> +		return count;
> +
> +	pctrl2 = (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_CTRL2];
> +	pstatus2 = (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_STATUS2];
> +	ctrl2 = le16_to_cpu(*pctrl2);
> +	status2 = le16_to_cpu(*pstatus2);
> +
> +	/*
> +	 * INIT_CACHE_WBI and INIT_CXL_RST are self-clearing doorbells. With a
> +	 * provider neither reaches hardware: synthesize their completion in the
> +	 * shadow so the guest poll finishes, clearing the initiate bit and
> +	 * setting the matching Status2 completion. Cache Invalid is set only
> +	 * while caching is disabled and reads 0 otherwise (CXL r4.0 sec 8.1.3.5,
> +	 * Table 8-9). Under the guard map INIT_CACHE_WBI and Cache Invalid go to
> +	 * the device; only INIT_CXL_RST and its completion are virtualized.
> +	 */
> +	if (ctrl2 & PCI_DVSEC_CXL_INIT_CACHE_WBI) {
> +		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CACHE_WBI;
> +		if (ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING)
> +			status2 |= PCI_DVSEC_CXL_CACHE_INV;
> +	}
> +	if (!(ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING))
> +		status2 &= ~PCI_DVSEC_CXL_CACHE_INV;
> +	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> +		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
> +		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
> +		status2 |= PCI_DVSEC_CXL_RST_DONE;
> +	}
> +
> +	*pctrl2 = cpu_to_le16(ctrl2);
> +	*pstatus2 = cpu_to_le16(status2);
> +
> +	return count;
> +}
> +
> +static int init_cxl_dvsec_perm(struct perm_bits *perm, int len)
> +{
> +	if (alloc_perm_bits(perm, len))
> +		return -ENOMEM;
> +
> +	perm->writefn = vfio_cxl_dvsec_write;
> +
> +	/* Serve the whole CXL DVSEC from the shadow. */
> +	for (int i = 0; i < len; i++)
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
> +/*
> + * Without a CXL provider the device is bound without the CXL extensions, so
> + * the DVSEC is read from hardware, Control and Control2 stay writable, and
> + * the RW1C status bits in Status and Status2 (for example Viral_Status) can
> + * still be cleared. Drop the writes whose effect outlives the user: Config
> + * Lock and the Range registers. Initiate CXL Reset goes through the same
> + * doorbell as with a provider, so the reset runs at a vfio reset point under
> + * memory_lock.
> + */
> +static int init_cxl_dvsec_guard_perm(struct perm_bits *perm, int len)
> +{
> +	if (alloc_perm_bits(perm, len))
> +		return -ENOMEM;
> +
> +	perm->writefn = vfio_cxl_dvsec_write;
> +
> +	/* Extended capability header: ID and next pointer from vconfig. */
> +	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
> +
> +	p_setw(perm, PCI_DVSEC_CXL_CTRL, NO_VIRT, (u16)ALL_WRITE);
> +	p_setw(perm, PCI_DVSEC_CXL_CTRL2, PCI_DVSEC_CXL_INIT_CXL_RST,
> +	       (u16)ALL_WRITE);
> +	/* Status (offset 0Eh, between Control and Control2): RW1C to the device. */
> +	p_setw(perm, PCI_DVSEC_CXL_CTRL + 2, NO_VIRT, (u16)ALL_WRITE);
> +	p_setw(perm, PCI_DVSEC_CXL_STATUS2,
> +	       PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR,
> +	       (u16)~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR));
> +
> +	return 0;
> +}
> +
> +/* Virtualize the CXL DVSEC so a guest cannot reprogram the device through it. */
> +static int vfio_cxl_dvsec_init(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 dword;
> +	u16 dvsec, cap;
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
> +	 * usable Type-2 function; leave its DVSEC unvirtualized rather than
> +	 * index the device-length-sized perm allocation past its end.
> +	 */
> +	if (len < PCI_DVSEC_CXL_STATUS2 + 2)
> +		return 0;
> +
> +	/*
> +	 * Without a provider, guard only a CXL Type-2 function, with the same
> +	 * test vfio-pci-core uses to load the provider.
> +	 */

Cryptic comment.  Why don't we expose vfio_pci_is_cxl_type2() and use
it here?

> +	if (!vdev->cxl_ops) {
> +		if (!pcie_is_cxl(pdev))
> +			return 0;
> +		ret = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +		if (ret)
> +			return pcibios_err_to_errno(ret);
> +		if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +		    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +			return 0;
> +	}
> +
> +	vdev->cxl_perm = kmalloc_obj(*vdev->cxl_perm, GFP_KERNEL_ACCOUNT);
> +	if (!vdev->cxl_perm)
> +		return -ENOMEM;
> +
> +	if (vdev->cxl_ops)
> +		ret = init_cxl_dvsec_perm(vdev->cxl_perm, len);
> +	else
> +		ret = init_cxl_dvsec_guard_perm(vdev->cxl_perm, len);
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
> +static void vfio_cxl_dvsec_exit(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_perm)
> +		return;
> +
> +	free_perm_bits(vdev->cxl_perm);
> +	kfree(vdev->cxl_perm);
> +	vdev->cxl_perm = NULL;
> +	vdev->cxl_dvsec = 0;
> +	vdev->cxl_dvsec_len = 0;
> +}
> +
> +/*
> + * Every DVSEC carries the same ID in pci_config_map, so vfio_find_cap_start()
> + * can walk from one DVSEC into an adjacent one. Match the CXL DVSEC by range.
> + */

IMO, a comment is more relevant below.

> +static bool vfio_cxl_dvsec_contains(struct vfio_pci_core_device *vdev,
> +				    loff_t pos)
> +{
> +	return vdev->cxl_perm && pos >= vdev->cxl_dvsec &&
> +	       pos < vdev->cxl_dvsec + vdev->cxl_dvsec_len;
> +}
> +
>  int vfio_config_init(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -1842,6 +2030,10 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
>  	if (ret)
>  		goto out;
>  
> +	ret = vfio_cxl_dvsec_init(vdev);
> +	if (ret)
> +		goto out;
> +
>  	return 0;
>  
>  out:
> @@ -1863,6 +2055,7 @@ void vfio_config_free(struct vfio_pci_core_device *vdev)
>  		kfree(vdev->msi_perm);
>  		vdev->msi_perm = NULL;
>  	}
> +	vfio_cxl_dvsec_exit(vdev);

Teardown in opposite order of init.  Last initialized ~ first exit.

>  }
>  
>  /*
> @@ -1926,12 +2119,17 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  			 * of the extended capability list.  Use default, ro
>  			 * access, which will virtualize the id and next values.
>  			 */
> -			if (cap_id > PCI_EXT_CAP_ID_MAX)
> +			cap_start = vfio_find_cap_start(vdev, *ppos);
> +
> +			if (cap_id > PCI_EXT_CAP_ID_MAX) {
>  				perm = &direct_ro_perms;
> -			else
> +			} else if (cap_id == PCI_EXT_CAP_ID_DVSEC &&
> +				   vfio_cxl_dvsec_contains(vdev, *ppos)) {
> +				perm = vdev->cxl_perm;

				/*
				 * Multiple DVSECs may be back-to-back, resulting
				 * in bogus cap_start.
				 */

Thanks,
Alex

> +				cap_start = vdev->cxl_dvsec;
> +			} else {
>  				perm = &ecap_perms[cap_id];
> -
> -			cap_start = vfio_find_cap_start(vdev, *ppos);
> +			}
>  		} else {
>  			WARN_ON(cap_id > PCI_CAP_ID_MAX);
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 70acb03d466e..fd1ad0baf470 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -120,6 +120,9 @@ struct vfio_pci_core_device {
>  	u8			*pci_config_map;
>  	u8			*vconfig;
>  	struct perm_bits	*msi_perm;
> +	struct perm_bits	*cxl_perm;
> +	u16			cxl_dvsec;
> +	u16			cxl_dvsec_len;
>  	spinlock_t		irqlock;
>  	struct mutex		igate;
>  	struct xarray		ctx;

