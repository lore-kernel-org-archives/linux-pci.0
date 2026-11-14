Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674070;
	b=yA8ZW1rb/V4jKHC7mS0eApGoCHD71w/HuNbGFNnRqYMAMUbbSRslYooQsFUXrotLSuTY
	 /tzMJky96mBeCPGwgqQqQ6chRABXFDXagBKDdFgCuY2RGP4GTqb5fydrmNmv2QJuM9rxZ
	 i/J3jZk6RMSCXJq1IHEyOvpvFSBJ/D8hJOPYufaz/PD50V3gkQ3xxCoASFHMkE+IHM39o
	 wmW2Nsayci6SBAvFjxAGlZZrRspV4AZFdcCxDPSyETT97NvcTcRpem/MBybLnMsGxgoVQ
	 AL9tvDCyD553AUi+PZLsWdavBa9QGGOgrluDcmIXkaAmAb0hZ3eeg/o9EhcTwim0A+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=153KEwy2rYQSi6UdJ27uwP/UbojbxTfBxXyRoK0tsns=;
	b=GZZTNCjOp6K1qnU4J6FeudFAoiwKGdv58hLfjbrRc73a9+WhqC7s18hFtjXG4Agsf5zx
	 Nz6r5B+zPzl867r6dHbelQNkPef2yU7D+4DaZ4azCcKpXumElGzpdL0b+ABSlS/fzEcbR
	 adp6YCPeyJDMRnFuHmy0MFwh4fcpf0ikcnaW1OpP9brnyNjz4Mw4c94tDvTDAAJndah5G
	 wC3NlLe7C+mkJkb5NydLmEt4z5IwXU1u7vv/rBuxqsc93HQIhviimSkABwox+Ul91Iqjd
	 rPaWCx/lmgTeDv8eyEoVXFWK/JShKnOhNKxTYLi1gQCaGByQqA1jhDgDh9ASrMUqKuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orcqhncc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA56606A899
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orcqhncc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AF51F000C8;
	Sat, 14 Nov 2026 16:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674070;
	bh=153KEwy2rYQSi6UdJ27uwP/UbojbxTfBxXyRoK0tsns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=orcqhncc6CKyYKJ4SnVC40jxnwu5UOarnXG7tr714cDTdm2Toal/kpTpC0T3sua/T
	 fKkjSpWu0RDpBgdDcv+MA8CDLYSATNmi//GmsXYzfrOGF1AfLvL2sUxmo2cI/0yYpc
	 i8cHJLbOQTDCSUFbXlNFUVJAf/9LeA3FFPeL8Mpl8P5Ql6YySRJj/mOY6yu5hPoUXu
	 y9rVWyERX8jterVCufMEYa4FHwwbqMOfL6QKJZ2j5/Q0weQteUIOyZecIcxV72qRcB
	 4nfIjlOdurw7wWBAxVRvVRt/stPy7/hibToQdtu5gyuxx54JSLRq6ydUg67oJfii2/
	 Feml9ZhOW5ZkA==
Message-ID: <sashiko-outbox-214756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] PCI: Disable pcie port on specific amd devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-3-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:34:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] PCI: no_pcie_port leaves D3cold bridges exposed in suspend and
  sysfs
- [Medium] x86/PCI: quirk_disable_pcie_port() disables pcieport on
  Thunderbolt eGPUs
--

commit ceffb6c4c39f628d202fdc8e2a5f341d822f54ff
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

PCI: Disable pcie port on specific amd devices

This commit adds a no_pcie_port flag to struct pci_dev and sets it via an
early PCI fixup on the upstream bridges of certain AMD GPUs on Apple
MacBookPro models so pcie_portdrv does not bind to them.

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 795d81c7a4de4..b1697cc4aed56 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1094,6 +1094,48 @@ static void asus_disable_nvme_d3cold(struct pci_de=
v *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d=
3cold);
> =20
> +static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] =
=3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void quirk_disable_pcie_port(struct pci_dev *pdev)
> +{
> +	struct pci_dev *upstream =3D pdev;
> +
> +	if (dmi_check_system(quirk_disable_pcie_port_dmi_table)) {
> +		while ((upstream =3D pci_upstream_bridge(upstream)))
> +			upstream->no_pcie_port =3D 1;
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x67ef, quirk_disable_pcie_po=
rt);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x69af, quirk_disable_pcie_po=
rt);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_po=
rt);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7360, quirk_disable_pcie_po=
rt);

[Severity: Medium]
Can quirk_disable_pcie_port() also disable pcieport on a Thunderbolt
hierarchy when an external GPU with one of these retail AMD PCI device IDs
(such as Radeon RX 460/560 0x67ef or Radeon RX 5500 XT 0x7340) is attached?

Walking every upstream bridge without checking
!pci_is_thunderbolt_attached(pdev) sets no_pcie_port =3D 1 on the Thunderbo=
lt
Root Port and switch bridges, breaking pciehp, PME, AER, and bridge runtime
D3 across that hierarchy.

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a9cbfc1d2bc75..d2f19e5666022 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	int type =3D pci_pcie_type(dev);
>  	int status;
> =20
> -	if (!pci_is_pcie(dev) ||
> +	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
>  	    ((type !=3D PCI_EXP_TYPE_ROOT_PORT) &&
>  	     (type !=3D PCI_EXP_TYPE_UPSTREAM) &&
>  	     (type !=3D PCI_EXP_TYPE_DOWNSTREAM) &&

[Severity: High]
Does returning -ENODEV here leave the upstream bridges exposed to config
space accesses while powered off by apple-gmux via PWRD(1)?

Without pcie_portdrv bound, each upstream bridge has dev->driver =3D=3D NULL
(so pm =3D=3D NULL) and remains in RPM_ACTIVE with runtime PM forbidden.  W=
hen
apple-gmux powers off the discrete GPU in gmux_set_discrete_state(), it
saves state, sets pdev->current_state =3D PCI_D3cold on the bridges, and cu=
ts
power via PWRD(1).

During system suspend while the bridges are off, pci_pm_prepare() sees
!pm_runtime_suspended(dev) and skips direct_complete, and then
pci_pm_suspend_noirq() accesses the dead bridge directly:

drivers/pci/pci-driver.c:pci_pm_suspend_noirq() {
    ...
	if (!pm) {
		pci_save_state(pci_dev);
		goto set_unknown;
	}
    ...
}

pci_pm_resume_noirq() similarly accesses config space and PCIe capabilities
on the dead bridges before gmux_resume() restores power.

At runtime, any userspace read of /sys/bus/pci/devices/.../config (such as
lspci) calls pci_read_config() -> pci_config_pm_runtime_get(), where
pm_runtime_resume(dev) is a no-op because the unbound bridge is still in
RPM_ACTIVE, so pci_user_read_config_*() reads directly from the powered-off
bridge and triggers a CPU CATERR.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D2
