Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0D466B14;
	Wed, 26 Aug 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766319; cv=none; b=E8A1BnsupADVyNAqZXYjCrXG9Dqr51LlYKqGLPANpdwOtzm66ylU10vIhXWIQsnm15M/1DJ8v9C/1HtcnoFapH0VbLohTuI7/YjAStwUwtV8FlY+pwwT9Iku4hLnKg+c6hXw9VWQfpvhGBEx9oXJ3xrPSWmXgkcF6sqOcqd+8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766319; c=relaxed/simple;
	bh=UQXlOt/RzSBB24GfSpUOcJFKn+QwHg24nkb5CbUa5jc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BUm5Bh+Tb5fU6GTnJq3A1xh+YIHao84LXfT3duLJB9nYdGiX7PjmsoD4gClz25AJyGzpZOdPTcCIZnxuD1KgK5fblQ4cKkV8N84PJgOaJAcOf8w6EVsw+fmi1IyYyNtfM2RS4rE0HIevCUXrsyQKnVdl/MBmW/wPTGUZqEt+aNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTiiSeio; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTiiSeio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787766306; x=1819302306;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=UQXlOt/RzSBB24GfSpUOcJFKn+QwHg24nkb5CbUa5jc=;
  b=CTiiSeioQVw/grMbPCWTj+WFvCjS+2Y/oQAI0JqHouqYt+jiqCDp4Slc
   pFJLFcRyIs8tma2JYwYlc8rjYiahEYLvt08FTP8ZY0dc691gM8iCCHatu
   CnIwr1IVZUi8+8XT+25C+rP4Dz88lxHKQeJtbiHp+QDTiB7krPcQ5WtmI
   RO39JaMqYKJoNE4Tsk9vMckjP7iaLTFOS67QL2byLNPdm/X+DOdzollTe
   eyc4gHzvLksbRn2CPW9udx2EB6vWCmlMC9vyKyVrLKVIPG/Y2JnkXR9e2
   eo75jMMhUDF7k9Lgju66MdXjnzS3JQhb1co2qWqvZ1Wyn5BUoAW8T5G5k
   g==;
X-CSE-ConnectionGUID: sVuo/WStQzqeVTSp3KVSFQ==
X-CSE-MsgGUID: tteQjt8TR+ynjhXa7R474Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="99775934"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="99775934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 10:45:01 -0700
X-CSE-ConnectionGUID: elJKFjknRH287rmPcMWBtw==
X-CSE-MsgGUID: cXc+hkvARPS9XTOnoHLE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="265048890"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 10:44:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Aug 2026 20:44:54 +0300 (EEST)
To: hangej <hangej@amazon.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, dwmw2@infradead.org, 
    kexec@lists.infradead.org, nh-open-source@amazon.com
Subject: Re: [PATCH v4] pci_crash: capture PCI config space at panic time
In-Reply-To: <20260723185216.1089927-1-hangej@amazon.com>
Message-ID: <5188f7e8-4d19-685b-49e3-f2249685d9a3@linux.intel.com>
References: <20260723185216.1089927-1-hangej@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1348826095-1787755571=:1168"
Content-ID: <2c601786-6286-6bb3-0e63-9c5b7c04b6c5@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1348826095-1787755571=:1168
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e7a9ea7e-2ec3-21f6-5a11-b587348c9661@linux.intel.com>

On Thu, 23 Jul 2026, hangej wrote:

> From: Johannes Hange <hangej@amazon.com>
>=20
> Add CONFIG_PCI_CRASH, a crash-time PCI config-space capture facility.  A
> pre-allocated, RCU-published snapshot of all PCI devices is maintained vi=
a
> a bus notifier; at panic time pci_crash_save() reads config space into th=
e
> buffer using a trylock-based accessor that skips devices on lock
> contention.  The buffer and a physical-page directory (pagemap) are
> exported through VMCOREINFO so crash analysis tools can extract PCI
> register state without relying on /proc or sysfs in the crashed kernel.
>=20
> Key design points:
>=20
>   - Snapshot rebuild is debounced (200 ms) to coalesce VF enumeration
>     storms; rebuild runs in process context on system_wq.
>=20
>   - Retired snapshots are freed via queue_rcu_work() (process context)
>     because pci_dev_put() may trigger device_release() ->
>     devres_release_all() which can sleep -- incompatible with the softirq
>     context of plain call_rcu() callbacks.
>=20
>   - pci_crash_endpoint_reachable() gates every config read with
>     software-state checks (pci_dev_is_disconnected, pci_channel_offline,
>     pci_dev_is_removed, D3cold) plus a live upstream-bridge LNKSTA read
>     to confirm link presence.  The pci_dev_is_removed() check catches
>     cleanly-removed devices whose host bridge module may have been
>     unloaded (bus->ops freed) but whose pci_dev struct persists due to
>     snapshot references.
>=20
>   - capture=3D module parameter selects 'always' (every panic) or 'aer'
>     (only when an uncorrectable AER error is detected on a root port).
>=20
>   - devices=3D parameter filters the capture set by class code or the
>     keyword 'bridges'.
>=20
>   - Buffer is kvmalloc'd with __GFP_ZERO; capped at 24 MiB, 4096 bytes
>     per device.  A pagemap records physical addresses of each buffer page
>     for the crash parser.
>=20
> Introduce pci_dev_is_removed() as a public read-only helper in
> include/linux/pci.h, mirroring the existing pci_dev_is_disconnected()
> pattern.  The PCI_DEV_REMOVED bit (set by pci_destroy_dev during clean
> removal) was previously only accessible via drivers/pci/pci.h.
>=20
> Signed-off-by: Johannes Hange <hangej@amazon.com>
> ---
>  Documentation/PCI/index.rst                   |    1 +
>  Documentation/PCI/pci-crash-capture.rst       |  236 ++++
>  .../admin-guide/kernel-parameters.txt         |   16 +
>  MAINTAINERS                                   |    8 +
>  drivers/pci/access.c                          |   60 +
>  include/linux/pci.h                           |    8 +
>  include/linux/pci_crash.h                     |  122 ++
>  kernel/Kconfig.kexec                          |   16 +
>  kernel/Makefile                               |    1 +
>  kernel/pci_crash.c                            | 1013 +++++++++++++++++
>  kernel/vmcore_info.c                          |   13 +
>  11 files changed, 1494 insertions(+)
>  create mode 100644 Documentation/PCI/pci-crash-capture.rst
>  create mode 100644 include/linux/pci_crash.h
>  create mode 100644 kernel/pci_crash.c
>=20
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 5d720d2a415e..7f499a43ddb4 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -19,4 +19,5 @@ PCI Bus Subsystem
>     endpoint/index
>     controller/index
>     boot-interrupts
> +   pci-crash-capture
>     tph
> diff --git a/Documentation/PCI/pci-crash-capture.rst b/Documentation/PCI/=
pci-crash-capture.rst
> new file mode 100644
> index 000000000000..3a57696afa6f
> --- /dev/null
> +++ b/Documentation/PCI/pci-crash-capture.rst
> @@ -0,0 +1,236 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +PCI Crash Capture Buffer
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The PCI crash capture module (``CONFIG_PCI_CRASH``) saves PCI configurat=
ion
> +space for all (or selected) devices at panic time.  The data is written =
into
> +a pre-allocated buffer whose physical pages are exported via VMCOREINFO,
> +allowing crash analysis tools to extract device state from the vmcore.
> +
> +This is useful because AER (Advanced Error Reporting) registers are vola=
tile
> +and cleared by device reset during kexec into the crash kernel.  Capturi=
ng
> +them before kexec preserves the error state that caused or contributed t=
o the
> +crash.
> +
> +Boot Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``pci_crash.capture=3D`` (default: ``always``)
> +  When to capture PCI config space.  Comma-separated tokens:
> +
> +  ``aer``
> +    Capture only if a root port reports an uncorrectable error in its
> +    AER ROOT_STATUS register.  Non-PCI panics skip capture entirely
> +    (a handful of MMIO reads to root ports, sub-microsecond).
> +
> +  ``always``
> +    Capture on every panic regardless of AER state.  Useful for
> +    cascading failures where a PCI link-down causes an MCE or NMI
> +    watchdog timeout before DPC/AER fires, so the crash reason is
> +    unrelated but the AER registers still hold the originating error.
> +
> +``pci_crash.devices=3D`` (default: ``all``)
> +  Which devices to include in the capture buffer.  Comma-separated token=
s:
> +
> +  ``all``
> +    Every PCI device in the system.
> +
> +  ``bridges``
> +    PCI-to-PCI bridges (class 0604) and CardBus bridges (class 0607).
> +
> +  ``root_ports``
> +    PCIe root ports only.
> +
> +  ``XXYY``
> +    Hex PCI class code (class byte XX, subclass byte YY).
> +    Up to 8 class codes may be specified.
> +
> +  Bridges are always implicitly included regardless of the filter value
> +  because they hold AER registers needed for root cause analysis.  The
> +  filter is applied at device enumeration and hotplug rebuild time, not =
at
> +  crash time (zero overhead on the panic path).
> +
> +Both parameters are writable at runtime via sysfs
> +(``/sys/module/pci_crash/parameters/``).
> +
> +Architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +::
> +
> +  late_initcall
> +      =E2=94=82
> +      =E2=94=9C=E2=94=80=E2=94=80 register PCI bus notifier (before the =
first rebuild)
> +      =E2=94=9C=E2=94=80=E2=94=80 enumerate PCI devices (filtered by dev=
ices=3D param)
> +      =E2=94=9C=E2=94=80=E2=94=80 allocate buffer via kvmalloc (may be v=
malloc for >4 MiB)
> +      =E2=94=9C=E2=94=80=E2=94=80 build pagemap: kmalloc'd array of per-=
page physical addresses
> +      =E2=94=94=E2=94=80=E2=94=80 publish snapshot via rcu_assign_pointe=
r()
> +
> +  hotplug (BUS_NOTIFY_ADD_DEVICE / BUS_NOTIFY_DEL_DEVICE)
> +      =E2=94=82
> +      =E2=94=94=E2=94=80=E2=94=80 schedule delayed rebuild (200 ms debou=
nce)
> +              =E2=94=94=E2=94=80=E2=94=80 re-enumerate, re-allocate buff=
er + pagemap,
> +                  publish new snapshot, retire old via queue_rcu_work()
> +
> +  panic (__crash_kexec =E2=86=92 crash_save_vmcoreinfo =E2=86=92 pci_cra=
sh_save)
> +      =E2=94=82
> +      =E2=94=9C=E2=94=80=E2=94=80 rcu_read_lock(); sample the published =
snapshot
> +      =E2=94=9C=E2=94=80=E2=94=80 quick-scan root port AER ROOT_STATUS (=
capture=3Daer)
> +      =E2=94=82     =E2=94=94=E2=94=80=E2=94=80 bail if no uncorrectable=
 errors
