Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148C2D12ED;
	Tue, 28 Jul 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202831; cv=none; b=C8F+sNVxCYFhrMhdkPYRtcRvYqWM1n3BaAxQqoibgt7SwfXZv7JsDfDNq0pqeO0WxUL6WztJ3IQQOR6r7RCvpme+3U9KIMkIB+FKZr4C8O9R9UYRI8Sn9XOIKTZJ30B89nAWtDOKg+Jt+bV0/IwNQZlZFq3I+nrsnHLP/07bTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202831; c=relaxed/simple;
	bh=974UfaClIEkh0r8CEkEMv5DpNHVtYPq3lN+Xb/ZsLU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ufyMcxJY4sOKMkJVO5Mah/ab0yRj2oYmHkFCujsiW2exIbJxHFKOKy7lAnkiULZzGupidT3023inYL7rHJKX51odC1t68qj2QXMleDP/Li4Ccv5XIfimY/K4U7CaSli6asUekw0/1NcU/CJYxipk3d12FG1dngDHY1oz2B3doeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd24yYT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd24yYT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116661F000E9;
	Tue, 28 Jul 2026 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785202829;
	bh=kdMBQksHi5MOeDMJEsJpSIdGuE8ouikrHF6Hz/tP5OM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dd24yYT5ah4KaIFilx4sGgfxcCxcVy1A/8qCAc4r0jvUMftMKbCW2GO1dJpRWih5X
	 y11Kp2vmZHxgokF/Hs2lyZ0qvYZSL+kCjuqI1gjBKzHy5g/+9gVSUlx7BAyMOxqo01
	 INANQDzFwqoxAd/FV1Krj+hHs4NFbi4l+WWkr4fYmRRCAw2rQfz/BNgzmBH2/vtjsN
	 XWStDplo7JAhhFCahLU8GXW4haNZYWNJ58y/ZcQQanqWXj6YKuUtQmEy2wIaCfeJJS
	 1FBVnMCsE4k5hjwFbqKp4vMpfpHjWN80WSlJXYqzd62JgzhXcE/noK1XdV798a9M6N
	 Vkrfus9NLIeBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Handle return value from endpoint .init
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260728012548.465139-2-marek.vasut+renesas@mailbox.org>
References: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
 <20260728012548.465139-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:40:28 +0000
Message-Id: <20260728014029.116661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double execution of `dw_pcie_edma_remove()` on the `dw_pcie_ep_ini=
t_registers()` error path leads to double-free of eDMA IRQs and DMA device =
unregistration list corruption.
--

--- Patch [1]: [PATCH 1/2] PCI: dwc: Handle return value from endpoint .ini=
t callback ---
commit cb2920cc5e4b5269e0e38169339b1b10e422e580
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: Handle return value from endpoint .init callback

Add return value handling for struct dw_pcie_ep_ops .init callback.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..d78fb845582b2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
[ ... ]
> @@ -1367,8 +1367,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *e=
p)
>  		list_add_tail(&ep_func->list, &ep->func_list);
>  	}
> =20
> -	if (ep->ops->init)
> -		ep->ops->init(ep);
> +	if (ep->ops->init) {
> +		ret =3D ep->ops->init(ep);
> +		if (ret)
> +			goto err_remove_edma;
> +	}

[Severity: High]
This is a pre-existing issue, but by handling the return value here, this
error path becomes more easily reachable. Can this lead to a double-free
of eDMA IRQs and list corruption?

If ep->ops->init() fails, the code jumps to err_remove_edma which calls
dw_pcie_edma_remove(pci) and returns the error code.

The caller typically catches this error and cleans up again:

drivers/pci/controller/dwc/pci-layerscape-ep.c:ls_pcie_ep_probe() {
    ...
    ret =3D dw_pcie_ep_init_registers(&pci->ep);
    if (ret) {
        ...
        dw_pcie_ep_deinit(&pci->ep);
        return ret;
    }
}

dw_pcie_ep_deinit() then calls dw_pcie_ep_cleanup(), which unconditionally
executes dw_pcie_edma_remove(pci) a second time.

Since dw_edma_remove() does not clear its internal state (chip->dw =3D NULL)
after freeing resources, will this second invocation cause a double-free
or kernel oops during a device probe failure?

> =20
>  	dw_pcie_ep_disable_bars(ep);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728012548.4651=
39-1-marek.vasut+renesas@mailbox.org?part=3D1
