Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965430;
	b=X1IT4uiGLGQTYAMNRAw0ls3s8Rsxde8E9zG7zg07t7DKAaotOF7Q6P2osSGIcZ8XE6tY
	 jUGOSFauZRfVKXhMNm3JQ1f3YxwQyk3MDFJzd8PGEs2fj4/sDymKuFR1KqbTTRSi/NpJh
	 I93VVXBw65bM1on3FGMIPtOSSXD5KqdyAP2ylxUh/8MLuYpLvVrnsKYNUeBIZOEaCZqYT
	 PvYKZlce6+s19laG9PZhgCVdcR6A+nTaVI15ofTxrAi+Su7ZKr/XPorEcTtkMxN1mp/2o
	 nKsebAzhPCYa+tEZMYkfXd04nK+fM4f2yUaQ5L4f5gl24+iJpbboUhLh7AG/rdzp6WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GN1fVjYxpwYeWehIr6jWZIABSi3LQWbasYzKdhco65s=;
	b=sHwRI6ae1DirQFqJ45kDqWLsfBHEdb1hA78HnmAhNJw964X9swiswv7jOHldzUzkRCcu
	 mqwDPACK2AmmYCOjpuBbkXK0FXPzfCyG6K+RUI4D4K293KchNs2O/Is+MFFm7wopaGHaN
	 LNPgT62mniP/bngissyjym6c0mIo+o1n5Kv2EFyTWO+pnWNhsiOuF1yLBLTwjyyza00A8
	 gQTi8X0Cw5u6OewKuHC9jFzVPB5Fv4RQuTxJaivixGErvImMZdf6MaoUSpmqksUZ+eLUR
	 pPJCX9OQYcwixkSV/I9IX+AE+6weKR0U0M9p1/i/B2AG0AoN4YfbosyxMG5AwyP451Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwcAb+sx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE45608361D;
	Fri,  6 Nov 2026 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwcAb+sx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05701F008A3;
	Fri,  6 Nov 2026 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965430;
	bh=GN1fVjYxpwYeWehIr6jWZIABSi3LQWbasYzKdhco65s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwcAb+sxEnWI/JBGmzxPNQ5wKyAWW/3g/2fpXplAaNNGURCVD9uB1U+C6ByTMWQ5a
	 sFJaq6+qbhH3dwAL0SfRMk0/cMFnXElYmK1XahWN3ClcQplq3F5NMtOwVd+MZeI+SD
	 DKA6FKq87YrujhPXPBIEyZLnnYovliknLkehO7uUcX4+hUdtOcvdnYhbN8//OIVAGy
	 85TMarOOBPkcHLbXf1HvuH1QgOJscqe2saQXqjVKRK0z5wfN/kbJvygzCNoDbqphdC
	 SeoC2kzl2S2E/FOWdeQkbrXhS75Zvk8HCH/xXIOVVRZ30iAAaTEi1wyThO3A5+LOuR
	 a6zmxkQqimJrA==
Message-ID: <sashiko-outbox-201350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] PCI: default trust policy overwrites adversarial default in
  pci_setup_device()
- [High] PCI: broken adversarial trust inheritance in
  pci_set_default_trust_policy()
- [Medium] PCI: pci_dev_ats_permitted() drops PCI_ACS_TB after full
  authorization
--

commit 4f93e031c1b1cdb8175550bd66ba1ab96c7a1e00
Author: Leon Romanovsky <leon@kernel.org>

PCI: Replace untrusted state with device trust

