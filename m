Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB5480942;
	Wed, 12 Aug 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555693; cv=none; b=cjzzVgYhHtHcCnB4roEPNeXr9R8rekVngi6XWefbw/gOsZXWqNZA3N9fu2bzWoBO19ChYqsVf8v1EwnpMRmnN4+9XxOQTgRDwnl8LI3p89Nx+WvNrx9Maz8QG89cLfLjWf6/qsz2cDQzsHEbGNHP02OkuNFEw4zoC+hRC7FmjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555693; c=relaxed/simple;
	bh=TqrWsNn1+9iDVwIvcbXJ4HHE2kBtuJoamk/kteBuO0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EwRHJog4oYoxgtvvB9sZye+POJRCkX7HFgL3el8pI6iDc3DtL0TKAtNZhVBmB5NpklXNrs663Bi1dq6w4FqxlYlUjnfMAx8JvkYQ03Gv5RdOwnrCV8qMP7PH7vGAiRxt8ct6gDevNpPDJhVI9Tdu7jowbBv3KUv9M03dhXt9SRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRi9Bk05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRi9Bk05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E921F000E9;
	Wed, 12 Aug 2026 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555691;
	bh=GgxkyQ/W1H2f7/LkcJkSDmIji8DnE8AvhmpXXiTk/vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lRi9Bk05e7dadB2O2uNW/gj5nW3XYwad8jc0ezU3tjjytO1nTmAaxJGSiGZv5O82f
	 2PAq+iF6APGRa3xlpEROzztf9SoXRhRWar7X1GK6w/X0TIoEs8DoLl0i61NjiFUsor
	 fm8Odku4D39rXxOLvcDtHxEFXheCzpLRafvXlW+VVfmDx7rqwW/e8NS5uNHf666Q2i
	 y3msNfwcPQbid03w37ns+tD4jzeDN4M9ewGhAj0+DVZ5W3k+aBdY5LyuPflk689cJE
	 vM8ZniGrPx1EWPqVZ9N5JEgxhsTdvlBDH/yEpRC0WqMxC4AGsB+yXF6k5DLCumSOmf
	 djPXtwo7+3zzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260812172247.276554-5-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
 <20260812172247.276554-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:28:10 +0000
Message-Id: <20260812172811.59E921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 407d1a51921e9 ("PCI: Create device tree node for bridge") linked
> the PCI enumeration process together with devicetree, creating a devicetr=
ee
> node for discovered PCI bridges.  Its successor commit ae9813db1dc5a ("PC=
I:
> Add quirks to generate device tree node for Xilinx Alveo U50") shows how
> to use a PCI final fixup quirk to also create a devicetree node for a
> non-bridge PCI device.  These changes allowed devicetree overlays to
> describe components downstream of a PCI device, by providing a place to
> attach the overlay.
>=20
> Note that the dynamic devicetree node is only created if the device didn't
> already have an assigned node.
>=20
> Later, commit aa7b4bbcb3a1d ("arm64: dts: qcom: qcs6490-rb3gen2: Add
> TC9563 PCIe switch node") *pre-defined* devicetree nodes to represent the
> PCI device nodes that would (also) be discovered via the PCI enumeration
> [ ... ]
>=20
> (There are many things that could be verified for statically-defined
> devicetree nodes, but this is all we'll do for now.)
>=20
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812172247.2765=
54-1-elder@riscstar.com?part=3D4

