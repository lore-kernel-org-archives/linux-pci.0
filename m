Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2033EAEC
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716041; cv=none; b=OTDOHT2Zc5P+EvNDY0D5gmLVp9uq/bWNUDE9FjAWPgy+sdSSCK23pDKd2XATMd5JX0Q5QEVcz7EBI2fn72wWvMyR9F7aWKzIUT/yGmPSRXFkGgb1N/Sn/S7vw8dD5sgtc2778jz8MCYxTWyKiMVtwS0Y/b1bzSxB6sNHTDXALYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716041; c=relaxed/simple;
	bh=k8Fqeh0XQoDVMJs/ar1RpRgnPa5fEnqXQClXXJLBN5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5OlVTWIN9RsYRaZkrXp/cEySGOZRt5I0wl5ECU83V/aWKf6dunOb+acTkaiBx9HSSSHXmE3xF9xS6A3rGSpxyF4dY8+gjsv16LstCQioPFVW6kp1hQ6mc4SfCB2Vc5F5ZAfDu2uHC9UhjGlEDzgeCnWkLmhmtHgY6k1/kVm0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWXA5oBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWXA5oBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF41C1F000E9;
	Fri, 14 Aug 2026 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716037;
	bh=TXmRGYj1y2xJlmC3vUMCU2xkCr3WGddrKVjDMUUqNes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWXA5oBpAIbt12ysPTIyg88ywJ6q4K8qtCmHmey9aoCeDPiGi75zAmFfcP0T1pWQG
	 TWhdd6hMih/XNrxMCX3JPf0e34URNE3K8nI1u6fDuEJ8odM3SuqMvGTDCEpLabf2gu
	 HbUU1d7fQabg1nnuRl/x1tmYuNejqXNKpN8IgXjm4owSTXkw8g2EJvg3HM9Cw4uQQt
	 7HmT9SyA6RF2pJ8d5iUk0ug+KCGUtReDfkTnLMOUzrRAQcm1WD5ew1/SA5mqBx6jt/
	 EMdZZCkzixU4cn7niScrAMZgMy3iisX5188GoFGS60kSQjutWcuQojVAWrbuXDT43C
	 gynrilQNneirQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pcie_bus_perf: Allow MRRS above MPS when
 completions are safe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kai-Heng Feng" <kaihengf@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814134547.23148-1-kaihengf@nvidia.com>
References: <20260814134547.23148-1-kaihengf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:00:37 +0000
Message-Id: <20260814140037.AF41C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The topology walk in `pcie_path_needs_mrrs_cap()` fails to travers=
e across nested PCIe domains like Intel VMD, allowing MRRS to be unsafely r=
aised and causing dropped Completion TLPs.

Pre-existing issues:
- [High] In PCIE_BUS_PERFORMANCE mode, devices on a virtual root bus (like =
Intel VMD) are assigned an MPS larger than the physical host endpoint can h=
andle, leading to dropped Memory Writes.
--

--- Patch [1]: [PATCH] PCI: pcie_bus_perf: Allow MRRS above MPS when comple=
tions are safe ---
commit bf577b720721bb4bea4fbd0d9d55339ceaede57f
Author: Kai-Heng Feng <kaihengf@nvidia.com>

PCI: pcie_bus_perf: Allow MRRS above MPS when completions are safe

In PCIE_BUS_PERFORMANCE mode, pcie_write_mrrs() sets MRRS equal to MPS
for all endpoints. This patch allows MRRS to exceed MPS when it is safe
to do so based on root complex completion sizing.

Link: https://lore.kernel.org/linux-pci/20180123174821.GF5317@bhelgaas-glap=
top.roam.corp.google.com/T/

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..3e17594e181d9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5845,14 +5845,14 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  		return -EINVAL;
> =20
>  	/*
> -	 * If using the "performance" PCIe config, we clamp the read rq
> -	 * size to the max packet size to keep the host bridge from
> -	 * generating requests larger than we can cope with.
> +	 * If using the "performance" PCIe config, clamp the read rq size when
> +	 * the path cannot safely accept root-sized completions (intermediate
> +	 * bridge or this device has lower MPS than the root port).
>  	 */
>  	if (pcie_bus_config =3D=3D PCIE_BUS_PERFORMANCE) {
>  		int mps =3D pcie_get_mps(dev);
> =20
> -		if (mps < rq)
> +		if (pcie_path_needs_mrrs_cap(dev) && mps < rq)

[Severity: High]
Will this check bypass the clamp for nested PCIe domains like Intel VMD?

If pcie_path_needs_mrrs_cap() terminates its walk at the virtual root bus
because bus->parent is NULL, it will evaluate as safe.=20

Could a driver calling pcie_set_readrq() then bypass the clamp and unsafely
raise MRRS above the physical host path's MPS?

>  			rq =3D mps;
>  	}

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18d..7ab2bd66f3a5f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2961,6 +2961,76 @@ static void pcie_write_mps(struct pci_dev *dev, in=
t mps)
>  		pci_err(dev, "Failed attempting to set the MPS\n");
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the top-down
configuration in pcie_write_mps() fail across nested PCI domains?

Looking at pcie_write_mps(), virtual root ports bypass the inheritance chec=
k:

drivers/pci/probe.c:pcie_write_mps() {
    ...
    if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT &&
        dev->bus->self)
            mps =3D min(mps, pcie_get_mps(dev->bus->self));
    ...
}

For a virtual root port in a VMD domain, pci_pcie_type(dev) equals
PCI_EXP_TYPE_ROOT_PORT, bypassing this inheritance and getting configured
with its max MPSS (e.g., 512) while ignoring the physical host topology.

If the physical VMD endpoint on the host bus has an MPS of 256, could an
inner device inherit an MPS of 512? When the inner device transmits a
512-byte Memory Write, will the physical VMD endpoint drop it as a
Malformed TLP since it exceeds its primary side MPS?

> +/*
> + * Check whether MRRS must be capped to the device's MPS.
[ ... ]
> + */
> +bool pcie_path_needs_mrrs_cap(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus =3D dev->bus;
> +	int root_mps =3D -1;
> +	int min_inter_mps =3D -1;
> +
> +	while (bus->parent) {

[Severity: High]
Does this topology walk fail to traverse across nested PCIe domains?

The loop relies on bus->parent to reach the Root Port. For nested domains
like Intel VMD, the virtual root bus has bus->parent =3D=3D NULL, terminati=
ng
the walk prematurely and ignoring the physical host topology.

> +		struct pci_dev *bridge =3D bus->self;
[ ... ]
> @@ -2973,12 +3043,19 @@ static void pcie_write_mrrs(struct pci_dev *dev)
[ ... ]
> -	mrrs =3D pcie_get_mps(dev);
> +	if (pcie_path_needs_mrrs_cap(dev))
> +		mrrs =3D pcie_get_mps(dev);
> +	else
> +		mrrs =3D min(128 << dev->pcie_mpss, 4096);

[Severity: High]
If pcie_path_needs_mrrs_cap() evaluates the virtual domain as safe, could
this unsafely raise MRRS above the physical host path's MPS?

If the VMD physical endpoint on the host bus has an MPS of 256 but the
inner device's MRRS is raised to 512, will the host Root Complex respond
with a 512-byte Completion TLP that the VMD endpoint drops as a Malformed
TLP?

>  	/*
>  	 * MRRS is a R/W register.  Invalid values can be written, but a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814134547.2314=
8-1-kaihengf@nvidia.com?part=3D1
