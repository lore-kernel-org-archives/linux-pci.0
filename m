Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19D369206;
	Tue,  1 Sep 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245259; cv=none; b=n12vCjtsZwxQOq/GHwZCv0deoD6wrcbD2DsUdkjXqkAhK8jFoDBmmGOB9TeaNLbGujvga+F5eDpfpTgV7LztyqNArq3aboIr8Fm5VMoSMHVPX2fyONY9iq5Ag4M7xy4um/GE29Wrz1BXQB/b9JEIVraOUopiTDN+YgS7aWb5nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245259; c=relaxed/simple;
	bh=sXWcuLnegOxCEGRzXJ4kFlINiQaXhSO/uNE6YLafAFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D6qqBabe9WVg/9vhDPoe5Cs0kSi9m5vBakaTxfb7nuPW9BHirJswmJ6gzBTb4UbYhX51qRB2ufjOQTo4FRaU0yzyeTHjNRnnO+UKXo9fUS5v2rR3omwI9QWiOuYq2m392CjLTgeS3Q7k0m2wokxlBcLs8USfKW+VICQPhzGiYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADQlEyrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADQlEyrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D941F000E9;
	Tue,  1 Sep 2026 06:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245257;
	bh=gm+ku6Ht59Gp068OgMTmQcgzHkY9abxoa10ok3pxP/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADQlEyrRTsN3ulQlt2h9tuCLge4SCgEk8u0ifpPh/MU/acDbRpOjDkPVkRpQjQ0qF
	 2AppInpFIhHiXLoJ8LQL3UMnna6LU/IBvlH9NZ2cT5EKVz37b9ERG5tL1qI6Dv0WFy
	 kQBShRczCl43yN3Itsf5j0aKqurBOzmLQayKQHiG/a9MnN+C7jE/lJ2h5aA6fbr48p
	 nrR8WLPxn1Ehu3U+Yo2nJPVOxda7Nc77sfBGh6KH0NeFQrp+HEPIHH4bXlBar7yNCH
	 N/NVn29aBg7R8HpEV0295bujcCNq4bi2AaKi8FVS76/DLyvcZ2Bii35PU2rtuv4g9I
	 IMCf3WQ06tSag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] PCI: endpoint: pci-epf-vntb: Serialize virtual
 PCI bus scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260901063238.631166-2-den@valinux.co.jp>
References: <20260901063238.631166-1-den@valinux.co.jp>
 <20260901063238.631166-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:47:37 +0000
Message-Id: <20260901064737.87D941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global static PCI driver and ID table are mutated and registered i=
nside a per-device bind callback, preventing multi-instance support and cor=
rupting global state.
- [High] Improper mixing of C struct accesses and I/O accessors (readl/writ=
el) on a DMA coherent RAM pointer.
--

commit 52fb844432dfeb3fe13eef7dc35765e5cdc04cfa
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan

The virtual PCI bus is scanned without holding the PCI rescan/remove
lock. This can race with other PCI topology changes.

Hold the lock across the bus scan and device addition.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP=
")
Link: https://lore.kernel.org/r/3tgrcel5fl55ulf3zjya4fkz4t2ms7iwwjif5rnzn2r=
afsydd6@i4e5etm7uqvz/

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index c3caec927d748..412e8cc6fb1d2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

While reviewing this file, I noticed a couple of pre-existing issues.

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_bind() {
    ...
	pci_space[0] =3D (ntb->vntb_pid << 16) | ntb->vntb_vid;
	pci_vntb_table[0].vendor =3D ntb->vntb_vid;
	pci_vntb_table[0].device =3D ntb->vntb_pid;

	ret =3D pci_register_driver(&vntb_pci_driver);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code corrupt global
state if multiple instances of the endpoint function are bound?

If multiple endpoint functions are bound via configfs, a second call to
epf_ntb_bind() would overwrite the shared pci_vntb_table[0] and pci_space[0]
without synchronization, corrupting the first instance's state.

Also, won't calling pci_register_driver(&vntb_pci_driver) a second time fail
with -EEXIST, preventing the bind? Should this dynamic registration of a
global PCI driver be moved to the module initialization sequence instead?


A second issue occurs when allocating and accessing spad memory:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_config_spad_bar_alloc=
() {
    ...
	base =3D pci_epf_alloc_space(epf, ctrl_size + spad_size,
				   barno, epc_features, 0);
    ...
	ntb->reg =3D base;

	ctrl =3D ntb->reg;
	ctrl->spad_offset =3D ctrl_size;
    ...
}

The exact same RAM pointer is then accessed via I/O accessors:

drivers/pci/endpoint/functions/pci-epf-vntb.c:vntb_epf_spad_read() {
    ...
	void __iomem *base =3D (void __iomem *)ntb->reg;

	val =3D readl(base + off + ct + idx * sizeof(u32));
    ...
}

[Severity: High]
This is a pre-existing issue, but does this code cause undefined behavior by
mixing C struct accesses and I/O accessors on a standard RAM pointer?

The driver allocates memory via pci_epf_alloc_space() (which uses
dma_alloc_coherent()) and assigns the returned standard virtual memory
pointer to ntb->reg.

Later, in vntb_epf_spad_read(), this standard RAM pointer is forcefully cast
to void __iomem * and accessed via readl().

On architectures with strictly separated I/O memory or strictly typed memory
domains, using MMIO instructions on standard cacheable memory can trigger
exceptions or alignment faults. Is it possible to avoid using MMIO accessors
on memory that isn't mapped as I/O memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901063238.6311=
66-1-den@valinux.co.jp?part=3D1
