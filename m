Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104347;
	b=PpNwetKD04CZJmARd1IhS+9DNPSmByjhORSJHcm4aBKbOP61EBoCUWfS2XBUVbIuYdTj
	 2idDQH/LwNTlqbwkXBJyMYB48NlO7QOTc2uMUZaguH3PcxqnWZFIF7C1cg2U5XL/d6O9x
	 mRQyGVhLwhoISBueCV50ezPYpAW7FArvkJv1yJIHm01tdJcfk9aHmzRdHkDXVmG4PcTG5
	 RM7//rUU6RvPqCQWCDPiwHkESB0D2JdjwEKEZAc05SafUkEgUiC6EvB9H4WFBKPjjCrHr
	 trFdrMuyoh5igqNHQTpA07TgQJBy0wSz7CdunKe4RJCl9m9TCwtywFa71jL2j5KGNQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uF24RwuNJ4WT7hvTYHlU+dJR9ZV1YaMLz+4UKrSInG8=;
	b=leE24JiAqvD0ydk3HH0v2Dx1UHcMwN+nSeL+ZsMKi2pI4UF4ojmWVqmXrwBKWHiXLAFl
	 HvoPmpGampqv05BHMyRsKrZ+AhZGUJRw9HzCmjf1YpsSzkvW+l1lHHjQRK3vCyqvymp8N
	 zmdncymd1qizOsaQEdMBvQ7fMsrmQ2p7hmcEZj6RGUe76UMUAdI4jpjseIxyXxfnNf53n
	 kQQqaT9t6CZi66PSLN9ZK8eRp9U/OX03RWaKIZF55GNMk1/0UNGCDbvc1hSPayRW8Gv+S
	 7fYbsU9hkk94O3wzptFww9vf2aWlv54rAyMJfp0EXhbcXuEg/SPuw7WaWREWynEVbRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZl1iV9O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FC606AA05
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZl1iV9O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552B61F01825;
	Tue, 27 Oct 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104346;
	bh=uF24RwuNJ4WT7hvTYHlU+dJR9ZV1YaMLz+4UKrSInG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JZl1iV9OOPaFSMe/L7OQfPKC9trbwirjnk2ZRdJe3IuarskKfBDsnr2dBJOWcLtr2
	 rIxBqnhfsqK8y5f0BHfAxSYf9R2NPZHFlxXrUVxw4z8CUosy0hmcam7MVc0KMcANiY
	 xYcSKjOuFz+D3BFHhg2zliD/HRUcTTVYCIK+ABMJtwbrwNgWeaFY52x464pn6allhT
	 3ZO7rasDeqyAPXYMsdM6CuZpEyjJhENchkwNKKqMPyhtkFS5zlwexm+klMEImt1swT
	 IIPSfUEchnJ9GJtodeQw1cPrvNbh9l/OVh6qiQZaX/Ot3JUh0Y7o7ghmgErOePm/q1
	 dyvuMN+uTGPZw==
Message-ID: <sashiko-outbox-186554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/16] PCI: dwc: sophgo: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-13-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-13-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> sophgo_pcie_disable_l0s_l1() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap() and store the offset in a u8.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D12

