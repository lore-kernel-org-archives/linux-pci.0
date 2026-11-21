Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259285;
	b=HTYXotlSRQDimWQpRKGSR/sKE3E60BpAlmAceENfk1ohJDtA/393dCjVfd/o5jgP0e1G
	 Jp9PkKf31qCBAG9nlhEMnAfCe1h5qXY+t2GLRescckNZrd8oeS86PHS+2qJVG6ZKox+n6
	 IuMcitP98y5+BHNojDYEjrXN/b4EgQissAUUnf58asuI2n9jwCL6+PVW7Bv27pRTIsHcU
	 PAjrExb/UrTOfFMO+y8TZ3NNMNA95f8vawYQ02VPj8g8t5KsATf+j+q1rBdJ37apu8rIH
	 lzQFzNzUvODZFi1wsVVdTUr3rHeQEOLgow2Ap0/gW1KyqTfOD6anp6y/hnl3hLEr1dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pCXh5NtrNnJK1LpPwJr3Hg43FTTjfhhCPGLPSN1LOEo=;
	b=wTaJJjsESmTn+od8nml2z6sIKvrsYgWev8CaAZn8Rz7C6jlBq0/9987dJCW1kNgjwCm6
	 yTZwnAL6SH0ZhFbeechMJQADvdEfylq2YouLbi3FJFfLgQF8TQGXHd4pwNd0fO49lPDXK
	 dcPNU9c1hNYUPBR8HBb5HwDy4PoPbWpbBujojOWHXly9jVaRoPL3Powws2aTx8GqG65es
	 O3z8f4rzKspoZXRDbFsHo2c6JkNdoMMm0duF3SuzuVd30aj8vzsyFE7HjlFBU4tyGDSbI
	 ljjtznImC0bZiv9dp5hm1aNT1BJSqJhas+KCOehyM72X2RZ8dZfqMDI5lLVNscBxcIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeaMwMr+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92018606A320
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FeaMwMr+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D541F000CA;
	Sat, 21 Nov 2026 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795259284;
	bh=pCXh5NtrNnJK1LpPwJr3Hg43FTTjfhhCPGLPSN1LOEo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FeaMwMr+UYa9WphlWp25nB3gB7fNVThigMPbriODOwKha3AIAHWOHa3gHie/G01lx
	 /OLFvtYYzq8yZOiZTE5YZoQsfJGXg1mGIeJ1nLOKNQtCp4DNOSAw8SfKmsgOJ+2GvQ
	 8iOv36lmjsmGXTqfOen4ouFRhO+8PJQYqYMlx/vqGMUfv+G/VkrrBtGndRZ71YeFxm
	 CDH50Yysx8+yJjc47B6GtKdp8HiZPdHzc27c3c2REOwQtextUtITQ9kh7+L+7DBk54
	 pmqdBIoXFk2OXmXASTLphfVb4K9+yKb1dGg7ybQVWz7fVKRCjTbCqR7442BkWD+Pzt
	 XS6SchKPe36aw==
Message-ID: <sashiko-outbox-226970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: Make PCIe link wait timeout configurable via
 pcie_link_timeout=
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongtao Zhang" <zhanghongtao35@huawei.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261121110806.1158344-1-zhanghongtao35@huawei.com>
References: <20261121110806.1158344-1-zhanghongtao35@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:08:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] PCI/DPC: 4000 ms timeout in pci_dpc_recovered() expires
  before link wait
- [Low] PCI: unnecessary EXPORT_SYMBOL_GPL and missing __ro_after_init
  on timeout
- [Low] PCI: inaccurate kernel-parameters.txt note on blind-sleep ports
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] PCI: missing PCI_ERROR_RESPONSE check in
  pcie_wait_for_link_status() [1]
--

commit 79c6602cfac02cd18ceb2cc8a36f64252285fc19
Author: Hongtao Zhang <zhanghongtao35@huawei.com>

PCI: Make PCIe link wait timeout configurable via pcie_link_timeout=3D

This commit makes the PCIe link training and link state transition wait
timeout configurable at boot via the pcie_link_timeout=3D kernel parameter,
allowing values between 1000 ms and 10000 ms.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 396d196d6ea00..15d6507de968d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5304,6 +5304,20 @@ Kernel parameters
>  		force	Enable ASPM even on devices that claim not to support it.
>  			WARNING: Forcing ASPM on may cause system lockups.
> =20
> +	pcie_link_timeout=3D
> +			[PCIE] Timeout in milliseconds to wait for PCIe link
> +			training and link state (up/down) transitions, e.g.
> +			during hot-plug power-on, error recovery resets and
> +			runtime resume.
> +			Some devices, or specific device/board combinations,
> +			may need more than the PCIe spec's 1 sec to train the
> +			link; use this to raise the wait, e.g.
> +			pcie_link_timeout=3D3000
> +			Range: [1000, 10000] ms. Values out of range are
> +			ignored with a warning and the 1000 ms default is
> +			used. Only affects failure detection latency; healthy
> +			links return as soon as training completes.

