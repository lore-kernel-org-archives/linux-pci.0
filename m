Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC473A7839
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877554; cv=none; b=Axg2P+3wf4Hmxezr62NA4T6u/o89enQPY1WT1lS3buJKS4qHuAX8TCh23eRTJWyGbc+6Tl8HWWa2C2hw7hYxU9aEJNj9GBQCzPCxRZOTuawPoDU6Y07tYqoLNCyNF/EdsUiocPpETgkeYebXtN8rlGcHNV0Gzy/MQsfvaQiIgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877554; c=relaxed/simple;
	bh=y5sr2Bhb4pM+iMfNN0Gwd79+2WTisPplpJL6T9c5vh8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dMFbJ205KslwONiXVVOK1A1PdgwP3VLZuuAc4gShbRdFhNeoxIt+Gk9oftQjY1NWiVyIrprO77UN80oqSDrtngw8Dm4+20yXFALBdrihaOibCXaUN6dhfaBKyelVMMei7j5d9TODQDsvH2rk3ZO/RCeXnY/s2lTYQQ6vkNdwtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5qJfJS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5qJfJS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312921F00898
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877552;
	bh=B9UoYBH3g4mUi6LX44VoMZRFlNLZSY6SOC8ciIqZuU0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=e5qJfJS4CQz3jaXwJKubNQ+wV4Q8qke8xqhX/xSTBP0P53AC1CW8aFfprU/E1Iqvt
	 demiPN2qzNfGB8KCFQSJieHEz1uYcEiNqndbMpGtMrJL7ROYi1HTFxcsJHELTVnDFM
	 bjv2UPvQfGUJD2sJn/gcQvAyAPnXCi5ao/0fNtDpQI8ul0MGTKGoqSiY/dS3luj2qg
	 qXaMq4A3lKA+CLOFif8+35f825SnDHmeSuEyooqgG28mGWMaaE+bDJSdV9iTKsQ2Sm
	 JrJBwad8G5WhUa+b4bwPkcQ0DwA8BJyPdphyksMqbHZ8keFXaUPskvMshCvthMV2Dy
	 Tu/CYeBXjNIEg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 87F3F198004A;
	Tue, 13 Oct 2026 03:45:50 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 13 Oct 2026 03:45:50 -0400
X-ME-Sender: <xms:rOHNat6o3Ig8m0_WWtoxK0-0uwDfFLyByUmZKy5qm5vVKdQRmizuLA>
    <xme:rOHNalsu4pFahhwb40J1NX799LMVTVBQ14SyMvmLvrjVIsAZrxo4s3YlRFCacEuc_
    bKUQKmNUr1iyoh4l4FQIA7oxpyOQZx0nbo_3N2QcqsMWZN-BwS4rvzy0w>
X-ME-Proxy-Cause: dmFkZTEuRNCJZuisoHttjXKwnGmGMRJcV7S8D38QDDsVOnpdPG9l6OkdaZvbmX1QMRNZLW
    XxAuZxaxyz+vm0lSmRxpCXrbjWVwufj2oUfC2xFg2u4KZu7IvfshvrWpDbKIb0EmrsuFtB
    vcAJNcBmMR3DN04VWwGQtay5T9/xpqY7KYNM0SLvUa2nKAQ/lju7TncIOYaII5WIPrWkDp
    DkIVebes73/8+/Vqh4OqFys27seJdLPxBqJJoRyfR/Gc2EsFwM2i3sSZc6RGsY3anigqMt
    7RKRvZx7u8hNOFfgAba77vrY+J1kxzwJU7jYRPwS8CSFULoI2laAaYblhxP2JHlX5wfqmS
    1RPzPLWYlmE8SyYy090lgHvYFUk4ORgFnCteUc82EnKxYlrWl6gUTCYe4n10/yb660RPcD
    xm9QpHqAtJbx8E0yyD7fo1CGPXDeQwSJfQGzTKEPUX/HxLjvR3ccXuu+WzKbGxLBZub/cS
    w4CP8qkx3wfkbvoTjQpnKrJqu0WqFOQPFLh6Q7so6CeAKjcthGoIoKnyKccLjOERW1h/lL
    HUrFr1YBbO6yDtAjq7Jh71YOnp5Oqv/sM6b0GsffvyFsiSsW6Ec6Prv5Em/A8SGClGsylR
    a96mAzy7tQG0EJKL9M4hp2NA9pQcmbRoIobft20iAmDfQGhwitmuNaJmlrPA
