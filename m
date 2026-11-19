Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116586;
	b=1eYgPzmsxOPJCQBX7hC4vd58LyQvlT/+NQ1Ng9jE2i7kr22aElT4K3Lb6dVo2OSM+sd8
	 vxIbrAEZn0MlEiPPJ++8E/cBKCsbqmM+S8s5IaxbAXezON46KE4F3DCHScx3FmG5r5gvU
	 UmEUFtbBUzaY9QYdAwrKVHoTlcT0ROCF8tcaI+U05mkcKA5lDmifr0QVxDDz4rQcaup+z
	 OT1WzveiAo7n4hMIuX4DXqJYipzsyWpNuNkWnNltACLJLGBkKvVqjwSzrSclscNy8e4LT
	 uzWMhgPXPa5OJKTOcB3lK8QUZsxVr/+s+zKcvfvfYxlAWjWCO5P2NeUR+oJWOvECMtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TDcyp4amGa2d41a2tjAhIG6PlePP7oYEW6VOqbUps6o=;
	b=ZxAFJlHty+O5yOOE8YfavkVg0Z7nBoMhimitbFNCC+y0pWjBd8rlIwdPq6F7BlE0NtWc
	 pTrdRl1vzY6uzIJYnWPxkHdGYFegpi7LmBetzrbFd+Jdqq3CNirViAbrxkj0puOKu0TnB
	 qKkdcMEbc+K49tRbBnB9gqQdrCyA1wV48LMk1xQxnIpLHNM45tWnAcXMTekYnw064bIKe
	 pKqJN47db67QIUms+7y3UNil9XS6CjuuB7dEAH7Tfeg3BgXLFGtSKYv6He179FRDvUhwC
	 1VTXXQefQ+CgaiN9LMB1E/SqIY9vaA6aZphTMJEXlQdLPNfDGcKdFK/nDQVMwlrkjIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwrW703W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFA606A330;
	Thu, 19 Nov 2026 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwrW703W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F71F1F000C6;
	Thu, 19 Nov 2026 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116586;
	bh=TDcyp4amGa2d41a2tjAhIG6PlePP7oYEW6VOqbUps6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bwrW703Wcm7uOXut5/fxqw/URVrVaCpfBZSZqCLCRH3oGLfA3Wk+EiJwMsiSPz7lF
	 cJVCvWtmVwSIbRO4s4mw442g/ZWo81BPLEjBp9jCqHOqjrjyTc1VpD0jqZMN75FNa/
	 UjTtp7R2jvUt6yog72M1LW/VT8jNBBaisTNuCISAK4ElcRD0jQG4h7iCK5++01RR7A
	 qC2xqIxsRuEW05g4gRNi5/X4VhFcAcRpog0oeByW3kQeTQnSd4m1n9ex28olEaZV2i
	 IZ6mnYel6dzI7N19tL4hNoD6RO6lx4rZKtIy6Gs6kLGcz6k5EJT7UrBr6u85koVy0r
	 yr1nKor95QO3g==
Message-ID: <sashiko-outbox-223912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 26/31] PCI: Use device trust for platform
 restrictions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-26-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-26-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:45 +0000
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
- [High] PCI: broken adversarial trust inheritance in
  pci_set_default_trust_policy()
- [High] PCI: explicit default trust policy on removable devices
  resolves unrestricted
- [Medium] PCI: of_create_pci_dev() runs pci_ats_init() before
  device_trust_init()
--

commit ab3df18f298528c15fefd9b9d8d3f08b809b920f
Author: Leon Romanovsky <leon@kernel.org>

PCI: Use device trust for platform restrictions

This commit derives default PCI device trust policies from removable topolo=
gy
and gates PCI ATS initialization and ACS Translation Blocking on the device
trust policy.

