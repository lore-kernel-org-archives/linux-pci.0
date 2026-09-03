Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E0283FDC
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405131; cv=none; b=LrYI83XSxs7BNau1n8Eyv8BvZvau4R/au29U3mP0+2vdY/X0hxNl1/mY5N4BMnJrEA6RV2oHr8uKuhZmDdvwYpBnTDczbdH0wBL/7v9XHK626f7e2QPgK3MN4SSn+KiBD3iHGFh6yuLDG2WUyWOiyixWdvnMfmklo7yeFxtXHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405131; c=relaxed/simple;
	bh=kh9iGFpwGfsdvCWjVJMvVcND0/NBeyufsV+n+ndl+SQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXonLgzYnMRtHMFj/kiNlUN03ue2/wrp4NxvcsaS1Ra8N/j+g7UUdbQ5waq8OdpqfhqayGTCucFZHpLc7jGAXln7xNnpT8jid7RxrQo+l6XT7q63h6GqS5iF7NTo/s6fVsnj9j7XGuKMyqPjHx/0Fe015CdNmJav+QQluBy+Tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxLXN3SE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxLXN3SE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655A1F000E9;
	Thu,  3 Sep 2026 03:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405129;
	bh=tnMyPUYEAD7lZm0uhL8vCdKC5BYNmogRNIPEyCFXJTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TxLXN3SEElIWWYOFB7NnP2lcdc5DPTQtJyzpWPYiz4a48dbp21nUryRVtOpT7Y/kp
	 v7lX8IVjAh38WdEx404UBWv2OdCDCoV3S3Cx3WfqoDqndregnJzwc97KFE1bI/SrDr
	 rE7kkRGYqx8RC6LMsjnZ6shxGTDW2Dn82em/QEE6groO4Qg+JulkZjdZ5TBTTaat4/
	 w5r1RlrKyyDqiLIwClY8f4CpYDdluVlCx5Mq47xiQX7Gm3u2BHsX3mcPCTXWB3yd8v
	 tH6YD7R7czOBHd+N5F96Mx10QDo8Vj4Rxi1Uuvuk6Uy0zE5T+mfrPwcdAaPk/TRd8P
	 Yn0YpXut4q0Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dw-rockchip: Bail out if the INTx irq domain
 creation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1788403477-71491-2-git-send-email-shawn.lin@rock-chips.com>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <1788403477-71491-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 03:12:09 +0000
Message-Id: <20260903031209.B655A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng IRQ domain and chained handler cleanup on initialization failure paths, =
leading to a memory leak and potential Use-After-Free.
- [High] This problem wasn't introduced by this patch, but there is an unpr=
otected lockless iteration over the PCI bus devices list in the threaded IR=
Q handler.
--

commit e7543706c2d1058d78b54feb3252321efa4a390b
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Bail out if the INTx irq domain creation fails

rockchip_pcie_init_irq_domain() can fail, e.g. when the DT node is
missing its "legacy-interrupt-controller" child node. This commit
propagates the error to abort probing instead of continuing with a
NULL irq_domain, which previously caused a panic on the first INTx.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index af26a07c0c9e5..50824c8b1d83e 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -432,8 +432,10 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp=
 *pp)
>  	pci->dbi_base2 =3D pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
> =20
>  	ret =3D rockchip_pcie_init_irq_domain(rockchip);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(dev, "failed to init irq domain\n");
> +		return ret;
> +	}
> =20
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);

[Severity: High]
This is a pre-existing regression, but there is a missing IRQ
domain and chained handler cleanup on initialization failure paths,
which can cause a memory leak and use-after-free.

If rockchip_pcie_host_init() succeeds but a subsequent step in
dw_pcie_host_init() fails (e.g., link training), the probe aborts and
devres frees the rockchip struct. Because the driver lacks a .deinit
callback in rockchip_pcie_host_ops, the IRQ domain allocated via
irq_domain_create_linear() is leaked.

Additionally, the chained handler mapped via
irq_set_chained_handler_and_data() is never removed. Can a subsequent
legacy interrupt or spurious trigger invoke rockchip_pcie_intx_handler()
with the devm-freed rockchip pointer, causing a kernel panic?

Does rockchip_pcie_host_ops need a .deinit callback to properly unwind
these resources on failure paths?


While reviewing this file, another pre-existing regression was noticed in
rockchip_pcie_rc_sys_irq_thread():

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_rc_sys_irq_thre=
ad() {
[ ... ]
	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
		dev_dbg(dev, "hot reset or link-down reset\n");
		for_each_pci_bridge(port, pp->bridge->bus) {
			if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
				pci_host_handle_link_down(port);
		}
	}
[ ... ]
}

[Severity: High]
This is a pre-existing regression, but there is an unprotected lockless
iteration over the PCI bus devices list in this threaded IRQ handler.

When a hot-reset or link-down event occurs, the handler traverses
pp->bridge->bus->devices using for_each_pci_bridge(). This traversal is
performed locklessly without acquiring the required down_read(&pci_bus_sem).

If a concurrent PCI device removal operation modifies the list (e.g., via
sysfs or hotplug), could this lockless traversal access poisoned pointers
or freed device structures, potentially causing list corruption or a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1788403477-71491-1-=
git-send-email-shawn.lin@rock-chips.com?part=3D1
