Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483776;
	b=LdWz4iqmHQy9EtYHjxiz8EbotLMMScss3qDw3tZoFcEJA8lURgsVUnWHnAx5gQTM+xVl
	 YuVzw0Dj9tEIw0k/1Ko4HdfHtIbVwWG8YW2+kuegoOnNuQWhTaJD829UVf2A6uMTxA+Uk
	 Sasp5Hd5HzyRAd+eDTH51dtixrHEQj0kd3nP0gSBsBIdEvp+Na+FQxEnW7u40dcL8eE4O
	 nuxFevOD/BNS5F6gDDbEUt2L2SyJkBvO0+oHpdBrXCfn7a/VGxZJgIFkaPyJwRAu6jciD
	 PNjgsGVdg1DXcY7BB6nrcn07VBp84j6DberBBfwx1acrMh4+ICQGjVUwaUsm/sz6zyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LH7SYOKhoAsj74u/2/55aQt/nu8axmL6zwz5UY3NgVs=;
	b=Ye0f6dQ4l58qARQi6zpXB5SKsspf7w0gWQthKZl29nwjU73ScePEcDASeG87rDOpXNFN
	 uJUD1HNZE0B02WOFrmT5+Qif9n9BNflWrIsXMCZSYyC8iNtiSWjaTuOcXQX20m6xd31zf
	 31UOJmhZ9Jw417UXFygYlSixOmZ0WggK47ILqo2Zfz43XcMucDZkn00S3Of06bB0hmGct
	 QbgoeNeEiy0TQFmU8gm9dJtg1tlh2lSAG5J6riU/3iOkO5bs6gukX273BIUBXP9M63j+n
	 YdLq17qKKBovya2cH7uVMKfzwqrfdZPsQ0yUPfxL55K5nTur2GkLT49IC9pEzkpWH/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgGKxpsi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00982606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgGKxpsi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992BC1F000C4;
	Tue, 20 Oct 2026 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483775;
	bh=LH7SYOKhoAsj74u/2/55aQt/nu8axmL6zwz5UY3NgVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgGKxpsilvsVHzYYqBRSwzrUUo/vYgzYpVPj+82pl9ljADaZNUooQqOXTrnokqF99
	 TAfAkhKfm1XBkQB6/skcF/AXMcZ2FCtZvzi1zis+ukJ6hcQ2Xe4EI6nOB0j+3QMeOt
	 8C1oaOE5PGww73dPGY0FWS2wI1+qxbcJRlWkRYQQexqgZhHblwwhQ/asQb8xI6MOK/
	 A01m4Qy2nmb6jQ/3Ts+mN4/tjZseM6zKZ4k5E3aDxFCqFhK5H++HJvD3/92XB6s98P
	 oe0v5G4jpN7da00YBk9dx49IuzGsHfNumUUKVW3oCAf3+QAMPUUROg1vCVJyrxS3K2
	 lLBtB5y1+hSHA==
Message-ID: <sashiko-outbox-178484@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] PCI: dwc: Add Renesas to the RAS DES VSEC list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-2-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:09:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capabili=
ty
> with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
> not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D1

