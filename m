Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127953D0B6
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957272; cv=none; b=b+1fSRdZxPl5KyhiAWIX66qDZCAGjhrsnagP2sfOma5PVEqXTM/NT/BSKJrQuW0MKBVRPBouPezlbW6ePkxxUecwvMeYV9nfhRxkCOV4DRKY2iOLRQw4tfBIKBWp9Duu4l+6aChqJggFWFZGYZeJD+Fl+RW9CLlYtChTn6MVe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957272; c=relaxed/simple;
	bh=PECijMhJxVwwEtk/I6vDc2K8UTmQiuQ6KHMVK2Ix4Mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lq4obCBa8op67TiGimoxtOM4kSQt919/8CjgDEJmWWmST7AMKmHo8SQ/VbdQizlAntdl7YDzfHBxwiFZeEbLY3L+/1Hlya7em2673HwvN2dkLMpNEFCZnZYOT/sHWX48zxTzt59wBdipa6ht6kZVDdtjI0eAj8WxEzmXOExTiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFzOSZ/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFzOSZ/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7557B1F00A3A;
	Wed,  9 Sep 2026 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957270;
	bh=PECijMhJxVwwEtk/I6vDc2K8UTmQiuQ6KHMVK2Ix4Mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFzOSZ/zKjLDa5gAjK1FTxQU2/lmRX8KczvZf5zbYbHiyuzyWZV4iYQCSAxpw8qAD
	 8parp4CeYPBlRF6sHzU/8SWNjnYgj0PqoZalywwGYPL0w3sQn/Pvok7evmvsT2uqWf
	 fJ0EhlYqI1L7Pgy37h3KiUTzsk7BR1iTuCN4diLVgjmCeB9LG5iNuoBFWuSLsAuac/
	 MXnzWxx1W48eI9Zebe4KPimofVeEBcODdAgVZmAE+Zg/deAtCrXgUMjp1mvtoO7gE9
	 hOFoke5cnMpAxGJbt+bAlZls6NAYM+emj7GUZdLMbny3n6qYHPpM123YmfZh6rYIDU
	 EghUgD/K+P9Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909-shutdown-v6-2-62b7bd123236@oss.qualcomm.com>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-2-62b7bd123236@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:34:30 +0000
Message-Id: <20260909123430.7557B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
> to check whether every downstream endpoint can be put into D3cold before
> bothering to move the link to L2. If no endpoint supports it, the
> function returns early and leaves the link up.
>=20
> Querying D3cold support during shutdown is actively harmful, not just
> slow: pci_host_common_d3cold_possible() requires every active endpoint
> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
> is still in D0 -- which is common, since endpoint drivers aren't
> guaranteed to have suspended by the time the host's shutdown path runs
> the check fails and dw_pcie_suspend_noirq() returns early without ever
> moving the link to L2, leaving it up right up to the point where the
> system cuts power/clocks to the controller.
>=20
> Add a force parameter to dw_pcie_suspend_noirq() that callers set
> explicitly to force this behavior, still call
> pci_host_common_d3cold_possible() unconditionally, since it's also how
> pme_capable gets set, but ignore its return value and force L2 entry
> regardless when force is set.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-shutdown-v=
6-0-62b7bd123236@oss.qualcomm.com?part=3D2

