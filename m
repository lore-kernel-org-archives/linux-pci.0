Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084321;
	b=c3w/kO8aeNYbTe8ZpWthdjG3YokQpbZ6qGZ/jC5mUgq1meiAQmDtsVY+uhujd8kQKYjF
	 0LCR2nkv59fji7YR+tl1HEONTeMUIji7LylEB/3vvAYjYHo9VpplA0yAwnU/a3FMtS+Eh
	 jcNCnVogpjDmSVJAu+N3Hi3q0LtL5f1R5RNrVdePls45VNaivG6+DYq0Ppxu3EMWfc8hD
	 dZG+zgFM+lR0JLMdT6Brc32MexTgvpaFj9Bgc7DzO/vIfhwDZerzdpt8NprFjmFeItLv7
	 4C+sXzEqfPmPUVvnToRf2yyc/0Lk2/oNvSMez5GzV6IVs/wBIxu5sqjP7v0Teo56Hrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MLYV/9BUIfSbAtHLFVQ3CU/GXZVVfT6FDvd8k66d3E4=;
	b=qJmGkBraLXSHkLaVDRDFnXo7AE8j9At2n80i543ecNHI8YcjYM2w5fvDwndakTHHvwfr
	 QR6EAomNn9MQuzGgveuwLcZFjm8+3ERhd0kFLGcFrvhSbcZhuvljIBMLvfVBCazONhCe4
	 ue0m/3aTuz1G/eG7IGz2OvDAzw6QU0K3oERYvPYiBQ/OFNWyGepPxwTKhdOe5c9xmKTks
	 vxlKU8bJ8d3JYwUS72QXrBM7gI7Tg4L+me6I0sxFFg9ur+/wIiYELpZVtCNG7J1Ly7Qhk
	 u1upN9g9IwS6DnTEGqjkggXUa2IJRCLx4e3xXAZVOYzantb1bExaElpu4rjuzL8d9sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BE68qbr8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E4606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BE68qbr8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D74E1F000CA;
	Thu, 19 Nov 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084321;
	bh=MLYV/9BUIfSbAtHLFVQ3CU/GXZVVfT6FDvd8k66d3E4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BE68qbr8xhkYwxGwgsHSR2imMHi4f6P8NBZGgfOUC7QZ3r9mbXrvIOCoXYTxCpexM
	 YYNjsN0EgZfO1WrasymcE6vMNvx4a2C3nPU4Fy1eyYbb+L9JEZRtQWqpm40+KQ+qcF
	 27Iy7gGo5v2jkZVrGw7epQsXHGwSmq+B45vZgS8TcENk44Ji1HPPjBgXQE4XKBhReL
	 gyuJNzACKCoHv++Q3zHCTJ4yGjh0rBZFi4aSZ4RPoGOodTq0/spH8+SRPfkDO+5L/l
	 0yxRn9EfAD24jDGOUoERILrAfk8a/IsM7nOaI3ArTVLChM1YFq0yrTFT06mpOk6Cqq
	 JyVAxssKTOveQ==
Message-ID: <sashiko-outbox-222957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 4/4] PCI: Re-check function 0 reset methods after
 scanning its slot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119100628.1948990-5-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
 <20261119100628.1948990-5-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:32:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] PCI: AB-BA deadlock between pci_scan_slot() and pciehp
  reset_lock
- [Medium] PCI: stale reset sysfs attributes after
  pci_prune_reset_methods()
- [Medium] PCI: incomplete reset method pruning conditions in
  pci_scan_slot()
- [Medium] PCI: late or missing multifunction flag breaks hotplug slot
  reset probe
--

commit a12801a8cda3240b7730ba41ca17db3de977e4a2
Author: Vidya Sagar <vidyas@nvidia.com>

PCI: Re-check function 0 reset methods after scanning its slot

This commit adds pci_prune_reset_methods() and calls it on function 0 at
the end of pci_scan_slot() when multiple functions are discovered,
removing reset methods that no longer probe successfully once sibling
functions are on the bus.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 05d049f7ba75b..4175cca8e6e31 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5489,6 +5489,41 @@ void pci_init_reset_methods(struct pci_dev *dev)
>  	dev->reset_methods[i] =3D 0;
>  }
> =20
> +/**
> + * pci_prune_reset_methods - drop reset methods that no longer work
> + * @dev: PCI device to check
> + *
> + * Probe each of @dev's current reset methods again and remove the ones
> + * that fail, keeping the order of the rest.  Unlike pci_init_reset_meth=
ods(),
> + * this never adds a method, so a list set through sysfs is kept, except=
 for
> + * methods that can no longer work.
> + *
> + * Context: The caller must hold the device lock of @dev, which serializ=
es
> + * this against resets and writes to the "reset_method" sysfs file.
> + */
> +void pci_prune_reset_methods(struct pci_dev *dev)
> +{
> +	u8 methods[PCI_NUM_RESET_METHODS] =3D {};
> +	int m, i, n =3D 0, rc;
> +
> +	might_sleep();
> +	device_lock_assert(&dev->dev);
> +
> +	for (i =3D 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		m =3D dev->reset_methods[i];
> +		if (!m)
> +			break;
> +
> +		rc =3D pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_PROBE);
> +		if (!rc)
> +			methods[n++] =3D m;
> +		else if (rc !=3D -ENOTTY)
> +			break;
> +	}
> +
> +	memcpy(dev->reset_methods, methods, sizeof(dev->reset_methods));
> +}

