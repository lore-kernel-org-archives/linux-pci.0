Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754F3546FA;
	Wed,  2 Sep 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313237; cv=none; b=ZoCAANLG/bVU9Wp7GldJMlGsGHvaMZMmJwhEwrWmct2oSRjjHey3HySkJIJLd38h4lbFVGTtEpD+Y8MZr10jJ+mwUvCzx+Ml5BtyPRQuYA70kHSDRpYXuCHtVfTgtjFFQB5wOmcFNKFKUo3SNC/zIRRoOt0o0idLzWIOZ6c2WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313237; c=relaxed/simple;
	bh=Y9Rkuy7HDhxHX8laUw6rbLAlIIFlsedfYTyx2aoNdlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmJRaZ2bFzH6iO0BxJr+sTrG1Glle8F9alcfFZ3joE0TjXXEwpcr7zVCd3RldcWIknsHcGPNcI8zOl9nSV5wt7bj3iDZPMUDrWcAN74ikJBbaABCde0ShkGuM+tWgjp5OJkjEUItQltaTO0f65tkU6sFRqe1t0maXPsnD8HF2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=HNqywE1q; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="HNqywE1q"
Received: from dog.kanata.rendec.net (pool-174-112-193-187.cpe.net.cable.rogers.com [174.112.193.187])
	by mail.mindbit.ro (Postfix) with ESMTPSA id AD2EDCC9F8;
	Wed,  2 Sep 2026 04:40:10 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro AD2EDCC9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1788313214;
	bh=FbYcYzQbyga8iWEe6oyzYcbMpKCkV0HffyQaE8+dHbE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HNqywE1qV4tagWexRGCU287ejbZmWBHMZLbsYQRCssG6WvLLWFrmuffrDBW+SSRPN
	 6zc9ebG5WZywY8j0pg38+1B8cFpXqzufJmUHsItfyUUly4CIp/Vqsm5nCOoL++uPlj
	 J31LtBNOZYGHjrUAUi28S+aRjI/RL02KYDuTXB2eZj9sJIv1k7yMidJTnYYA2CemHO
	 W9UaQkGEe1Ye4DGXcN2wkeKTCsR4ZPp3TWTWQoTJM8f3GreJKOD+hcX8guqrISdHCP
	 Ro7rWrQs+FdYvs1O+aRJsD/mx/bdSI95pnyvM121i6zhMe0L1iPyhYol9doQUZBr9Z
	 PbYqq6L/2uZXQ==
Message-ID: <ed86629d74368c6811e9f3b8f169584c0faf71ce.camel@rendec.net>
Subject: [BUG] Re: [PATCH 1/1] PCI: dwc: Apply ECRC workaround for
 DesignWare cores prior to 5.10A
From: Radu Rendec <radu@rendec.net>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, 	jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, 	Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com, 
	vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 21:40:08 -0400
In-Reply-To: <20260410062507.657453-1-mmaddireddy@nvidia.com>
References: <20260410062507.657453-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 11:55 +0530, Manikanta Maddireddy wrote:
> The ECRC (TLP digest) workaround was originally applied only for DesignWa=
re
> core version 4.90a. Per discussion in Synopsys case, the dependency of th=
e
> iATU TD bit on ECRC generation was removed in 5.10a, so apply the
> workaround for all DWC versions below that release.
>=20
> Replace the misleading comment that referred to raw version constants
> with readable DesignWare release name aligned with the implementation.
>=20
> Fixes: b210b1595606 PCI: dwc: Apply ECRC workaround to DesignWare 5.00a a=
s well
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

This patch breaks dw_pcie emulation in Qemu. I'm using the imx8mp-evk
machine and a single virtio-net-pci device attached to dw_pcie.

What I see is this: pci->version is 0x0, so with the patch applied,
dw_pcie_enable_ecrc() gets called now, whereas previously it didn't
(because the condition checked specifically for 490A and 500A).

This has a ripple effect that ultimately makes the system fail to boot:
 * vp_reset() for the virtio-net-pci device spins forever in the loop
   around vp_modern_get_status(mdev), which always returns 0xff.
 * vp_reset() is called in the context of the probe() function for the
   virtio-net-pci device, so probe() never returns.
 * the init task gets stuck in wait_for_device_probe() before it
   executes the real init binary (stack trace below).

#0 wait_for_device_probe
#1 prepare_namespace
#2 kernel_init_freeable
#3 kernel_init
#4 ret_from_fork

This is a separate problem of virtio (vp_reset() should eventually give
up), and I will send a RFC patch shortly.

Now back to the point, the obvious dumb fix is to check if pci->version
is 0x0 but I believe there is little appetite for that because it would
be just a workaround for the (incomplete) Qemu emulation of dw_pcie. I
assume it would be preferable to fix it in Qemu instead, to present a
valid version value that also happens to be >=3D 510A to avoid setting
the PCIE_ATU_TD bit.

But looking at the code, I'm not sure if it's as easy as it sounds. I
noticed there are quite a few other things that happen differently in
the driver if the version is >=3D 460A, so setting a correct version in
Qemu would also flip those conditions. I don't know if that can break
something else.

If, however, the "dumb fix" doesn't sound that horrible, I'm happy to
send a patch. Or, if you have any other suggestions, please let me
know. Thanks!

> ---
> =C2=A0drivers/pci/controller/dwc/pcie-designware.c | 6 +++---
> =C2=A0drivers/pci/controller/dwc/pcie-designware.h | 1 +
> =C2=A02 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index d69db0ab3b14..d0b3b93fc940 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -487,8 +487,8 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pc=
ie *pci, u32 index, u32 reg
> =C2=A0static inline u32 dw_pcie_enable_ecrc(u32 val)
> =C2=A0{
> =C2=A0 /*
> - * DWC versions 0x3530302a and 0x3536322a has a design issue where the '=
TD'
> - * bit in the Control register-1 of the ATU outbound region acts
> + * DesignWare core versions prior to 5.10A have a design issue where the
> + * 'TD' bit in the Control register-1 of the ATU outbound region acts
> =C2=A0 * like an override for the ECRC setting, i.e., the presence of TLP
> =C2=A0 * Digest (ECRC) in the outgoing TLPs is solely determined by this
> =C2=A0 * bit. This is contrary to the PCIe spec which says that the
> @@ -563,7 +563,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> =C2=A0 if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
> =C2=A0 =C2=A0=C2=A0=C2=A0 dw_pcie_ver_is_ge(pci, 460A))
> =C2=A0 val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> - if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
> + if (!dw_pcie_ver_is_ge(pci, 510A))
> =C2=A0 val =3D dw_pcie_enable_ecrc(val);
> =C2=A0 dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val)=
;
> =C2=A0
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 82946bf78b21..739a213c27c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -35,6 +35,7 @@
> =C2=A0#define DW_PCIE_VER_480A 0x3438302a
> =C2=A0#define DW_PCIE_VER_490A 0x3439302a
> =C2=A0#define DW_PCIE_VER_500A 0x3530302a
> +#define DW_PCIE_VER_510A 0x3531302a
> =C2=A0#define DW_PCIE_VER_520A 0x3532302a
> =C2=A0#define DW_PCIE_VER_540A 0x3534302a
> =C2=A0#define DW_PCIE_VER_562A 0x3536322a

--=20
Best regards,
Radu
