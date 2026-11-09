Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259596;
	b=mGuIDRg4OB6fwVJ/bhBrfs3iR8cmdmBsIuF0z/Dg8ShCdw7rg3uoN7Iwr3M28wytnUzl
	 oCmnfHVRbDTI0bViPMv75rmqBRkCTuXQqomeh5cjNLVKm9SYnB31UnUw5DIFL3rHZ0mXq
	 4wSwmGwJOOnE7DAdG6SmDudnB3HwVcWsNAYQ/AWIoT1Fdq9n1VNbrmCMRHHJ4zkVG6IVA
	 MJVllS2Ip9QI3iDbTdm81g9LNRMd9X7y6DdvwqMyS9pj9xkzaqAwuNWXCaaDxxCkP5T3b
	 wttQxiqgBwCDr2k8zFaRQ0s4YNh9qfp23kZIWg7DWMQIaGVEoMNk5aGIDZa0A8on3yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RYNa0KD2IdUxVCzOtz4B4CDPv4BOX6XSJ/1cAfs44KY=;
	b=CJ3DX7TncmzhV87Ty8yL72YTBbM7SSOzF9Kj/jFuLHArI8d62Zu51gAwonuv5jPfRprG
	 WhLr6uyHgUX7eOIvahbrOWmRypN9iggusycj5SmlDypyE2j7or7VG/lDAyWS+Wc3gg+m+
	 7PPvn2iHWDx1x7c5e7CrCQrvHZXGKKybJParqWXDs0HnNbljFYlDvXxovag2Rp5tCTLhM
	 hvSV/ZZM8qJ/PeGJAPnR2jhDfH3HfqLk9b0ABgR95KlajSi2hC+xqD12ds8g+gB54QWcm
	 qbLkUCYTDBfWQsjTBYoev3ArEz/ksMEstvi2KyEomfGDgGtDcgSSEX/90zu2x2VYKTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsGDZAC0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9F606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsGDZAC0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3211F0089F;
	Mon,  9 Nov 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259596;
	bh=RYNa0KD2IdUxVCzOtz4B4CDPv4BOX6XSJ/1cAfs44KY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SsGDZAC08LKR/GjhviryGn6/PZah1ElphhljQ4WPh8vqsitXM2TYIe3XYccfgR3Sr
	 EJl8pou3LYDrU2a+ylGq9a9WZpewjWy+kqlAv/r3WDXljYnEcRm/ZyWMj8LbA/4aVE
	 KcQXu38/3N1w0nhAV8qFVpfIB7wk5xrfKU6chk3nu5OrRNylfPj+XhmIG5v3epdnDo
	 OVilaULRtGvWQg7g5+NqSyUuYzb/26L5oxKZunhiGPFB2VCt0NxaXIDGy/Eiwxy0D6
	 XTkZ4U9MC1RjnuGO+/C0tU/DgpIy1aIHnX6lWb6KaJXGgWkXxmsRD5sVxWX0P6whwH
	 +lio0fxCVKawQ==
Message-ID: <sashiko-outbox-205668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] PCI: Use Header Type to detect CardBus bridges in
 pci_resource_alignment()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-4-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:26:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_resource_alignment() detects CardBus bridges by the Class Code while
> the rest of the PCI core uses the Header Type.
>=20
> When CONFIG_CARDBUS is not set, pci_cardbus_resource_alignment() returns
> zero. A non-CardBus device that reports the CardBus Class Code then gets
> zero alignment for all its resources, and pbus_size_mem() calls __ffs()
> on it, which is undefined behavior. When CARDBUS is set, the device gets
> CardBus window alignment instead of its own alignment.
>=20
> Use pci_is_cardbus_bridge() in pci_resource_alignment() and make it take
> a const pointer as pci_resource_alignment() has one.
>=20
> Fixes: fd29d4ea09ba ("PCI: Separate CardBus setup & build it only with CO=
NFIG_CARDBUS")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D3