This commit replaces the PCI-specific untrusted flag in struct pci_dev with
the generic device trust policy and trust level infrastructure, defaulting
removable PCI devices to DEVICE_TRUST_POLICY_ADVERSARY and updating IOMMU,
ATS, and ACS callers accordingly.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5b6960bbb35bc..139e6f7b4e022 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1738,24 +1738,27 @@ static void set_pcie_cxl(struct pci_dev *dev)
> =20
>  }
> =20
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_default_trust_policy(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent =3D pci_upstream_bridge(dev);
> +	struct pci_dev *parent =3D pci_physfn(dev);
> +
> +	if (dev->dev.trust_policy !=3D DEVICE_TRUST_POLICY_DEFAULT)
> +		return;
> +
> +	if (parent =3D=3D dev)
> +		parent =3D pci_upstream_bridge(dev);
> =20
>  	if (!parent)
>  		return;
> -	/*
> -	 * If the upstream bridge is untrusted we treat this device as
> -	 * untrusted as well.
> -	 */
> -	if (parent->untrusted) {
> -		dev->untrusted =3D true;
> +
> +	if (device_policy_is_adversarial(&parent->dev)) {
> +		dev->dev.trust_policy =3D DEVICE_TRUST_POLICY_ADVERSARY;
>  		return;
>  	}
> =20
>  	if (arch_pci_dev_is_removable(dev)) {
> -		pci_dbg(dev, "marking as untrusted\n");
> -		dev->untrusted =3D true;
> +		pci_dbg(dev, "setting adversarial trust policy\n");
> +		dev->dev.trust_policy =3D DEVICE_TRUST_POLICY_ADVERSARY;
>  	}
>  }

[Severity: High]
Can checking device_policy_is_adversarial(&parent->dev) in
pci_set_default_trust_policy() fail to propagate the adversarial default to
downstream ports and endpoints when the upstream bridge's trust_policy has
been overridden?

On x86 ACPI systems, for a PCIe switch connected to an integrated
USB4/Thunderbolt Root Port where root->external_facing and
pcie_has_usb4_host_interface(root) are true, arch_pci_dev_is_removable() in
arch/x86/pci/acpi.c returns true only for the Switch Upstream Port directly
under the Root Port:

arch/x86/pci/acpi.c:arch_pci_dev_is_removable() {
	...
	/* Anything directly behind a "usb4-host-interface" is tunneled */
	if (pcie_has_usb4_host_interface(parent))
		return true;

	/*
	 * Check if this is a discrete Thunderbolt/USB4 controller that is
	 * directly behind the non-USB4 PCIe Root Port marked as
	 * "ExternalFacingPort". Those are not behind a PCIe tunnel.
	 */
	if (pcie_switch_directly_under(root, pdev))
		return false;
	...
}

For the Switch Downstream Ports and Endpoints on that switch,
pcie_has_usb4_host_interface(parent) is false and
pcie_switch_directly_under(root, pdev) returns true, so
arch_pci_dev_is_removable() returns false and relies on inheritance from the
parent bridge.

Because pci_setup_device() calls device_trust_init(&dev->dev) on the parent
bridge before subordinate buses are scanned (or userspace updates the bridg=
e's
trust_policy via sysfs before hotplugging a downstream device), overriding =
the
Switch Upstream Port's trust_policy to disabled or full changes
parent->dev.trust_policy away from DEVICE_TRUST_POLICY_ADVERSARY.

When child devices are subsequently set up, both
device_policy_is_adversarial(&parent->dev) and arch_pci_dev_is_removable(de=
v)
return false, leaving removable external devices at
DEVICE_TRUST_POLICY_DEFAULT (which resolves to DEVICE_TRUST_FULL) and
bypassing IOMMU DMA domain enforcement, ATS restrictions, ACS Translation
Blocking, and SWIOTLB bounce buffering.

> =20
> @@ -2082,7 +2085,7 @@ int pci_setup_device(struct pci_dev *dev)
> =20
>  	set_pcie_cxl(dev);
> =20
> -	set_pcie_untrusted(dev);
> +	pci_set_default_trust_policy(dev);
>  	device_trust_init(&dev->dev);

[Severity: High]
What happens if a removable PCI device is configured with an explicit defau=
lt
policy via device_trust=3D, device_trust.driver=3D, or sysfs trust_policy?

In pci_setup_device(), pci_set_default_trust_policy(dev) runs on a freshly
zero-allocated struct pci_dev before device_trust_init(&dev->dev). Because
dev->dev.trust_policy is always DEVICE_TRUST_POLICY_DEFAULT at that point, =
the
early return in pci_set_default_trust_policy() is never taken, and a remova=
ble
device is set to DEVICE_TRUST_POLICY_ADVERSARY.

Immediately afterward, device_trust_init(&dev->dev) invokes
device_trust_apply_boot_policy(). If the kernel command line contains a
per-device default rule such as:

  device_trust.default=3Ddisabled device_trust=3Dpci:<bdf>=3Ddefault

or if default is later selected via device_trust.driver=3D or by writing de=
fault
to sysfs trust_policy before binding, dev->dev.trust_policy is set to
DEVICE_TRUST_POLICY_DEFAULT.

Because pci_set_default_trust_policy() is never called again and pci_bus_ty=
pe
does not implement bus_type->trust_resolve():
1. pci_dev_default_is_restricted() returns false for
   DEVICE_TRUST_POLICY_DEFAULT, allowing identity IOMMU domains in
   iommu_get_default_domain_type() and amd_iommu_def_domain_type(), IOMMU
   bypass quirks in risky_device(), ATS capability registration in
   pci_ats_init(), and omission of PCI_ACS_TB in pci_enable_acs().
2. At driver bind time, device_trust_prepare() calls
   device_trust_resolve_default(), which resolves DEVICE_TRUST_POLICY_DEFAU=
LT
   to DEVICE_TRUST_FULL instead of DEVICE_TRUST_ADVERSARY, so
   device_is_adversarial() returns false and SWIOTLB bounce buffering in
   drivers/iommu/dma-iommu.c is skipped.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..087c63b177c85 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
[ ... ]
> @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struc=
t device *dev)
>  {
>  	return container_of(dev, struct pci_dev, dev);
>  }
> +
> +static inline bool
> +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_policy policy =3D READ_ONCE(pdev->dev.trust_policy);
> +
> +	return policy =3D=3D DEVICE_TRUST_POLICY_DISABLED ||
> +	       policy =3D=3D DEVICE_TRUST_POLICY_ADVERSARY;
> +}
> +
> +static inline bool pci_dev_ats_permitted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_level level =3D device_get_trust_level(&pdev->dev);
> +	enum device_trust_policy policy =3D READ_ONCE(pdev->dev.trust_policy);
> +
> +	if (level =3D=3D DEVICE_TRUST_DISABLED)
> +		return policy !=3D DEVICE_TRUST_POLICY_ADVERSARY &&
> +		       policy !=3D DEVICE_TRUST_POLICY_DISABLED;
> +
> +	return level =3D=3D DEVICE_TRUST_FULL;
> +}

