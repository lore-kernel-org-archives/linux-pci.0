Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A53E1731
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592042; cv=none; b=dl4m4ly3akql6pYY7cGMgfUQ+z9VMVYlAi9LjAhhe/3TcoIJjer94K+XWIqOf8jW6tGrptuvlSX2GKDFK94aV4cASvd4Xu20/EK06qaI8wiXn8GOFYuHhyUU0afdk8Lm5UaC67nuGuXSINpLqfWd4uFMbmXXWzD0w0a9hvMLokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592042; c=relaxed/simple;
	bh=nhhYXU0iWQeaWoSDodtRwg3N2YUnlnHT9FdYF++1hV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TcUgciDf3A6gje6g74IUCjf4jgQ1MTY7v/W7hCPwBldYNpjDGgZYuKgHwDXm+J22e9WjN5BCrN8vN54iXQ/rppdOtiXDon/ZjiRFYRp7f7M6PUr8lBzfu+qhKlK1TCR1PmvKBCnwXryUXzEx/nvZ3XDAwJV5r7bXTVSADhLSHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=irgZn/4C; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="irgZn/4C"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gFHJm1QjXz9tvv;
	Tue, 12 May 2026 15:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778592024; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qilrBREyLS7xnI+a9anWIOq6RhY/aUkPz6VnmvbObzs=;
	b=irgZn/4Cmh3UEqi28IQNasaP+cnjb3thnV7TH3wB9qxP5xOBdoT+tVDW570KsMjfWSyRpP
	mvslRBp/V639EyzxE7ThQBcH9uOjG41zJJdJLwuguAhTOMMqNvtRVVDvZl5dTBCX+pDZ4N
	Kv4tCGmMxueQEyrVBRef5cIiXA74RxSESrifuSYxfiPv67rHdZ0UKVG4aSer7j9KHk+Oou
	v1nSOhwRIpSyD45h5rxksbDPo7qP0EFWL/fi7HsBndZFRub+74gPDzR9izzRveN7WVFaPI
	yAPnXuPw2pVCLeZOPLJX4G9FedEnyWQYhjNVvwOJridkO8JYKumLHnZTSqYDAA==
Message-ID: <d4354bf4763a5996fb2e7dc389faba446727104d.camel@mailbox.org>
Subject: Re: [PATCH v4 2/7] PCI/MSI: Split __pci_enable_msix_range() for
 reuse
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Tue, 12 May 2026 15:20:00 +0200
In-Reply-To: <1777017460-243543-3-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
	 <1777017460-243543-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: zrhaaemhdu7pqiuc5fx9n5btkhx669cg
X-MBO-RS-ID: b084005ce043a07493b

On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
> Splits the __pci_enable_msix_range() function into two helper
> functions without changing the original behavior. The purpose is to allow
> future functions (particularly managed devres variants) to reuse these
> components.
>=20
> The split is as follows:
>=20
> 1. pci_msix_range_alloc(): Handles the allocation logic, including
> =C2=A0=C2=A0 parameter validation, hardware vector count verification, an=
d entry
> =C2=A0=C2=A0 validation. This function calculates the actual number of ve=
ctors
> =C2=A0=C2=A0 to allocate and returns the hardware-supported vector count.
>=20
> 2. pci_msix_range_init(): Handles the initialization of MSI-X context
> =C2=A0=C2=A0 and the actual MSI-X capability setup. This function takes t=
he
> =C2=A0=C2=A0 pre-determined number of vectors and hardware vector count a=
s inputs.
>=20
> 3. The original __pci_enable_msix_range() is now a wrapper that calls
> =C2=A0=C2=A0 these two helper functions in sequence, maintaining exact sa=
me
> =C2=A0=C2=A0 behavior.
>=20
> This is a preparatory step for introducing devres-managed MSI-X allocatio=
n
> API that will share the allocation logic while providing automatic cleanu=
p
> via devres.
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
> =C2=A0drivers/pci/msi/msi.c | 38 ++++++++++++++++++++++++++++++--------
> =C2=A01 file changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 748dba6..5c196c2 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -820,10 +820,10 @@ static bool pci_msix_validate_entries(struct pci_de=
v *dev, struct msix_entry *en
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> -int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entr=
ies, int minvec,
> -			=C2=A0=C2=A0=C2=A0 int maxvec, struct irq_affinity *affd, int flags)
> +static int pci_msix_range_alloc(struct pci_dev *dev, struct msix_entry *=
entries,
> +				int minvec, int maxvec, int flags, int *nvec_ret)

I think it's relatively common to have the 'flags' field as the last
function parameter. Also nvec seems to be suitable more next to the
other vec size parameters.

> =C2=A0{
> -	int hwsize, rc, nvec =3D maxvec;
> +	int hwsize, nvec =3D maxvec;
> =C2=A0
> =C2=A0	if (maxvec < minvec)
> =C2=A0		return -ERANGE;
> @@ -858,12 +858,16 @@ int __pci_enable_msix_range(struct pci_dev *dev, st=
ruct msix_entry *entries, int
> =C2=A0			nvec =3D hwsize;
> =C2=A0	}
> =C2=A0
> -	if (nvec < minvec)
> -		return -ENOSPC;
> +	*nvec_ret =3D nvec;
> =C2=A0
> -	rc =3D pci_setup_msi_context(dev);
> -	if (rc)
> -		return rc;
> +	return hwsize;
> +}
> +
> +static int pci_msix_range_init(struct pci_dev *dev, struct msix_entry *e=
ntries,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int minvec, int nvec, int hwsize=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_affinity *affd)
> +{
> +	int rc;
> =C2=A0
> =C2=A0	if (!pci_setup_msix_device_domain(dev, hwsize))
> =C2=A0		return -ENODEV;
> @@ -888,6 +892,24 @@ int __pci_enable_msix_range(struct pci_dev *dev, str=
uct msix_entry *entries, int
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entr=
ies,
> +			=C2=A0=C2=A0=C2=A0 int minvec, int maxvec, struct irq_affinity *affd,
> +			=C2=A0=C2=A0=C2=A0 int flags)
> +{
> +	int hwsize, nvec, rc;
> +
> +	hwsize =3D pci_msix_range_alloc(dev, entries, minvec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxvec, flags, &nvec);
> +	if (hwsize < 0)
> +		return hwsize;
> +
> +	rc =3D pci_setup_msi_context(dev);

OK, so IIUC the plan is then to later just remove this line once all
users are ported, correct?

If so, I'd put a TODO comment here: "Remove this after=E2=80=A6"

> +	if (rc)
> +		return rc;
> +
> +	return pci_msix_range_init(dev, entries, minvec, nvec, hwsize, affd);
> +}
> +



> =C2=A0void __pci_restore_msix_state(struct pci_dev *dev)
> =C2=A0{
> =C2=A0	struct msi_desc *entry;

