Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A048124C
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936058; cv=none; b=cBRhxP7fVKFnoW2Dz/RQ4Y2RhLyeBBKws5tcwy/7ZEQj3sBmmvtAbIJgiwRRzi4zl5/n3V9Ttd9etoQZzn5YtNG4y+MuZ+i0hmoWascI3Cisezc4sZbOabjoX3+4J0yE+Ah+qLEpkkmf5i+8aUYjEnbwh85qRIdz9RN6D5paQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936058; c=relaxed/simple;
	bh=rnx1wEGQxc8Z6gLDOuS6stCMihMWA8ON9RypGU6UMqw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OFzxGGUpNlIAxdn4+o/aio0jj8BwMPAWI3x4MDIjhRCv2DJzpINZs7Vc2FzqKYQaY178U2AQeXDbTb+IUxacC6KEHt0H3g4PGcSw3WnVBhKZNOSi7rVQX39cre+uw5dtyKJnaH5/vEvlnHMWs/au7FRf9I+m1X1wAkugi35CO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsJsOqA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsJsOqA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F491F00899;
	Fri,  2 Oct 2026 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936056;
	bh=58iBWS5vydy1LOwMbA0K18gZjjZJjS6FrPN8pTlBsBQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=XsJsOqA+FxBKEbpGSPD5OluJu7yTJz7vFU7dMkkUKkYOUtl7pZ9s1M4BKMDa/POGw
	 vKhIqBjUQksonkW7OMm/pCHOEYmAKDpl8BUvo+p1bSIt9iHn1smVE9JoBxCWdcc0ky
	 MPu3VCjF/8GiP0jSKA/AbQgl1gepXeFT7AAsiNmOhlYg8Nn7UQoMdONNlVK+tDecE2
	 DXLZD0OJui8oEi8a5I9DC2ap/JDUk1ZE9NAQ7/JsVc+EUhB4YnKAN4jEF02RCP+2lQ
	 mx7i54i1js2iR564IWdNTa/vdoTN+moTj8g89cbsfJx7YDd82D0mKnzIKd/MZWdc2N
	 DbB5w2F2PvrDg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 83A4B198003A;
	Fri,  2 Oct 2026 06:14:14 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 06:14:14 -0400
X-ME-Sender: <xms:9IO_apbyMXY1ejwIl-x6JdjPLEyb7-4X3jeaX3sephSIVKSzeKFCGw>
    <xme:9IO_arPhDcUVTZ3d1gzxfiJKOrUnCHqArG9ml4XWqJPxNLg-DdusGn0kUn7XL9tb7
    3YsYXFrR0S0v9tBfS0Z3C_5HzPzO7BV9zsLl1DZXyc6scZdJddywmB8>
X-ME-Proxy-Cause: dmFkZTEOhzeCfv7ie68jmSoH46+QlVXBi4FcqrFVJDalFeKKPAb16YxiHzJSGL284ysdRo
    hZW4T65r/rCBl4qGyZzIfehZAsdMMotwFYgtvbYopoFsmqbGp8ZFIHY7sBrSBn96Eybzhw
    cCJL3V/jdnI18IVGV+iyxuM/7Dl2zdjfQIs7WiqAe2uNIFpB1xkCTYthnJ2TQn0/ikyGT2
    NF1upUY1mGbXxVQxBfbqZQv3VdzWCiurw/B39Hxxu+NJGKau+4BTNbMnGUorOiYGd5d9Nj
    Fhl1NXGioTTUjmWfyjs3AGDRSUM+IevGmJQ5rl9YZryjCIMfNPM97oI5Af9QMePnBHK0pN
    eNHaW+PpQCUKyM9GqcK48ckItIJikR7UagL7NPtCqzS9BhxrZQdZW8YqGa6Y+L0OiYT+bw
    AvsFhxb/i3RAXOa1F+cgWz7UV1xqCrrqmueTpIhzgErkKIHuuKNnuIbaqIcQsT405MKYod
    zF8BvT8SbRjSCb2CGR/IBFRmuMOhAAlCY64roJDouHyk2XEJz31wp7S8UzogAP/E1jD94z
    yVouCfC+DQEypFECD7Da+hARtfBijIi+JoJkdAoGO5KMtl9fGIsQ3If9B8puseYZXRKIUl
    kRU1zd2ZcnbZSIq06+Fp0EocHRaEHXLbKZKgewCrIMi6vGsYGNOCixTciHRQ
