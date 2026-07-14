Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633572931C7
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056676; cv=none; b=po/Y9KlUCcxdkJDyPq48dQW45uT4evAIkflemS3wnqQE1CbRjafDST3CIRm9ULJEvuYWIEYBDAl59DjQ+orEM2mhOka23au2QcjX987YQUbJitd0XrGq9dl3IeCW00Eww1G3gexVtssOd7pm+R4Gx3ZolnJfwupAfRlg50+NgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056676; c=relaxed/simple;
	bh=j7mLnIIyzRGGwvfWsv85UQns2J2r+eZZo4X94E2QUNg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ae+MkhMfICTzq43g3Y6PvN328bG4Sq2zFt022Uc4/ee8t/YdpjBkNCeNlDia7I2jzIcvH8pnaU2x+k5qsHf7fBoEA/UaxzOLhoT4Q3+5r87JGHGJ+xv2vltfvM8QP5YkSb04XXGs0wHrDKZ9k1B4kG8BUvGtOc5j5uD3vHrt4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaPTiWPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaPTiWPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C387F1F000E9;
	Tue, 14 Jul 2026 19:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056675;
	bh=TAmBJb5gjf1BMA4k8Md3N+evo9cVfrNud05RWMbfzyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QaPTiWPTM76U8rgQqqgoMOePAX8x81t+Aj4lQmCQlp8KcguIUx9iSEo+jg51M0o36
	 BlEvn6lENQ7u1SRJxAxsPdoBZ9rDIWbiNSvqX0dZfeYmZYy8PwW7hJmmBzT0rY/d1s
	 eUXp5TuwbI4tFresv+3n3bNZZ+lXoYgMzi5FQZzCP1EPyNiKyUn6dQ6smnm9fVhChE
	 TcDqtWYN7iBk0ZKfXlQ7ic6/EWuVIB+M4hb/4qck+OTFozmiXGu8gdmwsmsajlegrN
	 kKOY3j7qpxZUxEXQJjzn4mZzJmRpHEOWJ6Ojk+R1kSQq0wZkjBycZKtvAHYxWXu4u2
	 +o+xneILWU62g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] PCI/FLIT: Add support for Flit Logging Extended
 Capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714183950.1620016-3-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
 <20260714183950.1620016-3-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:17:54 +0000
Message-Id: <20260714191754.C387F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Multiple execution contexts perform Read-Modify-Write (RMW) operat=
ions on the `PCI_FLIT_ERR_CNTR_CTRL` register without mutual exclusion, cre=
ating a race condition that can leave hardware interrupts enabled after dri=
ver removal or suspend, resulting in an unhandled IRQ storm.
- [High] Failure to properly mask level-triggered INTx interrupts in the ha=
rd IRQ handler leads to an IRQ storm and CPU lockup.
- [High] Infinite loop in threaded IRQ handler on surprise device removal o=
r PCI error response.
- [Medium] Platform-configured Flit Error Counter settings are lost across =
D3cold suspend/resume transitions.
- [Medium] Unbounded loop in `flit_isr` drains hardware error logs, risking=
 Denial of Service (DoS) and soft lockups.
--

--- Patch [2]: [PATCH 2/5] PCI/FLIT: Add support for Flit Logging Extended =
Capability ---
commit 2eae6403f78aaec770133667c1980b90da860010
Author: Avadhut Naik <avadhut.naik@amd.com>

PCI/FLIT: Add support for Flit Logging Extended Capability

This commit introduces a port service driver to support the PCI Express Flit
Logging Extended Capability. This feature allows logging of erroneous flits
on ports operating in PCIe Gen6 Flit Mode.

> diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
> new file mode 100644
> index 0000000000000..12f2b6fbf1de0
> --- /dev/null
> +++ b/drivers/pci/pcie/flit.c
> @@ -0,0 +1,170 @@
[ ... ]
> +static void flit_cntr_disable(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev =3D dev->port;
> +	u16 ctrl, flit =3D pdev->flit_cap;
> +
> +	/* Disable both Error Counter and Interrupt generation */
> +	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &ctrl);
> +	ctrl &=3D ~(PCI_FLIT_ERR_CNTR_EN | PCI_FLIT_ERR_CNTR_INTR_EN);
> +	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, ctrl);
> +}

