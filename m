Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C339EB79
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592178; cv=none; b=mlLs/JeLDF6vS8BelcfDwq7qgPVFsE9USLJO3NaCx7OFrhxK7uw80c4SRKOMFecHkRgABr3Gi/eqLzF3O9zSZSNCFKLzlIWUqh9JD+vPM7U5Qedyrk4I0jjjaW1YwMoSNC50fk1XLKeMb88rMKsZz77Sr9h7hgXyFghcaI4GRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592178; c=relaxed/simple;
	bh=myvIDc1ZOWYEHgHeyWdjVCMRDeb1an9Oij6rdDbMHAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th4th9c9TWx+JqF+FLyEO8pKL8CzmPGqsorXfxGawpI7oevddsji5MwZayWjuf3p6ljhTKuJDafLgZZmAFVkPXIrPEzqHBjkZ5Uv1Ph69k+Y7DnZPh1eeAeIVvJEdfDoorvLnzcLzyfuPaahaIPYNMNIYeR4up5YPbeDzFSkrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JbqaIR/f; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JbqaIR/f"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gFHMW5ZkZz9ts1;
	Tue, 12 May 2026 15:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778592167; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPIYwD2QRLUuKH063bcZ0c2RHyBt35j1X1Rue2oYtHg=;
	b=JbqaIR/fF+lB3xvt1ffA0ijBkF5XDWeePV7Kx8wSBodU8L6hIBiQF8SwxdSqyHrKuc7/P9
	oGKL78AXc2zMHW5/fuBEJg6RHPcmsXkYhqIp4wXGvU4jobJC928h7ZP5PAunFRlpoqjrYj
	7aRMMv/EThTsK47BOVQcsedRs1pN0mzdCMBcjc858KimYfNm37vKS0eziGMBklqs5Jrol+
	9auEK/gsaLEx4tK6EbvWfwOOmniBDInOP8ONaQiCktU4qgzcCjfi+See+/Qdg70ohsz4es
	0b26IiZD7CfcDgQqkrceAO+DRSIMrF7iZY62w4jlbkcLOKEYD5vHwlGf3zC0bw==
Message-ID: <c7894396253909ee7db94ca18eaef4420f7f9595.camel@mailbox.org>
Subject: Re: [PATCH v4 3/7] PCI/MSI: Introduce __pcim_enable_msi_range()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Tue, 12 May 2026 15:22:44 +0200
In-Reply-To: <1777017460-243543-4-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
	 <1777017460-243543-4-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 5dxe7ifhkigob8ekeo1fypcqr3mb4aai
X-MBO-RS-ID: 0087973060e502d3c9f

On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
> Introduce __pcim_enable_msi_range(), a devres-managed variant of
> __pci_enable_msi_range(). The new function provides automatic cleanup
> of MSI interrupts via devres, reducing the risk of resource leaks and
> simplifying driver error handling.
>=20
> This function is particularly useful for drivers that already use
> pcim_enable_device() and want consistent devres management for all
> PCI resources, including MSI interrupts.
>=20
> Drivers can replace calls to __pci_enable_msi_range() with
> __pcim_enable_msi_range() to benefit from automatic cleanup without
> changing their core logic.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
>=20
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>=20
> =C2=A0drivers/pci/msi/msi.c | 20 ++++++++++++++++++++
> =C2=A0drivers/pci/msi/msi.h |=C2=A0 1 +
> =C2=A02 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 5c196c2..0aaff57 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -499,6 +499,26 @@ int __pci_enable_msi_range(struct pci_dev *dev, int =
minvec, int maxvec,
> =C2=A0	return pci_msi_range_init(dev, minvec, maxvec, nvec, affd);
> =C2=A0}
> =C2=A0
> +int __pcim_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> +			=C2=A0=C2=A0=C2=A0 struct irq_affinity *affd)
> +{
> +	int nvec, rc;
> +
> +	nvec =3D pci_msi_range_alloc(dev, minvec, maxvec);
> +	if (nvec < 0)
> +		return nvec;
> +
> +	rc =3D msi_setup_device_data(&dev->dev);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D devm_add_action(&dev->dev, pcim_msi_release, dev);

OK I guess. But pcim_msi_release also sets the is_msi_managed boolean,
which I think will not be needed anymore long-term? If you agree, I'd
add a TODO for removing that boolean at an appropriate place and patch,
too.


P.

> +	if (rc)
> +		return rc;
> +
> +	return pci_msi_range_init(dev, minvec, maxvec, nvec, affd);
> +}
> +
> =C2=A0/**
> =C2=A0 * pci_msi_vec_count - Return the number of MSI vectors a device ca=
n send
> =C2=A0 * @dev: device to report about
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b3..81c6b099 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -94,6 +94,7 @@ void pci_msi_shutdown(struct pci_dev *dev);
> =C2=A0void pci_msix_shutdown(struct pci_dev *dev);
> =C2=A0void pci_free_msi_irqs(struct pci_dev *dev);
> =C2=A0int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int max=
vec, struct irq_affinity *affd);
> +int __pcim_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,=
 struct irq_affinity *affd);
> =C2=A0int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry =
*entries, int minvec,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int maxvec,=C2=A0 struct irq_affinity *affd, =
int flags);
> =C2=A0void __pci_restore_msi_state(struct pci_dev *dev);

