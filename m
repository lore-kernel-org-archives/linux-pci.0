Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED804582ED
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855953; cv=none; b=almcYlm7SFeQCZZIFXi+wTQ9xkF9kpC5yciaxW1CaIFz8LMXVguwXWRR0iAxOE4Fm3NwfhKfD2k4ZAjhmj9anI6QN0XPo7TDxPz3jR22XOPwAIbKsPug0NYU0sd8dR6UJ1sRitOTQCQeuccEsax1gLVGxoBzhbN+DJMEpfAF23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855953; c=relaxed/simple;
	bh=2i/JSOoqfAx9EEIDMaSmKXh1DIKygluy/3QHmD9N6n8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S7DEOkmc9Ajl2MWaMvglPNASnF+RiQbFkenDnHBcGU99L14Hx1yAuT725Ftg6sy0U/rgQW8Efn6wrOfKKZhVSpMhSHsFD4tLIyh2pPWB25GlFl4lFaXlR8OYWyLlMgNh/BSoFeLwP3drML5wNq6kVV5R0pTcdiQcMPMgpgKaz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0YBRfpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0YBRfpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD501F000E9;
	Tue,  4 Aug 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785855950;
	bh=zEcqbijH0MM7MzeUH+fp++K6g507dMhXEUFBILcr08A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0YBRfpSrGBYXCfZYkkWu4Wr6h7OwvUPDuFnGbMaAX2Q3RwcwYBSQ66bjpl9xTSBE
	 qZTVw0KEDbZt6yVMITdBXzojXhgicdpT/gw23SnEFx5th6npeBpXjCLx6nb7DWSLZr
	 p+OdIrZArY1NM31C0nszuIN9dFvtC7Tvh9kuMD0TRvkMExzcRnTqSl1PnIVHV/i8MV
	 Rf8mzyqaeY5n1O4VEck3w4fKG7+04/HFJYJTo92P/YuwxvepDx8+Xm+mnhmxg9Kgpd
	 5IBcQQDbXR7Ystlm/Zm2Cre6ieoJMS4uIE1cuqRNJmjCwbgBc7Xk9YfdzunUv57VHZ
	 rE9UVtHeybGqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804133810.184905-13-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-13-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:05:49 +0000
Message-Id: <20260804150549.AAD501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in proxy PM callbacks when child device i=
s unbound
--

--- Patch [12]: [PATCH V3 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeu=
p requirements to PCI ---
commit da80b1fc5d708734df314262ab3cf3703c943f07
Author: Adrian Hunter <adrian.hunter@intel.com>
Subject: i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI

This patch aligns the PCI wakeup state with the requirements of the I3C
devices it serves. It checks during suspend if any HCI instance has a
wakeup-enabled I3C device, and arms the PCI function's wakeup accordingly.

> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers=
/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index 5a9e2a43eff8d..2b3bf6fa74f29 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
[ ... ]
> @@ -272,6 +274,13 @@ static bool mipi_i3c_hci_pci_is_mfd(struct device *d=
ev)
>  	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
>  }
> =20
> +static bool mipi_i3c_hci_pci_any_wakeup_enabled(struct device *dev)
> +{
> +	struct i3c_hci *hci =3D dev_get_drvdata(dev);
> +
> +	return i3c_master_any_wakeup_enabled(&hci->master);

[Severity: High]
This is a pre-existing issue, but can this sequence result in a NULL pointer
dereference if the child driver is unbound?

If the mipi-i3c-hci platform driver fails to probe or is manually unbound
via sysfs, dev_get_drvdata(dev) will return NULL.

During system suspend, the PCI parent driver iterates over its child
platform devices in mipi_i3c_hci_pci_suspend(). If the BIOS left the bus
active (or the hardware hung during driver removal and failed to clear
the HC_CONTROL_BUS_ENABLE register), mipi_i3c_hci_pci_is_operational()
will return true.

This causes mipi_i3c_hci_pci_suspend_instance() to call
i3c_hci_rpm_suspend() and this newly added function, both of which will
dereference the NULL hci pointer.

Is it possible to add a NULL check here or in the caller before proceeding
with the suspend operations on the child device?

> +}
> +
>  static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *d=
ata)
>  {
>  	struct mipi_i3c_hci_pci_pm_data *pm_data =3D data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D12
