Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3E449B03;
	Mon, 28 Sep 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614752; cv=none; b=usEx9gJLpJi2MaOpzsCESGjZwm4pRR0rgXrOKehlFgOlrkrggvCyDmd7g4QK+rbcHwrLStoWTP0FIVQL1UGSHKDRbEZdQcu1LhPTj0hrLwKO8CVfCY3LLt3+nR8CivlBYTBuIpkusZ0B0SJthDVsalpNYSJ8HejB1a47pj+VObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614752; c=relaxed/simple;
	bh=P6sPkzemuhSTc03gymI3YweEYDiokcGfNfOHjRjVAbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WVA8blj7VHrODbyr0LuLKniFUGHtg08a6wb4eYOf61jrxUSMu7SGgfy6jHY9qetAgdRl1/TKRa5ND7leHAhZRT+vj2dLEZTpgg4yGeGoqiLcgiEAUzhvGZARHAFsmA/aYqiKnXyAwuIK9iRR0jrMb9aNYPLUO3d0UJI//jO8/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9bI3H3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW9bI3H3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE28F1F000FF;
	Mon, 28 Sep 2026 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614751;
	bh=P6sPkzemuhSTc03gymI3YweEYDiokcGfNfOHjRjVAbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GW9bI3H3pGN9+TvCqUCGXTAasFlRL500tL9hQZSYFaz/V19jcyEfq1NGpsTi1ZEWj
	 yKCwJZUXtTR1qymJaK8v73F5ZoijWzvpYi+7pXCFPD4Ka1MKP+1ZDseFLN1eE5B6ie
	 AdKdRwxzDhC/+nZ7psC7OEjuTIPnfCXQs/wb8SdDJ2M5SDPyDXzBZ7CXu+gi6EYfen
	 D/XGv/s5V+kR9YFGxQ1liuBjyX0g7jfEj/OaCALAQ/SlXrsWuQylmBkQk5Ws6dxv9i
	 W/THiKtwAwt8uaXgrGdE1dp7fqh/Z8d562a8m2HHiCkSS3rqdXxKId+mFmL0WZeQP/
	 rTSndaVkff8Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] PCI: dwc: Let glue drivers hide the Root Port
 MSI capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260928165230.3397664-13-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:59:10 +0000
Message-Id: <20260928165910.AE28F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D12

