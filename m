Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46968274FDF
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213997; cv=none; b=dceV52w5x6rSfK91wVmGogF23fq1XIKFky/9jsDxT8DXGzhFldpGogFElJlzBfViecQ69w/e04JW+a5G9JX8iFngh/3z4O8RLCvKUQ1hSCRQjtn9KDAHsJ6v76MCCcCtuFw87xYNStJkg09aM6giKyxRwmbLa+UDBaTpFTjlHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213997; c=relaxed/simple;
	bh=JbQ7qR5wtIm89m6j5d05ehY7NlatOUbzq1F1UGKvDkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fRc0lw36XqCbjl1LmZE/rMK7cKO1AMuuNHoDFsWB/HqzpfIn959695kSmNWwcFuHurQIVrUgZb71JLJyYoG7L9WAzBYnDn9pL+KAhA+VBOKOzD9PXfqB3YScj14HE4pFg6TBx+SUl8F3yyE0tWiGow15dOvX1BqOU7PaIXIJ9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvBvBj4E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvBvBj4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F10C2BCB0;
	Fri,  8 May 2026 04:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213996;
	bh=JbQ7qR5wtIm89m6j5d05ehY7NlatOUbzq1F1UGKvDkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UvBvBj4E+wjdoJtamlQxpS2djQHkM9Es83xo+l24JqJ0o7xlktt8q1HRcL1TG755T
	 p0uGs33PNvmrTh0ivuf3ociLMWN4Fyjh8VrIV5JNaoBp68SYj2SnwLEg58PWPDwC1V
	 w32+Krcx1JFEhuYs3U3VaOmMNHdxVHKSAmW1bu9pzgDPJvC2rw6T9aZmoNSD7PaXgW
	 VMpdZNQGRlfhQTPOZ7sHDiO29XbeMxqLzUXQcDuxijMQZLU6TyqptecyPijk3bTsao
	 B73gLuZvrAzA0lGqGwVZ9NpM6wGuubLBJinxA8BBGvvdMlyXRH5e+iQo6G327stLBp
	 YIamqP9oEARaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508034101.1910036-3-18255117159@163.com>
References: <20260508034101.1910036-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:19:56 +0000
Message-Id: <20260508041956.C8F10C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] PCIE_CADENCE_DEBUGFS tristate configuration causes build failure a=
nd module linkage issues.
- [High] Race condition in debugfs deinitialization leads to unprotected ha=
rdware access.
- [High] Missing Runtime PM reference in debugfs read handler causes system=
 crash.
- [Medium] Missing link teardown in `cdns_pcie_hpa_host_disable`.
- [Medium] Incorrect bitmask `CDNS_PCIE_LGA_LTSSM_STATUS_MASK` truncates LT=
SSM states.
--

commit b032928b3c42715d7bb97e0bd26a99d252cd98d9
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe link

Add the debugfs property to provide a view of the current link's LTSSM
status from the Root Port device.

> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/control=
ler/cadence/Kconfig
> index 9e651d5459735..cb010bc97aad3 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	tristate
> =20
> +config PCIE_CADENCE_DEBUGFS
> +	tristate "Cadence PCIe debugfs entries"

Could this Kconfig option be changed to a bool?

When configured as a module (=3Dm), Kbuild defines
CONFIG_PCIE_CADENCE_DEBUGFS_MODULE, not CONFIG_PCIE_CADENCE_DEBUGFS. As a
result, the preprocessor check in pcie-cadence.h evaluates to false, causing
the header to declare empty static inline stubs. When pcie-cadence-debugfs.c
defines the non-static versions, the build fails with a function redefiniti=
on
error.

Furthermore, changing the check to IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)
would cause linkage errors if the core drivers are built-in while the debug=
fs
feature is a module, since built-in code cannot call module functions.

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/driv=
ers/pci/controller/cadence/pcie-cadence-debugfs.c
> new file mode 100644
> index 0000000000000..a4f0c4f6f98f4
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> @@ -0,0 +1,208 @@
[ ... ]
> +#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)

Does this mask need to be extended to cover all possible states?

This mask covers only 6 bits, allowing it to extract values up to 63.
However, the cdns_pcie_ltssm enum defines states up to 127. If the
hardware enters a state 64 or higher, FIELD_GET will silently truncate
the value, making state 65 appear as state 1.

[ ... ]
> +static int ltssm_status_show(struct seq_file *s, void *v)
> +{
> +	struct cdns_pcie *pci =3D s->private;
> +	enum cdns_pcie_ltssm ltssm;
> +	u32 reg;
> +
> +	if (pci->is_hpa) {
> +		reg =3D cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
> +					CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
> +		ltssm =3D FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, reg);
> +	} else {
> +		reg =3D cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
> +		ltssm =3D FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, reg);
> +	}

Is a runtime PM reference required here before accessing the hardware?

Since the driver supports power management, the controller might be in a
low-power, clock-gated state when this debugfs file is read. Reading the
registers without calling pm_runtime_get_sync() first could cause a bus fau=
lt
and crash the system.

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/p=
ci/controller/cadence/pcie-cadence-ep.c
> index c0e1194a936b3..38a0157b60dc7 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -659,6 +659,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
>  	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
>  			      SZ_128K);
>  	pci_epc_mem_exit(epc);
> +	cdns_pcie_debugfs_deinit(&ep->pcie);
>  }

Should cdns_pcie_debugfs_deinit() be called earlier in the teardown process?

If a userspace process is currently reading the debugfs file while the modu=
le
is being removed, ltssm_status_show() could attempt to read registers after
the hardware has been deactivated, potentially resulting in a bus fault.
Removing the debugfs entries first ensures no new reads can begin while the
hardware is shut down.

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/dri=
vers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e88..8bf7cc106413b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> @@ -309,6 +309,18 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_r=
c *rc)
>  }
>  EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
> =20
> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	bridge =3D pci_host_bridge_from_priv(rc);
> +	pci_stop_root_bus(bridge->bus);
> +	pci_remove_root_bus(bridge->bus);
> +

Is it necessary to stop the PCIe link here?

The setup path explicitly starts the link with cdns_pcie_start_link(),
but this teardown function omits stopping it or disabling PTM responses.
Leaving the link active after the bus is unregistered could lead to
spurious interrupts or unhandled DMA requests.

> +	cdns_pcie_debugfs_deinit(&rc->pcie);

Similar to the endpoint path, should debugfs teardown happen before
the hardware is disabled to avoid concurrent access faults?

> +}

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers=
/pci/controller/cadence/pcie-cadence-host.c
> index 0bc9e6e90e0e0..873d496c440f0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -370,6 +370,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
> =20
>  	cdns_pcie_host_deinit(rc);
>  	cdns_pcie_host_link_disable(rc);
> +	cdns_pcie_debugfs_deinit(&rc->pcie);
>  }

Should this debugfs teardown be moved to the beginning of the function
for the same reason mentioned above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508034101.1910=
036-1-18255117159@163.com?part=3D2