X-ME-Proxy: <xmx:ruHNageaNEIinbj-zL3npUqKEHuDFwTaykldQgmU-_2fwmvHS-5lbg>
    <xmx:ruHNakfjCYIWlSrXZwe4rjgbzK6vCadEQySSJq2pLePzO3vtaWRuGA>
    <xmx:ruHNajxrH0Oqjwkb7N0picdjRNeejK-etsYwfqIb1_4M9miiCUQitA>
    <xmx:ruHNar_-t0BklNKBiS-nrC5TkoY9vfcbg8r4LEZb23nz1AbzLSG5Eg>
    <xmx:ruHNarjl_56fNCNuPtL5qqkqQvDyxupm9kIBfEAIgCfjfvjbA17apVBX>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E0A96F80090; Tue, 13 Oct 2026 03:45:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 09:45:27 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Message-Id: <5369bc85-a9af-429c-871a-0995d8f609f9@app.fastmail.com>
In-Reply-To: <ac7686c7-9446-1f38-bc85-67556f0f6137@linux.intel.com>
References: <20260930103036.248989-4-ardb+git@google.com>
 <20260930103036.248989-6-ardb+git@google.com>
 <ac7686c7-9446-1f38-bc85-67556f0f6137@linux.intel.com>
Subject: Re: [PATCH v3 2/2] PCI: Allow 64-bit non-prefetchable BARs in prefetchable
 windows
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Thu, 8 Oct 2026, at 19:52, Ilpo J=C3=A4rvinen wrote:
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
>
> Hi again,
>
> I think I now mostly understand the remaining problems, both relate to=20
> multipass resource assignment logic. First of all this seems required =
as=20
> well:
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b662cbeda51e..b5fdcb10d45a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2206,8 +2206,10 @@ static void pci_prepare_next_assign_round(struc=
t=20
> list_head *fail_head,
>  	list_for_each_entry(fail_res, fail_head, list) {
>  		struct pci_bus *bus =3D fail_res->dev->bus;
>  		struct resource *b_win;
> +		unsigned long flags;
>=20
> -		b_win =3D pbus_select_window_for_type(bus, fail_res->flags);
> +		flags =3D pci_bus_placement_flags(bus, fail_res->flags);
> +		b_win =3D pbus_select_window_for_type(bus, flags);
>  		if (!b_win)
>  			continue;
>  		pci_bus_release_bridge_resources(bus, b_win, rel_type);
>
> In addition, pci_bus_release_bridge_resources() ->=20
> pci_bridge_release_resources() -> release_child_resources() may releas=
e=20
> additional resources, some of which may be assigned to a different bri=
dge=20
> window by FW than where kernel will try to put them in the next pass. =
If=20
> there are no failed resources for that other bridge window in the fail=20
> list, the other bridge window is not released and thus doesn't get siz=
ed=20
> properly.
>
> Likely, the best course of action would be to wrap release_child_resou=
rces()
> with PCI level equivalent (it would improve printing as well as then t=
he=20
> resources are properly annotated with the device information).
>
> That would also likely make it possible to avoid tearing down resource=
s=20
> that are in use by some endpoint driver (which was recently reported t=
o=20
> occur, during hotplug IIRC).
>
> I hope this helps.
>

Thanks a lot. I will get back to this shortly, I hope.
