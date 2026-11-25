Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603510;
	b=tzBSgK/iXM/Dh2GKNIjipi6Iy56gwBkwR1Pi8Kp8OcbjjCJ4kT6Hn9MZOJZZcfJ7lBCn
	 GlatXzLn3iEADIWKUBPOLPyu1k+hYyQOPRM+0XVDWOSo/DrQJ5uh/xJfK6ageRpYwJjiC
	 FPz8OY4gKd2rY7W1QhhEwl4jT3CWCP6VkE83RUU46edWrAyOgQ74xmJuum43nBLR275mm
	 QxWyv+Yt72pPgytZjFMW/YJ7IpYmrYKXiW6IbHQSP7VvMezIJ0jvosENNL7jtykNgWSKl
	 oyv4ao5KedgoGnAjT93xHGi7lwUdDzZBNPxEuXr2gtNLl7/MlskpfZ/qZ1FXUn9gmoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603510;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sLt+a9fi/9onyCn4ayksBFwRvlKuZDZt6ri4AUiJyk8=;
	b=ojKY0iXrV7y7Sj6m4J+ECY1zRSo9sMrL092bOzrExZfIkuU6wd3iUek0XQn9DWIgBdIl
	 +3ZRV/OFM1k2li872yVPcB6AZ5tLErFltw468v8e8uboYIIyAXemliadyxbB+52eQJj0J
	 NyNV+MBQUiHiwr39Jt3shrLKux06+XQjpB+IOY/1esMwe8rTprnDssgjXLe5aQ+jXSlsN
	 tqkSUKGgpzlLNE4gCLJNk6YA/SUBa5jTQcDfDLd9euPt2OctlOqLHQXaTscXROUTDp7+H
	 pXs26QvXjrgN4M3654wWbG+UzaRp6RPN7mDy8QHn8timMDknLuDtLESRob5tAzRKItQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT9ZruDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC878606A327;
	Wed, 25 Nov 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT9ZruDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4181F000CA;
	Wed, 25 Nov 2026 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795603509;
	bh=sLt+a9fi/9onyCn4ayksBFwRvlKuZDZt6ri4AUiJyk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IT9ZruDPWI10God876df7jQXNp6mJWufLZaFIQTmOj6yYD/mlFuELIrWqTe/nP/fV
	 81oY+e1KrOrlDssL1LhYHO7fdTOqvNQ1yrfsQSn5Xt+jp7dvcBXGGHhS0f58hGxPEv
	 E056ngiaGK/AYQ6TDVXwGfFfHhsb1lU8YLU3NHWO83sGzFwyPmip2ArKfPOJ3ujSO2
	 F2aVQN2w0r+wAqyiCbDsyS626Aoz5DqzVwJqV4EMOW6d4tZPb22UqXn34bjNWI4kzH
	 KKJh6/uyFOmrlJdC9WnZG4GouvLN/4BCGDBlE58Wu9tQtl8Q41ywp89DbTjX2IknY9
	 N5ujGz5P4Ll7A==
Message-ID: <sashiko-outbox-233155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] PCI: qcom: Recalibrate the PHY on temperature drift
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125-glymur-thermal-fix-v1-3-b93a9feae156@oss.qualcomm.com>
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
 <20261125-glymur-thermal-fix-v1-3-b93a9feae156@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:45:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [Medium] PCI: qcom: qcom_pcie_recalib_work() checks target speed
  instead of link state
- [Medium] PCI: qcom: qcom_pcie_recalib_work() corrupts TLS and updates
  ref temp on error
- [Medium] PCI: qcom: qcom_pcie_suspend_noirq() leaves recalib_work
  disarmed on error
- [Medium] PCI: qcom: qcom_pcie_recalib_init() error unwind races with
  active global IRQ
- [Medium] PCI: qcom: qcom_pcie_recalib_work() races with Root Port
  suspend and D3hot
- [Medium] PCI: qcom: stale recalibration reference temp after resume
  and port reset
- [Low] PCI: qcom: missing CONFIG_PCIEPORTBUS dependency for
  pcie_set_target_speed()
- [Low] PCI: qcom: remove unused linux/atomic.h header inclusion
--

commit 2b6d79564efc85fd7cf5340b7e493d9126e31fcc
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI: qcom: Recalibrate the PHY on temperature drift

