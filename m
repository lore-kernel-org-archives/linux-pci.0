Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073334A49AF
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923022; cv=none; b=c9RWLDFQtl+BrcOxadeVJ08S+kfJmDKb6aigGVThxd7O1LoAYkoEu6HY4g8BtMOzLrN1WE2BRE/uN2BETTd6MmAjcPE+lEPGcQ6F2udCUSDyvfsP2cjZvIOuz/3K2crA/3tKBewnHp55E1BVn4hNAfriF9F9Nw4UzWjq/qenx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923022; c=relaxed/simple;
	bh=ZYssVvOLssJhjrFkX8qCPZmLqCg36BIR/YUUnjvmaus=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gcxm0VGOITNC0EpXPx6/3iCa+XkbiqW5uvmyY+VTyrNChnEMXJBwC9+ESrG+TAX2SNlLrNCGakSmb0Ho906bff8CLvavtzqdTRe/U+Jvu99MWer/INzo6qgm81NqYCzQx+99aJO9JooB3YaClQlnqlSQoduF4hDvccpteIapRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxEwQDdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxEwQDdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC5E1F000FF;
	Tue, 13 Oct 2026 20:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923020;
	bh=LUvVnkhDtwGe2j/q7lc4hVDfBNH+53y0e9jMWDu92PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxEwQDdQlJWP4zkPI17htmJwG5b7psakS5J5s1mNu1YeD/KMLHSn4Ehr27C+fTidI
	 8EcNwgnKkE0PgpI3fTjWHDVw2zgjy+FTjpNEDkY2fU3/ayVTmaOondAeAF+O7FGJgw
	 qviAJLaR56yTFdRpuQMoXy7gClwpH4Qriyt5dxFAmdHvGoSFFuZCp/hxI4qBEOk2Sk
	 EhMcVT6h+UHDEe8PAWwyce+m8Stm+e0COrUx+99BmAWIKJTfeTnohy7nkQlBK5+bKr
	 EOzO3lhBnINGbekFu0IWJedySjHQAYjNeFRLG/ZUtMlXeXItAfEIS0ctO27rvlahq0
	 7/pxmkdfASKxg==
Message-ID: <sashiko-outbox-170453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/AER: Add a kernel parameter to skip the reset
 during AER recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sunny Feng" <sunnfeng@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013201045.33806-1-sunnfeng@amazon.com>
References: <20261013201045.33806-1-sunnfeng@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:23:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/aer: interrupt storm when skipping AER reset
--

commit fe869440b3515f272e9e500d4db9fdb37085a98f
Author: Sunny Feng <sunnfeng@amazon.com>

PCI/AER: Add a kernel parameter to skip the reset during AER recovery

This patch introduces a "pci=3Derror_reset_disable=3D" kernel parameter to =
skip
resetting specific PCI devices during AER recovery. This allows the devices
to remain in their errored state so diagnostics can be collected, while
still re-enabling Root Port interrupts.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c376c3adbefd2..1f403f0f5d258 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

[ ... ]

> @@ -1872,7 +1883,21 @@ static pci_ers_result_t aer_root_reset(struct pci_=
dev *dev)
>  	if (host->native_aer && aer)
>  		aer_disable_irq(root);
> =20
> -	if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC_END) {
> +	/*
> +	 * Leave the devices in the state the error left them in if one of
> +	 * them is listed in the error_reset_disable parameter, so their
> +	 * diagnostics can be collected before they are recovered.
> +	 */
> +	if (dev->subordinate)
> +		pci_walk_bus(dev->subordinate, aer_check_error_reset_disabled,
> +			     &reset_disabled);
> +	else
> +		aer_check_error_reset_disabled(dev, &reset_disabled);
> +
> +	if (reset_disabled) {
> +		rc =3D -ECANCELED;
> +		pci_info(dev, "not reset, error_reset_disable matches a device below\n=
");

[Severity: High]
Could this cause an interrupt storm if a device is skipped from AER reset?

When a device is skipped via the error_reset_disable parameter, it is left
in a broken state with its Uncorrectable Error Status asserted.

Later in aer_root_reset(), the code unconditionally clears the Root Error
Status and re-enables Root Port AER interrupts via aer_enable_irq(root).

According to the PCIe Base Specification Rev 6.0, Section 6.2.4.2
(Multiple Error Handling), a device is allowed to generate additional Error
Messages for subsequent errors of the same type even if the status bit is
already set.

If the un-reset device continues generating errors (for example, due to a
degraded link or ongoing background DMA), the Root Port will continually
receive messages and fire interrupts.

Since the aer_irq() ISR clears the Root Error Status and returns even when
the event queue is full:

drivers/pci/pcie/aer.c:aer_irq() {
    ...
    pci_write_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, e_src.status);

    if (!kfifo_put(&rpc->aer_fifo, e_src))
        return IRQ_HANDLED;
    ...
}

Will this lead to an infinite hard interrupt storm loop, potentially
causing a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201045.3380=
6-1-sunnfeng@amazon.com?part=3D1
