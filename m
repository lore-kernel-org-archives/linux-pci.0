Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431F5908DF;
	Tue,  8 Sep 2026 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887205; cv=none; b=p1nBVffRwMyEfXPHjHgiBbprGr/j6FW3j50zXzoQDNbzAZNp5i+Lv/tvfOpeV7icwa/OuAMjXkQCub5UAOfAkaihbsMvZKAsF9Hu7XGW1erMwtTJOzLySDn7/hy79MRLJYyhwd56+oSDaPVGN+/cW0eJmkHob+xhEnhght+E0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887205; c=relaxed/simple;
	bh=E1dNdQgRqqk76Z0nhaU8EKNr8rpBu18mj6MogqsDG0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azty2/H3KxnQjRmqU4oogbmSIjeqM+KDYqDsRITaplXlW1vpWSf4rp63Rwo6qFA7Dls2c03rdCJsBB+fLkbTlmVhRditD7j909tRmCSR7wWU+hcytsTopQYEt278OtxEyRTt3lxCDBvgPJoEZepzBj8wMARhIozoZtbVD82et9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQPo6DFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQPo6DFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8731F00AC4;
	Tue,  8 Sep 2026 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887203;
	bh=38bwpambViT0MnnBb2GI/7dRI2ETNBZiZHIv1W6afuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQPo6DFXRFj1ivp5h5rWR4z8Opo+G8U03TFxEDPO04SrHviHM2VBY1HT8KfJuMQgo
	 Bw9ic8jEWEtTztCciZIJIKtQrS8jWYejvQE6A2EixP7wHioCyiwtLz/e3Im1qkXid2
	 p27lN43OXgpnni2XaDzTuj5Q2mR/vyK6KRCqfxZirXOG5yMTbeyL/hgzmd5blocP5H
	 ot5wWgxiaEqlPz8t0OE7+bk7uYOt7qbrtSYM17tZjc94s4KAUz/wjCCkusemrkHuM5
	 kn56WmXMIxoN5nPnuuvRFpZjcjugzB7KCmJsGvpY/iQgu2OLd6FCvzWR4XxaMEnChJ
	 r8kdCLeTTlxsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260908170035.160166-3-mario.limonciello@amd.com>
References: <20260908170035.160166-1-mario.limonciello@amd.com>
 <20260908170035.160166-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:06:42 +0000
Message-Id: <20260908170643.1C8731F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.
>=20
> The issue is actually a problem with BIOS configuaration of PCIe
> root ports, enabling a feature that causes problems with 64-bit
> DMA.  It is fixed by adjusting the kernel adjusting the
> configuration of those root ports.
>=20
> Cc: Arthur Husband <artmoty@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908170035.1601=
66-1-mario.limonciello@amd.com?part=3D2