This commit adds periodic thermal zone polling to recalibrate the PCIe PHY =
on
temperature drift by stepping the Root Port target link speed down to 2.5 G=
T/s
and restoring it.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index d903f10211c23..fb11718cea39b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -8,6 +8,7 @@
>   * Author: Stanimir Varbanov <svarbanov@mm-sol.com>
>   */
> =20
> +#include <linux/atomic.h>

[Severity: Low]
linux/atomic.h does not appear to be used in this file.

[ ... ]

> @@ -1839,6 +1858,197 @@ static void qcom_pcie_icc_opp_update(struct qcom_=
pcie *pcie)
>  	}
>  }
> =20
> +static int qcom_pcie_recalib_update_ref_temp(struct qcom_pcie *pcie)
> +{
> +	unsigned int i;
> +	int temp, ret;
> +
> +	for (i =3D 0; i < pcie->recalib_num_zones; i++) {
> +		struct qcom_pcie_recalib_zone *zone =3D &pcie->recalib_zones[i];
> +
> +		ret =3D thermal_zone_get_temp(zone->tz, &temp);
> +		if (ret)
> +			return ret;
> +
> +		zone->ref =3D temp;
> +	}
> +
> +	return 0;
> +}
> +
> +#define QCOM_PCIE_RECALIB_INTERVAL_MS	5000
> +
> +static void qcom_pcie_recalib_arm_worker(struct qcom_pcie *pcie)
> +{
> +	if (!pcie->recalib_wq)
> +		return;
> +
> +	queue_delayed_work(pcie->recalib_wq, &pcie->recalib_work,
> +			   msecs_to_jiffies(QCOM_PCIE_RECALIB_INTERVAL_MS));
> +}
> +
> +static void qcom_pcie_recalib_work(struct work_struct *work)
> +{
> +	struct qcom_pcie *pcie =3D container_of(work, struct qcom_pcie,
> +					      recalib_work.work);
> +	struct dw_pcie_rp *pp =3D &pcie->pci->pp;
> +	struct device *dev =3D pcie->pci->dev;
> +	struct pci_dev *port __free(pci_dev_put) =3D pci_get_slot(pp->bridge->b=
us, PCI_DEVFN(0, 0));
> +	enum pci_bus_speed speed;
> +	bool drifted =3D false;
> +	unsigned int i;
> +	u16 lnkctl2;
> +	int temp, ret;
> +
> +	if (!port || !port->subordinate)
> +		goto rearm;
> +
> +	scoped_guard(mutex, &pcie->reset_lock) {
> +		for (i =3D 0; i < pcie->recalib_num_zones; i++) {
> +			struct qcom_pcie_recalib_zone *zone =3D &pcie->recalib_zones[i];
> +
> +			ret =3D thermal_zone_get_temp(zone->tz, &temp);
> +			if (ret) {
> +				dev_err(dev, "Failed to read %s: %d\n",
> +					thermal_zone_device_type(zone->tz), ret);
> +				continue;
> +			}
> +
> +			if (abs(temp - zone->ref) >=3D zone->drift)
> +				drifted =3D true;
> +		}
> +
> +		/* No zone has drifted far enough to need a recalibration */
> +		if (!drifted)
> +			break;
> +
> +		ret =3D pcie_capability_read_word(port, PCI_EXP_LNKCTL2, &lnkctl2);
> +		if (ret !=3D PCIBIOS_SUCCESSFUL)
> +			break;
> +
> +		speed =3D PCIE_LNKCTL2_TLS2SPEED(lnkctl2);
> +		if (!pcie_valid_speed(speed))
> +			break;
> +
> +		/*
> +		 * Equalization only runs at 8.0 GT/s and above, so a slower
> +		 * link has nothing to recalibrate.
> +		 */
> +		if (speed >=3D PCIE_SPEED_8_0GT) {

[Severity: Medium]
Can this trigger link retraining when no endpoint is attached, when the link
is down, or when the negotiated link speed is below 8.0 GT/s?

pci_host_probe() enumerates the Root Port and allocates port->subordinate e=
ven
when dw_pcie_wait_for_link() fails with -ENODEV, and dw_pcie_setup_rc()
initializes PCI_EXP_LNKCTL2_TLS to the controller's maximum supported speed.
Because this checks the configured target speed in PCI_EXP_LNKCTL2 rather t=
han
whether the link is active and currently operating at 8.0 GT/s or above
(port->subordinate->cur_bus_speed), temperature drift will attempt speed
changes and retrain the link on disconnected slots or Gen 1/Gen 2 endpoints.
In addition, if a Gen 3+ link has downtrained to 2.5 GT/s while TLS remains
>=3D 8.0 GT/s, pcie_set_target_speed(port, PCIE_SPEED_2_5GT, true) returns 0
early without updating PCI_EXP_LNKCTL2_TLS because bus->cur_bus_speed is
already 2.5 GT/s.

> +			ret =3D pcie_set_target_speed(port, PCIE_SPEED_2_5GT, true);
> +			if (ret)
> +				dev_err(dev, "Failed to step down the link speed: %d\n", ret);
> +
> +			/*
> +			 * The device below may not be able to train to the
> +			 * original Target Link Speed, which is reported as
> +			 * -EAGAIN even though the speed was restored.
> +			 */
> +			ret =3D pcie_set_target_speed(port, speed, true);
> +			if (ret && ret !=3D -EAGAIN)
> +				dev_err(dev, "Failed to restore the link speed: %d\n", ret);
> +		}
> +
> +		/*
> +		 * Update the reference temperature of every zone and not just
> +		 * of the one that drifted, so all of them measure their next
> +		 * drift from the same point in time.
> +		 */
> +		ret =3D qcom_pcie_recalib_update_ref_temp(pcie);
> +		if (ret)
> +			dev_err(dev, "Failed to update the reference temperature: %d\n", ret);
> +	}

[Severity: Medium]
If stepping down to 2.5 GT/s fails in pcie_retrain_link() after
pcie_bwctrl_change_speed() has written 2.5 GT/s to PCI_EXP_LNKCTL2_TLS, can
PCI_EXP_LNKCTL2_TLS be left stuck at 2.5 GT/s?

When the step-down retrain fails, port->subordinate->cur_bus_speed remains =
at
the original speed, so the subsequent restore call hits the early return in
pcie_set_target_speed():

drivers/pci/pcie/bwctrl.c:pcie_set_target_speed() {
    ...
	if (bus && bus->cur_bus_speed =3D=3D speed_req)
		return 0;
    ...
}

That skips writing the original target speed back to PCI_EXP_LNKCTL2, leavi=
ng
TLS at 2.5 GT/s so future recalibrations are skipped and any later retrain
drops the link to 2.5 GT/s.  Also, qcom_pcie_recalib_update_ref_temp() runs
even when pcie_set_target_speed() fails, advancing zone->ref as if
recalibration succeeded.

> +
> +rearm:
> +	qcom_pcie_recalib_arm_worker(pcie);
> +}
> +
> +#define QCOM_PCIE_RECALIB_ZONE_CELLS	2
> +
> +static int qcom_pcie_recalib_get_zones(struct qcom_pcie *pcie)
> +{
> +	const char *prop =3D "qcom,pcie-recalibration-thermal-zones";
> +	struct device *dev =3D pcie->pci->dev;
> +	struct of_phandle_args args;
> +	unsigned int i, num_zones;
> +	int ret;
> +
> +	ret =3D of_count_phandle_with_args(dev->of_node, prop, NULL);
> +	if (ret =3D=3D -ENOENT)
> +		return 0;
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "%s requires CONFIG_THERMAL_OF\n", prop);