X-ME-Proxy: <xmx:9oO_aj-yB1TebkrtO_pYm5WnJvy0yiA3GnyjaQDlBnj9NaZavktK2Q>
    <xmx:9oO_ah-DTaT_d-LOeWku0PphyLZctDMA8W1cl1VYe34Re-F7e576ew>
    <xmx:9oO_ajSKpkZ2tlQALPdhIWCryvjCMALKC7J75EgrP1juiv5adM1cNQ>
    <xmx:9oO_alf-ssMkXD8F2y43X3ie_QAkAvXIUrx_SaPxVPJgxACVt4OE_A>
    <xmx:9oO_anBJoVXl9KG493HM3YfIU1xH5Z8VrHGbFCUVbSq0sPRJOC3su13q>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CA401F80084; Fri,  2 Oct 2026 06:14:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 12:13:52 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Message-Id: <734dafa4-e65a-4db5-88a8-9169453a2f5c@app.fastmail.com>
In-Reply-To: <245de2a8-4172-b886-75d6-4d017c30672e@linux.intel.com>
References: <20260930103036.248989-4-ardb+git@google.com>
 <20260930103036.248989-6-ardb+git@google.com>
 <245de2a8-4172-b886-75d6-4d017c30672e@linux.intel.com>
Subject: Re: [PATCH v3 2/2] PCI: Allow 64-bit non-prefetchable BARs in prefetchable
 windows
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed, 30 Sep 2026, at 20:50, Ilpo J=C3=A4rvinen wrote:
> On Wed, 30 Sep 2026, Ard Biesheuvel wrote:
>
>> From: Ard Biesheuvel <ardb@kernel.org>
>>=20
>> The non-prefetchable memory window of a PCI-to-PCI bridge can only
>> decode 32-bit addresses, and so non-prefetchable BARs of devices belo=
w a
>> bridge can only be allocated from the part of the host bridge memory
>> space below 4 GB. This is the case even for 64-bit BARs, which could
>> easily be placed above 4 GB if there was a bridge window to put them =
in,
>> and on many platforms, 32-bit addressable MMIO space is scarce.
>>=20
>> The PCIe spec addresses this in the implementation note "Additional
>> Guidance on the Prefetchable Bit in Memory Space BARs" (PCIe r7.0, sec
>> 7.5.1.2.1): on PCIe, setting the Prefetchable bit of a BAR still perm=
its
>> correct operation even if the range has read side effects or cannot
>> tolerate write merging, as long as the entire path from the host to t=
he
>> device is PCIe, given that PCIe Memory Reads always carry an explicit
>> length, and PCIe Switches never prefetch or merge writes. The same
>> reasoning applies when it is the OS that places a non-prefetchable BAR
>> in a prefetchable bridge window: PCIe Root Ports and Switch Ports
>> forward requests that hit either window in exactly the same way. Henc=
e,
>> the prefetchable window of a PCIe Root Port or Switch Port, which may=
 be
>> 64-bit, can serve as a 64-bit window for non-prefetchable BARs too. [=
0]
>>=20
>> So add pci_bus_placement_flags(), which returns the flags of a resour=
ce
>> on a given bus with IORESOURCE_PREFETCH set if it is a 64-bit
>> non-prefetchable memory resource, the bus is not a root bus, all brid=
ges
>> between the bus and the root bus are PCIe Root Ports or PCIe Switch
>> Ports, and the host bridge has no prefetchable memory window, but does
>> have one that extends above 4 GB in PCI bus address space. [1]
>>=20
>> Evaluate the conditions on the bridges and the host bridge only once
>> per bus, when it is added, and record the result in a new bus flag,
>> PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS: pci_register_host_bridge() sets
>> it on the root bus if the host bridge does not qualify, child buses
>> inherit it, and pci_alloc_child_bus() sets it on the secondary bus of
>> any bridge that is not a PCIe Root Port or Switch Port.
>>=20
>> Use pci_bus_placement_flags() wherever the resource allocator decides
>> which bridge window a device resource (including an SR-IOV VF BAR)
>> belongs in:
>>=20
>> - in pbus_select_window_for_type(), which is used when sizing bridge
>>   windows, and when releasing them to retry failed assignments or to
>>   resize a BAR;
>> - when allocating the resource in __pci_assign_resource(), by passing
>>   its result to __pci_bus_alloc_resource();
>> - when claiming a resource assigned by firmware, in
>>   pci_find_parent_resource();
>> - when deciding which assigned resources to release after a failed
>>   assignment, and which failures are relevant to a resized BAR.
>>=20
>> As a result, an eligible 64-bit non-prefetchable BAR is handled exact=
ly
>> like a 64-bit prefetchable BAR: it is placed in the prefetchable wind=
ow
>> of the upstream bridge, which may be above 4 GB, and allocation falls
>> back to the non-prefetchable window if the prefetchable one has no
>> space. [2]
>>=20
>> 32-bit BARs are not affected, and neither are bridge windows, as only
>> prefetchable bridge windows can be 64-bit. Devices below conventional
>> PCI or CardBus bridges, below PCIe to PCI/PCI-X bridges (in either
>> direction), or below host bridges that have a prefetchable window or =
no
>> window above 4 GB are not affected either, and neither are devices on=
 a
