Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300728;
	b=f9Wgpq5gGV2C8GzBLTX6PXg4bHTqswkKeVwciOhMWIT/tlJCfCVMo0mo+4siMmBG0Yp6
	 5cH3GSmlHJFWxPjjGnxx4xw4Ckj2D6XOPhbBqlka03JOT3hJh8qxQqO1M2ue3pADdKJbb
	 P1//41YSdmBO53pmxZLDBWuMseNjl9AdvvTvtCUDkG/FqLLwWon+TjgYTHUjr77Zmx+MF
	 B7MEe2BeqG7ilPsn0DhI/viKIe0Aw4dLaLZzkh80E3mr+m78D75mm4cRwGA4N7rF9rL2C
	 7c4ek43uUrWiunB539WM7z/NfpPMt2FYDZ5tcdFio0w0Dsh/CEWCFh9XCBosdJrNnjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300728;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k2vrbG3qJWvwgvJN4aU5eAq9985vjKRNCf686kQgLTE=;
	b=t+oCrV4fj4hpTqFt38uYgDeDFRkuEdp6O4Kk3gAgDf/mkpUSuSweO0T0ix0Geq7zhn5U
	 0XMH5i0yfNTfYYLoY6yQv4avOfhq346MSpl1ffxqgBpxqiSdT3HHmWquTWr18VMdpO6bG
	 snEhNV+Fl67vXBMrvh+nk4ekrzHPwQSNdW9boD4i0bBr75gYBn3lboak+YuJ+1nAmQnZM
	 SrHpeE44a1jwgHdZVYULU/qgAFsD9vdSdIFyVEmRt24EGYLJbNo5AWff26M18oUPxxwAG
	 mk2utdf237ZjhYUCpEzaolJ6fEqRmBZ8BDxrfgYvKMQaIqgUJ4NWzDzUiW8qKp+96oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZddTlHC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08360A2604
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZddTlHC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F81F008A7;
	Tue, 10 Nov 2026 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300727;
	bh=k2vrbG3qJWvwgvJN4aU5eAq9985vjKRNCf686kQgLTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZddTlHCw5GLyOJFGHIAx4VKqesfm84A/LKDU0PVlkOWrRRB4SUn9IouY2itBnPzf
	 wvilpJxi18Sh1B941EdbDWadFzvSd5DbuYtalXJmcsQS6WphTPbbAetsG/TetxI6I0
	 tR46NDFHsPPg6n/AV824Gft4+nvYBIwxNaU9qNVkk4uKzNpIqc18yNcekEAW4FhTAc
	 yqAKlcATIyDetv4clpn1IaBt95wK5lhdCZhp2Cnb62NRMBa/Rhsk2IuI9aWWIAgN23
	 fiCtD9RM0JWfjbRiEQ6wvSw4sztX7/y4DT71TP9FD7dAaJ48j2N3P2UNvmqJQcVoL1
	 ZaY4DQZs0+mwg==
Message-ID: <sashiko-outbox-206673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-11-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:52:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB endpoint can place DMA resources after an MW in the same BAR.
> Limit the MW to the advertised boundary so clients cannot overwrite
> those resources.
>=20
> Advertise this support in LINK_UP, including when DMA is unavailable.
> Older endpoints ignore the argument.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D10

