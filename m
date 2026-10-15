Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926E35DA47
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035448; cv=none; b=U7uauXRN2LUnM5/I8gAui5Cs9wDHV+v5sEfsHwLP4i6DTiRQSjbV7VNUtT8PvL9hSM9dHS5Zvlt0Z2TaHRuTAI8HeuCLFn35hn+j5WFUGpIBQ0dls9huOlC+GRtf6vHwLOMJWpOuo/11tg1gXAWNxwu1wi3miwTMVjE/LhqwS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035448; c=relaxed/simple;
	bh=pNCRMUr/S2JcPzPujri1Uw60mH4POWxOd5PmvzS2jGw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eaeqZi3JBgqxtu95TFQ6I8wQiYgeqYxcyVr4gM0KuWZfJ6OWWI1npvgDN+AVjYyWnXM0cSuymE+P0KNR6C+p0Jq02ov8aL5o2909NM/dV87K8b3P6wONsUmcbahfZ0+7Cwm9S7xpWXlD3TAxlcMO919LH5XWprlb0gShKKQm+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKumgtKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKumgtKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322AE1F000C4;
	Thu, 15 Oct 2026 03:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035446;
	bh=pNCRMUr/S2JcPzPujri1Uw60mH4POWxOd5PmvzS2jGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKumgtKRlvunk7ZQimqaP/v39+pCqIcN80CL1eHnUkyr93uI4vMyIHvqO9AyliwJU
	 wulhXv50nZRsaYUyc9UZNTv+maQ//YlafZUQm/S1s73kGAsBCr9BnwxxIfxgntHq+p
	 skzu939EzcMJrZg0qbHMX99N0uK/3uiawy3USvxQN+7x+WTWWoH+UYJbKgeTXlJQpE
	 HiL+v/K29zw2Di9S8F4zRhnI0yFZ9tpFxQR9ejyiL1qZe02WGbsnAIX6PqPZXv17CX
	 H48nNDTaaOklx1eVDSr2psHk2oGVOJ7sdi8eq0rHYXVUExxCU/yqNbkiP8K1ykNSqp
	 E9PS/kCWrGMLQ==
Message-ID: <sashiko-outbox-172205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/18] PCI: dwc: Let glue drivers hide the Root Port
 MSI capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-14-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:37:25 +0000
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
> it is up to the vendor wrapper. The controller on R-Car Gen4 SoCs
> (DWC 5.20a) appears to lack SII2MSI, and its APP block merely latches
> the signals into status registers wired to platform IRQs, so an MSI
> targeted at the GIC ITS is never sent.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D13

