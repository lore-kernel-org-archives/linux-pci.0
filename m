Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030495;
	b=z+1XSeBsQ2O2ls3+2rb8BfIB2ZkUfzWHPlybT/T1L2GLt8iDT5cQczGBFwfGLu1GZ20c
	 K3uTaO5J0BX/k8SWJBf29M/vlb+Z4rBCI9JQdKoWcCu5Jwe6adTpbCRa/eS4RCaHb4xHN
	 71AYy7F8jE3ifcHB2yQAJHS046SI/QUxudBY7x0QBPjiptzWpHTpFQx02/8R8OA6+dtQ7
	 Bob8EcszYrplzFhRW4goIW7vLMFiFeSHuPMklaK4QhQMBOSerzqWcys6Iylbaxp5Nx5++
	 PRzey/qYc3jUtmsSy1R/KyU8QNENCb/1DsuZEB0bR06fypNUYoYXbYNBm7xvbXXH50w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FVeUffRw7T6g+3akaImRbiP/P4nxSJkQA4gJvLrBbmE=;
	b=pwO0gsfKtKXAVtZ393au1JXAIZFhvUkCJulMq/8tI6/KuhQ9J3rC2M6a32bm8KbrmGNd
	 vU9XO+Hw7M3mfwofz/kefS4DqVng7bi7APiDmptFCnSOhK343nVVXNxenSK4KRcYiGy1H
	 MjhXT8OyqeaB16c1cP1tqsAHpjQWEmMpoNIEPjXAqGq52U8v1D4g1XdJLEClw8Ie4oThh
	 AWQcksrELb/V8CLXMs/AEqihWGU3+v/QYk7RaPeEDZxaaUWksk5eBE2tfZ60YDh51B3Ju
	 ITCEcNSLn73hTXR08upAso0lHXLkynJIDhVPaJWnp/aXTvr6hmXTnxX9Q0Hoa9luP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2fSAlP+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788560A3826
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2fSAlP+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89A81F0133A;
	Mon, 26 Oct 2026 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030494;
	bh=FVeUffRw7T6g+3akaImRbiP/P4nxSJkQA4gJvLrBbmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2fSAlP+JM2FHlEDdikvPgNSIoopT244Ml8vNMy6NHXLsupmCu3BRqtOVfLzMbyKG
	 c/zBFN7GHqcv62Z1qIxajl2QkMAb6tTSFvRxPeccJpNcuDFS1YL42ENwT+SC8lx0G6
	 VYrOEwiIhorrIegu/V7lBYYBc9nB55II2If8DbDBLxlcm1BSFvKv3xMiUu0zRdb6d6
	 go46uT9M89vxQuRnOlozHg94gKcorx5tWtjRyCAX9Jiaa46brbiJWhRigDLrcVZ00g
	 gxynnunLkY//k7mS4VAQe/0qp+rxdWW+ppAze8eeVViW1K28hC2FfMBmVY5yAOfBBA
	 7RyXOJSzsIC4Q==
Message-ID: <sashiko-outbox-185478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Preserve the initial bus number in pci_bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-vfct-regression-v3-1-fe9586ed6978@amd.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-1-fe9586ed6978@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:01:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: number_initial clobbered on bus rescan in pci_scan_bridge_e=
xtend()
--

commit 66abeabff58a043b28934ad23308d764456e9fa4
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Preserve the initial bus number in pci_bus

This commit saves the firmware-assigned secondary bus number before PCI bus
renumbering and stores it in pci_bus->number_initial so drivers can match
firmware records against the initial bus number.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..9950a9dd1db1f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct p=
ci_bus *parent,
> =20
>  	/* Set up the primary, secondary and subordinate bus numbers */
>  	child->number =3D child->busn_res.start =3D busnr;
> +	child->number_initial =3D busnr;
>  	child->primary =3D parent->busn_res.start;
>  	child->busn_res.end =3D 0xff;
> =20
> @@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *b=
us, struct pci_dev *dev,
>  			child =3D pci_add_new_bus(bus, dev, secondary);
>  			if (!child)
>  				goto out;
> +			child->number_initial =3D secondary;
>  			child->primary =3D primary;
>  			pci_bus_insert_busn_res(child, secondary, subordinate);
>  			child->bridge_ctl =3D bctl;
> @@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *b=
us, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> +			if (!dev->secondary_busnr)
> +				dev->secondary_busnr =3D secondary;
>  			if (pcibios_assign_all_busses() || broken)
> =20
>  				/*
> @@ -1529,6 +1534,10 @@ static int pci_scan_bridge_extend(struct pci_bus *=
bus, struct pci_dev *dev,
>  			pci_bus_insert_busn_res(child, next_busnr,
>  						bus->busn_res.end);
>  		}
> +		if (dev->secondary_busnr) {
> +			child->number_initial =3D dev->secondary_busnr;
> +			dev->secondary_busnr =3D 0;
> +		}

[Severity: Medium]
Can this overwrite child->number_initial with the reassigned runtime bus
number during a subsequent PCI bus rescan when pcibios_assign_all_busses()
is enabled?

During the initial scan of a bridge taking the bus reassignment branch in
pci_scan_bridge_extend(), pass 0 saves the firmware secondary bus number in
dev->secondary_busnr. Pass 1 then transfers it to child->number_initial,
resets dev->secondary_busnr to 0, and writes the newly assigned bus number
(next_busnr) into the bridge's PCI_PRIMARY_BUS register:

drivers/pci/probe.c:pci_scan_bridge_extend() {
    ...
		buses =3D (buses & PCI_SEC_LATENCY_TIMER_MASK) |
			FIELD_PREP(PCI_PRIMARY_BUS_MASK, child->primary) |
			FIELD_PREP(PCI_SECONDARY_BUS_MASK, child->busn_res.start) |
			FIELD_PREP(PCI_SUBORDINATE_BUS_MASK, child->busn_res.end);

		/* We need to blast all three values with a single write */
		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
    ...
}

When a later bus rescan occurs (for example via pci_rescan_bus(),
/sys/bus/pci/rescan, pci_rescan_bus_bridge_resize(), or hotplug), pass 0
reads PCI_PRIMARY_BUS again, where secondary is now the reassigned bus
number. Because dev->secondary_busnr was reset to 0 in the first scan,
!dev->secondary_busnr is true and dev->secondary_busnr is set to the
reassigned bus number.

In pass 1 of the rescan, pci_find_bus(pci_domain_nr(bus), next_busnr) finds
the existing child bus, and the block after if (!child) overwrites
child->number_initial with the reassigned bus number. A similar overwrite
can occur if pci_find_bus() finds an already-existing bus during hotplug.

Also, in the new-bus case, pci_add_new_bus() calls pci_alloc_child_bus(),
which sets child->number_initial =3D busnr (next_busnr) before calling
device_register(&child->dev), pcibios_add_bus(child), and
child->ops->add_bus(child), so those callbacks see the reassigned bus
number in child->number_initial before pci_scan_bridge_extend() updates it
from dev->secondary_busnr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-vfct-regre=
ssion-v3-0-fe9586ed6978@amd.com?part=3D1
