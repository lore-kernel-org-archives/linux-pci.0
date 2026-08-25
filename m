Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD93242DF;
	Tue, 25 Aug 2026 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625651; cv=none; b=GstW3wLwU5VVWb83AbFz7aOdtQq4IDgmTsC0LF64pA0rgedM08PyVUNQzwr1eL53KQGv1xdI5pXBtZgAdfdg5DdND9WE/rfMf8QWH1/6VIYzx6FkCXssQkZeWygDv9xFhkfC2xNWLh4Fq0ZlfdNdUi0yU6/6Lx8z5p4eAG587N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625651; c=relaxed/simple;
	bh=5f0oTvyZFUPft5eTbI8IA7YcpmAce3CYSKTcP8+UYbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KW8eKJuAD5SCtcySWZbhXwBpi7tKshvm+RdPZeRbxg80smW5DarbnH47jkyQy1H11qG1R/piSWuFc2bv/Qko0Cu0pe7Yzz5U2+I9QmkRejebR4Gri7KbvFS912KPEVwj/L9bOd7WZNaO5p5xUuMQ8lJQjI+cyzi7tUKMp5cCCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL3s1Lun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL3s1Lun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDA31F000E9;
	Tue, 25 Aug 2026 02:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625643;
	bh=JI7+3v5yFpessGaI4GFugRzasPohKxsEWG/fNg+7n90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BL3s1Lun2iwDJuAqhtEUim6NuQC5Up/hzPSFlioLTioQMjyvLVYixFGqcjbH61swF
	 cW6F6DmFejr7dNKepSlSp6pMvrfIIZB3n1NwKYWHDUI5YRaFalOhdCJxF2kc+7rwP8
	 0i0jE1WEdlaJedL6FtOOe5dxKe1yrxWtmhA6t183SgLj+PuYQxhL1AcJ3zKBEUh9os
	 vII/1GiwmqegXW52lu3KbXqN30uRIJUJOV2tl1lTGcNi3PBPyV4lxE1mSnhkWgEFyG
	 rOh/K3Qs7VGZ4klY8/ZUkAT0vKtY6FExr0nzzf69Br4ecxZU8yFDxWPNRugDLpdFBJ
	 ZSAVmmMRm2K7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] PCI/CXL: Clear ACS SV across an SBR of a CXL
 DPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-11-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-11-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:40:42 +0000
Message-Id: <20260825024043.3DDA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unsynchronized access to the global `cxl_sbr_region_ops` struct po=
inter can result in a NULL pointer dereference or a Use-After-Free crash if=
 the CXL core module unloads concurrently.
- [High] Missing link training wait for nested bridges during subordinate c=
onfiguration space restoration.
- [High] Restoring the standard configuration space of subordinate devices =
re-enables Bus Master and Memory Space before their PCIe capabilities are r=
estored, risking Malformed TLP fatal errors.
- [High] The completion function attempts to access the configuration space=
 and memory regions of downstream devices even if the secondary bus reset f=
ails.
- [Medium] The polling loop in `cxl_port_pm_init_is_complete()` can miss a =
successful completion if scheduling delays cause `msleep()` to overshoot th=
e timeout.
--

--- Patch [10]: [PATCH v2 10/13] PCI/CXL: Clear ACS SV across an SBR of a C=
XL DPort ---
commit fae09a9aaf20d6e342f823e3752512b2c39cdd95
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

PCI/CXL: Clear ACS SV across an SBR of a CXL DPort

