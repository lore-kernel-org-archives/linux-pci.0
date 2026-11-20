Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178934;
	b=uhg4WRE4mRAfqWzvnB94bulrLjD/vTk/xXl/WVHqGB0ap0vHF8UcgRcLamlr0VptSLqM
	 eFtSx3Y/K3OtvhSd6Y2Vhhr+W7+SrwAuBtPrb19vJHPVnnij/dbFgZUNnN+IGMPEeXAWw
	 kicoCQfAQuiBsZr8WRz0UK6ymXq31TbvQhRVWPlH53BZTBL6sovlbZ2t5zx6UU7q5TqSS
	 MOoB6WSY+rTK4+iqPH0gnWeswNFOKeXHkpAhY2SaqQVZjYsvpTTA1MpXx9wyLsSptxzRC
	 QU/GSlJcPZcvsuVtk+dLrEUvMdz5O+qH0cbIhAbhq717Jo1bdFlriAQgJSV8KQH06qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178934;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5y5IiZafi4/ONiuYWfUibW0wvSSUQMFqt9ROxWxYZJE=;
	b=IjRHi/yF+NiJ3acATMzcJAjtBYZOOrAtJq1om06746FOoKIaBfAISv0G4FGdhpBLMOH5
	 SMZdvit8FvjouLfxA/cahbOUURZFutAoAlORlYIzlBeNstIl4Jf0Oh/YvhUaLBupNKh5C
	 0KvIdEbHMcArFl7Kx19dSDHB1dTZMn+ddbEkk9wY9d+ivaVnFMnSd1NhPFRsv1NW+mAnf
	 9vC5uL5JHkAAxIohbbuUrJXubhl84a/wLjrm+MKKzN+NXEnK5JseVUr5t6yqfc+XVAmC5
	 PkvDK5BLfizNbG7ieP/TaTVUd4QHGKthpyEiZsQMceoCktjKcALlAYf/KttkeasbKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7QsPB7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337E606A325
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7QsPB7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392211F000D4
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178934;
	bh=5y5IiZafi4/ONiuYWfUibW0wvSSUQMFqt9ROxWxYZJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n7QsPB7tDEbc/4rDSlloRLPnpIttBc234LywkWhE2F1MBc9XBEon+dcBXu+PpQRQk
	 O7TdTG1IkShgPlzzjSm+HAsAKnzjKmfMEVd0iDZWJlUUQ1MP4VHjEEs+0pnUj+mAEW
	 0ynPs+MOFw6wWj9w8uBF9DuRfLajcb8o10QQwFZoO6WJP0XwtzQq9AmbyGLQd8p5UT
	 i/Sijc2yy7SGwQomPzWLbwdt+PImJ+aTRYi3jZ+KnuafUvrcwxkFDhV4gs9CcMUPot
	 RzMErHQAVKy9EYzJVPuynvxE8GrAHlNu7PhiFXxlTvHrCF8vkn0A1vNZdWUI1l5zvS
	 jtYGcpeRZ3tsw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be47aa555cso975410e87.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:48:54 -0800 (PST)
X-Gm-Message-State: APuU4Z/ObLIfC9271zUWC4Nt7W1HO1Z2UCW3DfRmNHpWvb/tOWdRmy+H
	dgSImLPPo10LH5VoqkTj0wo5AC8bfq0ETCJGJhY6SsR3UvOh9QphesvhP9m7kxp1YtlI5foZ3qH
	ocFruJ2ssIoBQ8Pmk3zSyL+5yylEkALI=
X-Received: by 2002:a05:6512:31c3:b0:5c1:465b:ebe3 with SMTP id
 2adb3069b0e04-5c1bc7be4b6mr1079661e87.13.1795178932584; Fri, 20 Nov 2026
 04:48:52 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com> <20261116152403.2672-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261116152403.2672-6-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:48:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hgt_S26dy2MELqz4SiRo73hzZY_rU+_VfHpPKYPHEGLw@mail.gmail.com>
