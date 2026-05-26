Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2A3CAE74;
	Tue, 26 May 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789498; cv=none; b=X+EHioG6WNhc+IhfDSnE5N9A7pR+bOG+OJ91AQ5kYlJswRkz8pEEliH5k7jhtqE/iqNvu6OEyCGMHIDShLJg7j8PUX9cginJdXCHzlUn+idCMtf3ZSYb9V3/S67kkPeIiSq+pWbOmrrWG7wd8ES6e7stmneSdk2k2WQWiIItNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789498; c=relaxed/simple;
	bh=KT5kWMKmVPL6w0rKVQ1vm8hOH1tc1nglBRT5f5U8y9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=unl4dt7zbwl21K7zp5LyhTUAGP5lOojSEEkpZe4wyhwS95JYCRBoLRzHCW1/0YeXqNIhRG25EYx14W3IDLEDxbzuPSMcB4Xzk2DYf2JyXbDmUu8vKQAlYz03YTl82Q8IePHv9yShlAOllKcPz/ABkEtfdeeH1Gbua6j8OwGUGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqQN5jBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqQN5jBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783061F000E9;
	Tue, 26 May 2026 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789497;
	bh=uA5NhkbDkIgEGwM2hOxFD456ASr++z1K/LIMVB2rLqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqQN5jBFY+rg0VteIrEadzA0DYhaNw84W84EHZj7A+2/yRUCAeG3kaiaf5haaZV0e
	 MsoAE+PCjPigIlQD30qw96mhph3yPoFrUP1E6q3iY7WGCZF9W4TVfRcnw2SyqIWBnO
	 FG9R+x2e0H00qNaTWuPf43Br+IRul/d4hZhReahsOVRQPhXNzyJks+xiAjOedfHaBd
	 55hLT6PD5UBDTJTrKft5PcrKqlh3LkJscVa09eGQt1FqdtJ1JIe3ETVa5XRWUQf2DE
	 aOEjtH3s5HJz0M0hJ1SYrrbjcj4UeUISHLPqiiSdQGBul/ziAlD1oh9CjtJ1hrqxdQ
	 TCg9zPtLfqFbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] PCI: tegra: Add Tegra264 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260526-tegra264-pcie-v5-3-84a813b979d7@nvidia.com>
References: <20260526-tegra264-pcie-v5-3-84a813b979d7@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:58:15 +0000
Message-Id: <20260526095815.783061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [High] Missing `err` argument in `dev_err_probe()` call.
- [High] Passing `ERR_PTR(err)` to the integer `err` argument of `dev_err_p=
robe()`.
- [High] Call to undefined function `tegra_pcie_deinit()` in the suspend ca=
llback.
- [High] The probe function returns success when the link is down but frees=
 resources, causing a kernel crash on removal.
- [High] The driver calls a non-existent runtime PM API `devm_pm_runtime_ac=
tive_enabled()`.
- [High] The PCIe bandwidth request calculation always evaluates to 0 MBps.
- [High] Calling sleeping functions inside a noirq PM callback.
- [High] Ignoring the return value of `pm_runtime_get_sync()` leads to unsa=
fe hardware access and kernel crashes.
- [Medium] Leaking the BPMP reference if runtime PM initialization fails.
- [Medium] Unbalanced `pm_runtime_disable()` call during driver removal.
- [Medium] Wake IRQ is mapped and enabled for wakeup but never actually req=
uested.
- [Low] Missing `pm_ptr()` wrapper for the PM operations structure pointer.
--

commit f706a8f756af69546e040928eae0b5849025ac5c
Author: Thierry Reding <treding@nvidia.com>
Subject: PCI: tegra: Add Tegra264 support

This patch adds a driver for the PCIe controller found on NVIDIA Tegra264 S=
oCs,
setting up address translation registers and creating a standard PCI host
using ECAM.

> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/control=
ler/pcie-tegra264.c
> new file mode 100644
> index 0000000000000..0b8e0f724e251
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
[ ... ]
> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width;
> +	int err;
> +
> +	value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	value =3D Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(speed));

[Severity: High]
Does this calculation evaluate to 0 MBps? The speed variable is populated
with the raw hardware CLS value, but PCIE_SPEED2MBS_ENC() expects a mapped
enum pci_bus_speed constant. If the raw values do not match the expected
constants, the macro evaluates to 0, which would heavily throttle performan=
ce.

[ ... ]
> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	if (tegra_is_silicon()) {
> +		pcie->bpmp =3D tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
> +		if (IS_ERR(pcie->bpmp))
> +			return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
> +					     "failed to get BPMP\n");
> +	}
> +
> +	err =3D devm_pm_runtime_active_enabled(dev);

