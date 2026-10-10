Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC324A8A11
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791636597; cv=none; b=jzSBMw+LHGJ2QHqBCkrWmM0/aJDq3CUM2wzVFUE89MaTARjWWHOM6kF00ahtQlstjQU4H+uPcaNWjJsF2wYWoL19MVd/NhULeD6/ZicINFCdPxaJxwvObto/AnTTxTNa7Yr8sXQ55+CsWODp+QbpY7NlzqhVUydtGc62KKYJMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791636597; c=relaxed/simple;
	bh=bLszEkAORFRhOe+OJaR7RjvxBstJZ+4hNv41IOPP0lE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Se01eDjiA5lYJ1W+fQAmtb6KiIn/I7nhBNhkT+Zd2IreyuykiitDEvQGDvfXz+gpABIolGbMjq7PepwxMua/9KEQ59NSUi5FqXFlx4YleIeuV7ibKKG3uY3Zz0xUrB1vlhXEKCauK8EvwBwf99h1Tb3u0xzLHq+Tdrbidpb7B9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZdMy0LL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZdMy0LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2015D1F00898;
	Sat, 10 Oct 2026 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791636595;
	bh=bLszEkAORFRhOe+OJaR7RjvxBstJZ+4hNv41IOPP0lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZdMy0LL5YJ6qNUWsAis1JX7O1rg2MJ9aEt15q5EmGvM2c0h+X0d9TmCX1oFVIv4g
	 TWT1JpPXXf3ZFffHCK4RsD2ZYEF0W8P/MRYFkRrFNOtU4pnfMf58a/MszVvPA8o6y6
	 QgRAoN87bzkgmpJWGMSQbA02cyA0YxMSFgQ4c5D0kR9I93SLD6m15JhdgdBoK8OFKb
	 E/Oo0US9uWmfPiIORNSRHI3JRQQsJuubrtdQ4WQI6adz7WnEXE4kEP2tzsYoxXqvzA
	 5FYaupXKD9jcpjmBsDd+8QDcZbJGgJZZKrTPhPP7d6kFKnZW7Eoxg+9ADgTSapBIBg
	 qgQCRz7GMo4YA==
Message-ID: <sashiko-outbox-166546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Manoil" <claudiu.manoil@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2706e800774bb7e72992a8cc9d17ce7be039f046.1791548316.git.claudiu.manoil@nxp.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
 <2706e800774bb7e72992a8cc9d17ce7be039f046.1791548316.git.claudiu.manoil@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:49:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
> without any "ethernet" node in the static device tree. The ENETC4 driver
> describes their fixed link by applying a device-tree overlay onto the PCI
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791548316.gi=
t.claudiu.manoil@nxp.com?part=3D5

