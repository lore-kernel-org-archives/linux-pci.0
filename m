Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764462;
	b=Fp4XUMZVvHKZ6MtmjhkGChla8OK2jjkC16NGsmjBWkInZTReNg3o0IYvObpXsAQuM00z
	 f4ingWLM7oVEGOxAuJVuJr8OEKdZNnRUbADnf3yihWlmLZdeIQ5KPRwqLDzdao68MlERy
	 XCaO+bEWomHnM1DfQmDFcgMSxtuhikGLdXId1j0jYcf8scQ5zd0Gbpg7lHJ0HfwlrT8JR
	 mwGDehZlVErNOEWy6bluq44vv1QzqGbyRIgahoU+p9TOQ7WTEO7Pe1K60DG2ySdugEdy/
	 CROUcDK/WBpsd4lLQqOIY6gr9yX71Lfb4m8SC8toiYr98rWa6Cs2R4OBORnSmkrRHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L/Uv10MXpeqrXJrer64YsQeT7c/yMyL7dcLkFM4ek1c=;
	b=A8Af9JFXmhELX1IDVGjeIJqcGfMVJlsurlzw9mDpKtE/Oi7oFgh23XqYgS3YKTrXRkGY
	 F+jJy889ikfO8eDIlEbwgUTOx1cO4jIDUj/etpKJfr7uNNKyAOBEau+SlfMc/gqGW3hnK
	 tUXDMYT7VBXyvvD0KmFT9ZB5VT44jTj4o3oM6K2nKqp+ytRG75gma4CEEVjmQ3X3kVPUP
	 t+9xxc2PUh0kmPyVq7mcAxnHNXMNTioMEt+eN1Ii5b/n/9F7UWKXe986rfQh+MJGIXZZ1
	 ZUxUmaVLQHmfiHEEcedXXNcWGdW70l6sbxMc1OrFxCHT2N0XFFUJMipAYO0uxTzR9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1chKifg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1F606A31F
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1chKifg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBBC1F000CC;
	Sun, 15 Nov 2026 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794764462;
	bh=L/Uv10MXpeqrXJrer64YsQeT7c/yMyL7dcLkFM4ek1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1chKifgbYdhJfLsrdeR6skwoP5SURNqsgha5377q2iho5CYcm5sbr0sb3O9H6yxF
	 Op1d5oZSDefJE14aDwAsR1u0BKtBfwCEkW8t88aabNvGGA4OCvWeuPQfFE2M1NCU39
	 QIlG+4NQISq/maSl9ITz2adGcx/Mhj5DIoY83xCJ5ctM0KaTBddhF+BW/+K5N2+q/L
	 zMBVv66ZQEf27HJHB4FbTurfIVzfDgOJmmk/yC601eZyOPHWgPtW6d4Jnq9W+6OovX
	 0wC6jpmizzC2XC6ElydqeRFpcEDHgn1+0cn6ZnF/WCsxxeNa1kcloETRDIW/cZYi4s
	 Ce7b7IYKLd0/Q==
Message-ID: <sashiko-outbox-215687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI/PM: Keep hotplug ports out of D3 if they can't
 signal PME from D3hot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261115171831.1498006-4-avivb@amazon.com>
References: <20261115171831.1498006-1-avivb@amazon.com>
 <20261115171831.1498006-4-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 17:41:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On runtime suspend pciehp masks the hotplug interrupt and relies on
> PME to resume the port on a slot event. pci_bridge_d3_possible() does
> not check whether the port can signal PME from D3hot, so a port that
> cannot is not resumed by slot events.
>=20
> Return false from pci_bridge_d3_possible() for such native hotplug
> ports. pci_pm_init() computes bridge_d3 before it reads PME_Support,
> so move that assignment after dev->pme_support is set.
>=20
> Co-developed-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115171831.1498=
006-1-avivb@amazon.com?part=3D3

