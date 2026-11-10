Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296127;
	b=h+QrOyrylwPE2D0J58ZnpEfpmjamRokG7R5SgfSBrUxPEuaCXP76tJZGpNngZPU67iAc
	 O4VJcpJvsRwjpp9voDVqPqHAWAs3MqBsqhwQu/Dhxj/GbcQC8qIvk74deJPbzhPxETZgU
	 BaZzCmoZ/dbHMA3p/UK/Wt0g/r9UfRrR63m8HQNJhUU2ZlmwYNx8UJCKcCBMGy8z5hcvk
	 ZRPlNHQrmeGcw+yqv9lPhZGunoITVV5WIQ5ha3ajZZmAzOzw0r5+WaIKVXyKLT1ne41JI
	 9JKBILty2hjSL6OI5SS9MUIaZgJCJI9uVPlkqNFHLMj1kjc3ZKAJzcUIJQXycatgIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lZBatUg3AqKfmKBWuOMTcsEx7PNjRPr/IuDOXemiadc=;
	b=iG0eqmP4a5SQq4mnZh0+Y2PPgl8j/1/4e3CDV9JkLet57LIwG/fapJOC+bzexjEKTg9q
	 CIdK5Gn8SFfgyw5Br4cg4F6YyDhBZ911BU7b90BS3nEuh4t77Yai+Hv82qgKzQAGX0wYP
	 lczPk5mmHMAKCW4TJYscW6r++O6NCxzGgQymv3PnI3NRzip/dfVBxk/bjMNHrSq3vrlWI
	 pQKWizGggbEYGvgLrSEZM3LzWiLNjkENU6nKKJy5/Xd8KWkXXkHMY1VkaDvqzJMHhni97
	 SYVTssfciL19Qa1EEWDZ8seBI8r1rwQxvrKeTi1Htt4/bz66VqN9xEAU+/2mm91CeXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SW/LeAS7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4569606A330;
	Tue, 10 Nov 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW/LeAS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288801F008A6;
	Tue, 10 Nov 2026 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296126;
	bh=lZBatUg3AqKfmKBWuOMTcsEx7PNjRPr/IuDOXemiadc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SW/LeAS7CjE+EQchxT4q+0cp2Md/AZQEXjZ5Wt2er4mxP5+kN7xpnGk/jY3gx4enk
	 +JgYfGikjoubbwvNOyhYbLbHohenp7s6As9fPNqcGI7GEdv56lahQ2xue99bukVe53
	 wrpJP4mTp3OS7pUbMQ9gSr52XDa2w6ErP7xY6sH+31c30OfITDoMUhfeY7Za72bwlT
	 YRwehNrqxYcjyYaM74voOqZdtKLtwQmDTIdPq1h3gMmoVP7xnbUOnhspBBqqvFIxLP
	 W7s5s1KXYIxAI86x6COc/eNiC/3gnqha1OIpw25GX9xwO1fUXu3VHoZw+cJr+ozxl/
	 I3OpGbO0I8jhQ==
Message-ID: <sashiko-outbox-206518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] PCI: broken adversarial trust inheritance in
  pci_set_default_trust_policy()
- [High] PCI: default trust policy overwrites adversarial default on
  removable devices
- [Medium] PCI: pci_enable_acs() and pci_ats_init() break
  disabled-to-full trust policy
- [Medium] PCI: pci_dev_ats_permitted() drops PCI_ACS_TB after full
  authorization
- [Medium] PCI: of_create_pci_dev() skips pci_set_default_trust_policy()
  before ATS init
--

commit 7c55633025e040b3c2b6b2f31a6d205ea496c0f7
Author: Leon Romanovsky <leon@kernel.org>

PCI: Replace untrusted state with device trust

This commit replaces pci_dev::untrusted with the generic device trust policy
and trust level helpers across the PCI and IOMMU subsystems.

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093dd..c8c96acc26343 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
> =20
> -	if (pci_ats_disabled() || dev->untrusted)
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
> =20
>  	if (dev->is_virtfn)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..b08adba03f96b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1016,8 +1016,9 @@ static void pci_std_enable_acs(struct pci_dev *dev,=
 struct pci_acs *caps)
>  	/* Upstream Forwarding */
>  	caps->ctrl |=3D (dev->acs_capabilities & PCI_ACS_UF);
> =20
> -	/* Enable Translation Blocking for external devices and noats */
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	/* Enable Translation Blocking when ATS is unavailable or restricted. */
> +	if (pci_ats_disabled() || dev->external_facing ||
> +	    !pci_dev_ats_permitted(dev))
>  		caps->ctrl |=3D (dev->acs_capabilities & PCI_ACS_TB);
>  }

[Severity: Medium]
Does a device that starts with DEVICE_TRUST_POLICY_DISABLED (for example via
device_trust.default=3Ddisabled before initrd authorization or a driver tru=
st
rule) keep ATS disabled and PCI_ACS_TB enabled even after it is authorized =
for
DEVICE_TRUST_FULL?