X-Gm-Features: Aa3M54q3kudao5rnwautljy_IwjQT-qBAN--yV6WVw8dUPc3lfjm_3FYqQRJszw
Message-ID: <CAJZ5v0hgt_S26dy2MELqz4SiRo73hzZY_rU+_VfHpPKYPHEGLw@mail.gmail.com>
Subject: Re: [PATCH 05/13] PCI: Serialize bridge window sizing and resource assignment
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Williamson <alex@shazbot.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 4:25=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Bridge window sizing and resource assignment are started from multiple
> entry points: rescan and hotplug under pci_rescan_remove_lock, and BAR
> resize from sysfs or driver probe under device_lock() only. The entry
> points hold pci_bus_sem only for read, so nothing prevents two sizing
> and assignment passes from running concurrently on the same bridge
> windows and BARs. E.g., a rescan may assign a BAR that a concurrent BAR
> resize has released, or restore a resource the resize has already
> assigned.
>
> Looping BAR resize through sysfs against a rescan of the parent bus on a
> system with a BMG GPU triggers the add_list sanity check. The rescan
> sizes the Downstream Port's prefetchable window while the resize assigns
> it, and the sizing values overwrite the assigned window. The resize then
> programs these values into the Downstream Port, outside the root bus
> resources and overlapping System RAM [mem 0x100000000-0x4075ffffff]. The
> rescan skips assigning the window as it looks assigned, which leaves its
> add_list entry unused:
>
>   pci_bus 0000:b7: root bus resource [mem 0xd6000000-0xddfbffff window]
>   pci_bus 0000:b7: root bus resource [mem 0x2e0000000000-0x2effffffffff w=
indow]
>   pcieport 0000:b9:01.0: bridge window [mem 0x800000000-0x1000ffffff 64bi=
t pref] to [bus ba] add_size 4000000 add_align 800000000
>   pcieport 0000:b9:01.0: PCI bridge to [bus ba]
>   pcieport 0000:b9:01.0:   bridge window [mem 0xdda00000-0xddbfffff]
>   pcieport 0000:b9:01.0:   bridge window [mem 0x800000000-0x1000ffffff 64=
bit pref]
>   add_list && !list_empty(add_list)
>   WARNING: drivers/pci/setup-bus.c:1546 at pci_assign_unassigned_bus_reso=
urces+0x9e/0x130, CPU#58: srf8-resize-rac/2861
>   CPU: 58 UID: 0 PID: 2861 Comm: srf8-resize-rac Tainted: G S            =
      7.4.0-rc1-g6628e7d4c6b2 #59 PREEMPT(full)
>   RIP: 0010:pci_assign_unassigned_bus_resources+0x9e/0x130
>   Call Trace:
>    pci_rescan_bus+0x20/0x40
>    dev_rescan_store+0x6e/0x90
>
> Other trigger vectors are possible as well. Hotplug takes the same locks
> as the sysfs rescan. BAR resize walks the bridge windows up to the Root
> Port to make room for the resized BAR, and then sizes and assigns the
> whole hierarchy below the Root Port. Thus, hotplug anywhere below the
> same Root Port can race with the resize, e.g., when connecting a
> Thunderbolt device. Instead of the sysfs resize, a driver can resize a
> BAR during probe, e.g., after unbind and bind.
>
> pci_rescan_remove_lock cannot be taken under device_lock() because the
> device removal path takes them in the opposite order.
>
> Add pci_res_setup_lock and hold it across sizing and assignment in all
> entry points, including acpiphp which calls the internal sizing and
> assignment functions directly. Assert the lock is held in the
> functions that modify resources deeper in the call chains. In
> pci_do_resource_release_and_resize(), take the lock before selecting the
> bridge window and setting the BAR size as both depend on or change
> resource state.
>
> The race was also reproduced in QEMU, which found more symptoms.
> Looping BAR resize through sysfs against a rescan of the parent bus on
> a guest with 512M of RAM, using a synthetic host bridge with a Root Port
> and an Endpoint with a Resizable BAR, triggers the following failures:
>
> 1) Both the rescan and the resize release the Root Port's prefetchable
>    window. Both find it assigned, but the rescan releases it first, and
>    the resize then dereferences the NULL parent in __release_resource():
>
>      pcieport 10000:00:00.0: bridge window [mem 0x940000000-0x97fffffff 6=
4bit pref]: releasing
>      pcieport 10000:00:00.0: bridge window [mem size 0x40000000 64bit pre=
f]: releasing
>      BUG: kernel NULL pointer dereference, address: 0000000000000038
>      Oops: Oops: 0000 [#1] SMP
>      CPU: 0 UID: 0 PID: 49 Comm: init Not tainted 7.4.0-rc1-00001-g4aa3ac=
aaeb08 #1 PREEMPTLAZY
>      RIP: 0010:__release_resource+0x8/0x70
>      Call Trace:
>       release_resource+0x22/0x40
>       pci_release_resource+0x54/0x90
>       pci_do_resource_release_and_resize+0x1f3/0x3d0
>       __resource_resize_store+0xf0/0x180
>
> 2) The rescan restores a resource that has already been assigned:
>
>      WARNING: drivers/pci/setup-bus.c:136 at pci_dev_res_restore+0x32/0x9=
0, CPU#0: init/1
>      CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.4.0-rc1-dirty #6 PREEM=
PTLAZY
>      RIP: 0010:pci_dev_res_restore+0x32/0x90
>      Call Trace:
>       __assign_resources_sorted+0x2db/0x570
>       __pci_bus_assign_resources_one+0x57/0x190
>       __pci_bus_assign_resources_one+0x12d/0x190
>       __pci_bus_assign_resources+0xd/0x30
>       pci_assign_unassigned_bus_resources+0x6f/0x80
>       pci_rescan_bus+0x1a/0x30
>       dev_rescan_store+0x46/0x60
>
> 3) The rescan assigns the BAR while the resize is assigning it, failing
>    the resize:
>
>      pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x90fffffff 64bit pref]: r=
eleasing
>      pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x90fffffff 6=
4bit pref]: releasing
>      pci 10000:01:00.0: BAR 0 [mem size 0x40000000 64bit pref]: can't ass=
ign; no space
>      pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x93fffffff 6=
4bit pref]: assigned
>      pci 10000:01:00.0: BAR 0 [mem size 0x40000000 64bit pref]: failed to=
 assign