> +      =E2=94=9C=E2=94=80=E2=94=80 for each device: skip if unreachable, =
else read config space
> +      =E2=94=82     via pci_bus_read_config_dword_trylock()
> +      =E2=94=9C=E2=94=80=E2=94=80 flush dcache (buffer + pagemap) to RAM
> +      =E2=94=94=E2=94=80=E2=94=80 VMCOREINFO exports: PCI_CRASH_PAGEMAP,=
 PCI_CRASH_BUF_SZ,
> +          PCI_CRASH_VERSION
> +
> +Buffer Format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The buffer consists of a 32-byte header followed by variable-length
> +device records:
> +
> +.. code-block:: c
> +
> +    struct pci_crash_buffer_header {   /* 32 bytes */
> +        __le32 magic;           /* 0x50434943 "PCIC" */
> +        __le32 version;         /* 1 */
> +        __le32 device_count;
> +        __le32 config_size;     /* 0 =3D variable-length records */
> +        __le64 timestamp;       /* ktime_get_real_fast_ns() */
> +        __le32 flags;           /* reserved */
> +        __le32 reserved;
> +    };
> +
> +    struct pci_crash_device_record {   /* 8 + cfg_size bytes */
> +        __le16 domain;
> +        __u8   bus;
> +        __u8   devfn;
> +        __le32 config_size;     /* 256 or 4096 */
> +        __u8   config_data[];   /* 0xffffffff for unreachable dwords */
> +    };
> +
> +The pagemap (exported via ``PCI_CRASH_PAGEMAP``) allows the parser to
> +locate buffer pages without walking page tables:
> +
> +.. code-block:: c
> +
> +    struct pci_crash_pagemap {
> +        __le32 magic;           /* 0x5043504d "PCPM" */
> +        __le32 num_pages;
> +        __le64 buf_size;
> +        __le32 buf_offset;      /* offset of buffer start within first p=
age */
> +        __le64 addrs[];         /* physical address per page */
> +    };
> +
> +All multi-byte fields are little-endian.  The struct sizes and the
> +``addrs[]`` offset are asserted with ``BUILD_BUG_ON()`` so the on-wire
> +layout cannot drift away from the userspace parser silently.
> +
> +VMCOREINFO keys
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``pci_crash_save()`` exports the following keys into VMCOREINFO (consume=
d by
> +makedumpfile / the crash-utility and any bespoke vmcore parser).  They a=
re
> +emitted whenever a valid snapshot exists at panic time; the buffer may b=
e
> +unfilled when the AER quick-scan found no errors and skipped the capture
> +(``capture=3Daer``).  Parsers must check the buffer header magic (``PCIC=
``)
> +to confirm config space was actually captured:
> +
> +``PCI_CRASH_PAGEMAP=3D<hex>``
> +  Physical address of the ``struct pci_crash_pagemap``.  The pagemap is
> +  always kmalloc'd (direct-mapped), so this physical address is stable a=
nd
> +  the parser can read it directly from the vmcore.  From the pagemap the
> +  parser reconstructs the (possibly vmalloc'd, physically discontiguous)
> +  buffer page by page.
> +
> +``PCI_CRASH_VERSION=3D<dec>``
> +  On-wire format version (``PCI_CRASH_VERSION``).  Parsers must reject a
> +  version they do not understand rather than misinterpret the layout.
> +
> +``PCI_CRASH_BUF_SZ=3D<dec>``
> +  Total buffer size in bytes, matching ``pci_crash_pagemap::buf_size``.
> +
> +Safety Considerations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``pci_crash_save()`` runs from ``crash_save_vmcoreinfo()`` inside
> +``__crash_kexec()``, before ``machine_kexec()``.  It executes in crash
> +context, so every access on that path is constrained accordingly:
> +
> +- **Config reads use** ``pci_bus_read_config_dword_trylock()``, which ta=
kes
> +  ``pci_lock`` with a *trylock* and skips the device on contention.  Dep=
ending
> +  on ``crash_kexec_post_notifiers`` the other CPUs may still be running =
or may
> +  already be halted (possibly while holding ``pci_lock``), and the panic=
king
> +  CPU may itself have been interrupted mid config access while holding i=
t.
> +  ``pci_lock`` is a raw, non-reentrant spinlock, so a blocking acquire c=
ould
> +  deadlock the dump in either case; the trylock skips the device instead=
=2E  This
> +  avoids the lock deadlock only; it does not make the read itself fault-=
safe,
> +  which is why unreachable devices are skipped first (below).
> +
> +- **Unreachable devices are skipped before any access to them.**  A conf=
ig
> +  read to a device whose PCIe link is physically down can, on some
> +  architectures (notably arm64), raise a synchronous external abort.  Be=
fore
> +  reading an endpoint, the module establishes reachability *without touc=
hing
> +  the endpoint*:
> +
> +  - software state -- ``pci_dev_is_disconnected()``, ``pci_channel_offli=
ne()``,
> +    ``pci_dev_is_removed()`` and ``PCI_D3cold`` are flag reads (no MMIO)=
; they
> +    catch devices a subsystem has already marked gone or powered off.
> +    ``pci_dev_is_removed()`` additionally covers a cleanly-removed devic=
e whose
> +    ``pci_dev`` is kept alive by a snapshot reference while its host bri=
dge
> +    module (and thus ``bus->ops``) may already be freed; and
> +
> +  - the immediate upstream PCIe port's Link Status (Data Link Layer Link
> +    Active).  The upstream port is on-die and always responds, so readin=
g its
> +    Link Status cannot fault on the endpoint's dead link; if the link is=
 down,
> +    the endpoint is skipped and its record is filled with ``0xffffffff``=
=2E
> +
> +- ``ktime_get_real_fast_ns()`` is NMI-safe (lockless timekeeper snapshot=
).
> +
> +- **Live capture state is a single RCU-published snapshot.**  The rebuil=
d
> +  worker (process context) swaps it via ``rcu_assign_pointer()`` and fre=
es the
> +  old snapshot via ``queue_rcu_work()`` (the free runs in process contex=
t after
> +  a grace period, because dropping device references via ``pci_dev_put()=
`` can
> +  sleep); ``pci_crash_save()`` reads it under ``rcu_read_lock()``.  RCU =
keeps the snapshot alive for the *fill*, but the
> +  exported buffer/pagemap addresses are consumed after ``pci_crash_save(=
)``
> +  returns (the VMCOREINFO export, and ``machine_kexec()`` snapshotting R=
AM),
> +  i.e. after ``rcu_read_unlock()`` -- and on the default panic path peer=
 CPUs
> +  are still live and may retire snapshots.  ``pci_crash_save()`` therefo=
re
> +  *pins* the snapshot it captured (``pci_crash_captured_snap``); the RCU=
 free
