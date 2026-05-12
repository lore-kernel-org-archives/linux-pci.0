Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF237206F
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591369; cv=none; b=HI8nNwpbjBtIgcFL2PtsSjXveNQqUaujuYJIcAqPTWMO4tIPt/T1HOkkU+Th4hsSnWuDt9mfVUnzuqAC1NwexWzbXuS1gTZfaL/GIRNTEUF8vKiSqQdb+egmzIhTxL9IpENimXcvmHzHsO0699eqAqoaIs/NNdw6EiblMurgM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591369; c=relaxed/simple;
	bh=l3BQcgpDOnfsrcfQfCKtSMinpwAI0yDCmx4T/lJXbvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P47SQ+YFC7R38jFNJMQaaPMgXZiHIUwj1hdBrKctTUGOcAiLygCLsW48Wh7A+oYkP01c+idVB5o3diEvvjWt2wg5AYI3Kkt2QE2jFO3bqnHaT1mBSKh2QUibbu2UNw+kfnG64qfKkuKeWEww2whExydIiphyr4oFMIaws+0F48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sCBFb/CB; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sCBFb/CB"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gFH435dYBz9ttS;
	Tue, 12 May 2026 15:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778591363; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDSeSdYd+2ECHFAb33Ma5ka0Qs0FzpAEJsVDniKcC6Q=;
	b=sCBFb/CBW7hwCiYrdZr0YSWhl+Us9JnI2uarHP4bO8/DRcLcZtot1KsKWLfZVmVnr79wl4
	/f7dyqwmtx1lbNQGexOLoYWFPq3qxpwFiiyDvzinrRiSz/d/m15rPYGq60W2RGpu7j6HVj
	afHxjfIZ21vStrUjit140nHrGP2oOHTa4HlWnXm0AwjxCJKswTTTIfoPtUfjnUqOaX/wbl
	USkIR91m9pQiVMdEsbhtlsrQB0riLMVrRvCYkoL9Z5Nd6jY7ONnmbHS8Ely+rmtlOK/Oyi
	GDXZkpnRddO8uVOUUU4RD2DsSkApP/7x8qP9QIYqFokLVBk3SgM0PF7TcoLbmA==
Message-ID: <9f2198110612bc099932781a02cfa492333ea467.camel@mailbox.org>
Subject: Re: [PATCH v4 1/7] PCI/MSI: Split __pci_enable_msi_range() for reuse
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
	 <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 linux-pci@vger.kernel.org
Date: Tue, 12 May 2026 15:09:20 +0200
In-Reply-To: <93690b2a576a6f91fe0b0e33193b11e3619e9f9a.camel@mailbox.org>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
	 <1777017460-243543-2-git-send-email-shawn.lin@rock-chips.com>
	 <93690b2a576a6f91fe0b0e33193b11e3619e9f9a.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: hyg6mw4pid8ktmo7csmkk6ppx74ka4nz
X-MBO-RS-ID: 37bfd182c8676da23fb

On Tue, 2026-05-12 at 15:08 +0200, Philipp Stanner wrote:
> On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
> > Splits the __pci_enable_msi_range() function into two helper
> > functions without changing the original behavior. The purpose is to all=
ow
> > future functions (particularly managed devres variants) to reuse these
> > components.
> >=20
> > The split is as follows:
> >=20
> > 1. pci_msi_range_alloc(): Handles the allocation logic, including
> > =C2=A0=C2=A0 parameter validation and vector number calculation. This f=
unction returns
> > =C2=A0=C2=A0 the calculated number of vectors or an error code.
> >=20
> > 2. pci_msi_range_init(): Handles the initialization of MSI context
> > =C2=A0=C2=A0 and the actual MSI capability setup. This function takes t=
he pre-calculated
> > =C2=A0=C2=A0 number of vectors as input.
> >=20
> > 3. The original __pci_enable_msi_range() is now a wrapper that calls th=
ese
> > =C2=A0=C2=A0 two helper functions in sequence, maintaining exact same b=
ehavior.
> >=20
> > This is a preparatory step for introducing devres-managed MSI allocatio=
n
> > API that will share the allocation logic while providing automatic clea=
nup
> > via devres.
>=20
> nit: the actual goal is to remove the devres aspect from the pci_
> function.
>=20
> >=20
> > No functional changes intended.
> >=20
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >=20
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> >=20
> > =C2=A0drivers/pci/msi/msi.c | 30 ++++++++++++++++++++++++------
> > =C2=A01 file changed, 24 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 81d24a2..748dba6 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -420,11 +420,9 @@ static int msi_capability_init(struct pci_dev *dev=
, int nvec,
> > =C2=A0	return __msi_capability_init(dev, nvec, masks);
> > =C2=A0}
> > =C2=A0
> > -int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec=
,
> > -			=C2=A0=C2=A0 struct irq_affinity *affd)
> > +static int pci_msi_range_alloc(struct pci_dev *dev, int minvec, int ma=
xvec)
> > =C2=A0{
> > =C2=A0	int nvec;
> > -	int rc;
> > =C2=A0
> > =C2=A0	if (!pci_msi_supported(dev, minvec) || dev->current_state !=3D P=
CI_D0)
> > =C2=A0		return -EINVAL;
> > @@ -451,9 +449,13 @@ int __pci_enable_msi_range(struct pci_dev *dev, in=
t minvec, int maxvec,
> > =C2=A0	if (nvec < minvec)
> > =C2=A0		return -ENOSPC;
> > =C2=A0
> > -	rc =3D pci_setup_msi_context(dev);
> > -	if (rc)
> > -		return rc;
> > +	return nvec;
> > +}
> > +
> > +static int pci_msi_range_init(struct pci_dev *dev, int minvec, int max=
vec,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nvec, struct irq_affinity *affd)
> > +{
> > +	int rc;
> > =C2=A0
> > =C2=A0	if (!pci_setup_msi_device_domain(dev, nvec))
> > =C2=A0		return -ENODEV;
> > @@ -481,6 +483,22 @@ int __pci_enable_msi_range(struct pci_dev *dev, in=
t minvec, int maxvec,
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec=
,
> > +			=C2=A0=C2=A0 struct irq_affinity *affd)
>=20
> Doesn't that trigger a dead-code warning?

Ah no, wait, ofc doesn't. My bad.


Reviewed-by: Philipp Stanner <phasta@kernel.org>

>=20
>=20
> P.
>=20
> > +{
> > +	int nvec, rc;
> > +
> > +	nvec =3D pci_msi_range_alloc(dev, minvec, maxvec);
> > +	if (nvec < 0)
> > +		return nvec;
> > +
> > +	rc =3D pci_setup_msi_context(dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return pci_msi_range_init(dev, minvec, maxvec, nvec, affd);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * pci_msi_vec_count - Return the number of MSI vectors a device =
can send
> > =C2=A0 * @dev: device to report about
>=20