During pci_device_add(), pci_ats_init() sees pci_dev_default_is_restricted()
return true and skips initializing dev->ats_cap; nothing re-runs
pci_ats_init() when the device later transitions to DEVICE_TRUST_FULL.
Likewise, device_add() -> iommu_probe_device() -> pci_dma_configure() ->
pci_enable_acs() runs while the device is still unbound
(DEVICE_TRUST_DISABLED), so !pci_dev_ats_permitted(dev) is true and
pci_std_enable_acs() (as well as pci_quirk_enable_intel_spt_pch_acs()) sets
PCI_ACS_TB in hardware.  When really_probe() later sets DEVICE_TRUST_FULL a=
nd
calls pci_dma_configure() -> pci_enable_acs() a second time, pci_enable_acs=
()
reads the existing PCI_ACS_CTRL register value into caps.ctrl and only ORs
bits into it, never clearing PCI_ACS_TB.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5b6960bbb35bc..607569c31b5b9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1738,24 +1738,24 @@ static void set_pcie_cxl(struct pci_dev *dev)
> =20
>  }
> =20
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_default_trust_policy(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent =3D pci_upstream_bridge(dev);
> +	struct pci_dev *parent =3D pci_physfn(dev);
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
Can downstream devices behind a removable PCIe switch or SR-IOV VFs on a
removable PF lose their adversarial default policy when the parent's
trust_policy is overridden?

In pci_setup_device(), device_trust_init(&dev->dev) runs on the parent brid=
ge
before child buses are scanned (or before SR-IOV VFs are created).  If the
parent port or PF has its trust_policy changed to disabled or full (for
example via device_trust.default=3Ddisabled, a per-device rule, or sysfs),
device_policy_is_adversarial(&parent->dev) is false for its children.  On x=
86
ACPI systems, arch_pci_dev_is_removable() only returns true for the switch
upstream port directly beneath an integrated USB4/Thunderbolt root port and
returns false for the switch's downstream ports, endpoints below them, and
VFs:

arch/x86/pci/acpi.c:arch_pci_dev_is_removable() {
	...
	/* Anything directly behind a "usb4-host-interface" is tunneled */
	if (pcie_has_usb4_host_interface(parent))
		return true;

	if (pcie_switch_directly_under(root, pdev))
		return false;
	...
}

Those child devices therefore stay at DEVICE_TRUST_POLICY_DEFAULT and resol=
ve
to DEVICE_TRUST_FULL, bypassing IOMMU DMA domain enforcement, ATS and ACS
restrictions, and SWIOTLB bounce buffering.  Running pci_set_removable(dev)
before pci_set_default_trust_policy(dev) and checking dev_is_removable() wo=
uld
preserve the hardware removability state across parent policy overrides.

> @@ -2082,7 +2082,7 @@ int pci_setup_device(struct pci_dev *dev)
> =20
>  	set_pcie_cxl(dev);
> =20
> -	set_pcie_untrusted(dev);
> +	pci_set_default_trust_policy(dev);
>  	device_trust_init(&dev->dev);
> =20
>  	/* "Unknown power state" */

[Severity: Medium]
On PowerPC and SPARC systems where of_create_pci_dev() creates PCI devices
directly without calling pci_setup_device(), does pci_ats_init() run before
the device trust policy is initialized?

of_create_pci_dev() calls pci_device_add(), which runs
pci_init_capabilities() -> pci_ats_init() before device_add() calls
device_trust_init(), and never calls pci_set_default_trust_policy().  Becau=
se
pci_ats_supported() no longer checks the device state at runtime, dev->ats_=
cap
is populated while trust_policy is still DEVICE_TRUST_POLICY_DEFAULT, leavi=
ng
ATS enabled even when a boot trust policy restricts the device.

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

[Severity: High]
If a removable PCI device is configured with an explicit "default" trust
policy (via device_trust=3D, device_trust.driver=3D, or sysfs trust_policy)=
, does
that overwrite DEVICE_TRUST_POLICY_ADVERSARY with DEVICE_TRUST_POLICY_DEFAU=
LT
and grant the external device DEVICE_TRUST_FULL?

In pci_setup_device(), device_trust_init() runs after
pci_set_default_trust_policy() and overwrites dev->dev.trust_policy with
DEVICE_TRUST_POLICY_DEFAULT when a per-device default rule matches.  Because
pci_dev_default_is_restricted() only checks for DISABLED and ADVERSARY, and
pci_bus_type does not implement .trust_resolve, DEVICE_TRUST_POLICY_DEFAULT
bypasses pci_dev_default_is_restricted() during discovery and resolves to
DEVICE_TRUST_FULL in __device_trust_prepare() at bind time.

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
Can a device discovered with DEVICE_TRUST_POLICY_DISABLED lose PCI_ACS_TB in
hardware after being authorized for DEVICE_TRUST_FULL and undergoing a PCI
reset or D3cold transition?

At discovery, pci_ats_init() skips setting dev->ats_cap and pci_enable_acs()
sets PCI_ACS_TB because !pci_dev_ats_permitted(dev) is true.  Once the devi=
ce
is authorized and bound with DEVICE_TRUST_FULL, pci_dev_ats_permitted()
returns true even though dev->ats_cap is 0.  Because ACS registers are not
saved in saved_cap_space, a subsequent reset or D3cold resume clears the
hardware register and runs pci_restore_state() -> pci_enable_acs() ->
pci_std_enable_acs(), which sees pci_dev_ats_permitted() return true and
leaves PCI_ACS_TB cleared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D18