[Severity: High]
Multiple execution contexts perform Read-Modify-Write (RMW) operations on t=
he
PCI_FLIT_ERR_CNTR_CTRL register without mutual exclusion.

If flit_cntr_disable() runs concurrently with flit_isr() during driver
unbind or hot-unplug, could the lockless clear of the EN and INTR_EN bits
be silently overwritten by flit_isr() writing back its stale cached value
with INTR_EN set?

Since flit_irq() also performs a lockless RMW from hardirq context, should
all accesses to this control register be protected by a spinlock to prevent
leaving hardware interrupts enabled after driver removal?

[ ... ]
> +static irqreturn_t flit_isr(int irq, void *context)
> +{
[ ... ]
> +	do {
> +		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, &err_log1);
> +
> +		if (!(err_log1 & PCI_FLIT_ERR_LOG_VALID))
> +			break;
> +
> +		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
> +		pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n", err=
_log1, err_log2);
> +
> +		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
> +	} while (err_log1 & PCI_FLIT_ERR_LOG_MORE);

[Severity: High]
If the PCIe link goes down or the device is surprise-removed,
pci_read_config_dword() will return an error response of 0xFFFFFFFF (~0).

Since (~0 & PCI_FLIT_ERR_LOG_VALID) and (~0 & PCI_FLIT_ERR_LOG_MORE) are
both true, will this trap the threaded handler in an infinite loop?

[Severity: Medium]
Does this do/while loop need a maximum iteration limit?

If a faulty or malicious PCIe device streams flit errors and continually
asserts the MORE bit faster than the CPU can process them, could this
indefinitely stall the CPU in the threaded IRQ handler and cause a soft
lockup?

[ ... ]
> +static irqreturn_t flit_irq(int irq, void *context)
> +{
> +	struct pcie_device *dev =3D (struct pcie_device *)context;
> +	struct pci_dev *pdev =3D dev->port;
> +	u16 flit =3D pdev->flit_cap;
> +	u16 cntr_sta, cntr_ctrl;
> +
> +	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &cntr_sta);
> +	if (!(cntr_sta & PCI_FLIT_INTR_GEN_CNTR))
> +		return IRQ_NONE;

[Severity: High]
Similar to the loop in flit_isr() above, if the device is disconnected and
pci_read_config_word() sets cntr_sta to 0xFFFF, will this erroneously skip
the IRQ_NONE return and wake the thread?

> +
> +	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &cntr_ctrl);
> +	cntr_ctrl &=3D ~PCI_FLIT_ERR_CNTR_EN;
> +	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, cntr_ctrl);
> +	return IRQ_WAKE_THREAD;
> +}

[Severity: High]
When using shared legacy INTx interrupts, the hard IRQ handler clears
PCI_FLIT_ERR_CNTR_EN but fails to clear PCI_FLIT_ERR_CNTR_INTR_EN.

Since the interrupt status bit is only cleared on a 0 to 1 transition of
the EN bit (which happens later in the threaded handler), the INTx line
remains physically asserted.

Because flit_probe() does not use IRQF_ONESHOT, won't returning
IRQ_WAKE_THREAD unmask the IRQ line and immediately re-trigger the hard
IRQ handler, starving the threaded handler and creating an infinite IRQ
storm?

[ ... ]
> +static int flit_cntr_suspend(struct pcie_device *dev)
> +{
> +	flit_cntr_disable(dev);
> +	return 0;
> +}

[Severity: Medium]
The suspend hook disables the counter but does not read or save the
platform-configured "Set Events to Count" and "Trigger Event Count"
fields.

When flit_cntr_enable() is called on resume, it reads the hardware-reset
value (typically 0) and writes it back with the enable bits set. Will this
permanently erase the platform-specific error logging thresholds across a
D3cold suspend and resume cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714183950.1620=
016-1-yazen.ghannam@amd.com?part=3D2
