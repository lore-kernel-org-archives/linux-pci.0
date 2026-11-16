Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843016;
	b=HZjITXGjGXfmPmcZARzyj64IuUqYc5O5X6b0ApSaLK8NMjrzOej7dXFKFhoLjwpabVgz
	 1T7HQ0WYmUtJLXCe1pK8e+zGdylBPQAQ0JCL7d3cGKLiMxCIL7VdK2jqschl2rgmiXvXH
	 eVR2ybMqboz0gc0H7c4Pc4fsB0XXkChvBcj2v99ppOWtmPddKGDaXAzpbyWf13PHbHeQ6
	 0bwgid4HduhrzjcRZ/pCILM2V5WNkdcReXYWL0oJ2VDFqU60Jf3LDU7q6cem53Ot3Go/N
	 7RCwbkW7bqdEdbGDBngINfh6gx5Ww97sHEAHDSrkb+8ewbHyr/zLL6y31nzESLnzdFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Sybz9AVNQ1D/Oos9+9vW6nYMotH2PQedAaODv8HPoo=;
	b=rsrMRTSK7hELRuMxUPin8lVyqfh7tURZ3hnQgO1Ewnx398dHDrFyku2/5+bt2UMOYG4K
	 FYYyFJnldhALmK5X+qBPadrMLppIDKGsNZ4HsKgld5MirraMBB4gJaweCNyl6uamzjwPj
	 aImL8Pc8VEowucA46qW5cyx/ow+GBLRlVs4JWdC5qm+KQXNeKriWjcwBXCyni8hwyAbn+
	 qKlPPSfUe8WSuN5cBWVWT4fbte4XUJpE5+71xXdJkDT0tE7R4NP8oZhHLzpkfxz4U9tUi
	 jBJWgFoo55oxlkn2upRe9nCDVbOVjbOsgjrqd5kPMEJbiKJqp6c5tig5cChTRgA0JHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6EfJaCp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D7606A33B
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6EfJaCp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67F41F000C4;
	Mon, 16 Nov 2026 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843016;
	bh=2Sybz9AVNQ1D/Oos9+9vW6nYMotH2PQedAaODv8HPoo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d6EfJaCpytZwXrf/nae1C5iqV1lt+dtPOnmQzuMYn4CtUSoLnAGZY4isSZoPNTOPK
	 rz2i2CRms+nbiBKIAa5YVhByWRP/Ae14nrOHHkrGOkNt/PUYPjlACJl2FyZ4ukR8YK
	 hcXkIr7I6Q5HV5DOd210XERHj/7WsI0/P8lGTY9mt1Ckv0Po1xb8qdzD1+oafvSwWz
	 sCjZDiM6g6xBcvWg5oi+yYjklAkcHwF9wVvWTqGML0cPtEbJgU6Bm8PUFjWZqYzowY
	 03z5+ad1isSdKlMCDGpvoVgXMI4g/NRFdJY0RIEoVP1YhU992aM4y+LrT2k82gudqU
	 eNqHFYud5p8zQ==
Message-ID: <sashiko-outbox-217279@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] platform/x86: asus-wmi: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-8-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:30:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The asus-wmi driver scans single device and then attempts to assign its
> resource using pci_bus_assign_resources(). That function makes bridge
> window sizing disjoint from the assignment phase and is going to be
> removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely no-op in this case
> as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D7

