Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AE3EDAD9
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062612; cv=none; b=T14T6QWiDlsaE/nfSr6NRu4TFnhx9HFNfdIiK03/R0FD5bUYt3RZks/078i5mW7DANBf98FAMemOqX/b63z/SUORhnjpqcNFXe4rLaHqCSi7o8MgmGXCrvwuiv9PM02wloy/uYbDCFIrozO9J+4+7Ig131CV7Tk02gCo1yAYPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062612; c=relaxed/simple;
	bh=SLfg7joRG5hRwP6syfByopiDQZ95QBTu3wGgkctjz2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ggLVvecJQuKt6gOnnwnLxNPVsxiGaL2lzXXJhEkcGOeZu3MxjhrywMYTfD1au8/4xb72cOIVOYYLn0EEeqUz0fXfRPX+nxNPFpm+1lkof3JVU5kkrvHOQEn2IkWdZ5/A2CTI4cS6WbSrmiKWvIVjhUgLef2FhvbtuVisKENN8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVKOJLKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVKOJLKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FD6C2BCC4;
	Wed,  6 May 2026 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778062612;
	bh=SLfg7joRG5hRwP6syfByopiDQZ95QBTu3wGgkctjz2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UVKOJLKDiyoISr8GrKGKpZcSgXKSxxyaB8FxHaz5dt0wFeSmEgUFvA1Q/BbjaAZ8g
	 qDV9AYVtNvRluthVpblUo1VoKkqaEVFibIi+BiBugc5CzmrC7hPfsAbly0pM8awVyK
	 xjPyT7z2cDn2fxXy+B2yz4Av+EVKvJ6DTJ2nEnY0tllwna1gg75E2YzD8PN2xYv1ZR
	 w2bblY/YEZg/PxKUPGB4J//tzjlG27i0yWisN7XfK6m+V9C/Rffeu1d95bIzVGTT2d
	 /1qLKqMxnOCsnSBceHmRwa8MfJKKv+yIIZRzbayPSSfidn4SHkU70GD0g7UE1pQdF7
	 u1Wgjb20YMT/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] PCI: designware-plat: Drop unused include
Reply-To: sashiko@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506084858.867884-3-andriy.shevchenko@linux.intel.com>
References: <20260506084858.867884-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 10:16:51 +0000
Message-Id: <20260506101651.D6FD6C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `dw_plat_pcie_probe()`, `pci_epc_init_notify()` is incorrectly =
called on the error path if `dw_pcie_ep_init_registers()` fails, falsely no=
tifying EPF drivers that the EPC is ready.
--

commit e1010c1890e8eeb7c02639fb9293500993fe3d21
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

PCI: designware-plat: Drop unused include
   =20
This commit removes the unused <linux/gpio.h> header from the
pcie-designware-plat.c file since its symbols are not used.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/=
pci/controller/dwc/pcie-designware-plat.c
> index d103ab759c4ee..7d896752d43cd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c

[ ... ]

While reviewing this file, I noticed a pre-existing regression in the
error handling path of dw_plat_pcie_probe():

drivers/pci/controller/dwc/pcie-designware-plat.c:dw_plat_pcie_probe() {
        ...
        ret =3D dw_pcie_ep_init_registers(&pci->ep);
        if (ret) {
                dev_err(dev, "Failed to initialize DWC endpoint registers\n=
");
                dw_pcie_ep_deinit(&pci->ep);
        }

        pci_epc_init_notify(pci->ep.epc);
        ...
}

If dw_pcie_ep_init_registers() fails, execution falls through and
unconditionally calls pci_epc_init_notify(pci->ep.epc) rather than returning
an error.

Will this falsely notify all registered endpoint functions that the
endpoint controller was successfully initialized?

Endpoint function drivers react to the epc_init event by attempting
to allocate memory, set BARs, and configure hardware registers. Because
the memory windows are destroyed by dw_pcie_ep_deinit() when it sets
num_windows to 0, could these operations lead to failed memory allocations
or synchronous external aborts when writing to inaccessible registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506084858.8678=
84-1-andriy.shevchenko@linux.intel.com?part=3D2
