Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994712;
	b=tleCOcFXoI0HfjRoRzQGV80iIWBT24c0/LMW9ZMfVyTamsxglunrcmm+Rlcm+aQzdyF9
	 xpGurXRhQ0P9I57CksQBrQXsDnJtTvrIQ+UJgfMqSBOnZ331vX+Nlua1guAm6doLyFt1+
	 8XsTydWzp/SHtLYuBxmNs+qu4v0Wo6N70eaGXZsbpZwS2FAc9/0x+EnqIfJDLPz+5Jriv
	 DygqA/fUW7ISLh/LxYWrFzJh4SgdaCEo8shFahs57EJGXKDzRdGA+U6TIYw2VzWcybMKR
	 6uUICIk3BB0Ps32BWsySjkdN96sEigVFpJ2hZUCmaX0YficrH6Mrq0S94YvYdSlaSCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IyKXEMvT6IbskGAJMzZ9MxEQ9GqB16s51eKUtVy1ExY=;
	b=dgYG/SA6GiXxtOLdhDsGtYF/CrQH+FfSEB9TLw6G3NMDS9FLebyPHLAIRJ0jxpEMN1AC
	 h+yRnDVAuBszMvW6Zpaw82PThLZATmEWqEWahmshgGZRDhNGuJ7MwyI2dHclrkAMWVFY9
	 hLXQzCWR10z/s2X7xSZgslyl3riI8Kv7tbCyU7IBzWgTBGddGfxkezpj08fVoebrMa3Hf
	 gwFEfxnEoLrUNEJ71yjw5ml6G4Bl8/yxesDFi7N9NIEHBM4lSsm7rLFW+b5fkRnLH0M8Z
	 d1DuXGAzz/R2Babvuli5YX4FpBu3st58xIRuxhvE8AIT4uqN20bG0zwsTX0tWcKUTvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4UPu0NY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C5606A31C;
	Wed, 18 Nov 2026 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4UPu0NY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746BF1F000C4;
	Wed, 18 Nov 2026 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994712;
	bh=IyKXEMvT6IbskGAJMzZ9MxEQ9GqB16s51eKUtVy1ExY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4UPu0NYjKBOIWX7f7mZFPw0stWoMeZSigdu649yHcOnmOVpFeDOo8PUXnMH/Bjyj
	 6lKuBQMuJfnUxoH6E0CYsuC47VQ5YXPXrbYfHcXfzse7GAihDoSUiNl7nf//+b2CRc
	 OYk8tJnunItZ7lt8zBz5uPNcWPTNKLuRj/WwlKx0acBNGnj6dpUOTnKzrz55gGHIvw
	 OgsUGjp7r3liQry3as+RcY8Er+XYc9AgT4phieyp4HOFs15es+PTfeOcdGfH122g9H
	 K2845Fm3bTgP6WB1X3cL6tKQs7nlQaLu7uK5AvpHoXxAVBJyj5KqsaHejyeAltUcKV
	 zwBl46OR9Bkww==
Message-ID: <sashiko-outbox-220587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 02/13] PCI/TPH: Fix tph_enabled concurrent update
 race by bitfield packing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-3-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:38:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI/TPH: missing Fixes trailer for tph_enabled bitfield race fix
--

commit b7d26d11444570684d469d0d07a19d348c65832e
Author: Chengwen Feng <fengchengwen@huawei.com>

> PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
>
> Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
> u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
> 1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
> highlighted by Sashiko after VFIO TPH exposure. No functional changes.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

[Severity: Low]
Since this fixes the concurrent bitfield update hazard on tph_enabled,
should this include a Fixes: tag for the commit that introduced it:

  Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D2