[Severity: High]
Does devm_pm_runtime_active_enabled() exist in the kernel tree? It appears
this might be a typo for devm_pm_runtime_enable() or a similar helper, which
would cause a compilation error due to an unresolved symbol.

[Severity: Medium]
If the devm_pm_runtime_active_enabled() call fails and the function returns
early, does this leak the BPMP reference? It looks like tegra_bpmp_put()
is not called on this error path.

> +	if (err < 0)
> +		return dev_err_probe(dev, "failed to enable runtime PM\n");

[Severity: High]
Does this dev_err_probe() call have the correct number of arguments? It see=
ms
the integer error code argument is missing. This will cause the format stri=
ng
to be cast to the integer err parameter, leading to an uninitialized format
string and a likely crash or compilation error.

> +
> +	pm_runtime_get_sync(dev);

[Severity: High]
Should the return value of pm_runtime_get_sync() be checked here? If poweri=
ng
on the device fails, the driver proceeds to read MMIO registers during the
subsequent tegra264_pcie_check_ranges() call. Accessing unpowered hardware
registers can trigger a synchronous external abort and kernel panic.

[ ... ]
> +	tegra264_pcie_init(pcie);
> +
> +	if (!pcie->link_up)
> +		goto free_ecam;

[Severity: High]
If the link is not up, does this branch cause probe() to return success
while freeing the ECAM resources? The err variable is not set to a negative
error code before the goto. This would cause the driver to bind successfull=
y,
but pcie->bridge->bus would remain uninitialized, leading to a NULL pointer
dereference during unbind in tegra264_pcie_remove().

> +
> +	err =3D pci_host_probe(bridge);
> +	if (err < 0) {
> +		dev_err_probe(dev, ERR_PTR(err), "failed to register host\n");

[Severity: High]
Is ERR_PTR(err) the correct argument to pass here? dev_err_probe() expects =
an
integer as its second parameter. Passing a pointer could cause a build
breakage or result in incorrect error logging.

[ ... ]
> +static void tegra264_pcie_remove(struct platform_device *pdev)
> +{
[ ... ]
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

[Severity: Medium]
Since a devres helper is used in probe to enable runtime PM, it will
automatically queue a pm_runtime_disable() call on removal. Does calling it
explicitly here cause an unbalanced disable_depth counter? If the driver is
unbound and rebound, the counter might remain greater than 0, breaking
runtime PM for this device permanently.

[ ... ]
> +static int tegra264_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	tegra_pcie_deinit(pcie);

[Severity: High]
Is tegra_pcie_deinit() a typo? The driver defines the deinitialization
function as tegra264_pcie_deinit(pcie). Calling an undefined function will
cause a build failure.

> +
> +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> +		err =3D enable_irq_wake(pcie->wake_irq);

[Severity: Medium]
Is there a registered interrupt handler for this wake IRQ? The IRQ is mapped
and enabled for wakeup, but it does not seem to be requested anywhere via
request_irq() or dev_pm_set_wake_irq(). When the IRQ triggers, the kernel
will likely find no action handler, log a spurious interrupt error, and
permanently mask the IRQ, breaking subsequent wakeups.

[ ... ]
> +static int tegra264_pcie_resume_noirq(struct device *dev)
> +{
[ ... ]
> +	if (pcie->link_up =3D=3D false)
> +		return 0;
> +
> +	tegra264_pcie_init(pcie);

[Severity: High]
Can tegra264_pcie_init() safely run in a noirq callback? The callback execu=
tes
with hardware interrupts disabled, but tegra264_pcie_init() invokes sleeping
functions like usleep_range() and msleep(). Calling sleeping functions in an
atomic or noirq context will trigger a system hang or kernel bug.

[ ... ]
> +static struct platform_driver tegra264_pcie_driver =3D {
> +	.probe =3D tegra264_pcie_probe,
> +	.remove =3D tegra264_pcie_remove,
> +	.driver =3D {
> +		.name =3D "tegra264-pcie",
> +		.pm =3D &tegra264_pcie_pm_ops,

[Severity: Low]
Should the pm operations pointer be wrapped with pm_ptr()? Directly assigni=
ng
it without the wrapper prevents the compiler from eliminating the dev_pm_ops
structure as dead code when PM support is disabled.

> +		.of_match_table =3D tegra264_pcie_of_match,
> +	},
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-tegra264-p=
cie-v5-0-84a813b979d7@nvidia.com?part=3D3
