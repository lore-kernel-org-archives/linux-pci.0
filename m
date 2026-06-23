Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473C2DF15C
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240587; cv=none; b=MmwDa2wSfPwbXIJ4QeJdEaqedbnUe9XSId+ij0nsI6W/VSrxirKi/ctxLMk1CF0Ww18xN5m0y4Xywpx0JZoZcudUdDDuxAU7RBGK99JYknaRI7mrDiqMdEdp8PBMhzz4Xt0rlhDHmmbc7FiHXT06RJNrWtdwkan6BLM6VcXrRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240587; c=relaxed/simple;
	bh=/ElkxwYQtKwdFHIfeTWMn1xGNsmUkRF9INlIfQrA6+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NaOT/LwoUpsOkj2lBOSlvnrvb3aA0+cFT7VRkhzIltKmM+1VZnO2TK4sZ8NGHMp5HPjHde8H8tmKNfcsDlfx9QkRe7UgL7tNLMi/OSe/RBe/c8voEHb/yc9ajxTQNazC8KfhubAi5JlGMOwPFiH38THRMpwf/Mg6IWV5Il0e+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei2BbX4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei2BbX4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F411A1F000E9;
	Tue, 23 Jun 2026 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782240586;
	bh=mqGhEnOmwFm70yH0R5kDS576qy3dMQvjy1NKicaGyLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ei2BbX4ghngp2dB8J1ooNG2NwmQS9z1Y1OzyP7Yh1CkNxWFe3GoMj28jbPJi1G+xl
	 2+bod+hfNyQ3Zr8hkZmiTxN5bGuS76VIVZzAa8USG0cG2GW4Z8+8me4jrjgumJf6DW
	 MudrggZYwKDhT3dOF+Nh1SnKCwKG3O7iYquprWLxitO5zzCtstU6cuERt3SA/CrNhR
	 6NyCLl509CGlYIqSbQBD18lGcdFHUk6/8kcYwo9oQEF5BcloeouMP/WnsayrsJJyIm
	 ioz69G1tHL61h1CrBraDk3qfdtt+qBGLj6T9kFLnQXdJRPPqkLSE5m+/RYa4C0kWNY
	 zveco+HTaQRtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] Add device-specific reset for Qualcomm devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623183115.1585273-1-jtornosm@redhat.com>
References: <20260623183115.1585273-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 18:49:45 +0000
Message-Id: <20260623184945.F411A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unvalidated BAR length allows an out-of-bounds MMIO access, leadin=
g to a kernel page fault.
- [Medium] The polling loop for PCIe link recovery skips checking the regis=
ter entirely if the thread is preempted or delayed, leading to a false time=
out failure.
--

commit 0bc922fa348200a554286ab131ffa7ae41d959f1
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Add device-specific reset for Qualcomm devices

This commit adds device-specific reset methods for some Qualcomm PCIe
devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems) that lack
working reset methods for VFIO passthrough scenarios. The new methods
use BAR-space hardware reset registers to provide true hardware resets.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..cd3486aadedad 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

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

[Severity: High]
Can this lead to an out-of-bounds MMIO access if a spoofed device advertises
a truncated BAR?

Since pci_iomap() is called without validating the length of BAR 0, if a
malicious or malfunctioning device advertises a length shorter than the
accessed offset (0x3008), reading from the unmapped memory could trigger
a kernel page fault.

Should pci_resource_len(pdev, 0) be checked against the maximum offset
before accessing the registers?

> +	val |=3D QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
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
> +	while (time_before(jiffies, timeout)) {
> +		val =3D ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +		if (val !=3D 0xffffffff) {
> +			link_recovered =3D true;
> +			break;
> +		}
> +		msleep(20);
> +	}
> +
> +	if (!link_recovered) {

[Severity: Medium]
Could this loop return a false timeout if the thread is preempted?

If the scheduler delays the thread for longer than the timeout period just
before the loop starts or during msleep(), time_before() would return false
and the loop would exit without a final check of the hardware register.

Should there be a final register read after the loop (similar to what is do=
ne
in reset_hinic_vf_dev()), or could read_poll_timeout() be used here instead?

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

[Severity: High]
Is a BAR length check needed here as well to prevent out-of-bounds accesses
for MHI_SOC_RESET_REQ_OFFSET (0xb0)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623183115.1585=
273-1-jtornosm@redhat.com?part=3D1