A Secondary Bus Reset (SBR) of a CXL Downstream Port clears the
Downstream Component's (DPort) captured Bus Number. This patch
clears ACS Source Validation and Bus Master Enable across the reset
so that Port Power Management Initialization completes at link-up.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 417b6b44473e5..f3781d1e8f6e1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> +static int cxl_sbr_prepare(struct pci_dev *bridge, u16 dvsec,
> +			   struct cxl_sbr_ctx *ctx)
> +{
> +	int rc;
> +
> +	/* Abort before touching hardware if the regions cannot be disabled. */
> +	if (cxl_sbr_region_ops) {
> +		rc =3D cxl_sbr_region_ops->disable_regions(bridge);
> +		if (rc)
> +			return rc;
> +	}

[Severity: High]
Could accessing cxl_sbr_region_ops here result in a use-after-free or NULL
pointer dereference?

If a secondary bus reset is initiated via sysfs concurrently with the
cxl_core module unloading, the pointer might be cleared or freed before
disable_regions() is called. There does not appear to be any lock or RCU
protection here.

[ ... ]
> +static bool cxl_port_pm_init_is_complete(struct pci_dev *bridge, u16 dvs=
ec)
> +{
> +	unsigned long start =3D jiffies;
> +	unsigned long timeout =3D start + msecs_to_jiffies(100);
> +	u16 status;
> +
> +	do {
> +		pci_read_config_word(bridge,
> +				     dvsec + PCI_DVSEC_CXL_PORT_EXT_STATUS,
> +				     &status);
> +		if (!PCI_POSSIBLE_ERROR(status) &&
> +		    (status & PCI_DVSEC_CXL_PORT_EXT_STATUS_PM_INIT_COMP)) {
> +			pci_dbg(bridge, "%s: PM Init Complete set after %u ms, ext status %#0=
6x\n",
> +				__func__, jiffies_to_msecs(jiffies - start), status);
> +			return true;
> +		}
> +		msleep(10);
> +	} while (time_before(jiffies, timeout));
> +
> +	pci_warn(bridge, "%s: PM Init Complete not set after %u ms, ext status =
%#06x\n",

[Severity: Medium]
Will this loop miss successful completions if scheduling delays cause
msleep() to overshoot the timeout?

If the sleep significantly exceeds 10ms and crosses the 100ms timeout
boundary, the loop terminates and returns false without a final status
read. This might lead to spurious warnings and premature restoration of
ACS Source Validation, causing the Port to reject bus 0 traffic.

[ ... ]
> +static int cxl_sbr_restore_config_space(struct pci_dev *dev, void *userd=
ata)
> +{
> +	pci_restore_config_space(dev);
> +	pci_dbg(dev, "%s: config space restored\n", __func__);
> +
> +	return 0;
> +}

[Severity: High]
Does this unconditionally re-enable Bus Master and Memory Space before
PCIe capabilities are restored?

When pci_restore_config_space() writes the first 64 bytes, it restores
PCI_COMMAND while the Max Payload Size (MPS) remains at its hardware
reset default of 128 bytes. This might trigger Malformed TLP fatal errors
if the device interacts with a host configured for a larger MPS during
this window.

[ ... ]
> +static void cxl_sbr_restore_subordinate(struct pci_dev *bridge)
> +{
> +	if (!bridge->subordinate)
> +		return;
> +
> +	/* Parents before children: a child answers once its parent forwards. */
> +	pci_walk_bus(bridge->subordinate, cxl_sbr_restore_config_space, NULL);
> +}

[Severity: High]
Does pci_walk_bus() safely handle nested PCI-to-PCI bridges on the
subordinate bus?

It seems to restore the nested bridge's standard configuration and then
immediately traverse to the grandchildren without waiting for the nested
bridge's secondary link to retrain. This means configuration writes might
be sent to deeper endpoints while their link is still down.

[ ... ]
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
> +	struct cxl_sbr_ctx ctx =3D {};
> +	u16 dvsec =3D 0;
> +	int rc;
> +
>  	if (!dev->block_cfg_access)
>  		pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n",
>  			      __builtin_return_address(0));
> +
> +	if (is_cxl_dport(dev))
> +		dvsec =3D cxl_port_dvsec(dev);
> +	if (dvsec) {
> +		rc =3D cxl_sbr_prepare(dev, dvsec, &ctx);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	pcibios_reset_secondary_bus(dev);
> =20
> -	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> +	rc =3D pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> +
> +	if (dvsec)
> +		cxl_sbr_complete(dev, dvsec, &ctx);
> +
> +	return rc;
>  }

[Severity: High]
Is it safe to call cxl_sbr_complete() when
pci_bridge_wait_for_secondary_bus() times out or returns a non-zero error?

Accessing the configuration space and memory regions of downstream devices
while the secondary link is physically down might generate uncorrectable
PCIe AER errors like Unsupported Requests or Completion Timeouts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D10
