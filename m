Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579529;
	b=SN6/w/a9XqOw+TG3MTXyICNCFYbbZZFYL54QQkMzmzclhZOm8FilJu1C9phnlRLnJSti
	 3qBVMU5NlBp0dR3ItgNxKYlVOYBYh5nqD+oQydgLRue1jU7US0GqpqrAnwuv8q5j0vieE
	 tmbV/UjC/UpY2ORYPrVhDFhjD+Ttn0yVug70DhXWCxgoK95YnhD+0QrVehCQj1Bx7W85J
	 FwGXpiNF9np4w7EX20JHVeP5MZ3ecNYMMOnPId9rxrZAjV49WGdB24ojzyiG2nrXXSbdb
	 LFu4HDgCVzbL8ZuuCTacF6dSnRU0X82cSQ9kcRRFoQLGodwZTmU5JBS1iQrfRT5lGbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579529;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wDda4CZ4StYgPnBlyTFS46bq9AAPe2nWp5cDpPBb3GQ=;
	b=Bbv5+SFoxPKceXChPfSg61CHIe9rGEJRSkmCtGMiWoZC1WccCGjcpiOAMzmyHx7EwRWh
	 rP7RsSLMkr1z2q9ZnFGFah/zdXuLG32C9D05JgWyK7mRpMLWS+/bfiUU4hRvec7DmVHM7
	 Kiw7Qpy4ppRi/wmgqzh1VXlIQfxQ2owYveGfywGSXfi33/yhmCBJvcD7gwrmxRKrTjNoT
	 47F93yhQhrypmL6R6zRYnjCakxa504pfWmrrVjLVzNqwkWeF5ERZPImec86yVRpqVXXRg
	 RaIE4VhOwK0pBkP69pLcoulE5JBEb9pD9mgioGjztPMZ6VAReis3JZLkgBk9FCY4+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8apqUdv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B7606A323
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8apqUdv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E571F000C5;
	Fri, 13 Nov 2026 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579529;
	bh=wDda4CZ4StYgPnBlyTFS46bq9AAPe2nWp5cDpPBb3GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8apqUdvH1DJpVFXLBWkFA7jAqV2R9rUAW6tip1Rc0NSU5jlrbqERH4PjnW2DpSpc
	 bUK5s5bLt3fASueCNHcZqbKbqNmMYJkbiJT7Y/Ki77+4puoZAaarpIjakNo93yFgPh
	 GOpuL7CIAihE/az7FO/OYUgnCoqabPLMi0yyWRnJDB3vduqOnTADWld2zVIsK8niO5
	 TAjnpfOplItVbE2twuIngoOBYlehmByqlAK93KP0LXnOmympt6fi9/I85dlCqJRZQ6
	 zqguCCsFZhD0hgBim+ud/d6U1P+25TEb9xjjMGv9qtwgxCg1cB880W45UINay+haqY
	 NOf4jwzew8RjQ==
Message-ID: <sashiko-outbox-212968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-10-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:18:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB PCI function can now expose endpoint-local DMA channels to its
> host. Decode the extension and register the advertised channels before
> the NTB device, so clients of that NTB device can use the DMA
> functionality in the same PCI function. Endpoints without the extension,
> or hosts without support for its DMA type, continue without DMA.
>=20
> All DMA channels share IRQ slot 1, historically unused by link events
> and doorbells. This keeps the doorbell count unchanged and needs no
> extra vector.
>=20
> Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> and keep type-specific setup in local helpers. Support for another
> implementation can add a new case and its own helpers.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D9