>      pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x93fffffff 64bit pref]: r=
eleasing
>      pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x93fffffff 64bit pref]: a=
ssigned
>      pci 10000:01:00.0: BAR 0 [mem size 0x40000000 64bit pref]: resource =
restored
>      pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x90fffffff 64bit pref]: o=
ld value restored
>      pci 10000:01:00.0: Failed to resize BAR 0: -28
>
> 4) While one pass is sorting a released bridge window for assignment,
>    the other pass assigns it, which clears IORESOURCE_STARTALIGN. The
>    window then has zero alignment:
>
>      pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x93fffffff 64bit pref]: r=
eleasing
>      pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x93fffffff 6=
4bit pref]: releasing
>      pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x90fffffff 6=
4bit pref]: assigned
>      pcieport 10000:00:00.0: bridge window [mem 0x900000000-0x90fffffff 6=
4bit pref]: alignment must not be zero
>      pci 10000:01:00.0: BAR 0 [mem 0x900000000-0x90fffffff 64bit pref]: a=
ssigned
>
> 5) BAR 0 loses its flags and the Root Port's prefetchable window gets
>    programmed over RAM, after which every BAR resize fails with -EINVAL:
>
>      pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: can't ass=
ign; no space
>      resource: remaining [mem 0x000000001ffdf000-0x000000001fffffff] avai=
lable
>      resource: avoiding allocation from e820 entry [mem 0x1ffdf000-0x1fff=
ffff]
>      pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: failed to=
 assign
>      pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: can't ass=
ign; no space
>      pci 10000:01:00.0: BAR 0 [mem size 0x10000000 64bit pref]: resetting=
 resource