[Severity: Low]
Should this or Kconfig also check for CONFIG_PCIEPORTBUS?  When
CONFIG_PCIEPORTBUS is disabled, pcie_set_target_speed() is a stub returning
-EOPNOTSUPP, so qcom_pcie_recalib_work() will fail and log an error on every
temperature drift.

[ ... ]

> +static int qcom_pcie_recalib_init(struct qcom_pcie *pcie)
> +{
> +	struct device *dev =3D pcie->pci->dev;
> +	int ret;
> +
> +	if (!pcie->recalib_num_zones)
> +		return 0;
> +
> +	pcie->recalib_wq =3D alloc_workqueue("pcie-recalib/%s",
> +					   WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
> +					   0, dev_name(dev));

[Severity: Medium]
Can qcom_pcie_recalib_work() race with Root Port runtime PM or system suspe=
nd
before qcom_pcie_suspend_noirq() cancels it?

Because the platform device is the parent of the PCI host bridge, the Root
Port and downstream devices run pci_pm_suspend_noirq() (saving PCIe state a=
nd
entering PCI_D3hot) before qcom_pcie_suspend_noirq() runs, and runtime PM c=
an
also put the Root Port into PCI_D3hot:

CPU0                                  kworker
pci_pm_suspend_noirq(&port->dev)      qcom_pcie_recalib_work()
                                        pcie_set_target_speed(..., 2.5GT)
  pci_save_state(port)
    pci_save_pcie_state(port)
      /* saves 2.5 GT/s in LNKCTL2 */
  pci_prepare_to_sleep(port)
    /* transitions port to D3hot */
                                        pcie_set_target_speed(..., speed)
                                          /* retrains link in D3hot */
qcom_pcie_suspend_noirq(dev)
  cancel_delayed_work_sync(...)

On resume, pci_restore_pcie_state() will restore the saved 2.5 GT/s Target
Link Speed and permanently downgrade the link, or the worker can access
suspended thermal sensors and retrain the link while the port is in PCI_D3h=
ot.

[ ... ]

> @@ -2430,6 +2644,10 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
> =20
>  	qcom_pcie_icc_opp_update(pcie);
> =20
> +	ret =3D qcom_pcie_recalib_init(pcie);
> +	if (ret)
> +		goto err_host_deinit;

[Severity: Medium]
What happens if qcom_pcie_recalib_init() fails after the global IRQ has been
requested and PARF_INT_ALL_LINK_DOWN unmasked?

Jumping to err_host_deinit calls dw_pcie_host_deinit(), which frees
pp->bridge->bus, stops the link, and disables clocks via
qcom_pcie_host_deinit() while the devm-managed qcom_pcie_global_irq_thread()
is still active:

CPU0                                  <irq/qcom_pcie_global_irq_thread>
qcom_pcie_probe()
  qcom_pcie_recalib_init() -> err
  dw_pcie_host_deinit(pp)
    pci_remove_root_bus(...)
      pp->bridge->bus =3D NULL
    dw_pcie_stop_link(pci)
    qcom_pcie_host_deinit(pp)
                                      writel_relaxed(..., pcie->parf + ...)
                                      for_each_pci_bridge(port,
                                                          pp->bridge->bus)
                                        <-- NULL pointer dereference

In addition, qcom_pcie_host_deinit() only calls
pci_pwrctrl_power_off_devices() and does not destroy the pwrctrl devices
created in qcom_pcie_host_init(), leaking them on probe failure.

>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
> =20
> @@ -2464,6 +2682,10 @@ static int qcom_pcie_suspend_noirq(struct device *=
dev)
>  	if (!pcie)
>  		return 0;
> =20
> +	/* Recalibration touches config space, so it must not run past here */
> +	if (pcie->recalib_wq)
> +		cancel_delayed_work_sync(&pcie->recalib_work);
> +
>  	ret =3D dw_pcie_suspend_noirq(pcie->pci);
>  	if (ret)
>  		return ret;

[Severity: Medium]
If dw_pcie_suspend_noirq() or the subsequent icc_set_bw() call fails in
qcom_pcie_suspend_noirq(), does recalib_work stay permanently cancelled?

When suspend_noirq returns an error, the PM core does not mark the device as
noirq-suspended and skips qcom_pcie_resume_noirq() during rollback, so
qcom_pcie_recalib_arm_worker() is never called again.

> @@ -2575,6 +2797,8 @@ static int qcom_pcie_resume_noirq(struct device *de=
v)
> =20
>  	qcom_pcie_icc_opp_update(pcie);
> =20
> +	qcom_pcie_recalib_arm_worker(pcie);

[Severity: Medium]
Should qcom_pcie_recalib_update_ref_temp() be called when the PHY is
re-initialized and retrained in qcom_pcie_resume_noirq() (when
pcie->pci->suspended is true) and in qcom_pcie_reset_root_port()?

In both paths, qcom_pcie_host_init() and dw_pcie_start_link() power-cycle t=
he
PHY and train the link at the current temperature, but zone->ref is left at
the pre-suspend or pre-reset temperature.  If the temperature shifted by le=
ss
than zone->drift while suspended and then drifts further in the opposite
direction after resume, the PHY can drift by up to nearly twice zone->drift
from its post-resume calibration temperature without triggering recalibrati=
on.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-glymur-the=
rmal-fix-v1-0-b93a9feae156@oss.qualcomm.com?part=3D3
