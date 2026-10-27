Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104325;
	b=1l0/rnwJpqARHVX7KAAcUayrhLYiKn9k55KgKXJtRN0X/EEh5+dsHm7sPQtriAZMdpBu
	 xdEIosEOtpy1EdXCFRBH+hXXTCOGNp3xyrWjVXJTkvruTqK2IVahwDN8SgEV9O0OGO0JX
	 rLUvbVNqrh9/SUUP/cGwApognoNfdmdlYxLyNx04Pm6+rg/aqqCmbq5Ca03h9jEQ/HZSw
	 H65wxetQQyaEZ7AY1bvDs11qBC1EjZnruk7wO4Qm5JpnHe+x9xwDlG5ftKDsUenm9nrkK
	 eA2A6vt/ex0qfxPLRZTvSDzWlj2PelQssYZebVRxp7C7ODqnaIqF8Dl3DFxO01frn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104325;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=328trzmhKzEF5BXVtZQ6YjInawLtD8pAiyGdqQ/oeKs=;
	b=hv9tAueRKj1rHQffIxAZsxhT8cKHiYdF5zdIjDdz12TBIY/LHBoCAd8SA+XyHmgdWPYm
	 Qyakkp0dEENJz74PTBuI51+FjhkbbLWQgpLrauGHkmGI4EVqCO1/J3rWuh5igCnDJ5iay
	 TU7ILtXHZ91N6ooMFowDlVUrIvTJPmmVsMw6aRloM9aupxFLXqY46f6XYLrquCpUPHeXc
	 kiDfxxLVFcLWGVwRh5jjKDgyUl3zO57RlS8qoRjyFcUH6B5EeqUYah+HoR/SjzEYgGISP
	 EIuWv9sQ8Ol76Tad63DCGk+Mvfavsrm7GWYBHyLGvkDMlA2PXrXLbUUDWhEugDcYlSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNF9arVS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1654606B245
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNF9arVS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591CA1F01828;
	Tue, 27 Oct 2026 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104324;
	bh=328trzmhKzEF5BXVtZQ6YjInawLtD8pAiyGdqQ/oeKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNF9arVS3K6oj2bn4WLiZg7hDRtOtKbDo36VcyFHADoKZv3ugGTZC9oytTv0VlCMX
	 HIG99Qv2hAkG6JA3/apMuxy2R/UXJGoAZnhmBIvLGZ2xIuUJZ6hwYYbnLIDDQgg0FI
	 R7z4I+J/A0xmtf4HsITWJHlncI/zL5RSv8Kf9Qj+zashfJg7Wgf/FzF+7jSRtjj9yK
	 rzVYp0pu+hU+q4PSGCC/e8AeiL/RZtzaSq7Q6DvXHLcFtnufeENYx4p4JGx1YnosmZ
	 n6VRABsDPCTI6BaFTi5gJap0dV5fv4ydGDVhigadVvpxGSm9yjY7V4Ow2cdQG8ByoY
	 kQgfSWbiSd4Uw==
Message-ID: <sashiko-outbox-186551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/16] PCI: dwc: meson: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-6-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> meson_set_max_payload() and meson_set_max_rd_req_size() with
> dw_pcie_get_pcie_cap() and store the offset in a u8, which is the type
> used everywhere else for a capability offset.
>=20
> Both functions are called from meson_pcie_host_init(), which runs after
> the controller clocks and resets have been enabled, so the first lookup
> happens exactly where the open coded search used to happen.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D5