[Severity: Medium]
Won't a device discovered with DEVICE_TRUST_POLICY_DISABLED lose PCI_ACS_TB
after being authorized as full and undergoing a reset or D3cold transition?

When a PCIe port or device is discovered with DEVICE_TRUST_POLICY_DISABLED
(for example via device_trust.default=3Ddisabled), pci_ats_init() sees
pci_dev_default_is_restricted(dev) =3D=3D true and permanently skips record=
ing
dev->ats_cap, while initial pci_enable_acs() sees
!pci_dev_ats_permitted(dev) =3D=3D true and enables PCI_ACS_TB in
pci_std_enable_acs() or pci_quirk_enable_intel_spt_pch_acs().

If userspace in initrd later sets trust_policy to full and binds a driver,
dev->dev.trust_level becomes DEVICE_TRUST_FULL and pci_dev_ats_permitted(de=
v)
returns true even though dev->ats_cap is still 0.

Because PCI_EXT_CAP_ID_ACS is not saved in saved_cap_space, a subsequent PCI
reset or D3cold-to-D0 resume resets the hardware ACS control register and r=
uns:

  pci_restore_state()
    -> pci_enable_acs()
      -> pci_std_enable_acs() / pci_quirk_enable_intel_spt_pch_acs()

At that point pci_dev_ats_permitted(dev) returns true, so PCI_ACS_TB is no
longer set even though ATS was never initialized for the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D17
