Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794647276;
	b=N0qhN0cdCIxp+UuAIeSQPW8vm43T6+Erb1lNKobWqzTkqTpqSCFQZumQW0ZrKAX4HRw2
	 3qQxGta4gTAaxzt1u4hZ8qBFmoK6hCIb2DtHXhq7jfNyIu7otZuQ5mFDUcLTzAA66FOlr
	 YX1MI1YTogyu95jcQYwXNBMCO7TwdUi7YRuFos0m/kmnBhQFKAysCerr2WyjQPhhtSSMe
	 Rzz74TEjrPleKTfzlCHYexYzRXHJy9pN56UIEsS69FU29WVQqnTgm0Qq4vZxgV2rTqM1h
	 wYgOU4zVfXHCjxPBv9P2i5czJ9cVXasxHVq0e41tb+9d9tRtI5yLN8PlS+tfMQ/BFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647276;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RpwwvqgYCKTnehNvKCqhay7AK3cDaQgIYwpcycKhGbs=;
	b=H0hxIEJTyrsMbMIz5YlI1V3yMiBe7JbORTDxAsf0K+E++fkyCamU5Ww4InQb3zy6Qp/j
	 HYTrdFPSWWYokZywxs1cSbuImUYdA6D8zn8WP+znowp0A2P5DeSpNavTDwAWSVZd6RlSO
	 DOPYrMLNQeenKglkPvEvnTKPIJSvM1TTBc2M7yPa1QoZUFxJQ2vSAZmdEdtTKmT0m8gwo
	 kv1NNmhcromuMlao3A4+7YjqurbKAbjCbP2+WWLJvhVXQihwBZuWcw5edeXEi5W6vB2k+
	 ndrrOjo9Wx6Wi/gRqbP3Vv/bjmbRtM5xhM28duAs8silTybMuf46yR5zcBhJIXfY1RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXf9duQL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E436606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXf9duQL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959D41F000C4;
	Sat, 14 Nov 2026 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794647275;
	bh=RpwwvqgYCKTnehNvKCqhay7AK3cDaQgIYwpcycKhGbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cXf9duQLIO+GGyLvjeKsaVQ1egBL6nsDErPDw7sxF+/RNbcHrUODQvQJ2s3jVIWT6
	 nUYQpK1kOfW1YA1IkdSIVto7QX6M0kLBKFFhy1gQ2WCN7HHeKor90kQc6ShASZxd6V
	 poilCYBEnwgZUDP0h20iRZ+zB8eDa9RDyueb0ptOt+hVJSIL9M0OnmYf89GMa8pzOj
	 TejRhFjCceT56XJkj2yHvU3q7zrGZRKiaCFL0QwjkKdkUvacDeT0+E6+To+9Uvl/Yf
	 1/LVdVajnUSpncq38cNZmjKY4KCYFnOTxGmYI9uG/tnIW3EvXuS2OmX62fDeoYRbsb
	 5BxyHJDDQYXrA==
Message-ID: <sashiko-outbox-214318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Mask PARF_INT_ALL_3 events on Nord
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Guo" <shengchao.guo@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114084700.907031-1-shengchao.guo@oss.qualcomm.com>
References: <20261114084700.907031-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 09:07:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] PCI: qcom: missing qcom_pcie_enable_global_irq_events() call in
  qcom_pcie_resume_noirq()
- [Medium] PCI: qcom: late pcie->global_irq assignment in
  qcom_pcie_probe()
- [Low] PCI: qcom: missing Fixes: trailer for Nord PCIe controller
  support commit
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] PCI: qcom: asynchronous pm_runtime_put() in qcom_pcie_probe()
  [1]
--

commit 38b51880eb10af5087eac2fa97392397368f3684
Author: Shawn Guo <shengchao.guo@oss.qualcomm.com>

> PCI: qcom: Mask PARF_INT_ALL_3 events on Nord
>
> On Nord, the PARF_INT_ALL_3 interrupt group is unmasked out of reset
> (PARF_INT_ALL_3_MASK reads 0x43fff), and its events are routed to the
> same 'global' IRQ as PARF_INT_ALL. The driver neither handles nor clears
> any of them, and the global IRQ handler only looks at
> PARF_INT_ALL_STATUS.
>
> Some endpoints send a Device Readiness Status (DRS) message after link
> up, e.g. the SK hynix HFS001TFM9X186N NVMe drive (1c5c:1069). This
> latches DRS_MSG_RECEIVED (bit 12) in PARF_INT_ALL_3_STATUS and keeps
> the level triggered global IRQ asserted. The threaded handler then runs
> in a tight loop with PARF_INT_ALL_STATUS reading 0, starving other work
> and stalling the boot (RCU/SRCU stall warnings).
>
> Mask all PARF_INT_ALL_3 events and clear any latched status on Nord,
> before the global IRQ is requested in probe and again in
> qcom_pcie_reset_root_port(), since the register is reset together with
> PARF_INT_ALL_MASK. To keep the two writes together, move the
> PARF_INT_ALL_MASK programming in probe into the same helper, which now
> runs right before devm_request_threaded_irq() instead of after it.
>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