> +  callback leaks a pinned snapshot instead of freeing it, which is harml=
ess
> +  because the system is rebooting into the crash kernel.
> +
> +- Buffer capped at 24 MiB to bound allocation on systems with thousands =
of
> +  VFs; per-device reads are clamped to 4096 bytes and the fill loop
> +  bounds-checks every record against the buffer end.
> +
> +- ``pci_crash_ready`` defers param parsing and rebuild until ``late_init=
call``
> +  completes; kernel command-line values are stored and take effect once =
the
> +  PCI subsystem is up.
> +
> +Architecture support and residual risk
> +---------------------------------------
> +
> +The upstream-port Link-Status pre-check eliminates the common and
> +deterministic hang: an endpoint whose link is already down at panic is n=
ever
> +read.  Two narrow residual cases remain on architectures where a config =
read
> +to a dead device raises a fatal abort (e.g. arm64 ``do_sea()``, which ha=
s no
> +kernel-mode recovery for an external abort):
> +
> +- a link that drops in the small window *between* the upstream-port chec=
k and
> +  the endpoint read (a true hardware race); and
> +
> +- a multi-level fabric collapse in which an upstream port is itself behi=
nd a
> +  dead link (only the immediate parent is checked).
> +
> +On x86 a read to an absent device returns all-ones harmlessly, so these =
cases
> +are arm64-specific.  Capturing such a device may therefore, in those nar=
row
> +races, abort the dump on arm64.  Making the read itself recoverable woul=
d
> +require new architecture support in the abort handler and is intentional=
ly not
> +part of this module; it can be added later as a separate, properly-typed
> +arch facility without changing the on-wire format.
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..7ef515c8b849 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5298,6 +5298,22 @@ Kernel parameters
>  =09=09nomsi=09Do not use MSI for native PCIe PME signaling (this makes
>  =09=09=09all PCIe root ports use INTx for all services).
> =20
> +=09pci_crash.capture=3D
> +=09=09=09[PCI] When to capture PCI config space at panic time.
> +=09=09=09always (default): capture on every panic.
> +=09=09=09aer: capture only if root port AER reports
> +=09=09=09=09uncorrectable errors.
> +=09=09=09Requires CONFIG_PCI_CRASH=3Dy.
> +
> +=09pci_crash.devices=3D
> +=09=09=09[PCI] Which devices to include in crash capture.
> +=09=09=09all (default): every PCI device.
> +=09=09=09bridges: PCI bridges only.
> +=09=09=09root_ports: PCIe root ports only.
> +=09=09=09XXYY: hex class code (up to 8).
> +=09=09=09Bridges always implicitly included.
> +=09=09=09Requires CONFIG_PCI_CRASH=3Dy.
> +
>  =09pcmv=3D=09=09[HW,PCMCIA] BadgePAD 4
> =20
>  =09pd_ignore_unused
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f37a81950e25..47a562820582 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20560,6 +20560,14 @@ S:=09Maintained
>  F:=09drivers/leds/leds-pca9532.c
>  F:=09include/linux/leds-pca9532.h
> =20
> +PCI CRASH BUFFER
> +M:=09Johannes Hange <hangej@amazon.com>
> +L:=09linux-pci@vger.kernel.org
> +S:=09Maintained
> +F:=09Documentation/PCI/pci-crash-capture.rst
> +F:=09include/linux/pci_crash.h
> +F:=09kernel/pci_crash.c
> +
>  PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
>  M:=09Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>  M:=09Pali Roh=C3=A1r <pali@kernel.org>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63b..c05d02efd602 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
> +#include <linux/pci_crash.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/ioport.h>
> @@ -27,9 +28,11 @@ DEFINE_RAW_SPINLOCK(pci_lock);
>  #ifdef CONFIG_PCI_LOCKLESS_CONFIG
>  # define pci_lock_config(f)=09do { (void)(f); } while (0)
>  # define pci_unlock_config(f)=09do { (void)(f); } while (0)
> +# define pci_trylock_config(f)=09({ (void)(f); true; })
>  #else
>  # define pci_lock_config(f)=09raw_spin_lock_irqsave(&pci_lock, f)
>  # define pci_unlock_config(f)=09raw_spin_unlock_irqrestore(&pci_lock, f)
> +# define pci_trylock_config(f)=09raw_spin_trylock_irqsave(&pci_lock, f)
>  #endif
> =20
>  #define PCI_OP_READ(size, type, len) \
> @@ -85,6 +88,63 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>  EXPORT_SYMBOL(pci_bus_write_config_word);
>  EXPORT_SYMBOL(pci_bus_write_config_dword);
> =20
> +#ifdef CONFIG_PCI_CRASH
> +/**
> + * pci_bus_read_config_dword_trylock - non-blocking config read for the =
crash path
> + * @bus: target PCI bus
> + * @devfn: target device/function
> + * @pos: dword-aligned config space offset
> + * @value: result; set to ~0 (PCI "no response") if the read is skipped
> + *
> + * Like pci_bus_read_config_dword() but acquires pci_lock with a trylock=
 instead
> + * of blocking.  The PCI crash capture (CONFIG_PCI_CRASH) reads config s=
pace from
> + * crash_save_vmcoreinfo() inside __crash_kexec(), which can run while a=
 halted
> + * peer CPU still holds pci_lock, or after this CPU was interrupted mid =
config
> + * access while holding it.  pci_lock is a raw (non-reentrant) spinlock,=
 so a
> + * blocking acquire in either case would spin forever and hang the dump.=
  On
> + * contention this skips the device (value ~0, PCIBIOS_SET_FAILED) inste=
ad.
> + *
> + * This only avoids the pci_lock deadlock.  On x86 with legacy conf1 or
> + * mmconfig_32 port-I/O, a second blocking lock (pci_config_lock in
> + * arch/x86/pci/common.c) is taken below bus->ops->read() and is NOT cov=
ered
> + * by this trylock -- those paths can still hang the dump.  arm64 ECAM a=
nd
> + * x86-64 MMCONFIG are fully covered (no second lock).  The trylock also=
 does
> + * not make the underlying MMIO access fault-tolerant: a read to a devic=
e whose
> + * link is down can still raise an external abort, so callers must confi=
rm the
> + * device is reachable first.
> + *
> + * Context: crash/panic path only.  Returns 0 on success or a PCIBIOS_* =
error
> + * (PCIBIOS_SET_FAILED on lock contention).
> + */
> +int pci_bus_read_config_dword_trylock(struct pci_bus *bus, unsigned int =
devfn,
> +=09=09=09=09      int pos, u32 *value)
> +{
> +=09unsigned long flags;
> +=09u32 data =3D 0;
> +=09int res;
> +
> +=09if (pos & 3) {
> +=09=09PCI_SET_ERROR_RESPONSE(value);
> +=09=09return PCIBIOS_BAD_REGISTER_NUMBER;
> +=09}
> +=09if (!bus || !bus->ops || !bus->ops->read) {
> +=09=09PCI_SET_ERROR_RESPONSE(value);
> +=09=09return PCIBIOS_DEVICE_NOT_FOUND;
> +=09}
> +=09if (!pci_trylock_config(flags)) {
> +=09=09PCI_SET_ERROR_RESPONSE(value);
> +=09=09return PCIBIOS_SET_FAILED;
> +=09}
> +=09res =3D bus->ops->read(bus, devfn, pos, 4, &data);
> +=09if (res)
> +=09=09PCI_SET_ERROR_RESPONSE(value);
> +=09else
> +=09=09*value =3D data;
> +=09pci_unlock_config(flags);
> +=09return res;
> +}
> +#endif /* CONFIG_PCI_CRASH */
> +
>  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>  =09=09=09    int where, int size, u32 *val)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..1f6e1cebaecd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2709,6 +2709,14 @@ static inline bool pci_dev_is_disconnected(const s=
truct pci_dev *dev)
>  =09return READ_ONCE(dev->error_state) =3D=3D pci_channel_io_perm_failure=
;
>  }
> =20
> +/* Bit index in pci_dev->priv_flags for device removal state. */
> +#define PCI_DEV_REMOVED=09=093
> +
> +static inline bool pci_dev_is_removed(const struct pci_dev *dev)
> +{
> +=09return test_bit(PCI_DEV_REMOVED, &dev->priv_flags);
> +}
> +
>  void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
> diff --git a/include/linux/pci_crash.h b/include/linux/pci_crash.h
> new file mode 100644
> index 000000000000..dc29fe120ba9
> --- /dev/null
> +++ b/include/linux/pci_crash.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * PCI Crash Buffer - Capture PCI config space at panic time
> + *
> + * This module captures PCI configuration space data (including AER
> + * extended capability registers) for all PCI devices at panic time.
> + * The data is stored in a buffer whose pages are captured in the
> + * vmcore for off-site analysis.
> + *
> + * Copyright (c) 2026 Amazon.com, Inc. or its affiliates.
> + */
> +#ifndef _LINUX_PCI_CRASH_H
> +#define _LINUX_PCI_CRASH_H
> +
> +#include <linux/types.h>
> +
> +#define PCI_CRASH_MAGIC         0x50434943  /* "PCIC" in ASCII */
> +#define PCI_CRASH_VERSION       1
> +
> +/**
> + * struct pci_crash_buffer_header - Header for PCI crash buffer
> + * @magic:        Magic number (PCI_CRASH_MAGIC)
> + * @version:      Format version (PCI_CRASH_VERSION)
> + * @device_count: Number of device records following this header
> + * @config_size:  0 -- indicates variable-length records. Each device
> + *                record stores its own config_size (pdev->cfg_size:
> + *                256 for legacy PCI, 4096 for PCIe). Parsers walk
> + *                records sequentially using per-record config_size.
> + * @timestamp:    Capture timestamp from ktime_get_real_fast_ns()
> + * @flags:        Reserved for future use (0 for now)
> + * @reserved:     Padding to align to 32 bytes
> + *
> + * Total size: 32 bytes
> + */
> +struct pci_crash_buffer_header {
> +=09__le32 magic;
> +=09__le32 version;
> +=09__le32 device_count;
> +=09__le32 config_size;
> +=09__le64 timestamp;
> +=09__le32 flags;
> +=09__le32 reserved;
> +} __packed;

I think you're missing header for __packed.

