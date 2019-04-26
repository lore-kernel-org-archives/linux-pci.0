Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797BEC43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489D7206C1
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oE2B6YFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZNWZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:22:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35492 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfDZNWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 09:22:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so4460699wrs.2;
        Fri, 26 Apr 2019 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TIAj3o8zfFXQ7i9AcKA4c22ULiJK3bQpWrZbS8lfSJY=;
        b=oE2B6YFzTMkmAx+1z2qBzTzcFlVhLNOAF5qQbt2ORM3GRiu3DlE+p1JiY0j2Tgfj/S
         Pri8k3Yd4i35KmAsZXUh7xXawFvXpCj8KEXiuyDzU0LUoZwtI/HVE50Nd1OgSY3A5Ipe
         obmbttoKw8iEIA+zHy3SmTBe0D/ACu/LaXTlH+gr7PYvD6G+i5cxR8WlTNq+1LAbGKa6
         uZJKIt3++lvvPrDA+LkdZdhc0zaTwoj2OXqvX0apqAghOv+l9Vp4RNa5GdR+FkcSKMZh
         p/WD6BaqVxdzwBN2+Y86h6MLGRYHfAuFtuLZrExuXsSXeYKJ41/GDEG6KR3eZhKiUAxB
         c/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIAj3o8zfFXQ7i9AcKA4c22ULiJK3bQpWrZbS8lfSJY=;
        b=lr3c2dRznL7FQYqnAQwHSsMWOux7IpTp31Wt+13nanRmASNxL/V9+Bf9lqno4d2zPi
         slm/hd4CXys8lf+dEnak8+wG7D0CEQ41tY9S1AWUq6acLKPh2yAypN0isXH27PvpHz3W
         PdkDJstBWHwdmeuti7ovo0ZpieXtedIuFndELoQQVYd0Vy8wHOD3b0+Tvd35tT7eEi3V
         hUBw96oY7P2KcTpjukC0MJlcYiTxMjPGezc5wgONVmhpiYxmlhEmiCmi/BVTzD2GBIZt
         P4xXQdD0X9/3dQBQX8d8GJE4thAIOldzUft2UTgatpGo3UzhXJoM6BibYPW2bYKA09bh
         QnOw==
X-Gm-Message-State: APjAAAVfIxh2g8HJNfks38RGu9md4oFC+Io2NtX2wINmizuB9RLzBHsz
        BFEIa2gp5bbwHsaI2ktwvG8=
X-Google-Smtp-Source: APXvYqwmYn/JS2uRKmyvnyALE6EgO5folnEZ+LBghaKICk+Fcpkqu0t6PN5bVp6GmrIFKcQoy4WpcA==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr5225803wrx.32.1556284942301;
        Fri, 26 Apr 2019 06:22:22 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id 4sm24174575wmi.14.2019.04.26.06.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 06:22:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:22:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 00/28] Enable Tegra PCIe root port features
Message-ID: <20190426132219.GE16228@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:57:57PM +0530, Manikanta Maddireddy wrote:
> This series of patches adds,
> - Tegra root port features like Gen2, AER, etc
> - Power and perf optimizations
> - Fixes like "power up sequence", "dev_err prints", etc
>=20
> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
> based Jetson-TX1 and T124 based Jetson-TK1 platforms.
>=20
> TODO: I don't have T20 and T30 platforms to verify this series.
> Thierry has kindly agreed to verify this series on T20 and T30.

I tested this on TrimSlice and Beaver. next-20190426 boots via NFS on
both of those boards. Applying this series on top of next-20190426 works
on Beaver but does not work on TrimSlice. I'll see if I can bisect which
exact commit breaks this, but it seems like PCI accesses do work, since
I see the RTL8169 device being detected. But when the kernel tries to
send out DHCP requests, the packet transmission is never completed using
an interrupt, so maybe something interrupt related is broken.

Thierry

> V2 takes care of comments from Bjorn and Thierry.
>=20
> Manikanta Maddireddy (28):
>   soc/tegra: pmc: Export tegra_powergate_power_on()
>   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
>   PCI: tegra: Rearrange Tegra PCIe driver functions
>   PCI: tegra: Disable PCIe interrupts in runtime suspend
>   PCI: tegra: Fix PCIe host power up sequence
>   PCI: tegra: Add PCIe Gen2 link speed support
>   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
>   PCI: tegra: Program UPHY electrical settings for Tegra210
>   PCI: tegra: Enable opportunistic UpdateFC and ACK
>   PCI: tegra: Disable AFI dynamic clock gating
>   PCI: tegra: Process pending DLL transactions before entering L1 or L2
>   PCI: tegra: Enable PCIe xclk clock clamping
>   PCI: tegra: Increase the deskew retry time
>   PCI: tegra: Add SW fixup for RAW violations
>   PCI: tegra: Update flow control timer frequency in Tegra210
>   PCI: tegra: Set target speed as Gen1 before starting LTSSM
>   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
>   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
>   PCI: tegra: Change PRSNT_SENSE irq log to debug
>   PCI: tegra: Use legacy irq for port service drivers
>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>   PCI: tegra: Access endpoint config only if PCIe link is up
>   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
>   arm64: tegra: Add PEX DPD states as pinctrl properties
>   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
>   dt-bindings: pci: tegra: Document reset-gpio optional prop
>   PCI: tegra: Add support for GPIO based PCIe reset
>   PCI: tegra: Change link retry log level to info
>=20
>  .../bindings/pci/nvidia,tegra20-pcie.txt      |  13 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
>  drivers/pci/controller/pci-tegra.c            | 605 +++++++++++++++---
>  drivers/soc/tegra/pmc.c                       |   1 +
>  4 files changed, 558 insertions(+), 80 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDBgsACgkQ3SOs138+
s6FcLA//eitwlqBKygxV35jOjECLnGd/ds+9r6ilxxsLjfNnp2KJ8OKijsgxXHI+
FeU4FLr2RjIcjzf8q0IljJpGuHRBlGcNuwQwL21C/GliC52R5OyhPwM1yTl6TpLv
7tByFrB3N+gnSLo/o2NWDszHwOwd7DDQJmAFEwXU121WiRcaDZDSEgbeNZq29uCH
rBfuRxeSqO8+X9hZEtw+qKsVtLlrM2PlNtjdKCvR3wKRaIiSDWe+qcf8EBfDsoz5
SoGh5wiUWgZh4QuBpEvCyt+z4KsI0566JlgiyVE3wpmxLZQkBhhZS89iZ2YJhqX7
9AnPSe4SkP6tQcByWO1dqO9dm+oHKVXuroE6zkgcAMm2Sph3OLCvp0CS43DMep4S
x4YQX1LLCYl2E5ZhiqSNG137QsCGIi2rFIB2vsaR5HPxZiV+K5sD8cDuCtxFPrE8
w5hKIJs05eH9RtSXnQzBo+W1JcGC74hDgT5+rey44sMhhLSVjVbI2ld3j77X99FU
WTxTx49FqXiiiU8DSimvIxFJ7xzZAJlsq5MVmTbPVz4Gel+yNIKSOaOroaDgL6HI
91tGYEb2HtOh9NpsOAXYAw4X4R3npbgReO5vc42yRVEM8EtHdEFUqyrh5aP49W8w
mhhnQckKGoQhN0iF/e73ydOv0O3a75JFyiFcbQfEfN756LSrV/c=
=cYVY
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
