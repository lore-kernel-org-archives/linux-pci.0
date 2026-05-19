Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF14028CC
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196817; cv=none; b=R4G3kS4zK5v206+WgRS+yD8+s+ce0HHoKS0153781VNOUpIrvchXI8SDVcW3efaC4H+flxSeWB3vfs3nc860mQ7xejYHn47O41X+BKqAn4I0oHYLAzRfiy4a2vkt3RaPVAzXzFSKSEjjJiL+nWsxqiygoZHVD+/HuWjmNNsuUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196817; c=relaxed/simple;
	bh=xvpPbiLINaV8j62MwagLWorgWpNxIkyqbNZl16oa3f0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nnCKxXa/2OcuftnsrQ4eJgjDE7pTkzj28P4rKYAtTM0mm9c2NqQCwFg/fgRmj6dqjw58KOOYGIGD+wiLIZRTfzXQCpEahjof+pmH1Mf/2sqPC5L8Uuq72vr1D0ZZ+1QF5A5N1XbvbOdjubdzToEb8uBAw1ZfC48AvRsCdUl7mTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2h1cbru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2h1cbru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E1BC2BCB3;
	Tue, 19 May 2026 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196817;
	bh=xvpPbiLINaV8j62MwagLWorgWpNxIkyqbNZl16oa3f0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=C2h1cbruUgSA3CTpUZ/zQDuJAQEIIQAzkr8e6W35JAehYdArMiDsX+wKQ2jQgK0i/
	 cF/t4aYJetmBUEuBTgGhGiyO5K3Zf6lLJ84nAk4PSKIqmZ3h15e02pcis0hn08Vnb7
	 BLwYp673Upplsf28T3VKVuIaOmo/jZ1wYF9SVo6q9mKwfZbVpQBQrAMpeOuAk8WbxX
	 xXeVNe99GG9yoSpSOu0c1BBDkcgXPDcWDmn8Dmpr6Ixqqz1RtDU717sf1qmOg8ewjO
	 ZE6XmX4WhDmCaSpUJDF1fiAY236Z+xywd75nvAm7zYdeBM1ydJteQmea0OObm+RHJS
	 aMZr5FsFwAWPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519123609.1595280-3-18255117159@163.com>
References: <20260519123609.1595280-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:20:16 +0000
Message-Id: <20260519132017.63E1BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unprotected hardware register access in the debugfs read callback =
can cause a kernel panic if the device is runtime suspended.
- [High] Race condition during root bus teardown due to missing `pci_lock_r=
escan_remove()`.
- [Medium] Debugfs feature silently fails to initialize when compiled as a =
module due to incorrect Kconfig and preprocessor macro interaction.
- [Medium] The patch implicitly introduces critical behavioral changes (roo=
t bus teardown) not mentioned in the commit message.
--

commit 32300cb8f3d354c5d2edc089c48c2f9d49fdb425
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add HPA IP debugfs for LTSSM status

This commit adds debugfs support for HPA-based Cadence PCIe controllers to
allow users to read the current LTSSM state. It also introduces root bus
teardown logic during device removal.

> Add debugfs support for HPA-based Cadence PCIe controllers. A new file
> 'ltssm_status' is created under debugfs, allowing users to read the
> current LTSSM state as a string and raw value.

This isn't a bug, but the patch appears to introduce behavioral changes for
root bus teardown (adding pci_stop_root_bus() and pci_remove_root_bus() via
cdns_pcie_hpa_host_disable()) that aren't mentioned in the commit message.

Should this bus teardown logic be split into a separate patch, or documented
in the commit message?

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

Could this cause silent failures if configured as a module?

If a user configures this as a module (=3Dm), Kbuild will define
CONFIG_PCIE_CADENCE_DEBUGFS_MODULE instead of CONFIG_PCIE_CADENCE_DEBUGFS.

Because pcie-cadence.h guards the function declarations with
#ifdef CONFIG_PCIE_CADENCE_DEBUGFS, the core drivers will compile against
the empty static inline dummy functions instead.

Additionally, if we fix the macro to use IS_ENABLED(), would it cause linker
errors if the core driver is built-in (=3Dy) but the debugfs is built as a
module (=3Dm)?

Should this configuration option be changed to a bool?

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/driv=
ers/pci/controller/cadence/pcie-cadence-debugfs.c
> new file mode 100644
> index 0000000000000..97c5deef2b1ab
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
[ ... ]
> +static int ltssm_status_show(struct seq_file *s, void *v)
> +{
> +	struct cdns_pcie *pci =3D s->private;
> +	enum cdns_pcie_hpa_ltssm hpa_ltssm;
> +	const char *str_ltssm;
> +	u32 val;
> +
> +	if (pci->is_hpa) {
> +		val =3D cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
> +					  CDNS_PCIE_HPA_PHY_DBG_STS_REG0);

Could accessing this register cause a kernel panic if the device is
runtime suspended?

Cadence PCIe platform drivers rely on runtime power management and will gate
clocks and power domains when idle.

If a user reads this debugfs file while the controller is runtime suspended,
will reading the memory-mapped register of a powered-off IP block trigger
a synchronous external abort?

Should this hardware access be wrapped with pm_runtime_get_sync(pci->dev)
and pm_runtime_put(pci->dev)?

[ ... ]

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/dri=
vers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e88..abc1d0e58b981 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
[ ... ]
> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	cdns_pcie_debugfs_deinit(&rc->pcie);
> +	bridge =3D pci_host_bridge_from_priv(rc);
> +	pci_stop_root_bus(bridge->bus);
> +	pci_remove_root_bus(bridge->bus);
> +}

Could this lead to a race condition during root bus teardown?

Calling pci_stop_root_bus() and pci_remove_root_bus() without holding the
PCI rescan lock allows race conditions with concurrent PCI rescan or hotplug
operations triggered via sysfs.

While this pattern might have been copied from a pre-existing function like
cdns_pcie_host_disable(), does it need to be fixed here to prevent
use-after-free or system crashes?

Should these operations be protected by acquiring the lock using
pci_lock_rescan_remove() and pci_unlock_rescan_remove()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519123609.1595=
280-1-18255117159@163.com?part=3D2
