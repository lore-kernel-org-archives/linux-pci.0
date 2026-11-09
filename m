Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226408;
	b=hTWllrakw/2qn+1NH9hPTiyO6zFa3Ho45dGsfrLFHxlP2jSZ1oW/CXJ0k861JPKhcbvr
	 Yx0hD13rgmrsBR4S3w5pSWMezNJMxkd22X58SrOvvlO71sppNbBO3Ui5D/9f/9Jus8TsH
	 QDJQ4CdTH2y1Cu/8zMBkXc0Skc88mJWifgR9PVFv3p9RAgiEiBBaSZyjNxLjJPo8S0vcO
	 4od2JCQeIeVR2uSjO41FQfwZMR3FHSiJ9OEIDF5BbQ0IV6UCJMSgXCp2IvGMES7IBYhxe
	 z7tcjs0hiXb11Gpr9UQZtoFGVsfeC3rXzH2FbLZgkg3wlv3kHAFRSxcqIzAv2ektY1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qITtytVGLqK87RsR5G5JxyNANpXf1zphBq/N3WBABCs=;
	b=xW2tAnsRwFgzPJGnjeMyvns31rKm7bRH0MdnEfDL8xCawB8W8M0C2SsZwyRB+l2zROwg
	 rZh+KIFmja3ly44ssI7hU3vrPi6wGCVjKu+EMikhPfdbTAl2ELD9nxBTGQWTjHBfVMOur
	 fADiSpnZlK3T6l8UFud4oRXWXiFY2wLTC+CE+B9wbaVIeR3NZS7k5dV+NJX3D28r2pk1g
	 gcbIiqHGkSAQ1DuZWp8WHLWRpTbJNNgbY28hRTpVRFOajHs0HRFog8Pv9m5+6V6RAXSDz
	 emhpuarewExp/64sWPIL0YEyJdRYiZ4FxM/oQHmD+3BEgbXTaWyh7Zcy8bnA1moJtFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8hky+Mu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36F606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8hky+Mu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE25B1F0089F;
	Mon,  9 Nov 2026 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226408;
	bh=qITtytVGLqK87RsR5G5JxyNANpXf1zphBq/N3WBABCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8hky+MuQio2pqBZ+j4eAk5yNs8rvJXq1ufqT+hEUZBzpoCjuvUZ8PXaiLnPt5mJ4
	 G81rNRVbOfdsrKGZjtKnIKFhjg3invNrJB/cprNKYuvULaNYNxP+Vm7q4GVpi6bUeH
	 M4U5NHtn4ATc8/Lk/RsW1o0hBHs3eVmm1chOwgT4Gi56s3Kc7UqNjDg5hH3Rc3LF43
	 Vfd4fSlcIDVvmVDyWBkgFBj+jGFWmHdfwmOS96Wwgk2lf8zEgCoaWkeWBWGR+lMUyr
	 B8wyVlChIIf2Nl3KMrFy/4SZQBJ2L5OIFBLUr6GBSA2m5PNFIeJRVA+/d3pzcyYsla
	 OgJgcIfpXpW9Q==
Message-ID: <sashiko-outbox-204918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: aspeed: Drop PROBE_PREFER_ASYNCHRONOUS to fix
 enumeration race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jacky Chou" <jacky_chou@aspeedtech.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261109-aspeed-pcie-sync-probe-v1-1-71cc9e718623@aspeedtech.com>
References: <20261109-aspeed-pcie-sync-probe-v1-1-71cc9e718623@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:13:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI: aspeed: dropping PROBE_PREFER_ASYNCHRONOUS does not fix
  EP probe order
--

commit 0a5273357bc4c6f662270192044fe2acfee34187
Author: Jacky Chou <jacky_chou@aspeedtech.com>

PCI: aspeed: Drop PROBE_PREFER_ASYNCHRONOUS to fix enumeration race

This commit removes PROBE_PREFER_ASYNCHRONOUS from aspeed_pcie_driver so
that the ASPEED PCIe Root Complex driver probes synchronously.

> diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controlle=
r/pcie-aspeed.c
> index ecb7562f84c01..def5591010cac 100644
> --- a/drivers/pci/controller/pcie-aspeed.c
> +++ b/drivers/pci/controller/pcie-aspeed.c
> @@ -1104,7 +1104,6 @@ static struct platform_driver aspeed_pcie_driver =
=3D {
>  		.name =3D "aspeed-pcie",
>  		.of_match_table =3D aspeed_pcie_of_match,
>  		.suppress_bind_attrs =3D true,
> -		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe =3D aspeed_pcie_probe,
>  };

[Severity: Medium]
Does dropping PROBE_PREFER_ASYNCHRONOUS from aspeed_pcie_driver actually
solve the endpoint probe ordering problem described in the commit message?

Registering a struct pci_driver before the bus is enumerated succeeds and
adds the driver to pci_bus_type; its probe() callback does not run until
aspeed_pcie_probe() finishes enumeration and pci_bus_add_device() calls
device_initial_probe(&dev->dev), which binds any already-registered
pci_driver even when aspeed_pcie_probe() runs on an async worker.

If a consumer instead looks up a pci_dev directly from an initcall or an
on-board endpoint requires another driver to run before bus enumeration,
removing PROBE_PREFER_ASYNCHRONOUS still does not guarantee that
aspeed_pcie_probe() runs before late_initcall: aspeed_pcie_driver is
registered at device_initcall via builtin_platform_driver(), and
aspeed_pcie_probe() acquires resets, clocks, and PHYs (h2xrst, port->clk,
port->phy, port->perst) that can defer probing via -EPROBE_DEFER or
fw_devlink until deferred_probe_initcall() at late_initcall.

Meanwhile, forcing synchronous probing serializes the 10 ms mdelay() in
aspeed_host_reset() and the 100 ms msleep() per port in
aspeed_pcie_port_init() on the main boot thread across all RC instances.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-aspeed-pci=
e-sync-probe-v1-1-71cc9e718623@aspeedtech.com?part=3D1
