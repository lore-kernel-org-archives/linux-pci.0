Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955D3BBFD9;
	Fri, 18 Sep 2026 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701888; cv=none; b=YlxvVkvE2CEHDPda48IKrKTFtyOm+9ki+ulwWzU7o0llhPz7E9pL0lxxmlwM/TFuN3QWLrx5drPHhE6WDXV+u8GTjl9MypUAwBkikKjoeFGYXmmOs3MQHybGRsrt3rVFASvpOD/p+faSfXJvsHObiMqrCS547NoyW1QwfHu9wJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701888; c=relaxed/simple;
	bh=Zd85IjzkXBz8cIY1oXwsburQngP1P3LTrX3UgCD6/oQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c53HWYLv+V1cgVvxifcrYh/7jl3KXKmWv6Ef3sf82eWm0dzATWEeyWFpJpi0bmvoM0fUAvqFkAhm1Co35sicy8a3uagwQJbGnRJaeMoR0xKVRF0Vgr6PfZ/oDeaRxQfrCGWfI+Zvjl/85lE70/irHHruH8MBsI/vCMFBaThQFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVtwB7e8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVtwB7e8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815351F00893;
	Fri, 18 Sep 2026 03:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789701886;
	bh=Zd85IjzkXBz8cIY1oXwsburQngP1P3LTrX3UgCD6/oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aVtwB7e8YP0Q9Qwq+hFAT1a6ikqpNOvBmwlBHHDREVLKeqywP7pWlgoDnE0/3DjD3
	 uh2tstaArJ2JIr6RUsfp3TqsC2SwgYFQGZpu790wSOwFUO/fH4DHcABJqw/xF5uZBl
	 a2lVFCdhmL08DbOC2YR6d6NNBSC9CJEYZR4JUncXEtgce0dM4op9sGwvQ/GpTrZh7v
	 shghKgIG3yJa0PaKUSizCSWWA/XRYiS27gHwCJkxa9tVAuhYdnQaX+fq/C8JK8AKJV
	 A4thbtka4YKm92vc6AsH2B3ZAXQkP2EfJxixn4kn22HTmc1kjmC6mW6krY17pYasmw
	 HLu9Spk5Lx9RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] PCI: dwc: Let glue drivers hide the Root Port MSI
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918032038.2216471-9-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:24:46 +0000
Message-Id: <20260918032446.815351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> if iMSI-RX is used as MSI controller") hides the Root Port MSI/MSI-X
> capabilities when iMSI-RX is the MSI controller, as it cannot receive
> the Root Port's own MSIs.
>=20
> Some platforms cannot deliver them with an external MSI controller
> either. The DesignWare core signals Root Port interrupts (AER, PME,
> bandwidth, hotplug) as sideband signals on its SII interface and only
> turns them into MSI writes with the optional SII2MSI feature. Otherwise
> it is up to the vendor wrapper. R-Car Gen4 (DWC 5.20a) appears to lack
> SII2MSI, and its APP block merely latches the signals into status
> registers wired to platform IRQs, so an MSI targeted at the GIC ITS is
> never sent.
>=20
> Add a no_rp_msi flag so glue drivers can request the same INTx fallback
> regardless of the MSI controller in use. It is the counterpart of
> 'keep_rp_msi_en' from commit 3a4e8302e72f ("PCI: imx6: Keep Root Port
> MSI capability with iMSI-RX to work around hardware bug"), which keeps
> precedence: that one is needed for endpoint MSIs to work at all, whereas
> hiding the capability only moves the Root Port services to INTx. The
> removal stays in dw_pcie_setup_rc(), which also runs after a Root Port
> reset.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D8