[Severity: Low]
Is it accurate that this parameter only affects failure detection latency?
In pcie_wait_for_link_delay(), ports without link_active_reporting
unconditionally sleep for pcie_link_retrain_timeout_ms + delay even when the
link is healthy.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..a5996beeaebbd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -159,6 +159,25 @@ static bool pci_bridge_d3_disable;
>  /* Force bridge_d3 for all PCIe ports */
>  static bool pci_bridge_d3_force;
> =20
> +/*
> + * Effective timeout (ms) for waiting on PCIe link training / state chan=
ges.
> + * Defaults to the spec-mandated 1 sec floor.  Devices or device/board
> + * combinations that legitimately need longer than 1 sec to train the li=
nk
> + * can raise this at boot via "pcie_link_timeout=3D<ms>".
> + */
> +unsigned int pcie_link_retrain_timeout_ms =3D PCIE_LINK_RETRAIN_TIMEOUT_=
MS;
> +EXPORT_SYMBOL_GPL(pcie_link_retrain_timeout_ms);

[Severity: Low]
pcie_link_retrain_timeout_ms is only declared in drivers/pci/pci.h, only
consumed by built-in code (drivers/pci/pci.c and drivers/pci/pcie/dpc.c),
and only modified during __init.  Should EXPORT_SYMBOL_GPL() be dropped and
the variable marked __ro_after_init?

[ ... ]

> @@ -4624,7 +4674,7 @@ static int pcie_wait_for_link_status(struct pci_dev=
 *pdev,
>  	lnksta_mask =3D use_lt ? PCI_EXP_LNKSTA_LT : PCI_EXP_LNKSTA_DLLLA;
>  	lnksta_match =3D active ? lnksta_mask : 0;
> =20
> -	end_jiffies =3D jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS=
);
> +	end_jiffies =3D jiffies + msecs_to_jiffies(pcie_link_retrain_timeout_ms=
);
>  	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>  		if ((lnksta & lnksta_mask) =3D=3D lnksta_match)

[Severity: High]
This problem wasn't introduced by this patch, but can
pcie_wait_for_link_status() misinterpret a disconnected device [1] as
an active link because lnksta is not checked for PCI_ERROR_RESPONSE
(0xffff)?

When a config read from a removed or unresponsive device populates lnksta
with 0xffff, (lnksta & lnksta_mask) =3D=3D lnksta_match immediately succeeds
when active is true (falsely reporting that link training succeeded) and
never matches when active is false (blocking for the full
pcie_link_retrain_timeout_ms timeout).

[ ... ]

> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861b..ef04532d9c8ab 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -163,7 +163,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	 * to allow the Port to leave DPC.
>  	 */
>  	if (!pcie_wait_for_link(pdev, false))
> -		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n=
");
> +		pci_info(pdev, "Data Link Layer Link Active not cleared in %u msec\n",
> +			 pcie_link_retrain_timeout_ms);

[Severity: Medium]
Can pci_dpc_recovered() time out prematurely during DPC recovery when
pcie_link_timeout=3D is raised?

dpc_reset_link() waits up to pcie_link_retrain_timeout_ms in
pcie_wait_for_link(pdev, false) and again in
pci_bridge_wait_for_secondary_bus() before setting PCI_DPC_RECOVERED and
waking dpc_completed_waitqueue, whereas pci_dpc_recovered() still uses a
hardcoded 4000 ms timeout:

drivers/pci/pcie/dpc.c:pci_dpc_recovered() {
	...
	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
			   msecs_to_jiffies(4000));

	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
}

When pcie_link_timeout=3D is set above 4000 ms (or 2000 ms on ports without
link_active_reporting) and DPC link recovery takes longer than 4000 ms,
pci_dpc_recovered() returns false to pciehp_ist() while dpc_reset_link() is
still running.  pciehp_ist() then falls through to
pciehp_handle_presence_or_link_change() and tears down the hotplug slot
mid-recovery, and dpc_reset_link() later leaves a stale PCI_DPC_RECOVERED
bit set that causes pciehp_ist() to ignore the next hotplug event.

[1] https://sashiko.dev/#/bug/linux-139f3acd-7e0a-4e79-85a1-afc0e1e4f511

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121110806.1158=
344-1-zhanghongtao35@huawei.com?part=3D1
