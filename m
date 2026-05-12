Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BF349CEA
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591304; cv=none; b=pPHTLo9OETP4Hv/b7yADotjxNKTm9WCJGd/w+tey6uT9KkAwW/c/IFDeKG0qye6piPzyYFsHeLWo8IICsxOCYL3De7QWVD+y0yb20VL6R7jKR32ZLjCpcTHa20kQjAaRZ0y+5s/1JSJO/7cv25bH84tT5yhVZzaZR2TaZHZK9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591304; c=relaxed/simple;
	bh=w65/OBpwjh0uHiYjvr3D1UQQ5aaOwEqa/k9xp5C/d2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHqDDBT8RCn8kwiDbo919hqQrgSIbh+eUIOhWud20/qvJoz0yLwmMlgrQ6w/7GEDsnCTzy5Y/9bVCONOuxZVlEyEnEDSwnYuwXw3hlTPmQI1dioeNdkuWgBFg4mfZ8qF2VMlaNjJpW2cQduW+nZ5x186urE7A9ggLWqNwx3WKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LxwUDEPZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LxwUDEPZ"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gFH2p0y4Jz9tg0;
	Tue, 12 May 2026 15:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778591298; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft/L4wZAPmSJEB9Bln0jcx6NFiGlgkESzfw6XkOBh78=;
	b=LxwUDEPZJqvHlN6M+JZxT2h2AORKhEVZO7ACQmrAUJLl49rCkn1J82RkgeZRdgm+iKkgBn
	PVRk89bhVAETSZ6fZZcri7gWboGS24xXqYOGfbQIk2OQ7l+6QAmhWnIKMyl5DVxXBWdlzr
	er+dGsUef/nshUC5lI7pvPiQ+fYq4xqjdCidVFrcNXbX5MEvFEVGDo2TKku/hvNGkUG/Jb
	BX7pNcyol1aXuSKSYyO/o1Lbn5uG70yzwHvYgw0fuwZF0zHWvsNg9SyBUNn24kd0O7hhpP
	9+NdF38lT2SHaRiRWnhFS79LJk5Q6SMgeHswLw4gPcSc5NYifvTei/6W7taS1Q==
Message-ID: <93690b2a576a6f91fe0b0e33193b11e3619e9f9a.camel@mailbox.org>
Subject: Re: [PATCH v4 1/7] PCI/MSI: Split __pci_enable_msi_range() for reuse
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Tue, 12 May 2026 15:08:12 +0200
In-Reply-To: <1777017460-243543-2-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
	 <1777017460-243543-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: etnyb4qju7g7ehi3ztggdxp7nhr6pnbm
X-MBO-RS-ID: b9fa1b657a4235e5a25

On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
> Splits the __pci_enable_msi_range() function into two helper
> functions without changing the original behavior. The purpose is to allow
> future functions (particularly managed devres variants) to reuse these
> components.
>=20
> The split is as follows:
>=20
> 1. pci_msi_range_alloc(): Handles the allocation logic, including
> =C2=A0=C2=A0 parameter validation and vector number calculation. This fun=
ction returns
> =C2=A0=C2=A0 the calculated number of vectors or an error code.
>=20
> 2. pci_msi_range_init(): Handles the initialization of MSI context
> =C2=A0=C2=A0 and the actual MSI capability setup. This function takes the=
 pre-calculated
> =C2=A0=C2=A0 number of vectors as input.
>=20
> 3. The original __pci_enable_msi_range() is now a wrapper that calls thes=
e
> =C2=A0=C2=A0 two helper functions in sequence, maintaining exact same beh=
avior.
>=20
> This is a preparatory step for introducing devres-managed MSI allocation
> API that will share the allocation logic while providing automatic cleanu=
p
> via devres.

nit: the actual goal is to remove the devres aspect from the pci_
function.

>=20
> No functional changes intended.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>=20
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>=20
> =C2=A0drivers/pci/msi/msi.c | 30 ++++++++++++++++++++++++------
> =C2=A01 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 81d24a2..748dba6 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -420,11 +420,9 @@ static int msi_capability_init(struct pci_dev *dev, =
int nvec,
> =C2=A0	return __msi_capability_init(dev, nvec, masks);
> =C2=A0}
> =C2=A0
> -int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> -			=C2=A0=C2=A0 struct irq_affinity *affd)
> +static int pci_msi_range_alloc(struct pci_dev *dev, int minvec, int maxv=
ec)
> =C2=A0{
> =C2=A0	int nvec;
> -	int rc;
> =C2=A0
> =C2=A0	if (!pci_msi_supported(dev, minvec) || dev->current_state !=3D PCI=
_D0)
> =C2=A0		return -EINVAL;
> @@ -451,9 +449,13 @@ int __pci_enable_msi_range(struct pci_dev *dev, int =
minvec, int maxvec,
> =C2=A0	if (nvec < minvec)
> =C2=A0		return -ENOSPC;
> =C2=A0
> -	rc =3D pci_setup_msi_context(dev);
> -	if (rc)
> -		return rc;
> +	return nvec;
> +}
> +
> +static int pci_msi_range_init(struct pci_dev *dev, int minvec, int maxve=
c,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nvec, struct irq_affinity *affd)
> +{
> +	int rc;
> =C2=A0
> =C2=A0	if (!pci_setup_msi_device_domain(dev, nvec))
> =C2=A0		return -ENODEV;
> @@ -481,6 +483,22 @@ int __pci_enable_msi_range(struct pci_dev *dev, int =
minvec, int maxvec,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> +			=C2=A0=C2=A0 struct irq_affinity *affd)

Doesn't that trigger a dead-code warning?


P.

> +{
> +	int nvec, rc;
> +
> +	nvec =3D pci_msi_range_alloc(dev, minvec, maxvec);
> +	if (nvec < 0)
> +		return nvec;
> +
> +	rc =3D pci_setup_msi_context(dev);
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

