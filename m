Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12E2580CF
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453762; cv=none; b=R7nVNRxlKP+4LoQi0V8/qR5Q4LgALI+0L3q3ZZw8pBhWGFXUQpZmeaUNPPxeD7MvxdGxJUISWmRPkvzbxPml8fzlSViK+r33pbcF7MQePnxaK3FySmOPoX4Cml/mEy4DeEZ9tDbun7v0tmYqgm9OfbfWnFvHNjE/cs+TReARM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453762; c=relaxed/simple;
	bh=tZuhb8Ka7bzIrjYKQJ2jd/nNz6StFxEQYK71p8um7hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vi8BWR/6tclULZcP+9s5EWV9yHpUKjKugcX+IEKlalvX+H5CoFNaqEd+QaoTxj199h6NvlSurOfIGnr1+1OivhoKdawswPL8s9y3nSQa/YyD7knmN52hjoGpsC7Wv77xYr65UV3d8xl5NZv1fNNRNYBQTX5WSPUQ0o0qSIjsT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXqfP0CJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXqfP0CJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E51F000E9;
	Fri, 26 Jun 2026 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782453761;
	bh=iRtMM0EcyIk580/siqTUbFTR+gD8Bss7DWyBV0BgL4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXqfP0CJ9PVURUTOYGoQEDk6adNLXSuMZZaF2DkcUZEKXgEF37QKSVl3hftT5//Ks
	 nBuN9+qMeKuytn6n9ysygdij8NiXZXD7D30Y8rXavmly2nlUXavVoRDl8AxC2RQqQE
	 id1+fDjbzMjrm/DxQFogEXIdCFsvwQsKYwo7g6gVzAi9gyWn8SeeiDaGQHdarLPENf
	 GQt5hyZfgt2qXf0WkvodlKFPiI7nBbXGtPH3fybiximwSfMWxIh2p5YjJw12vQtfdp
	 XbxN/MUaO6tiNFJ43dKlcgHiorQU6Q9zyr3EgDaSViLmU9ENuhgpDcYwti3LQtegfO
	 0HkVH5rk4AtCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] PCI: Add device-specific reset for Qualcomm devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260626055023.197470-1-jtornosm@redhat.com>
References: <20260626055023.197470-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 06:02:40 +0000
Message-Id: <20260626060240.D10E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The condition checking for PCIe link recovery evaluates to always-=
true due to a type promotion mismatch, completely bypassing the 5-second wa=
it loop.
- [Medium] The `reset_qualcomm_wifi` function performs a read-modify-write =
on a hardware register without verifying if the initial read succeeded.
- [Medium] The polling loop for PCIe link recovery does not perform a final=
 condition check after the timeout, potentially causing false failures if t=
he thread is delayed by the scheduler.
- [Medium] The device-specific reset methods may trigger a SoC hardware res=
et that drops the PCIe physical link, which would cause the upstream port t=
o generate unmasked hotplug events.
--

commit 632c19d8e3a5ffaea7401f14cf4ba2e70f72cb54
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: PCI: Add device-specific reset for Qualcomm devices

This commit adds device-specific reset methods for certain Qualcomm PCIe
devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems) that lack working
reset methods for VFIO passthrough. It implements true hardware reset
mechanisms using BAR-space hardware reset registers.

> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4227,6 +4227,120 @@ static int reset_hinic_vf_dev(struct pci_dev *pde=
v, bool probe)

[ ... ]

> +static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
> +{
> +	bool link_recovered =3D false;
> +	unsigned long timeout;
> +	void __iomem *bar;
> +	u32 val;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar =3D pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	val =3D ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	val |=3D QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);

[Severity: Medium]
If the device is already hung and the initial ioread32() returns 0xFFFFFFFF
due to a completion timeout, does this read-modify-write sequence blindly
write 0xFFFFFFFF back to the hardware? Could writing all 1s to a global SoC
reset register overwrite reserved bits or place the device in an undefined
state?

> +
> +	msleep(10);
> +
> +	val &=3D ~QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	timeout =3D jiffies + msecs_to_jiffies(5000);

[Severity: Medium]
If this SoC hardware reset physically drops the PCIe link, and this port is
hotplug-capable, will the upstream Root Port generate unmasked Surprise
Link Down events? Since pci_dev_specific_reset() runs without masking link
change events, could pciehp asynchronously remove the device from the bus
while this reset is polling, breaking the VFIO passthrough?

> +	while (time_before(jiffies, timeout)) {

[Severity: Medium]
If the executing thread is preempted or experiences a scheduling delay just
before evaluating time_before(jiffies, timeout), and the delay pushes
jiffies past the timeout, will the loop exit immediately without a final
hardware check? Could this falsely report a timeout failure even if the
device recovered during the delay window? Should this perform a final check
after the loop, or perhaps use read_poll_timeout()?

> +		val =3D ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +		if (val !=3D PCI_ERROR_RESPONSE) {

[Severity: High]
Since val is a u32 and PCI_ERROR_RESPONSE is a 64-bit value (~0ULL), will C
type promotion zero-extend val to 64 bits and cause this condition to always
be true? When the device is unresponsive and returns 0xFFFFFFFF, does this
bypass the 5-second wait loop and falsely report success? Would it be better
to use the standard !PCI_POSSIBLE_ERROR(val) macro here?

> +			link_recovered =3D true;
> +			break;
> +		}
> +		msleep(20);
> +	}
> +
> +	if (!link_recovered) {

[ ... ]

> +static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
> +{
> +	void __iomem *bar;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar =3D pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
> +	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);
> +
> +	/* Be sure device reset has been executed */
> +	msleep(2000);

[Severity: Medium]
If this modem SoC reset also drops the PCIe physical link, does it suffer
from the same unmasked hotplug event issue described above?

> +
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626055023.1974=
70-1-jtornosm@redhat.com?part=3D1
