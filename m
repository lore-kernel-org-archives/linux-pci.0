Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F748CD48
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192922; cv=none; b=GQQQt6DLGUOz+zhegMoeIJOTpuNtxX6u9gCpGIhh7MS9wm+zelR2jokga/EP82ntQ6JRkRShqC73MvKDwBEIinIBO2A+Lb/UlPuH5lLIZa9jZkV/wpAdaAw/kZM/3ZvxYM5DnDyoMGSIcz88HSDVxuq6hpg/f3OCG8ZXOs+bBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192922; c=relaxed/simple;
	bh=+u4TNa3XdJiQ7MselGjvHM7aum8L3EoKx4PE4WAs3Bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqP4cb5Bz5XYz0qXFPuicZY4CuZqUQFNbrhRGPRcL9UGrSmzcu+SBh9oNNh5TAW++Q48PxprArSK17fCzrUnII9nK+OHHC63GKLBtTB/5auLlmrUoAlB1LPplU8JVsYYmj24E7hs9dLLMWahK1urs/oEe3HHW8AeTIbTD7mwsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsuIJMIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsuIJMIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF811F000E9;
	Mon, 31 Aug 2026 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788192920;
	bh=J9XmzqP9SXP6SvhVc0bgixTNoaD49u+oTwHZ8AxePhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsuIJMILD61/NfU1yIU4o7oAIeqg+TCftX/FsDhbiBPHv/YpL67PHYvdoLorA6pzv
	 ecIogGSnneow8AdnMuL416tn9BijuHPN799+pH/Rjv0LobAAkJ7UsglOgY7ZVg15E3
	 12oZd3/+HygMccECEFZlrVsxRVxxA7JsMGQfnmTH6dtDRISNytWibXtnY2Vb+o37L5
	 Qr1LFS4ieO6wYoJIol+iEHS8N6+hRT0XS+wBqsjR81MaAfUhyOEMryLy6HX0Wbf+xM
	 ZXSpcpgCzW9qe/8VZRGEHRSwxjlRom4iWMH/61ODIP3NkSp12l/lf2JvE4YktF7LfE
	 6aNxnom4PQXKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] PCI: cadence: Protect root bus removal
 with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-408-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-408-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:15:19 +0000
Message-Id: <20260831161520.5BF811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing cleanup of host init and link setup on pci_host_probe fa=
ilure.
- [Medium] Double pm_runtime_disable() due to mixing devm_pm_runtime_enable=
() and manual pm_runtime_disable().
--

commit 9d7375f353a2f9bf3cd5f3ff9c612cd84f44e32f
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Protect root bus removal with rescan lock
   =20
Hold the pci_rescan_remove_lock lock while stopping and removing a root bus
to avoid racing with concurrent rescan or hotplug operations triggered via
sysfs.

Link: https://patch.msgid.link/20260521161822.132996-2-18255117159@163.com

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers=
/pci/controller/cadence/pcie-cadence-host.c
> index fffd63d6665e8..c8daa5847c0f3 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -620,8 +620,10 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
>  	struct pci_host_bridge *bridge;
> =20
>  	bridge =3D pci_host_bridge_from_priv(rc);
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
> +	pci_unlock_rescan_remove();
> =20
>  	cdns_pcie_host_deinit(rc);
>  	cdns_pcie_host_link_disable(rc);

[Severity: Medium]
This isn't a bug introduced by this patch, but does cdns_pcie_host_setup() =
leak
hardware resources if a failure occurs during the probe phase?

If probe fails in cdns_pcie_host_init() due to a resource conflict:

drivers/pci/controller/cadence/pcie-cadence-host.c:cdns_pcie_host_setup() {
...
	ret =3D cdns_pcie_host_init(rc);
	if (ret)
		return ret;

Can this return without calling cdns_pcie_host_link_disable() to undo the p=
rior
link setup?

Similarly, if the failure happens later in the same function:

	return pci_host_probe(bridge);
}

Will this return the error code without undoing the setup performed by both
cdns_pcie_host_link_setup() and cdns_pcie_host_init()?

This could leave the PCIe link started and root port BARs configured,
potentially preventing a clean re-initialization on subsequent probe attemp=
ts.

[Severity: Medium]
This is also a pre-existing issue, but could the driver reload path in
pcie-sg2042.c leave runtime PM permanently disabled?

When sg2042_pcie_probe() initializes power management:

drivers/pci/controller/cadence/pcie-sg2042.c:sg2042_pcie_probe() {
...
	pm_runtime_no_callbacks(dev);
	devm_pm_runtime_enable(dev);

This automatically registers a devres cleanup function to call
pm_runtime_disable() on driver unbind.

However, the remove function manually disables it again:

drivers/pci/controller/cadence/pcie-sg2042.c:sg2042_pcie_remove() {
...
	pm_runtime_disable(dev);
}

If an administrator unbinds and rebinds the driver, does this manual call
increment the disable_depth counter a second time alongside the devres clea=
nup?

On subsequent driver reprobe, devm_pm_runtime_enable() would only decrement
it by one, leaving disable_depth at 1. Would this prevent the device from
entering low-power states after a driver reload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-408-sashal@kernel.org?part=3D1
