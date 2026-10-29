Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241979;
	b=oLgBK3i+juE+S3s3HRv9q2ZaXtOyij4BN4HAvyvdMC6WSBr6eoaGztgzYVLfXnOpr/Lv
	 Dj575dH3KexlJYUJONj3oT81sLZrILALgCSU/26Z63NStQ2vm5Z64QeFE4V7slH6p5uWc
	 EG1+6FYnit8cq5PRf0ngRDb+urO02Q/aifyrrPeV1HXrgoZoYwSneeSQNDcHZpgiVdkth
	 2ygo9hgHEHRqwPQbvL8/K7riIJcGggP6RqeFrnLJ/Dj1cSDBi5zTQJHsAlGt4NXqhZq8n
	 jWB+C9r3PtkZ8MaDjhMr9+YYPPsiAyEJmF+xAPDgvdjEPul14dpZfj7vDYR1NA94v5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=27auRIzFFUVNdO+y1smx9Dwfp4xMDuAnssizN2Z1Slk=;
	b=A4i0rvtWn8u1aFl0Lk2XZL01M8qUPHUxAdDibdEZYdIgKtYWH8maZ9rJfJQdoJLz3BlQ
	 3zPlWxwr/K3XT8bP/LrKWzJgtrKXkx+LQyJSVil5dyfRF8AO2m6OY83fm6J09ymjkjkJJ
	 FoiSxbWJ5C5C4jtKIOEIwwo2c7Lc9LobhyBMnyoGiAL41priwHjdJcGCW+//m2J974NeR
	 ETAnXUTAS2KDtpDHLlH4t/8YcCJDxpqfmu4XZc31Y+DAFWq39xxXtdY12GEETWV4x3VKK
	 hddyYJ8AuDJFJjPscTxLh13BfQ1U0XuAsk4Lb8jKaAw2FHu0sKGs+kbJiSVF2uPRDpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwRCgoPi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B89606A321
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwRCgoPi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8BE1F01825;
	Thu, 29 Oct 2026 02:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793241978;
	bh=27auRIzFFUVNdO+y1smx9Dwfp4xMDuAnssizN2Z1Slk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwRCgoPiDK8W87ERsC3LklqvAFjY1gcLiZr4GZcUWsm9sbyLaXofaPqU9t62oVURS
	 jGCboHgTFezF8cla/MoA/Vj8ULrq8faq4pdXTcJZEVJv/Ln6qCnbKddBMin9G8LLNl
	 l1bWr7MR1EJ05ddF+KCvE47Xue8rK0qAKQSvTnWVsqNOClE2p/EVW2Z5krRcDRGJBB
	 zE2JuaAxeRBZcZSMMlHg9O5U6kaWYp+DxO0QgwFePS+bdOg6skI3Vtr9CTGgiOgbHv
	 1vSS25Ut6DYL7Ds37SxdzWjHJVFswYcjytVnhIWRdAS9iIPZKWZSDTG8MVfhz9i2L8
	 aYhXdsiNS1EOg==
Message-ID: <sashiko-outbox-188645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Power on devices below the RC
 using pwrctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029024006.3483210-2-shawn.lin@rock-chips.com>
References: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
 <20261029024006.3483210-2-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 02:46:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Devices below the Rockchip PCIe host controller may need resources
> (regulators, clocks) enabled before they can be detected on the bus. So
> far the driver only enabled a single vpcie3v3 supply described by the
> controller node itself, which cannot express per-device or per-slot
> supplies.
>=20
> Use the PCI pwrctrl framework: before initializing the PHY, create the
> pwrctrl devices for the DT nodes below the controller and power them on.
> The supplies of the slot must be up before PHY init, so this has to run
> ahead of rockchip_pcie_phy_init().
>=20
> The controller node supply is kept for backward compatibility: boards
> that still describe vpcie3v3 on the controller keep working, and boards
> that move the supply into a child node get it enabled by pwrctrl.
>=20
> Only the RC mode is affected, the endpoint does not own the supplies of
> the devices below it.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029024006.3483=
210-1-shawn.lin@rock-chips.com?part=3D1