> +
> +/**
> + * struct pci_crash_device_record - Per-device record in crash buffer
> + * @domain:      PCI domain number
> + * @bus:         PCI bus number
> + * @devfn:       Device and function number (PCI_DEVFN format)
> + * @config_size: Config space size for this device (pdev->cfg_size:
> + *               256 for legacy PCI, 4096 for PCIe)
> + * @config_data: Raw PCI config space (config_size bytes)
> + *
> + * Records are variable-length: total size per record is
> + * PCI_CRASH_RECORD_META + config_size bytes.
> + */
> +struct pci_crash_device_record {
> +=09__le16 domain;
> +=09__u8   bus;
> +=09__u8   devfn;
> +=09__le32 config_size;
> +=09__u8   config_data[];
> +} __packed;
> +
> +#define PCI_CRASH_HEADER_SIZE  sizeof(struct pci_crash_buffer_header)
> +#define PCI_CRASH_RECORD_META  sizeof(struct pci_crash_device_record)
> +
> +/**
> + * struct pci_crash_pagemap - Physical page directory for crash buffer
> + *
> + * The PCI crash buffer may be allocated via vmalloc (for buffers
> + * exceeding ~4 MB where the buddy allocator cannot provide contiguous
> + * pages).  virt_to_phys() returns garbage for vmalloc addresses, so
> + * we maintain this small kmalloc'd directory that maps the buffer's
> + * virtual pages to their actual physical addresses.
> + *
> + * At panic time, crash_core.c exports the pagemap's physical address
> + * via VMCOREINFO.  The parser reads the pagemap, then reads each
> + * physical page from the vmcore to reconstruct the full buffer.
> + *
> + * The pagemap itself is always kmalloc'd (direct-mapped), so
> + * virt_to_phys() works correctly on it.
> + *
> + * @magic:     0x5043504d ("PCPM") -- validates this is a pagemap
> + * @num_pages: Number of entries in the addrs[] array
> + * @buf_size:  Exact buffer size in bytes (last page may be partial)
> + * @buf_offset: Offset of buffer start within the first page
> + * @addrs:     Physical address of each PAGE_SIZE page backing the buffe=
r
> + */
> +struct pci_crash_pagemap {
> +=09__le32 magic;
> +=09__le32 num_pages;
> +=09__le64 buf_size;
> +=09__le32 buf_offset;
> +=09__le64 addrs[];
> +} __packed;
> +
> +#define PCI_CRASH_PAGEMAP_MAGIC  0x5043504d  /* "PCPM" in ASCII */
> +
> +struct pci_bus;
> +
> +#ifdef CONFIG_PCI_CRASH
> +void pci_crash_save(void);
> +extern void *pci_crash_buffer;
> +extern size_t pci_crash_buffer_size;
> +extern phys_addr_t pci_crash_pagemap_phys;
> +
> +/*
> + * Non-blocking config read used only by the crash capture path; defined=
 in
> + * drivers/pci/access.c (where pci_lock lives).  Not exported and not pa=
rt of
> + * the public PCI API -- it is specific to this feature.
> + */
> +int pci_bus_read_config_dword_trylock(struct pci_bus *bus, unsigned int =
devfn,
> +=09=09=09=09      int pos, u32 *value);
> +#else
> +static inline void pci_crash_save(void) {}
> +#define pci_crash_buffer        ((void *)NULL)
> +#define pci_crash_buffer_size   ((size_t)0)
> +#define pci_crash_pagemap_phys  ((phys_addr_t)0)
> +#endif
> +
> +#endif /* _LINUX_PCI_CRASH_H */
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..056767c8ea8d 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -179,4 +179,20 @@ config CRASH_MAX_MEMORY_RANGES
>  =09  the computation behind the value provided through the
>  =09  /sys/kernel/crash_elfcorehdr_size attribute.
> =20
> +
> +config PCI_CRASH
> +=09bool "Capture PCI config space at panic time"
> +=09depends on VMCORE_INFO && PCI && (ARM64 || X86)
> +=09help
> +=09  Capture PCI configuration space (including AER extended capability
> +=09  registers) for all PCI devices at panic time.  The data is stored
> +=09  in a buffer whose pages are recorded in VMCOREINFO for off-site
> +=09  crash analysis.
> +
> +=09  This is useful for diagnosing PCI errors that caused or contributed
> +=09  to the crash, especially when AER registers are volatile and cleare=
d
> +=09  by device reset during kexec.
> +
> +=09  If unsure, say Y.
> +
>  endmenu
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 1e1a31673577..584ab235496e 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_KEXEC_CORE) +=3D kexec_core.o
>  obj-$(CONFIG_CRASH_DUMP) +=3D crash_core.o
>  obj-$(CONFIG_CRASH_DM_CRYPT) +=3D crash_dump_dm_crypt.o
>  obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) +=3D crash_core_test.o
> +obj-$(CONFIG_PCI_CRASH) +=3D pci_crash.o
>  obj-$(CONFIG_KEXEC) +=3D kexec.o
>  obj-$(CONFIG_KEXEC_FILE) +=3D kexec_file.o
>  obj-$(CONFIG_KEXEC_ELF) +=3D kexec_elf.o
> diff --git a/kernel/pci_crash.c b/kernel/pci_crash.c
> new file mode 100644
> index 000000000000..15d7fa0fc74f
> --- /dev/null
> +++ b/kernel/pci_crash.c
> @@ -0,0 +1,1013 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCI Crash Buffer - Capture PCI config space for crash analysis
> + *
> + * Copyright (c) 2026 Amazon.com, Inc. or its affiliates.
> + *
> + * Captures PCI configuration space at crash time so AER error
> + * registers reflect the crash-time state for off-site analysis.
> + *
> + * Design:
> + * - Init (late_initcall): enumerate devices, allocate buffer.
> + * - Hotplug: bus notifier queues deferred rebuild of device list
> + *   and buffer via workqueue -- no PCI reads.
> + * - Crash: crash_save_vmcoreinfo() calls pci_crash_save() which
> + *   reads config space into buffer, flushes dcache to RAM so
> + *   data survives kexec into crash kernel.
> + *
> + * Records are variable-length: each device's record is exactly
> + * 8 + pdev->cfg_size bytes (264 for legacy PCI, 4104 for PCIe).
> + * The parser walks records sequentially using per-record config_size.
> + *
> + * Buffer pages may be physically scattered (kvmalloc falls back to
> + * vmalloc for buffers exceeding ~4 MB).  A small kmalloc'd pagemap
> + * records each page's physical address so the crash parser can
> + * reconstruct the buffer without page-table walking.
> + *
> + * Config reads at crash time use pci_bus_read_config_dword_trylock(), w=
hich
> + * trylocks pci_lock and skips the device on contention.  pci_crash_save=
() runs
> + * from crash_save_vmcoreinfo() inside __crash_kexec(); depending on
> + * crash_kexec_post_notifiers, peer CPUs may already be halted (possibly=
 while
> + * holding pci_lock) and this CPU may itself hold pci_lock (a panic insi=
de a
> + * config access).  pci_lock is a raw, non-reentrant spinlock, so a bloc=
king
> + * acquire would deadlock the dump in either case; the trylock skips ins=
tead.
> + * This guards against the lock deadlock only -- a read to an unreachabl=
e device
> + * is handled separately by pci_crash_endpoint_reachable().
> + * for_each_pci_dev() needs pci_bus_sem -- only used at init/hotplug.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/crash_dump.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_crash.h>
> +#include <linux/slab.h>
> +#include <linux/timekeeping.h>
> +#include <linux/workqueue.h>
> +#include <linux/rcupdate.h>

Move this to its place in alphabetical order.

> +
> +#include <linux/cacheflush.h>
> +#include <linux/unaligned.h>

I don't know why these are not among the other headers but in a separate=20
group.

> +
> +/**
> + * pci_crash_flush_dcache() - Flush a memory region from CPU cache to RA=
M
> + * @addr: virtual address of region to flush
> + * @size: size in bytes
> + *
> + * Used at crash time to ensure the crash kernel sees our buffer/pagemap
> + * writes after kexec.
> + */
> +static inline void pci_crash_flush_dcache(void *addr, size_t size)
> +{
> +=09/* Only ARM64 and x86 implemented; Kconfig enforces depends on (ARM64=
 || X86). */
> +#ifdef CONFIG_ARM64
> +=09unsigned long start =3D (unsigned long)addr;
> +=09unsigned long end =3D start + size;
> +
> +=09dcache_clean_inval_poc(start, end);
> +#elif defined(CONFIG_X86)
> +=09clflush_cache_range(addr, size);
> +#else
> +#error "CONFIG_PCI_CRASH requires ARM64 or X86 dcache flush support (Kco=
nfig depends)"
> +#endif
> +}
> +
> +/*
> + * Live capture state is published as a single RCU-managed snapshot so t=
he
> + * lockless crash-time reader (pci_crash_save) always observes a consist=
ent
> + * {devs, num_devs, buffer, pagemap} set and can never race the rebuild
> + * worker freeing the old arrays.  The retired snapshot is reclaimed via
> + * queue_rcu_work() once no reader can hold it -- see pci_crash_rebuild_=
snapshot().
> + */
> +struct pci_crash_snapshot {
> +=09struct pci_dev=09=09**devs;
> +=09unsigned int=09=09num_devs;
> +=09void=09=09=09*buffer;
> +=09size_t=09=09=09buffer_size;
> +=09struct pci_crash_pagemap *pagemap;
> +=09size_t=09=09=09pagemap_size;
> +=09phys_addr_t=09=09pagemap_phys;
> +=09struct rcu_work=09=09rcu_work;
> +};
> +
> +static struct pci_crash_snapshot __rcu *pci_crash_snap;
> +
> +/*
> + * Scalars consumed by crash_core.c's crash_save_vmcoreinfo() right AFTE=
R it
> + * calls pci_crash_save().  pci_crash_save() publishes them from the sna=
pshot
> + * it captured; on a skipped or failed capture they are set to 0 so no s=
tale
> + * pagemap is exported into the vmcore.
> + */
> +void *pci_crash_buffer;
> +EXPORT_SYMBOL_GPL(pci_crash_buffer);

Add include.

> +
> +size_t pci_crash_buffer_size;
> +EXPORT_SYMBOL_GPL(pci_crash_buffer_size);
> +
> +phys_addr_t pci_crash_pagemap_phys;
> +EXPORT_SYMBOL_GPL(pci_crash_pagemap_phys);
> +
> +/*
> + * Set by pci_crash_save() to the snapshot it captured, so its buffer/pa=
gemap
> + * (whose addresses are exported into the vmcore via vmcore_info.c) cann=
ot be
> + * reclaimed out from under the crash kernel.  pci_crash_save() publishe=
s the
> + * buffer scalars and returns; vmcore_info.c then reads them and machine=
_kexec()
> + * snapshots RAM -- all AFTER rcu_read_unlock(), so RCU read-side protec=
tion has
> + * already ended by the time the buffer matters.  A rebuild racing on a =
live
> + * peer CPU (the default panic path runs __crash_kexec() before halting =
peers)
> + * could otherwise queue_rcu_work()-free this snapshot before kexec.  Th=
e free
> + * callback below honours this pin and leaks the snapshot instead -- har=
mless,
> + * the system is going down.  Written under rcu_read_lock() before the s=
calars
> + * are published, so the grace period ordering guarantees the callback s=
ees it.
> + */
> +static struct pci_crash_snapshot *pci_crash_captured_snap;
> +
> +/*
> + * Reclaim a retired snapshot after a grace period: drop dev refs + free=
=2E
> + * Runs via queue_rcu_work() in process context -- pci_dev_put() may tri=
gger
> + * device_release() -> devres_release_all() which can sleep.
> + */
> +static void pci_crash_snapshot_free_work(struct work_struct *work)
> +{
> +=09struct pci_crash_snapshot *s =3D
> +=09=09container_of(to_rcu_work(work), struct pci_crash_snapshot, rcu_wor=
k);

Include for container_of().

> +=09unsigned int i;
> +
> +=09/*
> +=09 * Pinned by an in-progress crash capture: its buffer address is live=
 in
> +=09 * the vmcore export.  Leak it rather than free memory kexec will rea=
d.
> +=09 */
> +=09if (READ_ONCE(pci_crash_captured_snap) =3D=3D s)

I don't remember what's the header for READ_ONCE() but you're likely=20
missing it as well.

> +=09=09return;
> +
> +=09for (i =3D 0; i < s->num_devs; i++)
> +=09=09if (s->devs && s->devs[i])
> +=09=09=09pci_dev_put(s->devs[i]);
> +=09kvfree(s->devs);
> +=09kvfree(s->buffer);
> +=09kfree(s->pagemap);
> +=09kfree(s);
> +}
> +
> +static DEFINE_MUTEX(pci_crash_lock);

Please document what a lock protects.

> +
> +/*
> + * Set in pci_crash_init() after delayed_work, PCI bus and notifier are
> + * ready.  Guards parse + rebuild in param setters: at boot (level -1)
> + * the setter just stores the string; pci_crash_init() parses and does
> + * the initial rebuild once PCI is up.
> + */
> +static bool pci_crash_ready;
> +
> +/*
> + * capture -- when to capture PCI config space.
> + * Comma-separated tokens:
> + *   aer    -- root port ROOT_STATUS has uncorrectable errors
> + *   always -- every panic regardless of PCI error state (default)
> + *
> + * Writable at runtime (0644) so operators and tests can toggle without
> + * reboot.  Writes re-parse capture_flags immediately.
> + */
> +#define PCI_CRASH_PARAM_CAPTURE_LEN=0932
> +static char capture[PCI_CRASH_PARAM_CAPTURE_LEN] =3D "always";
> +
> +#define PCI_CRASH_CAPTURE_AER=09=09BIT(0)
> +#define PCI_CRASH_CAPTURE_ALWAYS=09BIT(1)

