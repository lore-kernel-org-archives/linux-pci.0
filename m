Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269C3AC0D7
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045502; cv=none; b=oNDsKOkgWD7tCh3xHyvFnDHmrMisqsXm3bgi3JlHkaJjFRSHMora7HGswjziDe0bUEMxEX7u9FjMh92zTYAlG1a1Z6j2iQyndUJ3ojzcYalDA1iuws38LD+6BlJc356ZwLaj1CnWGZE9+erkll3jONLlKSZL91KJ+p3nWLVdgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045502; c=relaxed/simple;
	bh=WHBFp0MYwV+27MEv1BT4vUSIBkiWCtKpHUMLH/+uLsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X3Z8J/eAo1UT7q+DHtmwGBdasCwa+RWFxfjEzCBB61scBxVpVlAENTpaN9sZCWtbWogESx8yzEihdX2gJdbJ/9+KCPCHfs2ZyB3P9WMDSZ8Fgo1PnwDvX/jaB2U3pOwB1qbrhH5/D4m+f0iB9QvajFG65TaVmqETGSdGevafwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCUx3XSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCUx3XSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4F31F000FF;
	Tue, 22 Sep 2026 02:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790045500;
	bh=hWsvFI1wSJ7UeV9A92RcpeABzWMts4FwgubXbvcgcMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCUx3XSUIJDJJ8Ktwl3DWxedRi2lAhnVhESlsJa0zw0Jl/7GHDfyTLnGZllwocCt9
	 PE4q15h9i3b6f1uijSf0WgZuX4wsw20VRngsOXtyxjgcV6MM1wTuyDUo9yhgfbu2Nj
	 +zR/OnwLgBMdy2jNsyxVW7wPRr4J9KAnk7mffY6XDz0zR09BNau0AWVIR2YeilK492
	 vtX9Oo8mmzebj7Kj+SH9ULv127Fn2gzc4L2eZuNZejlWRNZd9WfhvRTwyLDRVA+GY+
	 d90QstljfTCX//kzalby1gHggUD7CM3uc5lxJF7tsKxj289lQAV77nmN2WZ3u63LrW
	 9NUC7KFi/RQMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] PCI: dw-rockchip: Move the INTx irq setup to
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790044622-164744-2-git-send-email-shawn.lin@rock-chips.com>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <1790044622-164744-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 02:51:39 +0000
Message-Id: <20260922025140.5B4F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pcie: missing dw_pcie_host_deinit() on error paths causes UAF
- [High] pcie: late INTx IRQ domain registration breaks downstream INTx int=
errupts
--

commit af2f81da80dcb1ab2a4b7035c602bf3d2a40f1c9
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Move the INTx irq setup to probe

The commit moves INTx IRQ domain setup out of the host ops .init() callback
and into rockchip_pcie_configure_rc() to avoid leaking the domain upon
controller reset. It performs the IRQ initialization immediately after
dw_pcie_host_init() completes.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index af26a07c0c9e5..59d9a1b095df6 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[ ... ]

> @@ -739,6 +725,24 @@ static int rockchip_pcie_configure_rc(struct platfor=
m_device *pdev,
>  		return ret;
>  	}
> =20
> +	/*
> +	 * This is done here instead of in the host ops .init() callback,
> +	 * which is also re-run by .reset_root_port(), so that the INTx irq
> +	 * domain is only created once, at probe time.
> +	 */
> +	irq =3D of_irq_get_byname(dev->of_node, "legacy");

[Severity: High]
Does moving the INTx IRQ domain creation here cause downstream devices to l=
ose
their INTx interrupts?

Since rockchip_pcie_configure_rc() calls dw_pcie_host_init() right before t=
his,
which internally invokes pci_host_probe() to enumerate the PCIe bus, downst=
ream
devices will be probed before this new code is reached.  When those devices
attempt to map their legacy INTx interrupts via the device tree, they won't
find the IRQ domain since it hasn't been created yet, which seems like it w=
ould
cause the mapping to silently fail.

This architectural issue appears to remain unaddressed at the end of the pa=
tch
series.

> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D rockchip_pcie_init_irq_domain(rockchip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init irq domain\n");
> +		return ret;
> +	}

[Severity: High]
Can these error paths cause a use-after-free by leaving the PCI root bus
actively registered?

Since dw_pcie_host_init() successfully allocated memory, registered the PCI
host bridge, and exposed the bus to the system, returning an error here
without calling dw_pcie_host_deinit() will leave the bus active.  Because
the driver uses devres for struct rockchip_pcie, any subsequent interaction
with the bus could trigger a use-after-free on the freed rockchip structure.

This issue does not appear to be resolved by the follow-up patches in this
series.

> +
> +	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> +					 rockchip);
> +
>  	/* unmask hot reset/link-down reset */
>  	val =3D FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790044622-164744-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D1