[Severity: Low]
This fixes a boot stall on the Nord PCIe controller.  Should it include:

  Fixes: f75d2d64fff1 ("PCI: qcom: Add Nord PCIe controller support")

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index eba1b2cb30f0a..03b2e61fc20f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -1871,6 +1877,22 @@ static int qcom_pcie_set_max_opp(struct device *de=
v)
>  	return ret;
>  }
> =20
> +static void qcom_pcie_enable_global_irq_events(struct qcom_pcie *pcie)
> +{
> +	/*
> +	 * The PARF_INT_ALL_3 events (e.g. DRS_MSG_RECEIVED) are unmasked by
> +	 * default, but not handled by the driver. Once latched, they keep the
> +	 * level triggered 'global' IRQ asserted, so mask and clear them.
> +	 */
> +	if (pcie->cfg->mask_int_all_3) {
> +		writel_relaxed(0, pcie->parf + PARF_INT_ALL_3_MASK);
> +		writel_relaxed(~0U, pcie->parf + PARF_INT_ALL_3_CLEAR);
> +	}
> +
> +	writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> +		       pcie->parf + PARF_INT_ALL_MASK);
> +}
> +
>  /*
>   * Qcom PCIe controllers only support one Root Port per controller insta=
nce. So
>   * this function ignores the 'pci_dev' associated with the Root Port and=
 just
> @@ -1928,8 +1950,7 @@ static int qcom_pcie_reset_root_port(struct pci_hos=
t_bridge *bridge,
>  	 * non-sticky.
>  	 */
>  	if (pcie->global_irq)
> -		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> -				pcie->parf + PARF_INT_ALL_MASK);
> +		qcom_pcie_enable_global_irq_events(pcie);
> =20
>  	qcom_pcie_start_link(pci);
> =20

[Severity: High]
Does qcom_pcie_resume_noirq() also need to call
qcom_pcie_enable_global_irq_events() when pcie->global_irq is set?

When resuming from system suspend where pcie->pci->suspended is true,
qcom_pcie_resume_noirq() -> dw_pcie_resume_noirq() ->
qcom_pcie_host_init() -> qcom_pcie_init_2_7_0() pulses the controller core
reset (res->rst), which resets the non-sticky PARF_INT_ALL_3_MASK and
PARF_INT_ALL_MASK registers back to their hardware defaults before
restarting the link.  On Nord, an endpoint that sends a DRS message on
link up will then latch DRS_MSG_RECEIVED in PARF_INT_ALL_3_STATUS and wedge
the system in qcom_pcie_global_irq_thread() once interrupts are re-enabled
on resume, and PARF_INT_ALL_MASK remains cleared to 0.

> @@ -2429,6 +2450,8 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>  			goto err_host_deinit;
>  		}
> =20
> +		qcom_pcie_enable_global_irq_events(pcie);
> +
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
>  						qcom_pcie_global_irq_thread,
>  						IRQF_ONESHOT, name, pcie);
> @@ -2438,9 +2461,6 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>  			goto err_host_deinit;
>  		}
> =20
> -		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> -				pcie->parf + PARF_INT_ALL_MASK);
> -
>  		pcie->global_irq =3D irq;
>  	}

[Severity: Medium]
Can qcom_pcie_reset_root_port() run before pcie->global_irq is assigned if
a link-down interrupt is already pending or fires as soon as
devm_request_threaded_irq() enables the IRQ?

CPU0                                  CPU1
qcom_pcie_probe()
  qcom_pcie_enable_global_irq_events()
  devm_request_threaded_irq()
                                      qcom_pcie_global_irq_thread()
                                        pci_host_handle_link_down()
                                          ...
                                            qcom_pcie_reset_root_port()
                                              qcom_pcie_host_init()
                                              if (pcie->global_irq) <-- 0, =
skipped
    return 0;
  pcie->global_irq =3D irq;

Because qcom_pcie_enable_global_irq_events() now unmasks
PARF_INT_ALL_LINK_DOWN before devm_request_threaded_irq(), the threaded
handler can run and reset the controller while pcie->global_irq is still
0.  qcom_pcie_reset_root_port() then skips
qcom_pcie_enable_global_irq_events(), leaving PARF_INT_ALL_MASK cleared
and PARF_INT_ALL_3_MASK unmasked after the reset.  Setting
pcie->global_irq =3D irq before devm_request_threaded_irq() avoids this rac=
e.

[Severity: Medium]
This problem wasn't introduced by this patch, but the err_pm_runtime_put
error path in qcom_pcie_probe() [1] calls asynchronous
pm_runtime_put(dev) immediately followed by pm_runtime_disable(dev):

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_probe() {
    ...
err_pm_runtime_put:
	pm_runtime_put(dev);
	pm_runtime_disable(dev);
}

Because pm_runtime_put() only queues an asynchronous suspend request and
pm_runtime_disable() cancels pending runtime PM work, the device is never
suspended when probe fails after pm_runtime_get_sync(), leaving it powered
on.

[1] https://sashiko.dev/#/bug/linux-26465cc9-b0b2-43e4-ac7d-ce66bfbb2db5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114084700.9070=
31-1-shengchao.guo@oss.qualcomm.com?part=3D1
