Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6E2DF138;
	Thu, 24 Sep 2026 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239345; cv=none; b=DJppKkG6xgzd3kRqXJjhoOlA/mKHtwCeQ8JQjFwA/NcZNzHgQ+F9r1damsMUf5GR/bsYhQ5QQxMvMerqqPp0jtXa+wNP8KDY/Pg3mmZqpIMMtQhbSXhi1DF6V+W/58hBATJsiXNARVKplwSnvcDF8CCvEFmpFmDr1o8qLS1HTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239345; c=relaxed/simple;
	bh=pGsh2jSC9D46z+3nLYcKrPgezVzDh4QNU+TYx3jGvi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ws6FVLhWE8TagrhmcLrNf7cGpnLcwpXawyjXr/NbHW9SJWcpgBgfjXp13uaDVlRF97+x7FEUQEJZkWsrikNTqyVQ7g0d2g3Zqm5WmYOlrtAggdsX6JnWTTGS+39Roobx93FDsiasH16PIW2DaEDo71IHIfHupmeDZIgE3hnLO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqbSiwbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqbSiwbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7D1F000FF;
	Thu, 24 Sep 2026 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239344;
	bh=pGsh2jSC9D46z+3nLYcKrPgezVzDh4QNU+TYx3jGvi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqbSiwbZaL3gC+67QEL6nfvSJQVNHs9KHcICRMwZ1t3CrMZr8wGmYe84n/A/t0ltc
	 WDORSOdjntA6mXBY94R79yfKEh3svT1xfZr9j/iMzZvgSrmTZoJ+4Er6K7FsTeG9PG
	 ivDlWwNlOp4rLLsA8nKPdHb5Xntbmvi86PyXHH5sdPU4OiFnFYD9mV3pZyGPtOkc66
	 Eh5MX7cSk8j5PbfAbf6oeenjXjQCoOVsSEYb5UVB7SPRHnkxqp/PkKhc9+2qHfyCfz
	 ddjxX+70exU+kNBcXOVwm4VZDYJi4mzzwMOHjqQL6p4P329YEQuLvtGqpKDKDWQxyM
	 NpKowqn+8ovaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: imx6: use regmap_assign_bits() for
 conditional set/clear
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260924083429.461746-1-peng.fan@oss.nxp.com>
References: <20260924083429.461746-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:42:23 +0000
Message-Id: <20260924084223.ACC7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Replace multiple if/else blocks using regmap_set_bits()/regmap_clear_bits=
()
> with the simpler regmap_assign_bits() calls.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924083429.4617=
46-1-peng.fan@oss.nxp.com?part=3D1