Add include for BIT()

> +static unsigned long capture_flags =3D PCI_CRASH_CAPTURE_ALWAYS;
> +
> +static void pci_crash_parse_capture(void);
> +
> +static int capture_param_set(const char *val, const struct kernel_param =
*kp)
> +{
> +=09char *trimmed;
> +
> +=09if (strlen(val) >=3D sizeof(capture))

Include for strlen()

> +=09=09return -EINVAL;
> +
> +=09/* Serialize against concurrent sysfs writers mutating the string. */
> +=09mutex_lock(&pci_crash_lock);
> +=09strscpy(capture, val, sizeof(capture));

Doesn't this work with two parameters version of strscpy(), IIRC we had=20
the macro magic for that?

> +=09trimmed =3D strim(capture);
> +=09if (trimmed !=3D capture)
> +=09=09memmove(capture, trimmed, strlen(trimmed) + 1);
> +=09if (READ_ONCE(pci_crash_ready))
> +=09=09pci_crash_parse_capture();
> +=09mutex_unlock(&pci_crash_lock);
> +=09return 0;
> +}
> +
> +static int capture_param_get(char *buf, const struct kernel_param *kp)
> +{
> +=09return scnprintf(buf, PAGE_SIZE, "%s\n", capture);
> +}
> +
> +static const struct kernel_param_ops capture_param_ops =3D {
> +=09.set =3D capture_param_set,
> +=09.get =3D capture_param_get,
> +};
> +module_param_cb(capture, &capture_param_ops, NULL, 0644);
> +MODULE_PARM_DESC(capture, "When to capture: aer, always (default: always=
)");
> +
> +/*
> + * devices -- which devices to capture.
> + * Comma-separated tokens:
> + *   all        -- every PCI device (default)
> + *   bridges    -- PCI bridges (class 0604, 0607)
> + *   root_ports -- PCIe root ports only
> + *   XXYY       -- hex PCI class code (class + subclass)
> + *
> + * Bridges are always implicitly included regardless of filter value
> + * because they hold the AER registers needed for root cause analysis.
> + * Applies at rebuild time only -- zero cost at crash time.  Writable
> + * at runtime (0644); writes re-parse and trigger async rebuild.
> + */
> +#define PCI_CRASH_PARAM_DEVICES_LEN=09256
> +static char devices[PCI_CRASH_PARAM_DEVICES_LEN] =3D "all";
> +
> +static void pci_crash_parse_devices(void);
> +static struct delayed_work pci_crash_rebuild_dwork;
> +
> +/* Debounce period for bus notifications (ms).
> + * SR-IOV liveupdate can enumerate ~3000 VFs in ~1.5s -- this coalesces
> + * the storm into a single rebuild after the last event.
> + */
> +#define PCI_CRASH_REBUILD_DELAY_MS=09200
> +
> +static int devices_param_set(const char *val, const struct kernel_param =
*kp)
> +{
> +=09if (strlen(val) >=3D sizeof(devices))
> +=09=09return -EINVAL;
> +
> +=09mutex_lock(&pci_crash_lock);
> +=09strscpy(devices, val, sizeof(devices));

2 params version?

> +=09{
> +=09=09char *trimmed =3D strim(devices);
> +
> +=09=09if (trimmed !=3D devices)
> +=09=09=09memmove(devices, trimmed, strlen(trimmed) + 1);
> +=09}
> +=09if (READ_ONCE(pci_crash_ready)) {
> +=09=09pci_crash_parse_devices();
> +=09=09mod_delayed_work(system_wq, &pci_crash_rebuild_dwork,
> +=09=09=09=09 msecs_to_jiffies(PCI_CRASH_REBUILD_DELAY_MS));
> +=09}
> +=09mutex_unlock(&pci_crash_lock);
> +=09return 0;
> +}
> +
> +static int devices_param_get(char *buf, const struct kernel_param *kp)
> +{
> +=09return scnprintf(buf, PAGE_SIZE, "%s\n", devices);
> +}
> +
> +static const struct kernel_param_ops devices_param_ops =3D {
> +=09.set =3D devices_param_set,
> +=09.get =3D devices_param_get,
> +};
> +module_param_cb(devices, &devices_param_ops, NULL, 0644);
> +MODULE_PARM_DESC(devices,
> +=09"Which devices: all, bridges, root_ports, XXYY hex class (default: al=
l)");
> +
> +#define PCI_CRASH_DEVICES_ALL=09=09BIT(0)
> +#define PCI_CRASH_DEVICES_BRIDGES=09BIT(1)
> +#define PCI_CRASH_DEVICES_ROOT_PORTS=09BIT(2)
> +/* Max distinct class-code filters in a devices=3D list; 8 covers realis=
tic use. */
> +#define PCI_CRASH_MAX_DEVICE_CLASSES=098
> +static unsigned long devices_flags =3D PCI_CRASH_DEVICES_ALL;
> +static u16 device_classes[PCI_CRASH_MAX_DEVICE_CLASSES];
> +static unsigned int device_class_count;
> +
> +static void pci_crash_parse_capture(void)
> +{
> +=09char *buf, *token, *rest;
> +=09unsigned long flags =3D 0;
> +
> +=09if (!*capture) {
> +=09=09WRITE_ONCE(capture_flags, PCI_CRASH_CAPTURE_ALWAYS);
> +=09=09return;
> +=09}
> +
> +=09buf =3D kstrdup(capture, GFP_KERNEL);
> +=09if (!buf) {
> +=09=09WRITE_ONCE(capture_flags, PCI_CRASH_CAPTURE_ALWAYS);
> +=09=09return;
> +=09}
> +
> +=09rest =3D buf;
> +=09while ((token =3D strsep(&rest, ",")) !=3D NULL) {
> +=09=09if (strcmp(token, "aer") =3D=3D 0)
> +=09=09=09flags |=3D PCI_CRASH_CAPTURE_AER;
> +=09=09else if (strcmp(token, "always") =3D=3D 0)
> +=09=09=09flags |=3D PCI_CRASH_CAPTURE_ALWAYS;
> +=09=09else
> +=09=09=09pr_warn("unknown capture token: %s\n",
> +=09=09=09=09token);

Fits to one line.

Add include.

> +=09}
> +=09kfree(buf);
> +
> +=09if (!flags) {
> +=09=09pr_warn("no valid capture tokens, defaulting to always\n");
> +=09=09flags =3D PCI_CRASH_CAPTURE_ALWAYS;
> +=09}
> +=09WRITE_ONCE(capture_flags, flags);
> +}
> +
> +static void pci_crash_parse_devices(void)
> +{
> +=09char *buf, *token, *rest;
> +=09unsigned long val;
> +
> +=09devices_flags =3D 0;
> +=09device_class_count =3D 0;
> +
> +=09if (!*devices) {
> +=09=09devices_flags =3D PCI_CRASH_DEVICES_ALL;
> +=09=09return;
> +=09}
> +
> +=09buf =3D kstrdup(devices, GFP_KERNEL);
> +=09if (!buf) {
> +=09=09devices_flags =3D PCI_CRASH_DEVICES_ALL;
> +=09=09return;
> +=09}
> +
> +=09rest =3D buf;
> +=09while ((token =3D strsep(&rest, ",")) !=3D NULL) {
> +=09=09if (strcmp(token, "all") =3D=3D 0) {
> +=09=09=09devices_flags |=3D PCI_CRASH_DEVICES_ALL;
> +=09=09} else if (strcmp(token, "bridges") =3D=3D 0) {
> +=09=09=09devices_flags |=3D PCI_CRASH_DEVICES_BRIDGES;
> +=09=09} else if (strcmp(token, "root_ports") =3D=3D 0) {
> +=09=09=09devices_flags |=3D PCI_CRASH_DEVICES_ROOT_PORTS;
> +=09=09} else if (kstrtoul(token, 16, &val) =3D=3D 0 && val <=3D 0xFFFF) =
{
> +=09=09=09if (device_class_count < PCI_CRASH_MAX_DEVICE_CLASSES)
> +=09=09=09=09device_classes[device_class_count++] =3D (u16)val;
> +=09=09=09else
> +=09=09=09=09pr_warn("too many device classes (max %d)\n",
> +=09=09=09=09=09PCI_CRASH_MAX_DEVICE_CLASSES);
> +=09=09} else {
> +=09=09=09pr_warn("unknown devices token: %s\n",
> +=09=09=09=09token);

One line.

> +=09=09}
> +=09}
> +=09kfree(buf);
> +
> +=09if (!devices_flags && device_class_count =3D=3D 0) {
> +=09=09pr_warn("no valid devices tokens, defaulting to all\n");
> +=09=09devices_flags =3D PCI_CRASH_DEVICES_ALL;
> +=09}
> +}
> +
> +static bool pci_crash_device_matches(struct pci_dev *pdev)
> +{
> +=09unsigned int i;
> +=09u16 dev_class =3D pdev->class >> 8;
> +
> +=09if (devices_flags & PCI_CRASH_DEVICES_ALL)
> +=09=09return true;
> +
> +=09/* Bridges always included -- they hold AER registers */
> +=09if (dev_class =3D=3D PCI_CLASS_BRIDGE_PCI ||
> +=09    dev_class =3D=3D PCI_CLASS_BRIDGE_CARDBUS)

Is cardbus that relevant still? :-/

> +=09=09return true;
> +
> +=09if ((devices_flags & PCI_CRASH_DEVICES_ROOT_PORTS) &&
> +=09    pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +=09=09return true;
> +
> +=09for (i =3D 0; i < device_class_count; i++) {
> +=09=09if (dev_class =3D=3D device_classes[i])
> +=09=09=09return true;
> +=09}
> +
> +=09return false;
> +}
> +
> +/* Sanity limit -- prevents multi-GB allocations on systems with many VF=
s */
> +#define PCI_CRASH_MAX_BUFFER_SIZE=09(24 * 1024 * 1024)

Please use SZ_xx + remember to add the header.

> +
> +/*
> + * PCIe extended config space size. Per-device reads are clamped to this=
 in
> + * case a device's cfg_size is corrupt at crash time.
> + */
> +#define PCI_CRASH_MAX_CFG_SIZE=09=094096

PCI_CFG_SPACE_EXP_SIZE

> +
> +/**
> + * pci_crash_build_pagemap() - Build physical page directory for buffer
> + * @buf: buffer allocated via kvmalloc (may be vmalloc'd)
> + * @buf_size: buffer size in bytes
> + *
> + * Allocates a kmalloc'd directory containing the physical address of
> + * each page backing @buf.  The pagemap is always direct-mapped, so
> + * virt_to_phys() works on it at crash time.
> + *
> + * Return: the new pagemap, or NULL on allocation failure.
> + */
> +static struct pci_crash_pagemap *pci_crash_build_pagemap(void *buf,
> +=09=09=09=09=09=09=09 size_t buf_size)
> +{
> +=09unsigned int num_pages =3D DIV_ROUND_UP(offset_in_page(buf) + buf_siz=
e, PAGE_SIZE);

Add include.

> +=09struct pci_crash_pagemap *pm;
> +=09unsigned int i;
> +
> +=09pm =3D kmalloc(struct_size(pm, addrs, num_pages), GFP_KERNEL);
> +=09if (!pm)
> +=09=09return NULL;
> +
> +=09pm->magic =3D cpu_to_le32(PCI_CRASH_PAGEMAP_MAGIC);
> +=09pm->num_pages =3D cpu_to_le32(num_pages);
> +=09pm->buf_size =3D cpu_to_le64(buf_size);
> +=09pm->buf_offset =3D cpu_to_le32(offset_in_page(buf));
> +
> +=09for (i =3D 0; i < num_pages; i++) {
> +=09=09struct page *page;
> +=09=09phys_addr_t pa;
> +
> +=09=09if (is_vmalloc_addr(buf + i * PAGE_SIZE))
> +=09=09=09page =3D vmalloc_to_page(buf + i * PAGE_SIZE);
> +=09=09else
> +=09=09=09page =3D virt_to_page(buf + i * PAGE_SIZE);
> +
> +=09=09if (!page) {
> +=09=09=09kfree(pm);
> +=09=09=09return NULL;
> +=09=09}
> +=09=09pa =3D page_to_phys(page);
> +=09=09pm->addrs[i] =3D cpu_to_le64(pa);
> +=09}
> +
> +=09return pm;
> +}
> +
> +/**
> + * pci_crash_endpoint_reachable() - Decide if @pdev is safe to read at c=
rash time
> + * @pdev: PCI device about to be read
> + *
> + * A config read to a device whose PCIe link is physically down can, on =
some
> + * architectures (notably arm64), raise a synchronous external abort.  I=
n the
> + * crash path that abort is unrecoverable -- the arm64 SEA handler (do_s=
ea())
> + * has no kernel-mode fixup and calls arm64_notify_die(), double-faultin=
g the
> + * panic and hanging the very dump we are trying to produce.  On x86 suc=
h a
> + * read returns all-ones harmlessly.  So before touching an endpoint we =
must
> + * establish reachability WITHOUT reading the endpoint itself.
> + *
> + * Two cheap, panic-safe signals are used, in order:
> + *
> + *  1. Software state -- pci_dev_is_disconnected(), pci_channel_offline(=
),
> + *     pci_dev_is_removed() and PCI_D3cold are pure flag reads (no MMIO)=
=2E  They
> + *     catch devices a subsystem has already marked gone (hotplug remove=
, failed
> + *     AER/DPC recovery, powered-off).  pci_dev_is_removed() also covers=
 a
> + *     cleanly-removed device whose pci_dev is pinned by a snapshot refe=
rence
> + *     while its host bridge module (hence bus->ops) may already be free=
d.
> + *     They are necessary but not sufficient: in the
> + *     cascading-failure window this feature targets, a link can be down=
 before
> + *     any subsystem has updated error_state, so these flags can still r=
ead
> + *     "live".
> + *
> + *  2. Parent-bridge link state -- read PCI_EXP_LNKSTA on the immediate =
upstream
> + *     PCIe port and test Data Link Layer Link Active (DLLLA).  The upst=
ream
> + *     port is on-die and always responds, so reading *its* config space=
 cannot
> + *     raise an abort caused by the endpoint's dead link.  If DLLLA is c=
lear,
> + *     the endpoint is unreachable and is skipped without ever being tou=
ched.
> + *     The bridge read uses the crash-safe trylock accessor so it cannot=
 hang
> + *     on pci_lock either.
> + *
> + * Return: false if @pdev should be skipped (record filled with 0xFFFFFF=
FF).
> + *
> + * Residual: a single immediate-parent check; a link that drops between =
this
> + * check and the read (TOCTOU), or a multi-level fabric collapse where t=
he
> + * upstream port itself sits behind a dead link, is not covered here.  S=
ee
> + * Documentation/PCI/pci-crash-capture.rst for the documented arm64 cave=
at.
> + */
> +static bool pci_crash_endpoint_reachable(struct pci_dev *pdev)
> +{
> +=09struct pci_dev *bridge;
> +=09u32 lnksta =3D 0;
> +=09u16 sta;
> +=09int pos;
> +
> +=09/* Software-state flags: pure reads, no MMIO -- always panic-safe. */
> +=09if (pci_dev_is_disconnected(pdev) || pci_channel_offline(pdev) ||
> +=09    pci_dev_is_removed(pdev) ||
> +=09    pdev->current_state =3D=3D PCI_D3cold)
> +=09=09return false;
> +
> +=09/*
> +=09 * Live link check via the immediate upstream PCIe port.  Only meanin=
gful
> +=09 * for a device sitting below a PCIe downstream/root port; for non-PC=
Ie
> +=09 * or root-complex-integrated devices there is no such link to test, =
so
> +=09 * treat them as reachable and let the crash-safe accessor handle the=
 read.
> +=09 */
> +=09bridge =3D pci_upstream_bridge(pdev);
> +=09if (bridge && pci_is_pcie(bridge) &&
> +=09    (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +=09     pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) &&
> +=09    bridge->pcie_cap && bridge->bus) {
> +=09=09pos =3D bridge->pcie_cap + PCI_EXP_LNKSTA;
> +=09=09/*
> +=09=09 * Read the aligned dword containing LNKSTA from the on-die
> +=09=09 * upstream port (always present), then extract the 16-bit field.
> +=09=09 *
> +=09=09 * Fail closed: if the bridge read cannot complete -- lock
> +=09=09 * contention (PCIBIOS_SET_FAILED) or any PCIBIOS error -- we
> +=09=09 * cannot prove the link is up, so treat the endpoint as
> +=09=09 * unreachable rather than issuing an MMIO read that may raise a
> +=09=09 * fatal external abort.  Contention is exactly a crash-path
> +=09=09 * condition we assume is likely, so "unknown" must mean "skip".
> +=09=09 */
> +=09=09if (pci_bus_read_config_dword_trylock(bridge->bus, bridge->devfn,
> +=09=09=09=09=09=09      pos & ~0x3, &lnksta) !=3D 0)

!=3D PCIBIOS_SUCCESSFUL, please add ret variable to keep line length sane.

> +=09=09=09return false;
> +
> +=09=09sta =3D (pos & 0x2) ? (lnksta >> 16) : (lnksta & 0xffff);

Why is this necessary???

> +=09=09if (!(sta & PCI_EXP_LNKSTA_DLLLA))
> +=09=09=09return false;=09/* link down -> endpoint gone */
> +=09}
> +
> +=09return true;
> +}
> +
> +/**
> + * pci_crash_read_config_space() - Read config space for one device
> + * @pdev: PCI device to read
> + * @ptr: destination pointer within the crash buffer
> + * @cfg_size: number of config bytes to read (already clamped by the cal=
ler)
> + *
> + * Reads @cfg_size bytes one dword at a time.  Devices deemed unreachabl=
e by
> + * pci_crash_endpoint_reachable() (disconnected, in error recovery, powe=
red
> + * off, or behind a down PCIe link) are skipped without being touched: o=
n x86
> + * such a read returns all-ones harmlessly, but on other architectures (=
e.g.
> + * arm64) it can raise a fatal external abort that double-faults the pan=
ic
> + * path.  Skipped or failed reads store 0xFFFFFFFF -- the standard PCI
> + * convention for absent/unreachable registers.
> + */
> +static void pci_crash_read_config_space(struct pci_dev *pdev, u8 *ptr,
> +=09=09=09=09=09unsigned int cfg_size)
> +{
> +=09struct pci_crash_device_record *record =3D
> +=09=09(struct pci_crash_device_record *)ptr;
> +=09u8 *cfg_data =3D ptr + PCI_CRASH_RECORD_META;
> +=09unsigned int offset;
> +=09u32 val;
> +
> +=09/* Defensive: never trust cfg_size, never deref a torn-down bus. */
> +=09if (cfg_size > PCI_CRASH_MAX_CFG_SIZE)
> +=09=09cfg_size =3D PCI_CRASH_MAX_CFG_SIZE;
> +
> +=09if (!pdev->bus) {
> +=09=09record->domain =3D 0;
> +=09=09record->bus =3D 0;
> +=09=09record->devfn =3D pdev->devfn;
> +=09=09record->config_size =3D cpu_to_le32(cfg_size);
> +=09=09memset(cfg_data, 0xff, cfg_size);
> +=09=09return;
> +=09}
> +
> +=09record->domain =3D cpu_to_le16(pci_domain_nr(pdev->bus));
> +=09record->bus =3D pdev->bus->number;
> +=09record->devfn =3D pdev->devfn;
> +=09record->config_size =3D cpu_to_le32(cfg_size);
> +
> +=09if (!pci_crash_endpoint_reachable(pdev)) {
> +=09=09memset(cfg_data, 0xff, cfg_size);
> +=09=09return;
> +=09}
> +
> +=09for (offset =3D 0; offset < cfg_size; offset +=3D 4) {
> +=09=09if (pci_bus_read_config_dword_trylock(pdev->bus, pdev->devfn,
> +=09=09=09=09=09=09      offset, &val)) {
> +=09=09=09put_unaligned_le32(0xFFFFFFFF, &cfg_data[offset]);
> +=09=09=09continue;
> +=09=09}
> +=09=09put_unaligned_le32(val, &cfg_data[offset]);

Why would the destination be unaligned?

> +=09}
> +}
> +
> +/**
> + * pci_crash_fill_buffer() - Populate buffer with config space
> + * @s: snapshot whose buffer is filled from its captured device list
> + *
> + * Records are variable-length: each is PCI_CRASH_RECORD_META +
> + * pdev->cfg_size bytes. The header's config_size is 0 to indicate
> + * variable-length; parsers walk records using per-record config_size.
> + *
> + * Uses ktime_get_real_fast_ns() for the timestamp -- safe in NMI/panic
> + * context (lockless, reads the NMI-safe timekeeper snapshot).
> + *
> + * Caller holds rcu_read_lock() so @s stays valid for the whole fill.
> + */
> +static void pci_crash_fill_buffer(struct pci_crash_snapshot *s)
> +{
> +=09struct pci_crash_buffer_header *header =3D s->buffer;
> +=09struct pci_dev **devs =3D s->devs;
> +=09u8 *ptr, *end;
> +=09unsigned int i;
> +
> +=09header->magic =3D cpu_to_le32(PCI_CRASH_MAGIC);
> +=09header->version =3D cpu_to_le32(PCI_CRASH_VERSION);
> +=09header->device_count =3D cpu_to_le32(s->num_devs);
> +=09header->config_size =3D 0;
> +=09header->timestamp =3D cpu_to_le64(ktime_get_real_fast_ns());
> +=09header->flags =3D 0;
> +=09header->reserved =3D 0;
> +
> +=09ptr =3D (u8 *)s->buffer + PCI_CRASH_HEADER_SIZE;
> +=09end =3D (u8 *)s->buffer + s->buffer_size;
> +=09for (i =3D 0; i < s->num_devs; i++) {
> +=09=09struct pci_dev *pdev =3D devs[i];
> +=09=09unsigned int cfg_size;
> +=09=09size_t rec_size;
> +
> +=09=09if (unlikely(!pdev))
> +=09=09=09break;
> +
> +=09=09cfg_size =3D pdev->cfg_size;
> +=09=09if (cfg_size > PCI_CRASH_MAX_CFG_SIZE)
> +=09=09=09cfg_size =3D PCI_CRASH_MAX_CFG_SIZE;
> +=09=09rec_size =3D PCI_CRASH_RECORD_META + cfg_size;
> +
> +=09=09/*
> +=09=09 * Never write past the buffer if the device set or a device's
> +=09=09 * cfg_size grew since the buffer was sized at rebuild time.
> +=09=09 */
> +=09=09if (unlikely(ptr + rec_size > end))
> +=09=09=09break;
> +
> +=09=09pci_crash_read_config_space(pdev, ptr, cfg_size);
> +=09=09ptr +=3D rec_size;
> +=09}
> +
> +=09header->device_count =3D cpu_to_le32(i);
> +}
> +
> +/**
> + * pci_crash_rebuild_snapshot() - Rebuild device list and allocate buffe=
r
> + *
> + * Two-pass approach:
> + *   Pass 1: count PCI devices
> + *   Pass 2: populate device array (filtered) and compute exact buffer
> + *            size from actual pdev->cfg_size per device (no padding)
> + *
> + * The devices param controls which devices are included.  Bridges are
> + * always included regardless of devices setting (they hold AER register=
s).
> + * devices=3Dall (default) includes everything.
> + *
> + * Does NOT read PCI config space -- reads happen only at crash time.
> + * This keeps rebuild fast during VF enumeration storms (~6000 ADD
> + * events on large accelerator hosts during liveupdate).
> + *
> + * After allocation, builds the pagemap so the crash parser can
> + * locate the buffer's physical pages in the vmcore.
> + *
> + * Publishes the new snapshot via rcu_assign_pointer() and retires the
> + * previous one via queue_rcu_work(), so the lockless crash-time reader =
never
> + * sees a half-updated state or a freed array.
> + *
> + * Caller must hold pci_crash_lock.
> + */
> +static void pci_crash_rebuild_snapshot(void)
> +{
> +=09struct pci_crash_snapshot *old, *new;
> +=09struct pci_dev *pdev =3D NULL;
> +=09unsigned int count =3D 0, i;
> +=09size_t total_size;
> +
> +=09old =3D rcu_dereference_protected(pci_crash_snap,
> +=09=09=09=09=09lockdep_is_held(&pci_crash_lock));
> +
> +=09/* Pass 1: count devices (upper bound). */
> +=09for_each_pci_dev(pdev)
> +=09=09count++;
> +
> +=09new =3D kzalloc(sizeof(*new), GFP_KERNEL);
> +=09if (!new) {
> +=09=09pr_warn_ratelimited("snapshot alloc failed; keeping previous (capt=
ure may be stale)\n");
> +=09=09return;
> +=09}
> +=09INIT_RCU_WORK(&new->rcu_work, pci_crash_snapshot_free_work);
> +
> +=09if (count =3D=3D 0) {
> +=09=09pr_info("no PCI devices found\n");
> +=09=09goto publish;=09/* publish an empty snapshot */
> +=09}
> +
> +=09new->devs =3D kvmalloc_array(count, sizeof(*new->devs),
> +=09=09=09=09   GFP_KERNEL | __GFP_ZERO);
> +=09if (!new->devs) {
> +=09=09kfree(new);
> +=09=09pr_warn_ratelimited("devs alloc failed; keeping previous (capture =
may be stale)\n");
> +=09=09return;
> +=09}
> +
> +=09/*
> +=09 * Pass 2: populate filtered device array and compute the exact
> +=09 * buffer size.  count (pass 1) is an upper bound; actual may be less=
=2E
> +=09 */
> +=09total_size =3D PCI_CRASH_HEADER_SIZE;
> +=09pdev =3D NULL;
> +=09i =3D 0;
> +=09for_each_pci_dev(pdev) {
> +=09=09if (i >=3D count) {
> +=09=09=09pci_dev_put(pdev);
> +=09=09=09break;
> +=09=09}
> +=09=09if (!pci_crash_device_matches(pdev))
> +=09=09=09continue;
> +=09=09new->devs[i] =3D pci_dev_get(pdev);
> +=09=09total_size +=3D PCI_CRASH_RECORD_META + pdev->cfg_size;
> +=09=09i++;
> +=09}
> +=09new->num_devs =3D i;
> +
> +=09if (new->num_devs =3D=3D 0) {
> +=09=09/* Publish empty: releases the previous (now stale) device set. */
> +=09=09kvfree(new->devs);
> +=09=09new->devs =3D NULL;
> +=09=09pr_info("no devices match devices=3D%s\n", devices);
> +=09=09goto publish;
> +=09}
> +
> +=09if (total_size > PCI_CRASH_MAX_BUFFER_SIZE) {
> +=09=09pr_warn_ratelimited("buffer too large (%zu > %d bytes); keeping pr=
evious snapshot (capture may be stale)\n",
> +=09=09=09=09    total_size, PCI_CRASH_MAX_BUFFER_SIZE);
> +=09=09goto err_free_devs;
> +=09}
> +
> +=09new->buffer =3D kvmalloc(total_size, GFP_KERNEL | __GFP_ZERO);
> +=09if (!new->buffer)
> +=09=09goto err_free_devs;
> +=09new->buffer_size =3D total_size;
> +
> +=09new->pagemap =3D pci_crash_build_pagemap(new->buffer, total_size);
> +=09if (!new->pagemap)
> +=09=09goto err_free_buf;
> +=09new->pagemap_size =3D struct_size(new->pagemap, addrs,
> +=09=09=09=09=09le32_to_cpu(new->pagemap->num_pages));
> +=09new->pagemap_phys =3D virt_to_phys(new->pagemap);
> +
> +=09pr_info("rebuild: %u devices (%zu bytes, %u pages)\n",
> +=09=09new->num_devs, total_size,
> +=09=09le32_to_cpu(new->pagemap->num_pages));
> +
> +publish:
> +=09/*
> +=09 * Publish the new snapshot and retire the old one.  Readers in
> +=09 * pci_crash_save() hold rcu_read_lock(), so queue_rcu_work() defers
> +=09 * the old snapshot's frees until a grace period elapses, then runs
> +=09 * the free in process context (pci_dev_put may sleep via
> +=09 * device_release -> devres_release_all).
> +=09 */
> +=09rcu_assign_pointer(pci_crash_snap, new);
> +=09if (old)
> +=09=09WARN_ON(!queue_rcu_work(system_wq, &old->rcu_work));

Add include for WARN_ON().

> +=09return;
> +
> +err_free_buf:
> +=09kvfree(new->buffer);
> +err_free_devs:
> +=09for (i =3D 0; i < new->num_devs; i++)
> +=09=09pci_dev_put(new->devs[i]);
> +=09kvfree(new->devs);
> +=09kfree(new);
> +=09/*
> +=09 * Allocation failed building the new snapshot.  Keep the existing
> +=09 * snapshot live (do not publish) so capture still works with the
> +=09 * prior device set; warn (ratelimited) so persistent failures show.
> +=09 */
> +=09pr_warn_ratelimited("rebuild failed; keeping previous snapshot (captu=
re may be stale)\n");
> +}
> +
> +#ifdef CONFIG_PCIEAER
> +/*
> + * Quick-scan root ports for a received uncorrectable AER error -- the s=
ignal
> + * that this panic is PCI-related and worth capturing.
> + *
> + * Return: true on the first root port whose ROOT_STATUS reports an
> + * uncorrectable error.
> + */
> +static bool pci_crash_aer_error_present(struct pci_crash_snapshot *s)
> +{
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < s->num_devs; i++) {
> +=09=09struct pci_dev *pdev =3D s->devs[i];
> +=09=09u32 status =3D 0;
> +
> +=09=09if (!pdev || !pdev->aer_cap)
> +=09=09=09continue;
> +=09=09if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ROOT_PORT)
> +=09=09=09continue;
> +=09=09/*
> +=09=09 * Same reachability gate as the capture path.  A root port is
> +=09=09 * on-die (no upstream bridge), so this reduces to the software-
> +=09=09 * state flags -- we read the port's own AER registers, never an
> +=09=09 * endpoint behind a potentially-dead link.
> +=09=09 */
> +=09=09if (!pci_crash_endpoint_reachable(pdev))
> +=09=09=09continue;
> +
> +=09=09/*
> +=09=09 * Fail closed, like the reachability check: a failed read
> +=09=09 * (lock contention or PCIBIOS error) sets status to ~0, which
> +=09=09 * would falsely test as "uncorrectable error present" and force
> +=09=09 * a pointless full capture.  Unknown means "no error seen".
> +=09=09 */
> +=09=09if (pci_bus_read_config_dword_trylock(pdev->bus, pdev->devfn,
> +=09=09=09=09=09=09      pdev->aer_cap + PCI_ERR_ROOT_STATUS,
> +=09=09=09=09=09=09      &status) !=3D 0)

!=3D PCIBIOS_SUCCESSFUL, use ret variable and do the compare separate=20
from the call.

> +=09=09=09continue;
> +=09=09if (status & PCI_ERR_ROOT_UNCOR_RCV)
> +=09=09=09return true;
> +=09}
> +=09return false;
> +}
> +#else
> +static inline bool pci_crash_aer_error_present(struct pci_crash_snapshot=
 *s)
