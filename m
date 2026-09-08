Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA3563FB7;
	Tue,  8 Sep 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883888; cv=none; b=OGCoh9uQ3nlggzQ8KVgSa4Dpxs8KHLx5QjufANOkbrW2OUdLOPnwwPMxUTanWJYYNnsv0WONj5qir6vIYlmwHa9v1biLOcANBUX4sUAWq5kwwLqaF/mljUctY3Fd5nOgbGmS2Dh0v4VthpLcVzIP4sAx1mbm3m4vWBR+WPa032Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883888; c=relaxed/simple;
	bh=LCJB/bBSJ6Qr8C+a3E//aJEMDEm/ATsf1wj8b7Yqqlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lB9oYUVL83QkAttG7QLEZoMYYgEHJxoAcNsoPYcGAPTzFeUOOI9Q/h28JYLTe9g2vomQNeOQsevoGeFAj9AEKopBN1eD1kd1Ojt66uBHg8DjgMOl7/eyt/DbEVzNMuQHgD2NKaebeQFJ0f4HOE1+zmTZ3NYTEFFGyIb0NEdx2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeQoNOP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeQoNOP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A331F00A3A;
	Tue,  8 Sep 2026 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883886;
	bh=eQtOv7eD6H20m0zWo+xhl+DuKQqGCiyKfHcdLqZ0so4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeQoNOP2/AbBnkNeFbs6XXLyde3Oo327CnQL++APk9XwN5MCbaW/Qh1rTloh9A6Nt
	 Gn3aUI8A7IY+4ooXj8sdx5yq1De/+RNBK8Bh/xScHsfxmAXI3x+Pr9nKNY6fZeG1nM
	 f9eOjDMBhb36++NBYBApMj7BdNSEvS8vBHvQvdnri/FTP5U7pCqkJ4HRQpNzw701HN
	 SaS4B7B4HirV+fPe1PbSpvmRPXMZtZNGzl5RPy4YnMtLgqryF/5zZ1NjBZS1T++Lgz
	 HobDVTwXGEZPQCMQ2ykRxdBZpoE5EMlVIcLam5TkXxifdVGpxyO1dXWHmqy1ux6aLu
	 yW+D8TQZT9EBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] ARM: orion/dove/mv78xx0: remove all board files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, dlemoal@kernel.org, linux-rtc@vger.kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, olteanv@gmail.com, Frank.Li@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev, cassel@kernel.org, linux-ide@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260908152808.3928630-6-arnd@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-6-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 16:11:25 +0000
Message-Id: <20260908161125.E4A331F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Orphaned MAINTAINERS entry for the TS-78xx platform.
- [Low] Legacy IRQ, MPP, and GPIO implementations are now unreachable dead =
code and unnecessarily compiled.
--

commit 67c50c71bc1677d3a7c7538373463163afb7b062
Author: Arnd Bergmann <arnd@arndb.de>
Subject: ARM: orion/dove/mv78xx0: remove all board files

This commit removes the legacy board files for the Orion, Dove, and MV78xx0=
=20
platforms. These files were retained in 2022 due to support in Debian/OpenW=
RT,=20
which is now gone.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdd75b73bf293..2bb036e8ddcd9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3080,8 +3080,6 @@ F:	Documentation/devicetree/bindings/arm/marvell/ma=
rvell,orion5x.yaml
>  F:	Documentation/devicetree/bindings/soc/dove/
>  F:	arch/arm/boot/dts/marvell/dove*
>  F:	arch/arm/boot/dts/marvell/orion5x*
> -F:	arch/arm/mach-dove/
> -F:	arch/arm/mach-mv78xx0/
>  F:	arch/arm/mach-orion5x/
>  F:	arch/arm/plat-orion/
>  F:	drivers/bus/mvebu-mbus.c

[Severity: Low]
Since all the board files like arch/arm/mach-orion5x/ts78xx-setup.c are
removed in this patch, should the MAINTAINERS entry for the TS-78xx platform
further down in this file also be removed?

The pattern F: arch/arm/mach-orion5x/ts78xx-* now points to deleted files,
which leaves an orphaned entry for Alexander Clouter.

[ ... ]

> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makef=
ile
> index 6f54d7fef27a7..7e9634e043185 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -2,15 +2,6 @@
>  ccflags-y :=3D -I$(srctree)/arch/arm/plat-orion/include
> =20
>  obj-y				+=3D common.o pci.o irq.o mpp.o
> -obj-$(CONFIG_MACH_KUROBOX_PRO)	+=3D kurobox_pro-setup.o
> -obj-$(CONFIG_MACH_TERASTATION_PRO2)	+=3D terastation_pro2-setup.o

[Severity: Low]
Are irq.o and mpp.o now completely unreachable code?

Since all the board files that called into these APIs have been removed,
it appears these objects are now unnecessarily compiled into the kernel
image. Should they be removed from obj-y here?

[ ... ]

> diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
> index e8c7580df8caf..dfde39cdd992b 100644
> --- a/arch/arm/plat-orion/Makefile
> +++ b/arch/arm/plat-orion/Makefile
> @@ -5,5 +5,5 @@
>  ccflags-y :=3D -I$(src)/include
> =20
>  orion-gpio-$(CONFIG_GPIOLIB)      +=3D gpio.o
> -obj-$(CONFIG_PLAT_ORION_LEGACY)   +=3D irq.o pcie.o time.o common.o mpp.o
> +obj-$(CONFIG_PLAT_ORION_LEGACY)   +=3D irq.o pcie.o mpp.o
>  obj-$(CONFIG_PLAT_ORION_LEGACY)   +=3D $(orion-gpio-y)

[Severity: Low]
Similarly, does this leave irq.o, mpp.o, and the orion-gpio-y objects as de=
ad
code as well?

Since their corresponding entry points in the board files were deleted,
could these also be removed from the build?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908152808.3928=
630-1-arnd@kernel.org?part=3D5
