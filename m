Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A74BA1C2
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161760; cv=none; b=bRWnzN9EhelY3XWf3PpCxoGfGm/9pT/9Koq8OwjRLMUCYZ2naAlmGaztwsMao9G39SicuTC7lSPJJi9s4rg4xRUA9veUq0XX8Skww22o8OUE0WtIYatElQ7VZ3iZFpJdltKig/1j2e6law7KgwA8dGanEgkEIt/pB2iVvm1M29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161760; c=relaxed/simple;
	bh=3bFy/tVdB2gBdh3OuQceyWjvH//UczOrO6XHJojYLrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtTnY6IloUFFhaEEMRWud36UtaPCXBHpmSIfR9XBGvf33I0Yxz8Nep25uMnARhsM7lIbyeI3099p/TbV1TgDTl3ms5NxLlOYqTH4KwKjxtCRw9c1w7I0aabZVMyoKuKsK56b1hi7O0VEf15EA3wQ/X+Ici86tzJvF2ENCQFSNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAqmZRoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAqmZRoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115651F000FF;
	Fri, 11 Sep 2026 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161759;
	bh=3bFy/tVdB2gBdh3OuQceyWjvH//UczOrO6XHJojYLrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAqmZRoAi2y6KnPCVGR8JmWp4tZFhHTgu9VlfiSSPjkEakZqNYYyqbFytZZFdAjZx
	 JNvh97qZPFPSvtiEaIof2lk2EZk6LMuKnQEL4Qzjde0NRk4tlbl0VdCaFhPIqKOS+6
	 KlpwGAcA4pgKSQOpmGAvbp9wTAa3HTwsoMXw0fxvc7luDeXvKxuSeBSUClSQs6j0Fh
	 +wUP5M843ntjWwAgAt//w4Ti5hGwS8dAfJnRPHwpRPlmcvsYhprW84pXc6X2mDkAM2
	 ItPP7jpdGiRfwapuS96aMN9ZtpGe/SpEfSfZ5RX1a8maNw+msDGktDFqWEt7jmhVCr
	 +ebGwhhy/YYAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is
 already valid
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RW5yaXF1ZSBIZXJuw6FuZGV6IEJlbGxv?= <ehbello@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911211559.207990-1-ehbello@gmail.com>
References: <20260911211559.207990-1-ehbello@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 21:22:38 +0000
Message-Id: <20260911212239.115651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
> rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
> behind an rk3399 root port almost never becomes usable: the link trains
> normally, but the endpoint's configuration space never answers, so the
> device is not enumerated. On this controller a configuration read that
> gets no usable completion is reported as an external abort rather than
> as an all-ones response, which on arm64 brings the machine down.
>=20
> The change added an unconditional 100 ms sleep so that PERST# stays
> asserted for at least Tpvperl after power becomes valid. The wait is
> performed while PERST# is asserted, so it also extends the reset by
> 100 ms, and this endpoint does not tolerate the longer assertion.
>=20
> Tpvperl is counted from the supplies becoming valid (PCIe CEM r5.1,
> sec 2.9.2). On boards whose PCIe supplies are always-on -- vcc3v3_pcie
> [ ... ]
> unchanged between v6.11 and v7.2.
>=20
> Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_por=
t() PERST# handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911211559.2079=
90-1-ehbello@gmail.com?part=3D1

