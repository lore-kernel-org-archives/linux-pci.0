Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669425;
	b=KJac49FNt9FyRc7/WT6CYDc74BE5Z3lgALZJD2eTkkq84sGivx4EPacV32RAiJ5ZsJm5
	 2MmpsyLcQmF1Hwta1Y767Za7KJ0nTsURQb4FTdt20P1rA9sXiwc+RYTudc5kWQjuNyRJ+
	 ToeQhbP3n8XMub3/nVuk7Ed001BoucOqG4B3fMSiw6UqvP34CPpb5xgpbGEsQoBXVyYeH
	 NokFv1vsf3p+JuCljaOUDJunPoON1Bla/V95No6NPclmscMuFmUiuytHpWKxexQXxkfUn
	 dSB9KTVsc/nUG7UtOB9y43FXe1t41ny1e5tV8p+Gpfn15ahgkBeG7aCYhxOeoRuPQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669425;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TRoBE8kyqp4A0waQhqxN10c2WDZ6xGH6sSi7rOB5hiw=;
	b=Tdp+5uPjl7K6PVUrYJl4V79d13WYtvlT3hDOOhqqumHqD0osSr6ho5/spUTNbtq+GrEI
	 YujAjj8Q+J0X+LflUzvKh6z81mCmyW7mPWC7hysgVlAyqtgod9/LiCi7vGlRb32eU+iZB
	 vrIqwc7q63JpHX+TpluH1P8ReAxhyGIys8mR8hDMeG71LBrowmFKb52cCpFZsAnXVvlgY
	 euaaxoQsTeBxdJrD5N7NBu3U7zKpfx7G1FXygjG2AnSRCSGUfKM0ZdGPXz40P7Vb9s1mn
	 aD4clvRoODMhxwkGej7a9VJCeVrVcPZe0HMXrIR16ShMGoW0kUnYFfaduTuywPM60sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMNwrEA0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799C606A331
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMNwrEA0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844001F000C5;
	Sat, 14 Nov 2026 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669425;
	bh=TRoBE8kyqp4A0waQhqxN10c2WDZ6xGH6sSi7rOB5hiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMNwrEA0krcf/qWfZ7t22tjdf/dlobFZUJV1cQi0w8aVDIMB6iXBwb2KLVt2DHAcb
	 vR5XS3XraEWNMVjcd8vq3jDvfRb0gzGrDoQX0cqTxbXtE7+PunKPa1oV3yq01Ydk0k
	 6XnWrMyvXkuKaOStia0Qiz1mfYAVjsS5b3u2BxMxEB1G0DvFr3RS+MKd1cSKwJEBtp
	 EI7XLw4JyNI43VdVEmGmC/570TufZS3W+++9nEVUFhtC2z0eIWhbJEAAQqtYjQ5z7g
	 1ZjwXMkogQF/RnCLU15YioUNGf1/zp72rVPOA0uocggg4ACL6jJBe0M2/KPTic+rbx
	 tF8ViKHM18YFg==
Message-ID: <sashiko-outbox-214690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 6/6] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Manoil" <claudiu.manoil@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <e256f380f2f1bc88752ee261101cc83ad84ebedd.1794581338.git.claudiu.manoil@nxp.com>
References: <cover.1794581338.git.claudiu.manoil@nxp.com>
 <e256f380f2f1bc88752ee261101cc83ad84ebedd.1794581338.git.claudiu.manoil@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 15:17:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
> without any "ethernet" node in the static device tree. The ENETC4 driver
> describes their fixed link by attaching a fixed-link node to the PCI
> function's own OF node, which requires that node to exist.
>=20
> Request the PCI core to synthesize a per-function OF node for these
> devices by registering of_pci_make_dev_node() as a final fixup, following
> the existing precedent for the Xilinx, Red Hat and EFAR devices. The
> helper is a no-op when the function already has a static OF node, so this
> has no effect on platforms that describe ENETC via static DT. It only
> takes effect when CONFIG_PCI_DYNAMIC_OF_NODES is enabled.
>=20
> Both ENETC4 PCI device IDs are covered (0xe101 and 0xe110), since either
> can be instantiated as a pseudo-MAC port on S32N79.
>=20
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794581338.gi=
t.claudiu.manoil@nxp.com?part=3D6

