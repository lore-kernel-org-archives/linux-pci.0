Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762E3BBFC9
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684375; cv=none; b=sl5k23qAM3mbV1UDs4JeEj9cyQs5A+Zw1tx2Nm3SzYuz7g0Kdye8VMe9fAjJsRPHMTsGlA6krtgaoReHRfElA0Zpz143E5Jj5i/RoD0WNa8hfwJqYT+VQYPLRf2lWmf7TaWirWl+fXukuQChVRrSVe/C+p/uTV1xKGTBqrLtUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684375; c=relaxed/simple;
	bh=T6zV7LPN2FCmhbHlO0XdQN3jryyrFP4niWuvo857Ha8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNPfdtucpFGBae+22SxKaYyi357rerWl3uH5AMfjDcp/5wxAo9UuH0gPCK2KsODeHVQo/SwB+D/pnCiqaoertSBj8y2r20a8+xe0NlpuhjLBjy2cZNI/Fl0QPLMmT0BSo5itj5POggDDkaZ8ZVC5TCYJSQcZMiR4ZqXe/ERzFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXa0SPVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXa0SPVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B98A1F000E9;
	Sun,  2 Aug 2026 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785684373;
	bh=T6zV7LPN2FCmhbHlO0XdQN3jryyrFP4niWuvo857Ha8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XXa0SPVQCCOQl2KarVr/sQ1rZaHQB6ribwNEL3K0K0PYSGO5U/r/b/zQe7Tsi/KXw
	 Ri8kS1B1wKalsPh6gxlT/c/brjJKhwafikwiUFvRV6VUD6LRb9vqR8reZJp48+4A3f
	 pjU/P1ZsfF+5IaUEfY6LFl2VL/c8cJzfNYRU+gli8tSLnsi+M9MSGu8QUsiZhKKgph
	 2epE3oDh7m5Ek45bwUbgA0E7rpM35x0J1N8xXOYPvByuSF9pi/4cnNl4z9M7PFIZu0
	 DXCrNRj6G1q+5R3fB09X0183oNL7Z+35aRqQaL+BblVos4WeV3ek5Dz1J6T3NSOwwa
	 8+ofLzuXl+T2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Safely terminate ACS redirect lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-1-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-1-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:26:12 +0000
Message-Id: <20260802152613.5B98A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
> path unconditionally writes a terminator to buffer[len - 1], so a path
> with enough ACS ports to fill the 128-byte buffer writes one byte beyond
> the buffer when verbose diagnostics are requested.
>=20
> Use seq_buf_str() to terminate truncated output safely and remove the fin=
al
> semicolon only when the buffer did not overflow.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D1

