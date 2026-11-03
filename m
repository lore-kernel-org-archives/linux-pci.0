Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723329;
	b=POmz10hX/3ZIz4rGnKSBU6fUP2BswAmEhrcpTmsxps1QJ6Y6a6vnKWQWiclM+bUq6fGO
	 l4Wh+ocIVqI/g0taVBs6qCysdH3k0x8YR/3HOgXlycHtwoWMPHgtB2DCXfQEr+Qgtaxp2
	 ol5W/k37HGLANpklKy4P0YuqaO+DUj14g8GE6fd5BI7/VSqzf9OAI7WwIDhDsyAtKnQ7S
	 XnF8JOueDTtFMdHVP4ROl48ei4tkGw187t/P/C9fNVkAbB6L2DPl4V89CJG9gIKGmLw29
	 O3U+OlAJ0ugEJcIJX81ZbU6iyzmOFEatnn8AKoPpCsJYCH2GCyc2df9BEoelmUiPhUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oQdauXdfVOjt7MLRzH2QtSjxU07iplbXh5yvD/Vfdtw=;
	b=yYxDU54hDcINfS7clKghv+0HczONcPo6Gs61spryfvjhFlcJxbtJ60Zc5SfBa8kTFTXz
	 WYPxQXkZAUHCoLsNzReC27UpVKqLM/u6KlpJThV6+n7zn29uEka3uBiRfm9AIBVY0b0JK
	 zc0KD2wxwAiWI8HUhiPBSYCkPrk3erVLgb86J7RE4+zt6tCS+meT10vSJoUEcOTGh6RaN
	 KaQB61f/IWMTzSiEkpQLlhW1rh8g3kUTU2M4Sw62VOiewNqlgLckD8ArtRWAtL6v/2gSq
	 ATpC23sj21/HtwEoY+JusMJ7dfLVDyAOcXB89rHPGZ1ivu3rZR8fADzMne89e3E5tDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH+B+GYj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2D606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH+B+GYj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA6F1F000C1;
	Tue,  3 Nov 2026 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723328;
	bh=oQdauXdfVOjt7MLRzH2QtSjxU07iplbXh5yvD/Vfdtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mH+B+GYjHVddU+Am30IlPK7GQkhVrAn4T8xZlsOaBAAGwbjhwnm6O/PSKwmpw7QEN
	 eVCeWwUbFm4/l4Eb+15sNFrxHek154HRiD+IZ2j7De57OvMF5jUoIZLUQTCNkgTF4o
	 UOka3qHjsP9ZE3umU51lXY49w8uhJmLdz3P7EPO4PTqNkSXZ03gHnJ9d9e4hnNX2Jc
	 MOyP30jO+FlfPwN0XGm5jJXoHWOOWw0eV29dTBnBOf1InmupTbUaoj3d1/aLrRlWz9
	 BG0Acu+phqxqbAhu5VoLdrWU6NSXh8Z422+nk0n+XeZP83MZ8cE7v4wS2if9FIdQqy
	 bjBF/n/IJKZcg==
Message-ID: <sashiko-outbox-195726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-ntb: cancel cmd_handler
 synchronously on cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengyu Liu" <lui2012qwq@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103161622.1597925-1-lui2012qwq@gmail.com>
References: <20261103161622.1597925-1-lui2012qwq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:28:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> epf_ntb_cmd_handler() re-arms itself unconditionally every 5ms at
> reset_handler, with no guard at all.  epf_ntb_epc_cleanup_interface()
> uses cancel_delayed_work(), which cannot stop a running callback: if
> the cleanup (configfs unbind) happens while the handler is mid-flight,
> the handler re-arms, and the delayed work fires after the devm-managed
> ntb_epc - and the devm_ioremap'd ntb_epc->reg it dereferences - have
> been released.  Use-after-free.
>=20
> The per-attempt race window is small (sub-microsecond callback vs a 5ms
> period), but configfs bind/unbind cycles can simply be repeated (root)
> until the race is won.
>=20
> Use cancel_delayed_work_sync(), which waits for a running callback and
> prevents its re-arm from taking effect.
>=20
> Found by static analysis.  The race was reproduced on a KASAN build
> with a small module exercising this exact arm/cancel/free pattern
> (no NTB hardware available); PoC and splat are below.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103161622.1597=
925-1-lui2012qwq@gmail.com?part=3D1