> +{
> +=09return false;
> +}
> +#endif
> +
> +/**
> + * pci_crash_save() - Capture PCI config space at crash time
> + *
> + * Called from crash_save_vmcoreinfo() inside __crash_kexec(), which
> + * runs before machine_kexec() boots the crash kernel.  This is the
> + * only reliable capture point -- panic notifiers run AFTER kexec by
> + * default (crash_kexec_post_notifiers=3D0).
> + *
> + * Capture check (capture param):
> + *   always  -- capture unconditionally
> + *   aer     -- quick-scan root port AER ROOT_STATUS for uncorrectable
> + *             errors; skip if none found
> + *
> + * When capture=3Dalways, captures on every panic.
> + * This is useful for cascading failures: a PCI link-down can cause
> + * an MCE or NMI watchdog timeout before DPC/AER fires, so the crash
> + * reason is UNKNOWN but AER registers may still hold error state.
> + *
> + * Reads config space fresh -- successful reads get current register
> + * state, failed reads (offline devices) write 0xFFFFFFFF.
> + *
> + * Flushes both buffer and pagemap from CPU cache to RAM so data
> + * survives kexec into crash kernel.
> + *
> + * Runs under rcu_read_lock(): a rebuild worker may still be mid-flight =
on a
> + * peer CPU, so RCU keeps the sampled snapshot alive for the whole captu=
re.
> + */
> +void pci_crash_save(void)
> +{
> +=09struct pci_crash_snapshot *s;
> +=09unsigned long cflags;
> +
> +=09/* Cleared first; set only on a successful capture below. */
> +=09pci_crash_buffer =3D NULL;
> +=09pci_crash_buffer_size =3D 0;
> +=09pci_crash_pagemap_phys =3D 0;
> +
> +=09rcu_read_lock();
> +=09s =3D rcu_dereference(pci_crash_snap);
> +=09if (!s || s->num_devs =3D=3D 0)
> +=09=09goto out;
> +=09if (!s->buffer || s->buffer_size =3D=3D 0)
> +=09=09goto out;
> +
> +=09/*
> +=09 * Pin this snapshot so a rebuild racing on a live peer CPU cannot
> +=09 * queue_rcu_work()-free its buffer/pagemap before machine_kexec() sn=
apshots
> +=09 * RAM.  The scalars below are read by vmcore_info.c AFTER we return =
and
> +=09 * rcu_read_unlock() -- i.e. after RCU read-side protection has ended=
 --
> +=09 * so RCU alone does not keep the buffer alive that long.  Written he=
re,
> +=09 * under rcu_read_lock() and before the scalars are published; the fr=
ee
> +=09 * callback honours it (see pci_crash_snapshot_free_work).
> +=09 */
> +=09WRITE_ONCE(pci_crash_captured_snap, s);
> +
> +=09/*
> +=09 * Publish the buffer location now -- before the AER quick-scan that =
may
> +=09 * skip the capture -- so vmcore_info.c always exports a valid (possi=
bly
> +=09 * empty) buffer.  vmcore_info.c reads only these scalars, immediatel=
y
> +=09 * after we return and still inside __crash_kexec() before
> +=09 * machine_kexec().
> +=09 */
> +=09pci_crash_buffer =3D s->buffer;
> +=09pci_crash_buffer_size =3D s->buffer_size;
> +=09pci_crash_pagemap_phys =3D s->pagemap_phys;
> +
> +=09cflags =3D READ_ONCE(capture_flags);
> +=09if (!(cflags & PCI_CRASH_CAPTURE_ALWAYS)) {
> +=09=09if (!(cflags & PCI_CRASH_CAPTURE_AER)) {
> +=09=09=09/* Neither 'always' nor a usable 'aer' mode -- skip. */
> +=09=09=09goto out;
> +=09=09}
> +=09=09if (!pci_crash_aer_error_present(s)) {
> +=09=09=09pr_info("no PCI errors detected, skipping capture\n");
> +=09=09=09goto out;
> +=09=09}
> +=09}
> +
> +=09pci_crash_fill_buffer(s);
> +
> +=09/*
> +=09 * Flush buffer and pagemap from CPU cache to RAM so the
> +=09 * crash kernel sees our writes after kexec.
> +=09 */
> +=09pci_crash_flush_dcache(s->buffer, s->buffer_size);
> +=09if (s->pagemap && s->pagemap_size > 0)
> +=09=09pci_crash_flush_dcache(s->pagemap, s->pagemap_size);
> +
> +=09pr_info("CAPTURE: %u devices, %zu bytes\n",
> +=09=09s->num_devs, s->buffer_size);
> +out:
> +=09rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(pci_crash_save);
> +
> +static void pci_crash_rebuild_worker(struct work_struct *work)
> +{
> +=09mutex_lock(&pci_crash_lock);
> +=09pci_crash_rebuild_snapshot();
> +=09mutex_unlock(&pci_crash_lock);
> +}
> +
> +static int pci_crash_bus_notifier(struct notifier_block *nb,
> +=09=09=09=09  unsigned long action, void *data)
> +{
> +=09if (action =3D=3D BUS_NOTIFY_ADD_DEVICE ||
> +=09    action =3D=3D BUS_NOTIFY_DEL_DEVICE)
> +=09=09mod_delayed_work(system_wq, &pci_crash_rebuild_dwork,
> +=09=09=09=09 msecs_to_jiffies(PCI_CRASH_REBUILD_DELAY_MS));
> +
> +=09return NOTIFY_OK;
> +}
> +
> +static struct notifier_block pci_crash_bus_nb =3D {
> +=09.notifier_call =3D pci_crash_bus_notifier,
> +};
> +
> +static int __init pci_crash_init(void)
> +{
> +=09/*
> +=09 * The on-wire buffer/pagemap layout is shared with userspace vmcore
> +=09 * parsers, which hardcode these sizes.  Catch any struct drift at
> +=09 * build time.
> +=09 */
> +=09BUILD_BUG_ON(sizeof(struct pci_crash_buffer_header) !=3D 32);
> +=09BUILD_BUG_ON(sizeof(struct pci_crash_device_record) !=3D 8);
> +=09BUILD_BUG_ON(offsetof(struct pci_crash_pagemap, addrs) !=3D 20);
> +
> +=09/* Nothing to do in crash kernel -- the buffer from the first kernel
> +=09 * is already in RAM (flushed before kexec) and the parser finds it
> +=09 * via the pagemap in VMCOREINFO.
> +=09 */
> +=09if (is_kdump_kernel())
> +=09=09return 0;
> +
> +=09INIT_DELAYED_WORK(&pci_crash_rebuild_dwork, pci_crash_rebuild_worker)=
;
> +
> +=09pci_crash_parse_capture();
> +=09pci_crash_parse_devices();
> +
> +=09/*
> +=09 * Register the hotplug notifier BEFORE the initial snapshot so no
> +=09 * ADD/DEL event in the startup window is missed.  The notifier only
> +=09 * schedules the debounced rebuild worker, which serializes on
> +=09 * pci_crash_lock behind this initial rebuild.
> +=09 */
> +=09bus_register_notifier(&pci_bus_type, &pci_crash_bus_nb);
> +
> +=09mutex_lock(&pci_crash_lock);
> +=09pci_crash_rebuild_snapshot();
> +=09mutex_unlock(&pci_crash_lock);
> +
> +=09WRITE_ONCE(pci_crash_ready, true);
> +
> +#ifndef CONFIG_PCIEAER
> +=09if ((capture_flags & PCI_CRASH_CAPTURE_AER) &&
> +=09    !(capture_flags & PCI_CRASH_CAPTURE_ALWAYS))
> +=09=09pr_warn("capture=3Daer but CONFIG_PCIEAER=3Dn; capture will not tr=
igger unless set to 'always'\n");
> +#endif
> +
> +=09rcu_read_lock();
> +=09{
> +=09=09struct pci_crash_snapshot *s =3D rcu_dereference(pci_crash_snap);
> +
> +=09=09pr_info("ready: %u devices (%zu bytes), capture=3D%s devices=3D%s\=
n",
> +=09=09=09s ? s->num_devs : 0, s ? s->buffer_size : 0,
> +=09=09=09capture, devices);
> +=09}
> +=09rcu_read_unlock();
> +
> +=09return 0;
> +}
> +late_initcall(pci_crash_init);
> +
> +/* Built-in only: crash infrastructure must outlive all drivers. */
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Capture PCI config space at panic time for crash ana=
lysis");
> +MODULE_AUTHOR("Amazon.com, Inc.");
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index 8614430ca212..8813f7e2e516 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -14,6 +14,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
>  #include <linux/kmemleak.h>
> +#include <linux/pci_crash.h>
> =20
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -91,6 +92,18 @@ void crash_save_vmcoreinfo(void)
>  =09=09vmcoreinfo_data =3D vmcoreinfo_data_safecopy;
> =20
>  =09vmcoreinfo_append_str("CRASHTIME=3D%lld\n", ktime_get_real_seconds())=
;
> +
> +=09/* Capture PCI config space before kexec into crash kernel */
> +=09pci_crash_save();
> +=09if (pci_crash_pagemap_phys && pci_crash_buffer_size > 0) {
> +=09=09vmcoreinfo_append_str("PCI_CRASH_PAGEMAP=3D0x%llx\n",
> +=09=09=09=09      (unsigned long long)pci_crash_pagemap_phys);
> +=09=09vmcoreinfo_append_str("PCI_CRASH_VERSION=3D%d\n",
> +=09=09=09=09      PCI_CRASH_VERSION);
> +=09=09vmcoreinfo_append_str("PCI_CRASH_BUF_SZ=3D%zu\n",
> +=09=09=09=09      pci_crash_buffer_size);
> +=09}
> +
>  =09update_vmcoreinfo_note();
>  }
> =20
>=20

--=20
 i.
--8323328-1348826095-1787755571=:1168--
