Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADB4A5EBA
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962612; cv=none; b=PUDtdmcreZjtDj3CRnu/JHPa/4VAwyGVp2uPeVe6owFJRsl34jqpAgC+kTjOnHpcrDpytEzu6MvDKRulWVUcR+oHESE/AUQw3AiqgaFmpucwHufFjpU5Ybx49qK4kjBlnZ7Kdnfn3dAMgMEHS1lGmb1/r8jfCIdN7skGCvFUX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962612; c=relaxed/simple;
	bh=Xk8nokU1Lk36Sv0KyOZtMXEuqS4Yfg7/zt82o3LzDT0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A4WnLjVGJM0yFaNcaGfsWSb0vKt+KFredzpZDAw16qqh0/WBuwruXJLjQHjWV7gY66f+AuTrbOQPZYUxh3sVhnXxrGCmpo5qqriFXGjTMMORWfrZF0UtR8d+9HhqLaUq0Q+v7SYH/1YePy9/ZxgVp7HFfJAJM0M8QXyHLeqK1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wne1zTvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wne1zTvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670911F008A1;
	Wed, 14 Oct 2026 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791962609;
	bh=AAigWs1FZhvyk4pr9ANuX0nlWGu4Qwxx5jFD0wPgTxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wne1zTvt76UTmkcCC6PA3OnxgQDbnZ0V/V6xVh8VxEwXal1GC+GtSpyAELbQyLDaq
	 TXIKmHqBpK+RBehaR/dU6fhPb72fmAm9mjGsqOGJ6nlQUXHBDOFkN39/e7PMrVdBOC
	 aYkrbIXlr1tFR5jMYJN0f6Yt58ptTVqvylkkhdizos6P6yKsUa/0+JN3LQqt7c/OZi
	 LEcHqITgvIhEIRIDrsdocAQEsRk2uYTWDzN/8KOTpUKJPrlhnNO7kF68Zs29Ly7PSB
	 qMV9Dq0e73qFIjUy4QpmllwcC+R/r0EtWWhkxzMKYOwEaSc861HgEN0WV6TWEdTILl
	 7f0TK0wvqZ5uA==
Message-ID: <sashiko-outbox-170936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261014071448.2473208-1-den@valinux.co.jp>
References: <20261014071448.2473208-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 07:23:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The control-region link status is currently updated only by
> COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> NTB link callbacks are empty. Consequently, the HOST can see the link as
> up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> leaves LINK_STATUS_UP set without notifying either NTB client.
>=20
> ntb_netdev can hide this device-level state bug because ntb_transport uses
> a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> device link state directly:
>=20
> After bringing both sides up, start one waiter on each side:
>=20
>   HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
>   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event
>=20
> [ ... ]
> With this patch, peer0/link changes to N on both sides and both waiters
> return.
>=20
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and =
EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014071448.2473=
208-1-den@valinux.co.jp?part=3D1