>> root bus, as there is no prefetchable window for their BARs to go to.
>>=20
>> [0] This reasoning does not extend to the host bridge, though: how it
>>     treats the windows that firmware describes as prefetchable is
>>     platform specific. For instance, the V3 Semiconductor V360EPC
>>     (pci-v3-semi) enables prefetching for its prefetchable window, the
>>     MPC52xx uses Memory Read Multiple for it, and Freescale PCI/PCIe
>>     host bridges (fsl_pci) enable relaxed ordering for it. However, if
>>     the host bridge has no prefetchable windows at all (as appears to=
 be
>>     the case on many x86 PCs), all prefetchable bridge windows are
>>     carved out of its non-prefetchable windows, and so the host bridge
>>     does not treat them any differently.
>>=20
>> [1] Placing non-prefetchable BARs in prefetchable bridge windows only
>>     helps if one of those non-prefetchable host bridge windows extends
>>     above 4 GB. Otherwise, the prefetchable bridge windows end up bel=
ow
>>     4 GB as well, and BARs would merely move between two bridge windo=
ws
>>     that are carved out of the same 32-bit space.
>>=20
>> [2] Note that this only concerns where a BAR is placed. How it is map=
ped
>>     is decided by the driver and by the attributes of the BAR itself
>>     (e.g., pci_iomap_wc() and the sysfs resource<N>_wc files only hon=
our
>>     IORESOURCE_PREFETCH on the BAR), and this change does not modify =
the
>>     flags of any BAR.)
>>=20
>> Assisted-by: LLM
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> Tested on QEMU arm64 'virt' (DT, all resources assigned by Linux) with
>> a qemu-xhci below a Root Port, an NVMe below a Switch, a qemu-xhci
>> below a PCIe-to-PCI bridge and another qemu-xhci on the root bus: the
>> 64-bit non-prefetchable BARs of the first two (and of the PCIe-to-PCI
>> bridge itself) move from the 32-bit non-prefetchable windows into the
>> 64-bit prefetchable windows above 4 GB, while the others stay where
>> they were. When the 64-bit host bridge window is marked prefetchable
>> in the DT, or removed from it, all resources are assigned exactly as
>> without this patch. Both drivers work, also after hot removal and
>> rescan of the endpoints and of the Switch. Also tested on QEMU x86_64
>> q35 with SeaBIOS, which assigns all resources itself: the firmware
>> assignment is claimed as before, and after hot removal and rescan, the
>> eligible BARs are placed in the prefetchable windows.
>> ---
>>  drivers/pci/pci.c       | 43 +++++++++++++++++++-
>>  drivers/pci/pci.h       |  1 +
>>  drivers/pci/probe.c     | 35 ++++++++++++++++
>>  drivers/pci/setup-bus.c | 23 ++++++++---
>>  drivers/pci/setup-res.c | 30 +++++++++-----
>>  include/linux/pci.h     |  1 +
>>  6 files changed, 115 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f8..51e96611d734 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -736,6 +736,43 @@ static bool pci_dev_config_accessible(struct pci=
_dev *dev, char *msg)
>>  	return true;
>>  }
>> =20
>> +/**
>> + * pci_bus_placement_flags - Get the flags to use for placing a reso=
urce
>> + * @bus: PCI bus of the device that owns the resource
>> + * @flags: Resource flags
>> + *
>> + * The non-prefetchable window of a PCI-to-PCI bridge can only decod=
e 32-bit
>> + * addresses, so 64-bit non-prefetchable BARs of devices below a bri=
dge have to
>> + * compete for space below 4GB. However, the PCIe spec notes that se=
tting the
>> + * Prefetchable bit of a BAR permits correct operation even if the r=
ange has
>> + * read side effects or cannot tolerate write merging, as long as th=
e entire
>> + * path from the host to the device is PCIe: PCIe Memory Reads alway=
s carry an
>> + * explicit length, and PCIe Switches never prefetch or merge writes=
 (PCIe
>> + * r7.0, sec 7.5.1.2.1, Implementation Note "Additional Guidance on =
the
>> + * Prefetchable Bit in Memory Space BARs").
>> + *
>> + * So if all bridges between @bus and the root bus are PCIe Root Por=
ts or PCIe
>> + * Switch Ports, handle 64-bit non-prefetchable resources on @bus li=
ke 64-bit
>> + * prefetchable ones, so that they can be placed in the prefetchable=
 window of
>> + * the bridge above @bus, which may be above 4GB. Other bridges, suc=
h as
>> + * conventional PCI bridges, may prefetch from their prefetchable wi=
ndow.
>> + *
>> + * Return: @flags, with IORESOURCE_PREFETCH set if a resource with @=
flags on
>> + * @bus may be placed in a prefetchable bridge window.
>> + */
>> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned =
long flags)
>> +{
>> +	if ((flags & (IORESOURCE_TYPE_BITS | IORESOURCE_PREFETCH |
>> +		      IORESOURCE_MEM_64)) !=3D (IORESOURCE_MEM | IORESOURCE_MEM_64=
))
>
> PCI_RES_TYPE_MASK
>

OK. Its definition will need to move, though, but I guess that's fine.

>> +		return flags;
>> +
>> +	if (pci_is_root_bus(bus) ||
>> +	    (bus->bus_flags & PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS))
>> +		return flags;
>> +
>> +	return flags | IORESOURCE_PREFETCH;
>> +}
>> +
>>  /**
>>   * pci_find_parent_resource - return resource region of parent bus o=
f given
>>   *			      region
>> @@ -749,6 +786,7 @@ struct resource *pci_find_parent_resource(const s=
truct pci_dev *dev,
>>  					  struct resource *res)
>>  {
>>  	const struct pci_bus *bus =3D dev->bus;
>> +	unsigned long flags =3D pci_bus_placement_flags(dev->bus, res->flag=
s);
>>  	struct resource *r;
>> =20
>>  	pci_bus_for_each_resource(bus, r) {
>> @@ -758,10 +796,11 @@ struct resource *pci_find_parent_resource(const=
 struct pci_dev *dev,
>> =20
>>  			/*
>>  			 * If the window is prefetchable but the BAR is
>> -			 * not, the allocator made a mistake.
>> +			 * not (and may not be treated as such), the
>> +			 * allocator made a mistake.
>>  			 */
>>  			if (r->flags & IORESOURCE_PREFETCH &&
>> -			    !(res->flags & IORESOURCE_PREFETCH))
>> +			    !(flags & IORESOURCE_PREFETCH))
>>  				return NULL;
>> =20
>>  			/*
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 8297cfb5dcd5..989b9c1f1580 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -567,6 +567,7 @@ static inline int pci_resource_num(const struct p=
ci_dev *dev,
>>  	return resno;
>>  }
>> =20
>> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned =
long flags);
>>  int __pci_bus_alloc_resource(struct pci_bus *bus, struct resource *r=
es,
>>  			     unsigned long flags, resource_size_t size,
>>  			     resource_size_t align, resource_size_t min,
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 27008e2ea5af..8f00ea3321c0 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -990,6 +990,32 @@ static bool pci_preserve_config(struct pci_host_=
bridge *host_bridge)
>>  	return false;
>>  }
>> =20
>> +/*
>> + * Return true if all memory windows of @bridge are non-prefetchable=
, and at
>> + * least one of them extends above 4GB in PCI bus address space (see
>> + * pci_bus_placement_flags()).
>> + */
>> +static bool pci_host_np_only_with_high_window(struct pci_host_bridge=
 *bridge)
