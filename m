Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804868;
	b=VTSn7Z3uAM869CbGgSOK/ebeo5oJPKHPThRiiPl3Z7wz+5v4Ue2VeQpKp2nSSdZ0dEgD
	 XJ8Un0AzNKasdkj05671yiLSwoD/cUY7e6JwF1R55MZZxk4DGBYsnliDxPsLs0AYpENw8
	 Kxf416rwY6/+C91aQXHrm+30JNy3zDpP/AYq2cGjRrVChp0G69FxsoxTVaAJCVUVG3b7j
	 43LrhTsoHCLDUnnSWOmjQv/uxlrUmitSzWlEaM2pi3Tv4KHYqJKHsqJYXp6zBIfG2pb1p
	 g1D02x4Zzo43IR7Opm5Ip2WVRxzYZMbQQlRX27jzGmxM+QJGiJylBI/8P75Nczk0BLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WgZjb4C+PBO6nkPCQGqvAnhUauN4zs0m1JFjI6msD1U=;
	b=s9P+50qwhxXWacfsQTGnHOKKfapNDGMW8U4qY4SnT7sSpT2c3oVPVqPm1PxueYabDXAp
	 L1e28zYERpst6k1gTgd2t5g08gNq3UpZscXr1DNAEZ9I2X/LyruXImbhSRk/VBT0Mfl/B
	 yHMW34jHCUnQmCEgpzJHrraECLNGgM9qRGK0Y43ehyG+VBoQoxB9Qv7o2Hs4ng8Sdv40O
	 r3a4gOFAndrLCl63Ijsu+14vcjsJ1wQg5u5GNTRf+CuFehjJ0R9ZyW2s6x7/B5uJZhKwW
	 RhPQnlRJskjG5M3NIhzyr8phVxNvXUORbx04h9lYb2qUz2Bf4ecluM/HVSmQ6mCWQaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+ArEAxq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB171606A31A
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+ArEAxq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECC91F01825;
	Sat, 24 Oct 2026 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792804867;
	bh=WgZjb4C+PBO6nkPCQGqvAnhUauN4zs0m1JFjI6msD1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+ArEAxqTDkKq/SiXTsaKveHMMohn7eiHujpDYzND+o5NHr0S7egpd1BDtRmwwGvx
	 LLlAckVEqj4XbM5hfs/xA0EfdU6eFFjRowsc1F7F0OnfQfKdzMi9KgcFYfdQy/ZBko
	 uGmwMbowpOmrEe2TZ6cbZAAsGgQtVPgGLskku/11FtGLFH9Cv5vW3T//Eg38AZF+YT
	 OH9b4VCsdea95L79rq2Elxn+z2mbLFQ7SyKqAsB7nVzSizE3JTlKG0/bLNnPPmht4H
	 UmYvUMdwJEKQyryq/JyN76Z0CAUmi3PZBOOUyT2STGFFjfrutM87Rk2o8+keo0fU9D
	 GrSrn30H/Nzxw==
Message-ID: <sashiko-outbox-183487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] PCI: rockchip-host: Hot-reset the endpoint
 before using the link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261024-rockchip-pcie-resume-v1-2-58e54a5cf5f1@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
 <20261024-rockchip-pcie-resume-v1-2-58e54a5cf5f1@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:21:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PCI: rockchip-host: PHY lanes powered off before hot reset in in=
it
- [Medium] PCI: rockchip-host: PCIE_CORE_AXI_LINK_DOWN cleared before 100 m=
s reset wait
--

commit 4a844e565a69f3a1a297df4c2424b03cd25ab7cb
Author: Igor Velkov <iav@iav.lv>

PCI: rockchip-host: Hot-reset the endpoint before using the link

This commit adds an endpoint hot-reset sequence during probe and resume
after initial link training, holding the reset for at least 2 ms, waiting
for the link to retrain, clearing PCIE_CORE_AXI_LINK_DOWN, and waiting
100 ms before configuration accesses.

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index b4499fc3f90b1..f75c2c8358f5d 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -400,6 +400,57 @@ static int rockchip_pcie_init_port_retry(struct rock=
chip_pcie *rockchip)
>  	return err;
>  }
> =20
> +/* Hot-reset the endpoint; *link_us: time until the link came back, 0 if=
 not reset */
