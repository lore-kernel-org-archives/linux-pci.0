Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E2331ECF;
	Wed, 10 Jun 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105401; cv=none; b=B8cGzm4pXurcKGd4r0tNHwx8mYJ9zk5W6A/uMp5UhKe3irR+yU9gRFnVltry4uZICZh3AxJftLIswv6bazsGtQvaWqY49gawrq++ywOo8XtClPqmGe53hDPKMnKdqF3DKPUhOIiHiBGgk1ncuQy3AaqYS3UVtt16wXWbfKvVqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105401; c=relaxed/simple;
	bh=f4ARvImfa2kme9BEBao2rzzrFZB5vzS5J2IscHB/oo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8HTOxTeSv9D5mXohGMuplIK/P1c1p9vVaqntPiQeHCEIdmhd/OrMfvFipxq3DIaUJAJ+JVTyGuNMH4bzGS1I8xPZQ8bIk0Bn3SUfljvvQHTgzeH8Y4UaqZxT9CQsMXAkhoKj7W8r1e/mZO8c38YU029IjG8xvk682eUkE1vMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoOAIhde; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoOAIhde"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E30A1F00893;
	Wed, 10 Jun 2026 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105400;
	bh=wZRP8AhhvgZ8EEgAJLO+1bL+TPGneyCKqtP7iUuLHR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DoOAIhdeWZ2NEH60xzHnIBqtsJPWYRVavXhN4H0/qvO9id/fMcAhhad1aHHbDwTHv
	 qNXBQE2R5Urcvc4Vl4K9iJeisrDOfHRhMee/yysUH7D2N4nXV5xbtWaBPhjT8SoZGu
	 XGfFEbIpsV/U0EBX/fRjCE9MRGwOotujUFXO+BmwJVNt0apwnq391gaBdCV06jy/WJ
	 P2EgOyxS7+MBODq8r4GYoDw9oUJbc33FnfvKsZdMRBOjaFCEh8nMyA8X4SgaIpduWz
	 /HQJHsR1mGlMSglrv0fwCLj7hX3wOV8MEPCAObpD5cRLg+yxvdPXdauFalY7sc+20X
	 S7oG4hYaY92YQ==
Date: Wed, 10 Jun 2026 20:59:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, 
	imx@lists.linux.dev, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sherry.sun@nxp.com
Subject: Re: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update
 device trees
Message-ID: <cpgr6bt2635l2wijluapmqumtbeuskf6womowhvmx4pu36ab2v@gbvnwlmjckc6>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>

On Wed, May 20, 2026 at 04:48:56PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> This series integrates the PCI pwrctrl framework into the pci-imx6
> driver and updates i.MX EVK board device trees to support it.
> 
> Patches 2-8 update device trees for i.MX EVK boards which maintained
> by NXP to move power supply properties from the PCIe controller node
> to the Root Port child node, which is required for pwrctrl framework.
> Affected boards:
> - i.MX6Q/DL SABRESD
> - i.MX6SX SDB
> - i.MX8MM EVK
> - i.MX8MP EVK
> - i.MX8MQ EVK
> - i.MX8DXL/QM/QXP EVK
> - i.MX95 15x15/19x19 EVK
> 
> The driver maintains legacy regulator handling for device trees that
> haven't been updated yet. Both old and new device tree structures are
> supported.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V3:
> 1. Rebased on top of latest 7.1.0-rc4
> 
> Changes in V2:
> 1. After commit 2d8c5098b847 ("PCI/pwrctrl: Do not power off on pwrctrl
>    device removal"), the pwrctrl drivers no longer power off devices
>    during removal. Update pci-imx6 driver's shutdown callback in patch#1
>    to explicitly call pci_pwrctrl_power_off_devices() before 
>    pci_pwrctrl_destroy_devices() to ensure devices are properly powered
>    off.
> ---
> 
> Sherry Sun (8):
>   PCI: imx6: Integrate new pwrctrl API for pci-imx6
>   arm: dts: imx6qdl-sabresd: Move power supply property to Root Port
>     node
>   arm: dts: imx6sx-sdb: Move power supply property to Root Port node
>   arm64: dts: imx8mm-evk: Move power supply property to Root Port node
>   arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
>   arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
>   arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port
>     node
>   arm64: dts: imx95: Move power supply properties to Root Port node

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> 
>  .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  2 +-
>  arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  2 +-
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  4 ++--
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  2 +-
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  4 ++--
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  4 ++--
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  4 ++--
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 ++--
>  .../boot/dts/freescale/imx95-15x15-evk.dts    |  4 ++--
>  .../boot/dts/freescale/imx95-19x19-evk.dts    |  8 +++----
>  drivers/pci/controller/dwc/Kconfig            |  1 +
>  drivers/pci/controller/dwc/pci-imx6.c         | 24 ++++++++++++++++++-
>  12 files changed, 43 insertions(+), 20 deletions(-)
> 
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்
