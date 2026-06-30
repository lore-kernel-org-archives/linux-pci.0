Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F43769FF
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803356; cv=none; b=eQZaZA4wmXMz7Dg3iUxrhJSTyWeGRHuQn9LTPO5D9a/CPW40o8Rk+Tp27IpaIlcWXIMG2wEYYZooaxB/S6uVE6R8/3K+u3UHsmBMtV9qdVnHy4ZFMU+JIzzDkT5AFO70nzKqp2Kvfb8Js+o3VameOOnrzXYeUfVqUboJGr0F/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803356; c=relaxed/simple;
	bh=OPsPLV1iijLPEOl4AgbF7IQFsPg6/WnRxxyRPVsWiU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bt8n2QSUrELPgqcegM/9L6iLgpJ9eCLBxFFHuTwwqu0Zp6VGQ06ICYWqZOY+vS57rWgmyg4/bqBdPWlb0sWZzAO75GQYwv8lANzbHeByQYfxh65koTEWkfs8LBhURAa8oXQNmKGuPu0blRB5lrpCOcL8rS9qzII9r6exRNW1138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+gJblhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+gJblhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5E61F000E9;
	Tue, 30 Jun 2026 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782803354;
	bh=SMeblETSb8ICs3HuSQo/taKTJo2rIihcx8wPSNlGZQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+gJblhCJzyA+H2hSe9r87G/DiiYBeWlGeJnEBXA24gDat2xCJfa/Z50Q3uqtkcVU
	 8UIFhhNStO8f7YFcVqGYbqsMv6hK4a49bWC0r0ZdJp43tlrvS46ROIJhBSUhFYabNW
	 Y/1bhbRdqwGEqp3Z/ybTnBQ/gqLc7/a3ozOlmUo9U9LV5ewpX4w3npQtileXn379xc
	 t+brfAktlyuS/n+ObW7Yyom2QY43UTW19Y2bzuyUHnG0rDRg92dDjJjBAPnWWN4CsX
	 jX1sK4dOldRMbU2mNTm5UVsWmcFYN4UWMIiFvlODK1b/Wm42rNiQJuMB3G6QHoz8se
	 70yhzuX8R4H1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12] PCI: Add device-specific reset for Qualcomm devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260630065815.199693-1-jtornosm@redhat.com>
References: <20260630065815.199693-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:09:13 +0000
Message-Id: <20260630070914.3B5E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The polling loop for PCIe link recovery lacks a final condition =
check, making it vulnerable to spurious timeouts if the executing thread is=
 delayed or preempted.
- [Medium] Read-modify-write operation on the SoC global reset register doe=
s not handle `0xFFFFFFFF` (PCI_ERROR_RESPONSE), potentially writing an inva=
lid state to the device.
--

commit 6f0f5be433a0e989c17f01ae046c3574dc1fbf77
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm devices

This commit adds device-specific hardware reset methods via BAR0 for=20
specific Qualcomm PCIe devices (WCN6855/WCN7850 WLAN cards and SDX62/SDX65=
=20
modems). These resets are intended to fix issues during VFIO passthrough=20
scenarios where the devices lack a working FLR or standard reset mechanism.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..6d465f6d43054 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> +static int reset_qualcomm_wlan(struct pci_dev *pdev, bool probe)
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
> +	val =3D ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +	val |=3D QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);

[Severity: Medium]
If the device is hung or the link is temporarily unresponsive, could the
initial ioread32() return PCI_ERROR_RESPONSE (0xFFFFFFFF)?

If it does, this read-modify-write operation would write 0xFFFFFFFF (and
later 0xFFFFFFFE) back to the device. Could writing these values trigger
unintended resets across the SoC or leave the hardware in an invalid state?

Would it be safer to verify !PCI_POSSIBLE_ERROR(val) before modifying
and writing it back?

> +	ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	val &=3D ~QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	timeout =3D jiffies + msecs_to_jiffies(5000);
> +	while (time_before(jiffies, timeout)) {
> +		val =3D ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);
> +		if (!PCI_POSSIBLE_ERROR(val)) {
> +			link_recovered =3D true;
> +			break;
> +		}
> +		msleep(20);
> +	}

[Severity: Medium]
Is this polling loop vulnerable to false timeouts due to scheduling delays?

If the thread is preempted during msleep(20) and delayed for more than 5
seconds, time_before(jiffies, timeout) will evaluate to false upon waking
up. The loop will exit without a final check of the register, returning
-ETIMEDOUT even if the link successfully recovered during the delay.

Should there be a final condition check after the loop, or perhaps use
read_poll_timeout() instead to handle preemption robustly?

> +
> +	if (!link_recovered) {
> +		pci_err(pdev, "PCIe link failed to recover after reset\n");
> +		goto out_restore;
> +	}
> +
> +	/* After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set
> +	 * and thus need to set MHICTRL_RESET to clear SYSERR.
> +	 */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630065815.1996=
93-1-jtornosm@redhat.com?part=3D1