>> +{
>> +	struct resource_entry *window;
>> +	bool high =3D false;
>> +
>> +	resource_list_for_each_entry(window, &bridge->windows) {
>> +		struct resource *res =3D window->res;
>> +
>> +		if (resource_type(res) !=3D IORESOURCE_MEM)
>> +			continue;
>> +
>> +		if (res->flags & IORESOURCE_PREFETCH)
>> +			return false;
>> +
>> +		if (upper_32_bits(res->end - window->offset))
>
> Should this use pcibios_resource_to_bus() for consistency with the res=
t of=20
> the code?
>

We are walking the window resources of an apriori known root bus here,
and pcibios_resource_to_bus() takes a bus, walks up to the root, iterates
over all window resources again to find the given resource, and then
applies the offset.

I agree it would be better to respect the layering here, but using
pcibios_resource_to_bus() is a bit of a kludge. Could we split it up
perhaps?

>> +			high =3D true;
>> +	}
>> +
>> +	return high;
>> +}
>> +
>>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>  {
>>  	struct device *parent =3D bridge->dev.parent;
>> @@ -1137,6 +1163,9 @@ static int pci_register_host_bridge(struct pci_=
host_bridge *bridge)
>>  		dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
>>  	}
>> =20
>> +	if (!pci_host_np_only_with_high_window(bridge))
>> +		bus->bus_flags |=3D PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS;
>
> Could this be simplified, e.g. to PCI_BUS_FLAGS_PREF_WIN_ANY_BAR.
>

Sure. That would also change the polarity, but I think that's an
improvement actually.
