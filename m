Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A133B97D;
	Tue,  1 Sep 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252928; cv=none; b=VqverEwk5zocBXYvJnwj9RSF0VDV07iD1gamt8i0mQSNSNjwDMHMn5tQjHZ2+5svKey7dYv38trziACrC7DXTGX3/5XKEhYFA6Gx9pOTj8lWrUpzf0U6BAiTgV9mKaEiVpfxL0q1ABIVJiC/MFwPZPgf1ZI/VHCibIHc2DBN+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252928; c=relaxed/simple;
	bh=F7NP2+aACTgvDtigo+/r4ZBJvQ4uqczsBwLqSVNHXgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bh/Rwhsa3DLd5ijejz5FGJNE+IiMIbpK8hKUg1T1AsKayPKSBq4qb1PX0s0BpGyN8NJAnD/HJCsihiE2gYriavl1oKMQ5SAoxNFcrbepu/E5KQolH6JREIvyE7+ZsZ/5YBRA3cCWFARUWqQairEvCFKd4Gx2dabfgTNnfBClYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiUwXMxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiUwXMxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9951F000E9;
	Tue,  1 Sep 2026 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252927;
	bh=F7NP2+aACTgvDtigo+/r4ZBJvQ4uqczsBwLqSVNHXgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SiUwXMxjG+66/FodulCHeCv65kZQLM/DvqOuc6PN+2NMfPR4Gz7JdwhR3f561Fcu9
	 sOqOH09KolSES7MYJyIUDCT3yuVNff8thuiADBjmzy7av1gY3ey8UW97k5FMEIZWiZ
	 UoKjZMHUS2P6ozqyFOQGBOe6FePS/6yRaZIr4QdWPS2tDp6QfUEMmnbpuEd6dZeyA8
	 QE6gnY+gYbqGy1XxcQmcWuMJ8c0L3zwgnegOHMQO04TPmuTPdQWbMZkQ2JNAHi4xJF
	 5hDC3oFFkyNdOeFPIkzetzgPcnsN+P7dceKZzwMWI8nk5rxLFp6PGXHG1q8PaZ65qf
	 64cexfcYueC4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:55:26 +0000
Message-Id: <20260901085527.0F9951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status =3D "disabled".
>=20
> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> powered-off port functions during PCI enumeration raises an Arm SError
> instead of returning an all-ones PCI error response. This prevents the
> board from completing boot.
>=20
> Commit 1a8c251cff20 ("PCI: move OF status =3D "disabled" detection to
> dev->match_driver") made disabled PCI functions remain discoverable so
> PCI fixups can still be applied, while suppressing driver binding later.
> Preserve that behavior for endpoint functions.
>=20
> For an unavailable node describing a PCI-to-PCI bridge, however, the
> node also represents a subordinate bus that must not be enumerated.
> Check the device tree node before reading the Vendor ID and return a PCI
> error response without accessing config space when such a bridge is
> disabled.
>=20
> Functions not described by device tree and disabled endpoint functions
> remain discoverable.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D1

