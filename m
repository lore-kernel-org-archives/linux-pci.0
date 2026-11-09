Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258769;
	b=0IsPjL6ho/7Acfy+EECQwX+lNfU8BQeohUD2IMZ0CwaIAdFQ7j9BTyjEtCuQHoVlpvCC
	 TiSG3sGnosaMQOqkxMen16ao3agcbVoz6at3yF+gzlmrPoF1I7espg0znpDPpH0aLRd/K
	 mVrUoKgwO1alZBICiKFdq4+CxK31xQlIcIMTkwBfiqnfQHlCR43r3HgkOHueUc3GPhNGP
	 x00RCcaMHo6n49Wg7ADLCBwtaKOZjmSuI3teYBT1EN9g2ZT8rhusts6a7zBezP1MH8xsI
	 Cbo+mv3MS2Tmt2iKH4CVlMtepdvOqpLengY7PiZSmorj01yb/Ki+3V438WMyTn6DiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=quE3GSG009jQkZhIdaVxDYzuMioCPDr6yuFm/1gwczo=;
	b=c4iBimzQCtS9+bzbUzWlVxUZy2qTvqevmjNSKcDmF35azxT+0uqCJKR2U2ZiqTwpph62
	 3dl1TNTpJe8YptqJFlYEr72exk+Bemy7+gh/5COm4BWGTWXwTJd6TeZmOH6CU9qtUuLn+
	 KAh2p5Ig3KvrpnUhkZwrAK3oU0KByPqgKjltEGB7VXdMPCJoSUAGddsY5zB+iZrHU8/qk
	 DeHQ0mmsQaZdp6nrp4xQqpWjy8h213NV5ugbyx3nG8vTEGa/ZU8wF/UyIMKmH1zs6XdOk
	 jyevKB84K36KvX1YdhzVWBPm9V+ZdKIlJ3PXAALlESReCAio7pmiTVBT677J4cqE8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuJ3Mkkt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA25606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuJ3Mkkt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CC91F0089F;
	Mon,  9 Nov 2026 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258769;
	bh=quE3GSG009jQkZhIdaVxDYzuMioCPDr6yuFm/1gwczo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LuJ3Mkkt4uX1DRUJaDW0GWiPGhjW8QD2y8fLUSh/sP6PK7sUWIatj3CuSyqRRGBl/
	 Slb7HPohPGis9Ty8sw+KYgmW1kG/su6NOFiXOktlZA9siCNzW2xTZQpThZauZX2MEi
	 wA5HFZOdp9E5JawXRK2NXPhx5QFJGe6Av7+XA+jqI5lmUnb93oXMfYHj+T+bgeiqDg
	 tcElL1PMs4fzTXhnsFtaRvHUCV65OGCd48os71EUwW2c5L8EL2XmrxvLru9HF283eo
	 mc/ROeS7SQ/2JuTfpU2rkXaUqhVW2lhcEANzOe484oexXHFen/7fw+U8Er76uYPYKE
	 OEcLQT3xP9V8Q==
Message-ID: <sashiko-outbox-205641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] PCI: Use Header Type in
 __pci_bridge_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-3-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:12:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Commit b2fb5cc57469 ("PCI: Rely on config space header type, not class
> code") converted bridge window sizing and assignment to use the Header
> Type but __pci_bridge_assign_resources() still uses the Class Code to
> decide how to program the bridge windows. A Type 1 bridge whose Class
> Code is not PCI_CLASS_BRIDGE_PCI gets its windows sized and assigned but
> they are never programmed into the bridge.
>=20
> Use the Header Type also in __pci_bridge_assign_resources().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

