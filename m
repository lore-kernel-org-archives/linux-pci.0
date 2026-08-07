Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF935677E
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119710; cv=none; b=knaCVIB1jYFQc1JCzflyy2fuZX7qVtA90oLciKlSNlfxY7G2Qy529Gg0drr9glFMK1bqCyaZGHjted9UFhA56z8btDKoLihWVbWAOfyFNCfIE4JNdY+bbhBsaukwMdFWFkSTd+NTz5dUm/EUAqKNyWtk3lAdoWzlvfrKFWiJEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119710; c=relaxed/simple;
	bh=2OHAuzlamwT3K4kNcz6Df9F4Xf9yr98V7/apupaBbsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IpC3AuFzyIeaxGWqvznqqGMvm97uSI5gZU27QkJahkUBXTgry/3dOiAdWFs2dLDvPDJnoc3ASePcGO01g2+EN6D7Dbqp8PPJD7jvcfvSOauc/TescLqDy7twww/0PoWeh8KV76qcmuIZ14Icy8K0Lvj9/9fGEBXNc+OVhwjsBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbgwE2P1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbgwE2P1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC9E1F000E9;
	Fri,  7 Aug 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119709;
	bh=oJIrPnXd/+/H8oQFNaXP9l1913OIB0w9W/CoEOgzs3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbgwE2P1ihY2b3J+jKs0G2gRQI6OezgcSOcyBPMkv+/x8hL8LmrcEFGffzITZzNiO
	 hIByTflV/pEkVQgv5FrxWQNwl6RwYz4/Abnq9FypzYqO6AdQ8WboeIsZo7hTnJdru0
	 4EAXiJIYqZqqWrv1GAzM0cWz7NymeAsS3Xqa1Bsf5taGdPl2yKP6/UMjCmy3PGGybt
	 Ee59gIZIyNh8hbS4JYximZ3FnR4DH4inuLvXl4iBX1qzrbWIxC53tAo14okmrblJ81
	 mCo/++wl8XB6IaJDREau0dCZxNQpaPyKtXWzxlMqg3VxbTdF657yNaoN9q41LYsVDR
	 +7pJGttrnVK+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Semih Baskan" <strst.gs@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260807160526.379-1-strst.gs@gmail.com>
References: <20260807160526.379-1-strst.gs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:21:49 +0000
Message-Id: <20260807162149.7CC9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
>=20
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
>=20
> With that property present, two things go wrong with this driver:
>=20
>  - devm_pci_alloc_host_bridge() parses those ranges and requests them,
>    then this driver adds its own window and requests the whole list a
> [ ... ]
>=20
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully=
")
> Tested-by: Rani Hod <rani.hod@gmail.com>
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807160526.379-=
1-strst.gs@gmail.com?part=3D1