> +static int rockchip_pcie_hot_reset(struct rockchip_pcie *rockchip, s64 *=
link_us)
> +{
> +	u32 status;
> +	ktime_t start;
> +	int err;
> +
> +	*link_us =3D 0;
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_HOT_RESET_ASSERT,
> +			    PCIE_CLIENT_HOT_RESET_CTRL);
> +	err =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INT_STATUS,
> +				 status, status & PCIE_CLIENT_INT_HOT_RST,
> +				 100, 100 * USEC_PER_MSEC);
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_INT_HOT_RST,
> +			    PCIE_CLIENT_INT_STATUS);
> +	/* Hold the reset at least 2 ms, as pci_reset_secondary_bus() does */
> +	if (!err)
> +		usleep_range(2000, 3000);
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_HOT_RESET_DEASSERT,
> +			    PCIE_CLIENT_HOT_RESET_CTRL);
> +	if (err)
> +		return err;
> +
> +	start =3D ktime_get();
> +	err =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATU=
S1,
> +				 status, PCIE_LINK_UP(status), 20,
> +				 LINK_TRAIN_TIMEOUT);
> +	*link_us =3D ktime_us_delta(ktime_get(), start);
> +
> +	/* Clear the AXI link-down status before config traffic, as the Cadence=
 host driver does */
> +	rockchip_pcie_write(rockchip, 0, PCIE_CORE_AXI_LINK_DOWN);
> +
> +	return err;
> +}
> +
> +/* A JMB585 sometimes comes out of reset unable to answer config request=
s */
> +static int rockchip_pcie_reset_endpoint(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev =3D rockchip->dev;
> +	s64 link_us;
> +	int err;
> +
> +	err =3D rockchip_pcie_hot_reset(rockchip, &link_us);
> +	dev_info(dev, "hot reset: link back in %lld us, err %d\n", link_us, err=
);
> +	if (err)
> +		return err;
> +
> +	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +	return 0;
> +}

[Severity: Medium]
In rockchip_pcie_hot_reset(), PCIE_CORE_AXI_LINK_DOWN is cleared immediately
after PCIE_LINK_UP(status) first polls true, before
rockchip_pcie_reset_endpoint() sleeps for 100 ms in
msleep(PCIE_RESET_CONFIG_WAIT_MS).

In the Cadence host driver, cdns_pci_map_bus() in
drivers/pci/controller/cadence/pcie-cadence-host.c checks that the link is =
up
and clears CDNS_PCIE_AT_LINKDOWN right before config accesses:

	/* Check that the link is up */
	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
		return NULL;
	/* Clear AXI link-down status */
	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);

Here, neither rockchip_pcie_reset_endpoint() after the 100 ms sleep nor
rockchip_pcie_rd_other_conf() / rockchip_pcie_wr_other_conf() verifies that
the link is still up or clears PCIE_CORE_AXI_LINK_DOWN.

If the endpoint link bounces or retrains during the 100 ms post-reset
initialization window, can hardware re-latch PCIE_CORE_AXI_LINK_DOWN (or
leave the link down) so that the first subsequent config read in
pci_host_probe() or pci_power_up() still triggers a synchronous external
abort or SError?

[ ... ]

> @@ -908,6 +959,10 @@ static int rockchip_pcie_resume_noirq(struct device =
*dev)
>  	if (err)
>  		goto err_pcie_resume;
> =20
> +	err =3D rockchip_pcie_reset_endpoint(rockchip);
> +	if (err)
> +		goto err_err_deinit_port;
> +
>  	err =3D rockchip_pcie_cfg_atu(rockchip);
>  	if (err)
>  		goto err_err_deinit_port;
> @@ -965,6 +1020,10 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
>  	if (err)
>  		goto err_vpcie;
> =20
> +	err =3D rockchip_pcie_reset_endpoint(rockchip);
> +	if (err)
> +		goto err_deinit_port;

[Severity: Medium]
Both rockchip_pcie_probe() and rockchip_pcie_resume_noirq() call
rockchip_pcie_init_port_retry() -> rockchip_pcie_host_init_port() before
calling rockchip_pcie_reset_endpoint() -> rockchip_pcie_hot_reset().

At the end of initial link training in rockchip_pcie_host_init_port(), the
driver latches rockchip->lanes_map and powers off all unused PHY lanes:

	/* Power off unused lane(s) */
	rockchip->lanes_map =3D rockchip_pcie_lane_map(rockchip);
	for (i =3D 0; i < MAX_LANE_NUM; i++) {
		if (!(rockchip->lanes_map & BIT(i))) {
			dev_dbg(dev, "idling lane %d\n", i);
			phy_power_off(rockchip->phys[i]);
		}
	}

When rockchip_pcie_hot_reset() then issues a hot reset and retrains the lin=
k,
those inactive PHY lanes have already been powered off, and neither
rockchip->lanes_map nor the PHY power state is updated after the hot reset.

If a multi-lane endpoint (such as the x2 JMB585 on Helios64 or an x4 device)
initially trains at a degraded width before the hot reset, will the powered=
-off
PHY lanes prevent the link from training to its full width during the hot
reset? Conversely, if a lane that trained initially fails to train during t=
he
hot reset, will the newly unused PHY lane remain powered on with a stale
rockchip->lanes_map?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-rockchip-p=
cie-resume-v1-0-58e54a5cf5f1@iav.lv?part=3D2