[Severity: Medium]
What happens to the reset and reset_method sysfs attributes if pruning
removes every method from dev->reset_methods[]?

When function 0 of a multi-function device supports no function-level
reset methods, bus (and cxl_bus) initially succeed during
pci_device_add() while bus->devices is empty.  device_add() then sees
pci_reset_supported(dev0) =3D=3D true and creates the reset and reset_method
files.  When pci_prune_reset_methods() later zeroes
dev0->reset_methods[], pci_reset_supported(dev0) becomes false, but the
sysfs groups are not updated, leaving an empty reset_method file and a
reset file that fails with -ENOTTY on function 0 while functions 1..N
omit both files.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 222ad696a1581..0f9b4115abd8d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2882,7 +2882,7 @@ static int only_one_child(struct pci_bus *bus)
>   */
>  int pci_scan_slot(struct pci_bus *bus, int devfn)
>  {
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *dev0 =3D NULL;
>  	int fn =3D 0, nr =3D 0;
> =20
>  	if (only_one_child(bus) && (devfn > 0))
> @@ -2895,6 +2895,8 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  				nr++;
>  			if (fn > 0)
>  				dev->multifunction =3D 1;
> +			else
> +				dev0 =3D dev;

[Severity: Medium]
Can bus and cxl_bus still be left enabled on multi-function devices in a
hotplug slot that implements reset_slot?

__pci_reset_bus_function() tries pci_dev_reset_slot_function() before
pci_parent_bus_reset(), and pci_dev_reset_slot_function() rejects
multi-function devices by checking dev->multifunction rather than
dev->bus->devices:

drivers/pci/pci.c:pci_dev_reset_slot_function() {
	if (dev->subordinate || !dev->slot ||
	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
	    (dev->multifunction && !dev->slot->per_func_slot))
		return -ENOTTY;

	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
}

On ARI multi-function devices, PCI_HEADER_TYPE_MFD is hardwired to 0b in
config space and pci_scan_slot() never sets dev0->multifunction =3D 1 when
fn > 0 is found, so pci_prune_reset_methods(dev0) still succeeds in
pci_dev_reset_slot_function() and keeps bus on function 0.  In addition,
for fn > 0 whose own Header Type register does not set
PCI_HEADER_TYPE_MFD, dev->multifunction is only set to 1 here after
pci_scan_single_device() has already probed reset methods, so fn > 0
records bus during probe and is never pruned.

>  		} else if (fn =3D=3D 0) {
>  			/*
>  			 * Function 0 is required unless we are running on
> @@ -2907,6 +2909,18 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  		fn =3D next_fn(bus, dev, fn);
>  	} while (fn >=3D 0);
> =20
> +	/*
> +	 * Function 0's reset methods were probed before the other functions
> +	 * were on bus->devices, so a bus reset looked possible then.  Its
> +	 * "reset_method" file already exists and userspace may have changed
> +	 * the list, so only drop the methods that can't work now.  The device
> +	 * lock keeps a write to that file from landing in the middle.
> +	 */
> +	if (dev0 && !pci_dev_is_added(dev0) && nr > 1) {

[Severity: Medium]
Does this condition miss other cases where the first device on a bus is
probed alone and later shares bus->devices?

pci_parent_bus_reset() refuses a bus reset whenever any other device is
on dev->bus->devices, but pruning only runs when fn 0 and another
function are both newly discovered in the same pci_scan_slot() call.
The first device on a bus still keeps an unusable bus reset method when:
- hypervisor_isolated_pci_functions() scans multiple non-zero functions
  without fn 0 (dev0 remains NULL),
- a later rescan adds a newly enabled sibling function alongside an
  already-added fn 0 (pci_dev_is_added(dev0) is already true and nr can
  be 1), or
- a bus has multiple devices at different slot numbers scanned across
  separate pci_scan_slot() calls.

> +		guard(device)(&dev0->dev);
> +		pci_prune_reset_methods(dev0);
> +	}

[Severity: High]
Does taking device_lock(&dev0->dev) inside pci_scan_slot() invert the
lock order against pciehp's ctrl->reset_lock?

During hotplug enumeration, pciehp_configure_device() holds
ctrl->reset_lock across pci_scan_slot() and pci_hp_add_bridge(), and only
drops ctrl->reset_lock around pci_bus_add_devices() to avoid an ABBA
deadlock with device_lock.  Meanwhile, slot and function resets acquire
device_lock(&dev->dev) before pciehp_reset_slot() takes ctrl->reset_lock
for write:

CPU0                              CPU1
----                              ----
down_read(&ctrl->reset_lock)
                                  device_lock(&dev0->dev)
                                  down_write(&ctrl->reset_lock)
device_lock(&dev0->dev)

 *** DEADLOCK ***

CPU0: pciehp_ist() -> ... -> pciehp_configure_device() -> pci_scan_slot()
CPU1: pci_reset_function() / reset_method_store() / pci_slot_reset() ->
      ... -> pciehp_reset_slot()

Because device_add(&dev0->dev) and list_add_tail(&dev0->bus_list,
&bus->devices) have already run before functions 1..N are scanned, CPU1
can lock dev0 while CPU0 is still scanning the remaining functions in
pci_scan_slot().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119100628.1948=
990-2-vidyas@nvidia.com?part=3D4
