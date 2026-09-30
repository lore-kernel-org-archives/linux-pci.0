Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF94052D5
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780786; cv=none; b=UDHQ7zEMt+zKiGrNFbKlps1aatSo7Gax4ui+owjtFtMmUvFx4fFoS784teDw9Xe+cD6t6Gq9YX6KJsWuFnAv6ccbVlxXeXp7/IEG7utvU0bTTb0KOT1i6cQNZgjOHwM59v4ZwMvOCiGMcc0CC8Ys4zQf8sSsJqLEHNvhEKWMRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780786; c=relaxed/simple;
	bh=xAl0AhyE7gS/uXkn5QTmhPUpovy45ztQFzVoqiHp+dA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cSSR519wJnJcwJE7M8BVraxC0t599/Ek7Tzx1FudaQUcHBDAcFdXveC7myRH1e5BUEO2QTnEFAFR3zMq6Zzhwj3iJ69Cj+NWK9ow0+7TtRUm+lltWnC5PWlpPJq1fADMy4oD5ZJAbDMkNtUYp+3kKs+bm+OiG9keeShdUloukzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2Ofiafd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2Ofiafd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE88A1F000FF;
	Wed, 30 Sep 2026 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780778;
	bh=Q9QfSuVvRZW99z8e8L2TYXnqUAq9jufmC8kej6tIPIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2OfiafdlavXjAQ7CGObUxCzd7UylPzkKcsrMOwQSmT/e5iXr2t5yYawJP3kP39PD
	 4+XeSJBWw9JuT5A3t91wYtKnFjKzycfiT+OjLPSZNb+ErowS/IMUDHJlodeHZg2Hiz
	 HBX5CWYmFQqhP7+AWgBrExZi8LLcbyJ93fATJwmXh7uzdoW83R73T2Pse0jMjeyXpF
	 6PHTEwavz2VIlKuNx+IapQJmScmaRCMyqtpXlsI6ZC6Kvvr+jwUGDhICT6GRF79gqH
	 0im1Rq/UxgF0PaX3hOg1HoKO0uBx3atekRLQ5MluhxCUHWpK8vXtNziBktO8Hdn9X7
	 R6B95rJqhfF4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] PCI: Configure Root Port MPS after scanning its
 hierarchy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org
In-Reply-To: <20260930145017.1356088-9-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
 <20260930145017.1356088-9-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:06:17 +0000
Message-Id: <20260930150617.CE88A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: ignoring pcie_set_mps() failures causes illegal MPS topology
--

commit 6dac99f476ff730ab7dd14051b62e9402806b339
Author: Niklas Cassel <cassel@kernel.org>

PCI: Configure Root Port MPS after scanning its hierarchy

This commit introduces logic to raise the Maximum Payload Size (MPS) for Ro=
ot
Ports and their downstream hierarchies to the largest supported value during
scanning or rescan. It applies to PCIE_BUS_DEFAULT configurations to improve
efficiency. It also enables the Intel read completion coalescing quirk for =
the
default MPS strategy.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d8e58e5ef7309..5f37b480b51df 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -3083,6 +3083,82 @@ static int pcie_bus_configure_set(struct pci_dev *=
dev, void *data)
>  	return 0;
>  }
> =20
> +static int pcie_raise_mps(struct pci_dev *dev, void *data)
> +{
> +	int mps =3D *(int *)data;
> +
> +	/* MPS is of type 'RsvdP' for VFs */
> +	if (!pci_is_pcie(dev) || dev->is_virtfn)
> +		return 0;
> +
> +	if (pcie_get_mps(dev) < mps && pcie_set_mps(dev, mps))
> +		pci_err(dev, "can't set Max Payload Size to %d\n", mps);
> +
> +	return 0;
> +}

[Severity: Medium]
When pcie_set_mps() fails in pcie_raise_mps(), this error is logged but
swallowed by returning 0 to the pci_walk_bus() callback loop. Does this all=
ow
the loop to continue and potentially create an illegal MPS topology where a
downstream device inherits a larger MPS than its upstream bridge?

> +
> +/*
> + * With PCIE_BUS_DEFAULT, pci_configure_mps() only matches each device t=
o its

[ ... ]

> + * leave hierarchies alone once any of their devices may have a driver b=
ound.
> + */
> +static void pcie_bus_raise_default_mps(struct pci_bus *bus)
> +{
> +	struct pci_dev *rp =3D bus->self;
> +	u8 smpss =3D rp->pcie_mpss;
> +	int mps, old_mps;
> +
> +	if (pci_pcie_type(rp) !=3D PCI_EXP_TYPE_ROOT_PORT ||
> +	    list_empty(&bus->devices) || pci_bus_in_use(bus))
> +		return;
> +
> +	pci_walk_bus(bus, pcie_find_smpss, &smpss);
> +	mps =3D 128 << smpss;
> +	old_mps =3D pcie_get_mps(rp);
> +	if (mps <=3D old_mps)
> +		return;
> +
> +	pcie_raise_mps(rp, &mps);
> +	pci_walk_bus(bus, pcie_raise_mps, &mps);

[Severity: Medium]
If the call to pcie_raise_mps() for the Root Port (rp) fails to set its MPS,
does this dangerously proceed to call pci_walk_bus() and set the MPS of
downstream devices anyway? Could this result in a PCIe protocol violation
leading to Malformed TLP errors and packet drops?

> +	pci_info(rp, "Max Payload Size of hierarchy set to %d (was %d)\n",
> +		 mps, old_mps);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145017.1356=
088-6-cassel@kernel.org?part=3D3
