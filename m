Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC33A425B
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798814; cv=none; b=I+OL1M6A4cqNJmVTAuXHbH3BVFu+FhelX559BkV36N+Xbzp31zzXLo+zhlRrLI9/1bWrJIZlpFP7zY9kgj0JTLk/r8F8JE/96tLHtqbgDEZJiT3kS3Jwv5/4NfLtBqncp1vN1LYXg1wJYTDeO8bDM/xAOi5BRQSCDYqpL3pmGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798814; c=relaxed/simple;
	bh=iIRsrQXhCMvxrrmtZbaALV3xhE1L1fkq/C5ZSH6FQj0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Etx/DTmxrr21U66iDO9OqnKmjpnUlsNPgvVyKXJbOorOMziDlB5ViqXOyDqz+fLKtNnEVZ+UytBtXyBWt+kwe/qJDmh9zO6xhiIlJ3uQhDoB3wgolS/B1yUwqlvRXKTo0H9AAxqrtBDdYANzKQkOFqkKt5MCkTt8sjvttdX2s+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0w8xIpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0w8xIpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6081F0089B;
	Mon, 12 Oct 2026 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798803;
	bh=iIRsrQXhCMvxrrmtZbaALV3xhE1L1fkq/C5ZSH6FQj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0w8xIpcXTPMQGLM29B2jH+V+Q/x6kD/eehtcDzeEyVsr5wc2VJxMzoaAKeaduIn6
	 ByWHgDrP0UHhm0kqGvc2Avbm6XTTHJU9Yaq06X6moSac29ENKvU30M3cW5NqDwSB7Y
	 AQUXFT6zeGu/0xX4VKNTwq5ZCfims2nnR2nyXz41A75a0F1WeKPG2VRK/AnH/FO8Ir
	 1RC/83PWnlRmvrLHnivasbNphNcPmB8Z0IG4ZUkdG41xCzVK+4HowMnzGtewUmQbIh
	 oLeG5/VL7pN+m4ltL0oB3Jm1lNcxpIuQ1M+D3xaivx+DFDjEqZ0hkFMKcueOTj/E+/
	 gNacppoKmtiXg==
Message-ID: <sashiko-outbox-167911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra194: Propagate REFCLK select GPIO
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012094815.28160-2-phucduc.bui@gmail.com>
References: <20261012094815.28160-1-phucduc.bui@gmail.com>
 <20261012094815.28160-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 09:53:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> devm_gpiod_get_optional() returns NULL when the optional GPIO is not
> present, but may return -EPROBE_DEFER or other errors.
>=20
> The current code treats GPIO lookup errors as if the GPIO were not
> present.
>=20
> Check the return value and propagate errors from the REFCLK select GPIO
> lookup.
>=20
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012094815.2816=
0-1-phucduc.bui@gmail.com?part=3D2

