Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247784;
	b=0GhfdK3CpCRcYRHqwqwBuN1r4uekdgyr9yCT2G+z7A65LI3ZU8BCG7vkF7XdWq8nWJk5
	 34diNQvGVvg0377R+vXT40N3oMcBObHjB2x3kQp+3Mzg31Jj/7RKZ1h/K5UUIgCbNhon3
	 v3TNqDo9TVV8BjU4bujy+Tp7r49MOLB1GP9FeuiNziMfIf2b7FR5tgkT+njRW1ymmx+Jp
	 ttmtOgPxkC4goWaDy/p8Z6114/5wT/coY8ZMvpAdrNkjgMtQ1WFu8TZVNN3VC4vAjRj54
	 U2jjXQzTY2AnUneJC5MkIPUbkJrvCU4cTSHkOzpSN8K1CXGHVvvW/O7uy9FStUoHHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yTptKuKaUnuYj5NwAdPY/s2yUI1EI4Y7JFGvJfVMmnU=;
	b=Yy7wpLkWwr/xBDWfva2L2A7imi1xgDKjwZJPY5Dt83PRFw7V0XJx2/kndnqhXBEXDyJw
	 XuD/1yf7q7JTaMK6OMli4/d3VxTGMkvSTawhZ7k6ZkuQVCqM2wG+dE1PLLoer/oRk3bnj
	 CCMxbCbIiWF98OFetnPnLv6tiVTrRYNI5Yaao/+o9AXA+XXFIEEEsPFCJ+aIbMPblfWFx
	 tYZ+WfpEuf4QKRa7V8S7VeNWK9hPK3l5cYywSW8937C8jIaGzT2u+oy0cUlXvgHHtaZFI
	 PxEBqUvWNsw7rOUmDNs9kgurd9uUovDtrjJRZFSfqShbX5AOde/KvBev/HB/hDsIBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbJAVAdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D5606A320
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SbJAVAdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7631F031E0;
	Thu, 29 Oct 2026 04:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793247783;
	bh=yTptKuKaUnuYj5NwAdPY/s2yUI1EI4Y7JFGvJfVMmnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SbJAVAdiHvPOYxMs9p9Bn0692ClIrToSwDvyTUhe9m1TK4UYkLjVROm2Zj8VMPLzt
	 z/1AOlh/RTlJSCbLl2RZRDFbF21vN4FR57sJqHopXM5+wfswQ+ak95SmK4j1kMwTHk
	 lZluaaDpQP8cATw8IcLxGSyt8yNGNoOx/4V/YPYE9aYLAnR2uGjPLsn61IJWSn00zQ
	 Da+a7pNhCEqqybK5kKpSM9lYx8R0dkxiLjcRHeAa5PXJlbvsZzbAUrDT9xepiPoqzI
	 85JMnY0ocQiKuvsvXI3ZWVPo1MANedkSZfnVj8lDa2ZyWKQ985YLMhmL4I7wcFAmqi
	 MhQaK/BbKX+mw==
Message-ID: <sashiko-outbox-188697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-shutdown-v7-1-3fd7a76a6991@oss.qualcomm.com>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
 <20261029-shutdown-v7-1-3fd7a76a6991@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:23:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> __pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
> downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
> the walk as soon as its callback returns nonzero. Any device enumerated
> after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
> capable endpoint -- is then never visited, so pme_capable can come back
> false even though such a device exists on the bus.
>=20
> Since pci_host_common_d3cold_possible() already returns false whenever
> any device disqualifies D3cold, aborting the walk buys nothing for the
> plain suspend path: the overall bool result is unaffected. But it
> silently drops pme_capable detection for any device ordered after the
> disqualifying one.
>=20
> This matters for the upcoming shutdown path in particular: unlike plain
> suspend, shutdown forces the link into L2/D3cold regardless of whether
> pci_host_common_d3cold_possible() itself allows it (see the following
> "force_d3cold" changes), so at shutdown time it's common for an
> endpoint to still be in D0 and disqualify D3cold while a later,
> PME-capable device is never visited. dw_pcie_suspend_noirq() still
> uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
> result here can cause Vaux/wakeup support to be dropped for a device
> that actually supports PME from D3cold.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-shutdown-v=
7-0-3fd7a76a6991@oss.qualcomm.com?part=3D1