>      pci 10000:01:00.0: BAR 0 [??? 0x00000000 flags 0x0]: failed to assig=
n
>      pci 10000:01:00.0: BAR 0 [??? 0x00000000 flags 0x0]: resetting resou=
rce
>      pcieport 10000:00:00.0: PCI bridge to [bus 01]
>      pcieport 10000:00:00.0:   bridge window [mem 0x20000000-0x200fffff]
>      pcieport 10000:00:00.0:   bridge window [mem 0x10000000-0x1fffffff 6=
4bit pref]
>      pci 10000:01:00.0: Failed to resize BAR 0: -22
>
> Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>
> Bjorn,
>
> It's up to you if you want to keep all those qemu reproduced cases in the
> changelog. You usually seem to prefer the log messages for easier googlin=
g
> in case somebody happens to hit the issue so I added them all.
>
> I couldn't get the rest to trigger on a real host but that could be due t=
o
> serial output that was too slow to keep up with the test loops which migh=
t
> have affected timing.
>
>  drivers/pci/hotplug/acpiphp_glue.c |  1 +
>  drivers/pci/pci.h                  |  1 +
>  drivers/pci/setup-bus.c            | 40 ++++++++++++++++++++++++++++++
>  drivers/pci/setup-cardbus.c        |  3 +++
>  4 files changed, 45 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 632344f34cae..d3987be044e3 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -502,6 +502,7 @@ static void enable_slot(struct acpiphp_slot *slot, bo=
ol bridge)
>
>                 acpiphp_rescan_slot(slot);
>                 max =3D acpiphp_max_busnr(bus);
> +               guard(mutex)(&pci_res_setup_lock);
>                 for (pass =3D 0; pass < 2; pass++) {
>                         for_each_pci_bridge(dev, bus) {
>                                 if (PCI_SLOT(dev->devfn) !=3D slot->devic=
e)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 77efa4c5c960..660a83b0045a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -124,6 +124,7 @@ unsigned char pcie_get_link_speed(unsigned int speed)=
;
>  extern bool pci_early_dump;
>
>  extern struct mutex pci_rescan_remove_lock;
> +extern struct mutex pci_res_setup_lock;
>
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 5b2d870ca13d..314c649c648f 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -26,6 +26,7 @@
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
>  #include <linux/limits.h>
> +#include <linux/lockdep.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -38,6 +39,17 @@
>  unsigned int pci_flags;
>  EXPORT_SYMBOL_GPL(pci_flags);
>
> +/*
> + * Serializes bridge window sizing, resource fitting, and assignment.
> + * pci_rescan_remove_lock cannot be used for this because BAR resize and
> + * some drivers run these operations under device_lock() during probe.
> + *
> + * Context:
> + *  - Nests inside pci_rescan_remove_lock and device_lock().
> + *  - Nests outside pci_bus_sem.
> + */
> +DEFINE_MUTEX(pci_res_setup_lock);
> +
>  struct pci_dev_resource {
>         struct list_head list;
>         struct resource *res;
> @@ -133,6 +145,8 @@ static void pci_dev_res_restore(struct pci_dev_resour=
ce *dev_res)
>         int idx =3D pci_resource_num(dev, res);
>         const char *res_name =3D pci_resource_name(dev, idx);
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         if (WARN_ON_ONCE(resource_assigned(res)))
>                 return;
>
> @@ -611,6 +625,8 @@ static void __assign_resources_sorted(struct list_hea=
d *head,
>         unsigned long fail_type;
>         resource_size_t align;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         if (!realloc_head)
>                 realloc_head =3D &dummy_head;
>
> @@ -893,6 +909,8 @@ static void __pci_setup_bridge(struct pci_bus *bus, u=
nsigned long type)
>  {
>         struct pci_dev *bridge =3D bus->self;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         pci_info(bridge, "PCI bridge to %pR\n", &bus->busn_res);
>
>         if (type & IORESOURCE_IO)
> @@ -973,6 +991,8 @@ static void pci_bridge_check_ranges(struct pci_bus *b=
us)
>         struct pci_dev *bridge =3D bus->self;
>         struct resource *b_res;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         b_res =3D &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
>         b_res->flags |=3D IORESOURCE_MEM;
>
> @@ -1077,6 +1097,8 @@ static void pbus_size_io(struct pci_bus *bus, resou=
rce_size_t add_size,
>         resource_size_t children_add_size =3D 0;
>         resource_size_t min_align, align;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         if (!b_res)
>                 return;
>
> @@ -1286,6 +1308,8 @@ static void pbus_size_mem(struct pci_bus *bus, stru=
ct resource *b_res,
>         resource_size_t children_add_size =3D 0;
>         resource_size_t add_align =3D 0;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         if (!b_res)
>                 return;
>
> @@ -1457,6 +1481,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, st=
ruct list_head *realloc_head)
>
>  void pci_bus_size_bridges(struct pci_bus *bus)
>  {
> +       guard(mutex)(&pci_res_setup_lock);
>         guard(rwsem_read)(&pci_bus_sem);
>         __pci_bus_size_bridges(bus, NULL);
>  }
> @@ -1486,6 +1511,8 @@ static void pdev_assign_fixed_resources(struct pci_=
dev *dev)
>  {
>         struct resource *r;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         pci_dev_for_each_resource(dev, r) {
>                 struct pci_bus *b;
>
> @@ -1550,6 +1577,7 @@ void __pci_bus_assign_resources(const struct pci_bu=
s *bus,
>
>  void pci_bus_assign_resources(const struct pci_bus *bus)
>  {
> +       guard(mutex)(&pci_res_setup_lock);
>         guard(rwsem_read)(&pci_bus_sem);
>         __pci_bus_assign_resources(bus, NULL, NULL);
>  }
> @@ -1663,6 +1691,8 @@ static void pci_bridge_release_resources(struct pci=
_bus *bus,
>         struct pci_dev *dev =3D bus->self;
>         int idx, ret;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         if (!resource_assigned(b_win))
>                 return;
>
> @@ -1860,6 +1890,8 @@ static void adjust_bridge_window(struct pci_dev *br=
idge, struct resource *res,
>         resource_size_t add_size, size =3D resource_size(res);
>         struct pci_dev_resource *dev_res;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         if (resource_assigned(res))
>                 return;
>
> @@ -2192,6 +2224,7 @@ void pci_assign_unassigned_root_bus_resources(struc=
t pci_bus *bus)
>         int pci_try_num =3D 1;
>         enum enable_type enable_local;
>
> +       guard(mutex)(&pci_res_setup_lock);
>         guard(rwsem_read)(&pci_bus_sem);
>
>         /* Don't realloc if asked to do so */
> @@ -2270,6 +2303,7 @@ static void pci_bridge_size_and_assign_resources(st=
ruct pci_dev *bridge)
>         int tried_times =3D 0;
>         LIST_HEAD(fail_head);
>
> +       guard(mutex)(&pci_res_setup_lock);
>         guard(rwsem_read)(&pci_bus_sem);
>
>         while (1) {
> @@ -2328,6 +2362,8 @@ static int pbus_reassign_bridge_resources(struct pc=
i_bus *bus, struct resource *
>         unsigned int i;
>         int ret =3D 0;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         while (!pci_is_root_bus(bus)) {
>                 bridge =3D bus->self;
>                 res =3D pbus_select_window(bus, res);
> @@ -2398,6 +2434,8 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>         unsigned int i;
>         int old, ret;
>
> +       guard(mutex)(&pci_res_setup_lock);
> +
>         b_win =3D pbus_select_window(bus, res);
>         if (!b_win)
>                 return -EINVAL;
> @@ -2495,6 +2533,7 @@ void pci_assign_unassigned_bus_resources(struct pci=
_bus *bus)
>         /* List of resources that want additional resources */
>         LIST_HEAD(add_list);
>
> +       guard(mutex)(&pci_res_setup_lock);
>         guard(rwsem_read)(&pci_bus_sem);
>         for_each_pci_bridge(dev, bus)
>                 if (pci_has_subordinate(dev))
> @@ -2505,6 +2544,7 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resourc=
es);
>
>  void pci_bus_size_and_assign_resources(struct pci_bus *bus)
>  {
> +       guard(mutex)(&pci_res_setup_lock);
>         guard(rwsem_read)(&pci_bus_sem);
>         __pci_bus_size_bridges(bus, NULL);
>         __pci_bus_assign_resources(bus, NULL, NULL);
> diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
> index dcb8e2b3f73b..6a473a1694b9 100644
> --- a/drivers/pci/setup-cardbus.c
> +++ b/drivers/pci/setup-cardbus.c
> @@ -6,6 +6,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
> +#include <linux/lockdep.h>
>  #include <linux/pci.h>
>  #include <linux/sizes.h>
>  #include <linux/sprintf.h>
> @@ -39,6 +40,8 @@ int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
>         resource_size_t b_res_3_size =3D pci_cardbus_mem_size * 2;
>         u16 ctrl;
>
> +       lockdep_assert_held(&pci_res_setup_lock);
> +
>         b_res =3D &bridge->resource[PCI_CB_BRIDGE_IO_0_WINDOW];
>         if (resource_assigned(b_res))
>                 goto handle_b_res_1;
> --
> 2.47.3
>
