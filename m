Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461109;
	b=HaS+7U+rJmbNuqLjYTG/0EBs2GE9Tt3i4GIEYa8vkDqhkNKCHiPmW8WNtT74xQgyYfHK
	 XaEKDD49TEZbc4Cpq6Uzj3EydpxUHLgBzk9RDiM4VN75EuDasyNJ25W7gJbM9gPvF6Uw3
	 gol6rsFfIfneP8Q1va6q7Ogtq4nmd+HfprmhrfDT+UV7jMPbwzQTKsptgNfs5tfLS+xbR
	 YmQWS306CXV06pMaQGlXXYhPlowPIlAbq925Ataw6Qz3Od9vyaYWwEpNDkfsOp3fH5Yx+
	 +XqYEl8CyEiiVtzBp54Me/5j8PF2ANHiaebNMt2YGDIpfI/bYeFhWyOP60Qeun6uXbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461109;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nS3t8PNTxr+6STLBPOKmbynDEcyP7pa8cVWuCTfFfro=;
	b=1YLr4KQGr18ceXw2lnIXg2CrnkVsqEw5BiD8hqK/VlVeLxd/tkTGaI7hKAYLn1Iaph0z
	 0/MeeNDAS3AhbXRg5HtSBNRrNlAgDlXapVmluP0n8xPe3eY3JIi4U/VOXzf1ohegdiIs+
	 aUsnXxKM98n9rk7igjE0w8q4IuwPIaSsocveH2ztuVNA3NSL0Ovl0avKCH4laOFGmu0TB
	 IJZV1KvUdm9fW2bwk6fOkRbWzKiB5oPfgXXAj/OOSCC40naG2fnf7X8E+O1iJtI2JmsNT
	 1546Cpog/OONCvgV5cmFx6rczWD5VnCswLNADzNgNhxJpwhapRzZqk5PM15FNxa0kSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WezSuAqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE9606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WezSuAqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE321F000C4;
	Tue, 20 Oct 2026 01:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792461109;
	bh=nS3t8PNTxr+6STLBPOKmbynDEcyP7pa8cVWuCTfFfro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WezSuAqunr+msTkgraU4p38zLKnTQZ5Grn+DNT6cK3loMNEIwKgL4o2yt7yxBLzDn
	 bsztUoIDoN5TBejC9aZYz4yYEkw234KtBgyN79nYR8YiL+gk3pF58dujJDmmR8Sfud
	 NOUfScg8xs+m90xIwf79mB28rkWlSdisuInLzMiUiWTd0H78wIWnn3TC4G8h6gRqV9
	 lHaZtdLGNgGgMzmUsN8rX67DKUi/UObkDklVYKQ9QtceS8neEgsgJ/se4/AVGxQ1sa
	 Etd54fE8m1LYM3FEJ6UCpda6TqV9M1uNbMz4YMhwYDklWtFmT/WMV6A6k5/4JZcsKS
	 udDgJzobkyZqA==
Message-ID: <sashiko-outbox-178418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Preserve the initial bus number in pci_dev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-vfct-regression-v1-1-5a63ddd378dd@amd.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
 <20261019-vfct-regression-v1-1-5a63ddd378dd@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:51:48 +0000
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
- [High] PCI: NULL pointer dereference in pci_alloc_dev() when bus is NULL
--

commit 8257f74f7a4f8e2e670cc3291997e9d0a2cd7a56
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Preserve the initial bus number in pci_dev

This commit adds an initial_bus_number field to struct pci_dev and populates
it during pci_alloc_dev() so drivers can match devices using their initial
firmware-visible bus number even after bus number reassignment.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..580b288d5c64f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2508,6 +2508,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type =3D &pci_dev_type;
>  	dev->bus =3D pci_bus_get(bus);
> +	dev->initial_bus_number =3D bus->number;

[Severity: High]
Can bus be NULL here?

pci_bus_get() in drivers/pci/bus.c explicitly checks if bus is NULL before
dereferencing it:

struct pci_bus *pci_bus_get(struct pci_bus *bus)
{
	if (bus)
		get_device(&bus->dev);
	return bus;
}

There are also several in-tree callers that pass NULL to pci_alloc_dev(),
such as make_local_pdev() in drivers/scsi/megaraid.c, alpha_core_agp_setup()
in drivers/char/agp/alpha-agp.c, and parisc_agp_setup() in
drivers/char/agp/parisc-agp.c:

	*pdev =3D pci_alloc_dev(NULL);

Wouldn't dereferencing bus->number unconditionally in pci_alloc_dev() cause
a NULL pointer dereference for these callers?

>  	dev->driver_exclusive_resource =3D (struct resource) {
>  		.name =3D "PCI Exclusive",
>  		.start =3D 0,

[ ... ]

>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-vfct-regre=
ssion-v1-0-5a63ddd378dd@amd.com?part=3D1
