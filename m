Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A840469856
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245086; cv=none; b=spd54lI4b31deWNMKA5HvG2nkrbik59MedhVFkxroRbgGXW8FR446axomrF6EUfc5yXVOo8d/iAsyBPfnvm7tKRqJFoqo5bLksmJt6Rc+1HdtlBnWV2TxDNoivpzmutM/hOPk6SjFFBRIMQEmy0/csdobk9vb+sOn+YZDdYmmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245086; c=relaxed/simple;
	bh=JWr0NNjXQImzVIa+BZdcSYF6v2HZGC8+Dsd4ySZ+oq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d5VsjySXNf5OYy//RNCXhR+0nwkbigfE37Ze5QQPgEAXKS8w/ZCrW3QNxw312f+/puZsRwpYhyCIwoo3y2DiQgLLFU5qKtJlC6H4p4VZe4hsL84B4Ry+bSWxAO53qyJykmDIZ7RzwZofE/urotFyuykc/tLGUAcmUvSILrWnJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=BawstyF/; arc=none smtp.client-ip=95.215.58.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="BawstyF/"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JWr0NNjXQImzVIa+BZdcSYF6v2HZGC8+Dsd4ySZ+oq8=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790245076; v=1; x=1790849876;
 b=BawstyF/9VGrshpXsMPCMHX7oIAutbAqnfqjxmntTnxy1d8KuQJy8Jya8g3DyxZVGpT33T2B
 htBtW78FptrYhYWJq40L0GqIU0hRj95mRRPISPe/oUYBki1LEb0YHuIYGk3mmHAKDFtQWiQRPqw
 MgJqKXuQbfUA9zcCsHNvMz3D2rIZ1B229Kjjf3ji2aMOdGz+xFIfD5D6PWxnXzJ9RJIAC947SpI
 Ya58uMFVjyORt7/edve9lnp81U1FFtPohMKZq/4Quu8LEn1QNT0p0FYHf6WVkKdrJ/ikHXf1EH8
 9T7nGVeMyhXk3ivUs9LVNhFmwwD/8r9zlZbWRBcP8mdrQ==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75bbed6db142c758;
	Thu, 24 Sep 2026 10:17:56 +0000
X-Mizu-Trace-ID: 75bbed6db142c758
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 12:17:54 +0200
Message-Id: <DLNGWXNFBWAP.2Z0ELO7NROZTC@cknow-tech.com>
Cc: <linux-rockchip@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 "Niklas Cassel" <cassel@kernel.org>, "Diederik de Haas"
 <diederik@cknow-tech.com>
Subject: Re: [PATCH v4] PCI: dw-rockchip: Move the INTx irq setup to probe
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Shawn Lin" <shawn.lin@rock-chips.com>, "Manivannan Sadhasivam"
 <mani@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>

On Thu Sep 24, 2026 at 6:06 AM CEST, Shawn Lin wrote:
> Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port(=
)
> and use for link down"), .reset_root_port() re-runs the host ops .init()
> callback to reprogram the Root Complex after a controller reset. That
> works for the register programming, but .init() is not re-entrant: it
> also creates the INTx irq domain and installs the chained INTx handler.
> Every root port reset therefore ends up with a second irq domain
> registered for the same fwnode: the previous one is leaked, as it is
> never removed, and worse, the INTx virqs of the downstream PCI devices
> were allocated in the previous irq domain and are never re-mapped, while
> the chained handler now looks up virqs in the new, empty domain. After a
> link down recovery, INTx interrupts are silently lost.
>
> Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
> creation and the chained handler installation out of .init() and into
> rockchip_pcie_configure_rc(), just before dw_pcie_host_init(). The
> lookup has to happen before the host is initialized, because
> dw_pcie_host_init() enumerates the bus and probes the downstream
> devices, and pci_assign_irq() maps their INTx interrupts at that point:
> if the domain does not exist yet, the mapping fails and the devices end
> up without a usable INTx. This also mirrors how the qcom driver requests
> its global IRQ, and leaves .init() with nothing but idempotent register
> programming, so both .reset_root_port() and dw_pcie_resume_noirq() can
> safely re-run it. Re-running of_irq_get_byname() on every resume is also
> gone.

While with only patch 1 of v3 I still got (5x) this warning:
  irq: no irq domain found for legacy-interrupt-controller !
but no more stack traces.

With v4 there are no stack traces and no more irq warnings.
My NVMe drive, Ethernet NIC (also PCIe based) and both MT7925 based Wi-Fi
and Bluetooth work fine, so feel free to include

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 Plus

Cheers,
  Diederik

> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and =
use for link down")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v4:
> - drop the code comment (Niklas)
> - create the INTx irq domain before dw_pcie_host_init() instead of
>   after it. dw_pcie_host_init() enumerates the bus and probes the
>   downstream devices, and their INTx interrupts get mapped at that
>   point, so registering the domain afterwards left every downstream
>   device without a usable INTx (flagged by the Sashiko review).
> - this also removes the failing steps behind dw_pcie_host_init(), so
>   there is no error path left that would return with the root bus
>   registered and the rockchip structure about to be freed (flagged by
>   the Sashiko review).
>
> Changes in v3:
> - split devm-managed part into a seperate patch
>
> Changes in v2:
> - Moved the of_irq_get_byname() lookup, the INTx irq domain creation
>   and the chained handler installation out of the host ops .init()
>   callback into rockchip_pcie_configure_rc(), right after
>   dw_pcie_host_init(), as suggested by Niklas Cassel. This supersedes
>   v1 patch 1/2, as .init() no longer creates the irq domain, and
>   removes the rockchip_pcie_host_hw_init() helper from v1.
> - Made the INTx irq domain devm-managed with
>   devm_irq_domain_instantiate() and uninstall the chained handler
>   through a devres action, addressing the probe failure leak and
>   use-after-free flagged by the Sashiko review.
>
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++--------=
------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 1497686..bd86e32c 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -422,23 +422,9 @@ static void rockchip_pcie_stop_link(struct dw_pcie *=
pci)
>  static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> -	struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> -	struct device *dev =3D rockchip->pci.dev;
> -	int irq, ret;
> -
> -	irq =3D of_irq_get_byname(dev->of_node, "legacy");
> -	if (irq < 0)
> -		return irq;
> =20
>  	pci->dbi_base2 =3D pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
> =20
> -	ret =3D rockchip_pcie_init_irq_domain(rockchip);
> -	if (ret < 0)
> -		dev_err(dev, "failed to init irq domain\n");
> -
> -	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> -					 rockchip);
> -
>  	rockchip_pcie_configure_l1ss(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	pp->bridge->reset_root_port =3D rockchip_pcie_rc_reset_root_port;
> @@ -731,6 +717,19 @@ static int rockchip_pcie_configure_rc(struct platfor=
m_device *pdev,
>  				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
>  				 PCIE_CLIENT_GENERAL_CON);
> =20
> +	irq =3D of_irq_get_byname(dev->of_node, "legacy");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D rockchip_pcie_init_irq_domain(rockchip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init irq domain\n");
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> +					 rockchip);
> +
>  	pp =3D &rockchip->pci.pp;
>  	pp->ops =3D &rockchip_pcie_host_ops;
> =20


