Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251C1C6FF5
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278794; cv=none; b=QOQOjpuy+4MHeOgtD/bwf0HJGtCGlcLRtZEf0XcrvblLIWYguZLAGZAEgHLzG93ormdIlbGF3A6BgRzdF1vQV1ik2N7hb2rSgYCd2THz1reV7v3EJ3G0Rw+92wZlafHCY5PNS7yww9ozvYPSB9hWnW+/sWYCfD9dAlkgV22Kt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278794; c=relaxed/simple;
	bh=6gJ1dypqQHWxMNAXxacahbS0Y91Dc8qlMzcBhtUN30w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hcZjIZJyaM2Bbd5adWIAdX8MLaRDl+GY37oz9BzopEtCWIQo46T56yZ7Lla8DHwhv9emI1D34AKsXN32o6sXdOSzKdxwXTgXeIkeubBFN7VdZu+1VXDU8x3RUHnSr8lA19cS1D6scCKz6WCL4RoreT9lCposm2+Rd6XGUqB6tsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDi3T75x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDi3T75x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B91F000E9;
	Fri, 21 Aug 2026 02:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787278792;
	bh=5qFlc5dw9R9LJVlPGWdamrX8UFaRWPcNHdDLssc+FpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GDi3T75xH6rX/7yJiCWsmKlz9B+32R1CK7obrXlcvn0EA+dHXsyi7YYpSdaOAl5DG
	 TModZlGrO7cS0dZM1jQ9Rf1IA+el8tKzk1eXijGC3DgaRMt3gN4OvcYRDXv+pjK0W7
	 cotVcftzFjkXQeiKjhAZEtcullw5DF40ZHxrPlgSDol8mw3c2yDNfrDS61zS1cQ5dh
	 u3Nzrs+PuzXs3X54m5ZHerFjDJLcxluOKr2Z+dPNVYHd2xknrqE9jwFbB7W5cmIBty
	 3t3sDOpyTqD5rrKc7t0IIV2hH5NpwGn988I0giQWx/xpOg+qPPC5HrxMuaVV2DrgKG
	 qYvPkyk/OwrSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260821020636.111719-1-marek.vasut+renesas@mailbox.org>
References: <20260821020636.111719-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:19:51 +0000
Message-Id: <20260821021952.697B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] System denial of service via kernel panic. Untrusted hardware in=
put maps directly into a `WARN_ON` assertion.
--

--- Patch [1]: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and M=
ax_Payload_Size to 256 Bytes ---
commit 79fc893274978b76ee056f33053d2211fce68461
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Limit Max_Read_Request_Size and Max_Payload_Size to 256 Byt=
es

This commit forces the Max_Payload_Size and Max_Read_Request_Size to at most
256 bytes for devices connected to the R-Car Gen4 PCIe controller. This wor=
ks
around a hardware limitation where longer reads wrap around at the 256-byte
boundary.

Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller suppor=
t for host mode")

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -411,6 +411,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pc=
ie_rp *pp)
>  	return ret;
>  }
> =20
> +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> +					struct pci_dev *dev)
> +{
> +	/*
> +	 * R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
> +	 * Max_Payload_Size (MPS). PCIe specification indicates that the MPS
> +	 * must not exceed minimum MPS of any element along the packet path.
> +	 * The controller reports Max_Payload_Size_Supported (MPSS) 256 Bytes
> +	 * for header type 0 and 128 Bytes for header type 1. The PCIe core
> +	 * will not allow MPS to be set higher than MPSS, warn here in case
> +	 * something went very wrong in the core.
> +	 *
> +	 * For details, refer to chapter "104.1.1 Features" in either of:
> +	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
> +	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
> +	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
> +	 */
> +	WARN_ON(pcie_get_mps(dev) > 256);

[Severity: Medium]
Is it safe to use WARN_ON() with values read directly from the device's
configuration space?

A malfunctioning or malicious PCIe endpoint could spoof its configuration
space and return a value for PCI_EXP_DEVCTL where the payload field is
greater than 256 bytes. When rcar_gen4_pcie_enable_device() calls
pcie_get_mps(dev), it issues a configuration space read directly to the
endpoint device.

If a system has panic_on_warn enabled, feeding this untrusted hardware input
into WARN_ON() could allow a connected PCIe device to intentionally trigger=
 a
kernel panic, resulting in a system-wide denial of service.

Would it be safer to handle this unexpected condition by using pci_warn()
and dynamically adjusting the payload size, rather than risking a system
panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821020636.1117=
19-1-marek.vasut+renesas@mailbox.org?part=3D1
