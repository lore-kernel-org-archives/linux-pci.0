Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453942;
	b=jpbOD+NjHeNg+LDok5Nw27Us6FROz4a2IcuEVv/TFouHXUQ9afDAMpqg75hek1azhvuE
	 frlcvHd4d8OT46d3xNplYIiO+2paWkluUvEZDKoIX9E3e0whgZF12tN83Da2vQp5hzHJH
	 RGCETBTsmnoUude1T6NcvU/txAqlgRDsj6f8/q5SY8H6lVoglzfPLr0ppKtebgh0H2EtB
	 N+mUhq5Qg6yaTG26xN5efRnvZeXard452XZTutbWXo7CHRYwiyDp09oyxUh3irjvPhY2n
	 635XEA3m0Ek1rhksQK1XhAu30ZN5cXusvEqhzU5xElcoiy2UhFgEMW385Vvh270/kmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=66jPEn2qXsWrGD/byF6yDkAcV20zxJP6NzbQy5ifKN4=;
	b=EsfDljUbkUeWMaFYAD2pgB1uk10czHCkm1Sy9o5HPBTGdEb0Bw8hQSyTeOlno9I7J3VG
	 yG6ufDKIvCPTmW1POAkqzvyMV6/G8LNUdBRJ/tq472/+5iGdeElDmvlv4ruJv1feZv/mG
	 RvTv5KvlWTEADmc+ur7yyuTkURX9S1qm+ZRp0LBJvsML00Vt0GnUoHyZ74WZVmd5PgsCN
	 I7uf2SjB84oEDJ7JPf0qaAMMquZ9Tka/FkMU/7/NPFm96aCCj1vP0YT/KeA4SDd34y9mM
	 fk/7r8XakrfMP9dxdWb6iejX0RpY0ZJeGMIdbPU33azbrdv547CwWkw1tJH2eoZbTew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwZd4mWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDA606A324
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwZd4mWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64C61F00A05;
	Thu, 12 Nov 2026 03:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453942;
	bh=66jPEn2qXsWrGD/byF6yDkAcV20zxJP6NzbQy5ifKN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwZd4mWZRuJxz4f/RboWtC4UlaHkQTvi72OCDh3AG7LAvoM/kHyNo5JF3aPlimcjW
	 Qnfmk/wdebiOgRjtlRUig39FyWchT/I7eAOeX8nwewK5PAuI1IDo4D5GkzRHpjdm7g
	 Laj9IfJZ5FMeKGpNr7S1qvO+YGCndtt0Q0da7n5iwrf9uBk+22K0+7a3yx3pnuyHrJ
	 hq+TB4kupznKuqmqbUi/VH1dIn92X81bzI1T1dHUsq7qn6MDgVAiPHWMfuW9W/iFWN
	 IlaopXzRJ0fFldKkN8D7HvTKo5o2Whs6qrS10LsUvQ6Ah1nmqa9hmt8W++1TkReuoS
	 1Hmhc1odaZm+w==
Message-ID: <sashiko-outbox-210272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] PCI: Introduce pci_clear/set_config_dword()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112031921.1255661-2-18255117159@163.com>
References: <20261112031921.1255661-1-18255117159@163.com>
 <20261112031921.1255661-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:25:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add helper functions to clear or set bits in PCI config space.
> These helpers reduce code duplication and improve readability for config
> space modifications by encapsulating common read-modify-write patterns.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112031921.1255=
661-1-18255117159@163.com?part=3D1