[ ... ]

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093dd..c8c96acc26343 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
> =20
> -	if (pci_ats_disabled())
> +	if (pci_ats_disabled() || pci_dev_default_is_restricted(dev))
>  		return;
> =20
>  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> @@ -40,7 +40,7 @@ void pci_ats_init(struct pci_dev *dev)
>   */
>  bool pci_ats_supported(struct pci_dev *dev)
>  {
> -	if (!dev->ats_cap || dev->untrusted)
> +	if (!dev->ats_cap)
>  		return false;

[Severity: Medium]
On PowerPC and SPARC, does pci_ats_init() run before dev->dev.trust_policy =
is
initialized when a PCI device is created via of_create_pci_dev()?

of_create_pci_dev() bypasses pci_setup_device() and calls pci_device_add()
directly, which runs pci_init_capabilities() -> pci_ats_init() and
pci_acs_init() before device_add() invokes device_trust_init().  Because
dev->dev.trust_policy is still DEVICE_TRUST_POLICY_DEFAULT at that point,
pci_dev_default_is_restricted() returns false, leaving dev->ats_cap populat=
ed
(and PCI_ACS_TB unset) even when boot trust parameters restrict the device.

[ ... ]

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f4..9aa69d19ceab4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1738,24 +1738,21 @@ static void set_pcie_cxl(struct pci_dev *dev)
> =20
>  }
> =20
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_default_trust_policy(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent =3D pci_upstream_bridge(dev);
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
> =20
> @@ -2082,7 +2079,9 @@ int pci_setup_device(struct pci_dev *dev)
> =20
>  	set_pcie_cxl(dev);
> =20
> -	set_pcie_untrusted(dev);
> +	pci_set_default_trust_policy(dev);
> +	dev->untrusted =3D device_policy_is_adversarial(&dev->dev);
> +	device_trust_init(&dev->dev);

[Severity: High]
Does calling device_trust_init(&parent->dev) before enumerating child buses
prevent downstream devices from inheriting DEVICE_TRUST_POLICY_ADVERSARY and
dev->untrusted?

During top-down enumeration, pci_setup_device(parent) sets the removable
bridge's trust_policy to DEVICE_TRUST_POLICY_ADVERSARY and then immediately
calls device_trust_init(&parent->dev).  When device trust is active at boot
(for example with bare device_trust, where the default policy is blocked),
device_trust_init() overwrites parent->dev.trust_policy to
DEVICE_TRUST_POLICY_BLOCKED before child buses are scanned.

When pci_set_default_trust_policy() later runs on child devices,
device_policy_is_adversarial(&parent->dev) is false, and on x86
arch_pci_dev_is_removable() returns true only for the external switch
upstream port directly under an integrated USB4/Thunderbolt root port:

arch/x86/pci/acpi.c:arch_pci_dev_is_removable() {
	...
	/* Anything directly behind a "usb4-host-interface" is tunneled */
	if (pcie_has_usb4_host_interface(parent))
		return true;
	...
	if (pcie_switch_directly_under(root, pdev))
		return false;
	...
}

As a result, downstream switch ports and endpoints behind an external PCIe
switch stay at DEVICE_TRUST_POLICY_DEFAULT with dev->untrusted =3D false,
losing IOMMU DMA isolation, ATS disablement, and ACS Translation Blocking.

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..d8edf8403a5ad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -616,6 +616,16 @@ static inline struct pci_dev *to_pci_dev(const struc=
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
> +	return policy =3D=3D DEVICE_TRUST_POLICY_BLOCKED ||
> +	       policy =3D=3D DEVICE_TRUST_POLICY_ADVERSARY;
> +}

[Severity: High]
Does setting an explicit "default" policy on a removable PCI device cause it
to be treated as unrestricted instead of adversarial?

pci_set_default_trust_policy() records a removable device's bus default by
writing DEVICE_TRUST_POLICY_ADVERSARY into dev->dev.trust_policy.  If a boot
rule such as device_trust=3Dpci:<bdf>=3Ddefault (or writing "default" to sy=
sfs
trust_policy) matches the device, it overwrites dev->dev.trust_policy with
DEVICE_TRUST_POLICY_DEFAULT.

Because pci_dev_default_is_restricted() returns false for
DEVICE_TRUST_POLICY_DEFAULT and pci_bus_type does not implement
trust_resolve(), ATS is allowed, PCI_ACS_TB is skipped, and
__device_trust_prepare() resolves the removable device to
DEVICE_TRUST_UNRESTRICTED rather than DEVICE_TRUST_ADVERSARY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D26
