Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F34AEBEA;
	Mon, 31 Aug 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190628; cv=none; b=jEK/7X65kTLR3KULdEV5yKCy0SHrko9jQ98PdNLnXAOExdcwhEv+ikJTrB3NFpOHbo8sO9wlNPEPC6cxZhiG0jmfIgKvrW5jnv7FutNCcYM8mymc6YYyr9C/628cwdGAIaT2c0QlWqkpZt7Tdy/2ZBb2j2c2L0sIGz1x1G9nze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190628; c=relaxed/simple;
	bh=FvL8vlpfxfF57I11JqfarFRLzrey1Ag6NPBlimucvVM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pG4BIZCp9GB3M4T+LvkliU/9He4VJ0nAgV6eghe5P8wVtOQErguvVOKYTI7G9w+Zq8m8DN5qmNWQ5cvQn6ZU+cfRtp7Eoe4XG5E+EFYkOgPP3YcB3QohLlyHE0vTLRJVTv/FoZ3g9uxJeZXDfygeHCO2vjkhmJ8QJfz266sd5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lqadxz2I; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lqadxz2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788190623; x=1819726623;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FvL8vlpfxfF57I11JqfarFRLzrey1Ag6NPBlimucvVM=;
  b=Lqadxz2Il0La0JehMYqas7wHktS313HJuZ5XcfnJhVuQkgjVwYNqsH7U
   BFWdnLHRCRjX619TJN+v5bsDIeKT0LtnrXZO+hsnGruCTujRVI8XEiA2U
   Vvns0ZTlpiKVOWJtagndPG+BlkWOrc/Hz8/WUPq6pAiqnslataueiJ1Ri
   HYYeiekYwX8RpILZGPk/+gP7F3cSs9TN/i27CvM/MikDNeNWZMx5QByNg
   7YllJTMOXApxP0efrV7jIAIjiohxt2ZKeejtQDoXwYCdYBVQ1TvTafvp1
   wMkhT7JHP/nJ+6k0iwWzDUZLH0VoRrUzpcIVixOdGOWFm/KGHap+5+Sla
   Q==;
X-CSE-ConnectionGUID: uvDipYnqQtKA5/0r0lWkkg==
X-CSE-MsgGUID: 1FUCrLELQt+/4Q1nwvPnEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114139909"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="114139909"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 08:37:02 -0700
X-CSE-ConnectionGUID: 2KUPjvjxT2iX+0PIGy3K9g==
X-CSE-MsgGUID: OznDWAmMT5qXxvcEqsDMYg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 08:36:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 18:36:53 +0300 (EEST)
To: Priyank Rathod <rathodpriyank@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>, 
    Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v7] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
In-Reply-To: <20260828-pcie-lmt-v7-1-6012e9e0940a@google.com>
Message-ID: <fb246f73-74d8-61d0-5886-3a24bc29f902@linux.intel.com>
References: <20260828-pcie-lmt-v7-1-6012e9e0940a@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-957476827-1788190613=:2637"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-957476827-1788190613=:2637
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 28 Aug 2026, Priyank Rathod wrote:

> Per PCIe Base Specification r6.0, sec 8.4.4 ("Lane Margining at
> Receiver"), PCIe devices operating at 16.0 GT/s (Gen 4) or higher data
> rates support the Lane Margining at Receiver Extended Capability
> (ID 0x27), and it is mandatory for receivers operating at 64.0 GT/s
> (Gen 6) or higher data rates. Lane Margining allows software to
> evaluate high-speed link margins by measuring timing and voltage steps
> for each individual physical lane and receiver.
>=20
> Add driver and debugfs support for PCIe Lane Margining at Receiver:
>=20
>   - Add Lane Margining at Receiver Extended Capability register
>     definitions (PCI_EXT_CAP_ID_LMR, PCI_LMR_PORT_CAP, PCI_LMR_PORT_STS,
>     PCI_LMR_LANE_CTRL, PCI_LMR_LANE_STS) to <uapi/linux/pci_regs.h>.
>   - Add Kconfig option CONFIG_PCIE_LMR (under drivers/pci/pcie/Kconfig)
>     dependent on DEBUG_FS.
>   - Implement drivers/pci/pcie/margin.c to probe the capability on Gen4+
>     links and expose per-device debugfs entries under:
>       /sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/
>     providing control over margining enablement, receiver selection, and
>     execution of timing/voltage margin step commands. Distinguish
>     between missing mandatory LMR capability on Gen6+ vs optional on
>     Gen4/Gen5.
>   - Hook pci_lmr_init() into pci_init_capabilities() during device probe
>     in drivers/pci/probe.c and pci_lmr_exit() into drivers/pci/remove.c.
>   - Add kselftest script under tools/testing/selftests/pcie_lmt/pcie_lmt.=
sh
>     to test debugfs capability reads, enablement, and stepping.
>   - Add MAINTAINERS entry for PCIe Lane Margining at Receiver (LMR).
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
> Changes in v7:
>   - Implemented dedicated ASPM Inhibit API (pci_lmr_aspm_inhibit) strictl=
y enforcing PCIe Base Specification Revision 7.0 sec 7.5.3.7 sequencing (Do=
wnstream Component first on disable, Upstream Component first on restore) w=
ith 2-3ms L0 settling.
>   - Added pci_lmr_ensure_aspm_inhibited() before executing physical margi=
n steps to protect against out-of-band ASPM re-enabling.

Hi,

Unfortunately, this is ASPM thing is still wrong solution and you even=20
admit it yourself in a pci_info message that ASPM got enabled=20
"unexpectedly".

Please handle ASPM disabling (and reenabling) through the aspm driver, do=
=20
not write to ASPMC in this driver at all!! (For better disable/enable ASPM=
=20
driver API, you may have to look in one of the pending ASPM series and=20
build on top of that.)

If/when you need "inhibit", that should be done by the ASPM driver. Note=20
though that the way aspm driver handles state disabling is not entirely=20
satisfactory, It should probably keep counter for each ASPM state and only=
=20
allow enabling ASPM state X when nothing has disabled it, because a driver=
=20
could also want to disable ASPM and possibly re-enabled it later (e.g.=20
over a duration of a reset or fw update). Saving LNKCTL here would mess=20
that up so it should be ASPM driver's sole responsability to prevent=20
enabled ASPM prematurely if anything has asked a state to be kept off.

>   - Eliminated pci_bus_sem lock inversion by resolving link partners once=
 before acquiring device locks and referencing them via pci_lmr_get_ports()=
=2E
>   - Switched pci_reset_lmr() to asynchronous pm_runtime_put() for remote =
partner to prevent stranding it in D0 without blocking local device reset.
>   - Aligned all specification citations, table numbers (Table 4-77 / Tabl=
e 4-73), and register bitfields to PCIe Base Spec r7.0 and r6.0.
>   - Wrapped comments to stay within 100-column checkpatch limit and added=
 @partner kerneldoc description.

Some code comments are much longer than the code lines, and they are hard=
=20
to read because of that. The comments would be better to still be limited=
=20
to 80-chars, even if for code the 80 chars limit can be exceeded where it=
=20
makes sense.


I see you also added HASW/HAWD handling which is good!

>   - Link to v6: https://lore.kernel.org/r/20260824-pcie-lmt-v6-1-bab4ce23=
3fa5@google.com
>=20
> Changes in v6:
>   - Added kernel documentation under Documentation/PCI/pcie-lmr.rst and i=
ndexed in Documentation/PCI/index.rst (Ilpo J=C3=A4rvinen).
>   - Updated MAINTAINERS with Documentation/PCI/pcie-lmr.rst (Ilpo J=C3=A4=
rvinen).
>   - Aligned capability bit naming and comments with PCIe Base Specificati=
on r6.0 sec 8.4.4 Table "Report Margining Capabilities Payload" (Ilpo J=C3=
=A4rvinen).
>   - Clarified Sample Multiple Receivers concurrency verification and rule=
s across physical lanes in kerneldoc and documentation (Ilpo J=C3=A4rvinen)=
=2E
>   - Refactored pci_lmr_run_cmd() to pass struct pci_margin_dev *mdev dire=
ctly, eliminating redundant NULL checks and using mdev->num_lanes (Ilpo J=
=C3=A4rvinen).
>   - Converted PCI config read/write return checking across all helpers to=
 pcibios_err_to_errno() (Ilpo J=C3=A4rvinen).
>   - Reversed return logic in pci_lmr_demargin_lane() to return early on e=
rror (Ilpo J=C3=A4rvinen).
>   - Refactored margin_lane_step_write() to eliminate bool is_voltage para=
meter, using command type (LMR_TYPE_TIMING / LMR_TYPE_VOLTAGE) and switch/c=
ase with consolidated bounds checks (Ilpo J=C3=A4rvinen).
>   - Renamed __pci_suspend_lmr_locked() to pci_lmr_disable_locked() to avo=
id PM terminology confusion and added lockdep_assert_held(&mdev->lock) (Ilp=
o J=C3=A4rvinen).
>   - Replaced -EACCES with -EBUSY across debugfs show/write callbacks when=
 margining is inactive (Ilpo J=C3=A4rvinen).
>   - Clarified comment for active operating link speed check (Gen4+ capabi=
lity vs dynamically operating speed) in margin_enable_write() (Ilpo J=C3=A4=
rvinen).
>   - Added WARN_ON_ONCE(!dev) check in pci_lmr_init() (Ilpo J=C3=A4rvinen)=
=2E
>   - Demoted capability detection log message from pci_info to pci_dbg to =
prevent boot log noise (Ilpo J=C3=A4rvinen).
>   - Fixed timing step mask extraction in pci_lmr_cache_rx_info() to use 6=
-bit LMR_TIMING_STEP_MASK (sashiko-bot).
>   - Resumed runtime PM via pm_runtime_resume_and_get() before performing =
config space reads in margin_enable_write() (sashiko-bot).
>   - Switched to pm_runtime_put_sync() during margining teardown (sashiko-=
bot).
>   - Link to v5: https://lore.kernel.org/r/20260820-pcie-lmt-v5-1-943b3b0e=
18bf@google.com
>=20
> PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
>=20
> Per PCIe Base Specification r6.0, section 8.4.4 ("Lane Margining at Recei=
ver"),
> PCIe devices operating at 16.0 GT/s (Gen 4) or higher data rates support =
the
> Lane Margining at Receiver Extended Capability (ID 0x27), and it is manda=
tory
> for receivers operating at 64.0 GT/s (Gen 6) or higher data rates.
>=20
> Lane Margining allows system software to evaluate high-speed link signal
> integrity and margins by measuring timing and voltage steps for each phys=
ical
> lane and receiver independently.
>=20
> This series introduces kernel driver support, debugfs controls, and a
> kselftest automation script for PCIe Lane Margining at Receiver (LMR/LMT)=
=2E
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> 1. How to Enable & Configure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> Enable the Kconfig option under PCI support:
>   CONFIG_PCIE_LMR=3Dy (or =3Dm)
>   (Depends on CONFIG_PCI and CONFIG_DEBUG_FS)
>=20
> Upon boot or device hotplug on Gen4+ links (>=3D 16.0 GT/s), the driver p=
robes
> Extended Capability ID 0x27 and exposes per-device debugfs interfaces:
>   /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> 2. How to Use the Debugfs Interface (Manual Margining)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> Inspect device-wide margining capabilities and port status:
>   # Inspect root device LMR capabilities & status
>   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
>   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status
>=20
> Enable active Lane Margining on the device:
>   # Enable Lane Margining state machine
>   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
>=20
> Inspect and step individual lanes (e.g. lane0):
>   # Select target receiver (0 =3D local receiver, 1..6 =3D retimers/link =
partners)
>   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/receiver
>=20
>   # Check available timing and voltage steps for this receiver
>   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/caps
>   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_timing_steps
>   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_voltage_steps
>=20
>   # Step timing margin or voltage margin offset
>   echo 2 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timin=
g
>   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_volta=
ge
>=20
>   # Reset margin offset back to nominal (0)
>   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timin=
g
>   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_volta=
ge
>=20
> Disable Lane Margining when finished:
>   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> 3. How to Run Automated Kselftests Using the Test Script
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> An automated kselftest script is included to test capability reads, recei=
ver
> selection, and margining commands across all enumerated LMR devices:
>=20
>   # Run directly as root
>   sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh
>=20
> Or run via the kselftest Makefile harness:
>   make -C tools/testing/selftests TARGETS=3Dpcie_lmt run_tests
>=20
> Sample script output on an LMR-capable device:
>   pcie_lmt: testing PCIe LMR debugfs entries
>   pcie_lmt: probing device pcie_lmr_0000:01:00.0
>     pcie_lmr_0000:01:00.0: capabilities read OK
>     pcie_lmr_0000:01:00.0: port_status read OK
>     pcie_lmr_0000:01:00.0: margining enabled OK
>     pcie_lmr_0000:01:00.0: testing lane0
>     pcie_lmr_0000:01:00.0: testing lane1
>     pcie_lmr_0000:01:00.0: margining disabled OK
>   pcie_lmt [PASS]
>=20
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shuah Khan <shuah@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Changes in v5:
>   - Sorted #include directives alphabetically and added missing includes =
for bits.h, bitfield.h, cleanup.h, overflow.h, and slab.h (Ilpo J=C3=A4rvin=
en).
>   - Converted bitmasks to GENMASK() and BIT() macros and used FIELD_PREP(=
) and FIELD_GET() instead of manual bit shifts (Ilpo J=C3=A4rvinen).
>   - Added pci_lmr_sts_payload() helper to cleanly extract the status payl=
oad byte before applying step and capability masks (Ilpo J=C3=A4rvinen).
>   - Replaced manual mutex locking sequences with guard(mutex)(&mdev->lock=
) across show and write callbacks to simplify control flow (Ilpo J=C3=A4rvi=
nen).
>   - Documented mutex lock protection scope in kerneldoc for struct pci_ma=
rgin_dev (Ilpo J=C3=A4rvinen).
>   - Used standard PCI_POSSIBLE_ERROR(), str_yes_no(), and scnprintf() hel=
pers throughout the driver (Ilpo J=C3=A4rvinen).
>   - Clarified receiver range (0..6 per PCIe r6.0 sec 8.4.4; 7 reserved) i=
n comments and validation checks (Ilpo J=C3=A4rvinen).
>   - Deduplicated timing and voltage show/write handlers using margin_lane=
_steps_show() and margin_lane_step_write() (Ilpo J=C3=A4rvinen).
>   - Placed speed check immediately following pcie_get_speed_cap() and han=
dled PCI_SPEED_UNKNOWN (Ilpo J=C3=A4rvinen).
>   - Converted lanes in struct pci_margin_dev to a flexible array member w=
ith __counted_by(num_lanes) allocated via struct_size() (Ilpo J=C3=A4rvinen=
).
>=20
> Changes in v4:
>   - Added Sample Multiple Receivers (Bit 5) concurrency verification in m=
argin_lane_timing_write() and margin_lane_voltage_write() per PCIe r6.0 sec=
 8.4.4, returning -EBUSY if another lane on the same receiver is already ma=
rgined when simultaneous lane margining is not supported.
>   - Added active operating link speed verification (PCI_EXP_LNKSTA_CLS >=
=3D 16.0 GT/s) in margin_enable_write() before enabling LMR, as LMR command=
s are physically undefined on links operating at Gen1/Gen2/Gen3 speeds.
>   - Added fast-path hardware NAK detection in pci_lmr_run_cmd() to return=
 -EOPNOTSUPP immediately if a receiver echoes MTYPE =3D=3D NO_CMD (0x7) aft=
er command issuance rather than waiting 150ms for a timeout.
>   - Added pci_reset_lmr() hooked into __pci_reset_function_locked() to sy=
nchronize software state and demargin on FLR or Secondary Bus Reset.
>   - Comprehensive NULL pointer checks and array/lane/receiver bounds chec=
ks added across all internal helpers and debugfs write handlers.
>   - Added MAINTAINERS entry for PCIe Lane Margining at Receiver (LMR).
>=20
> Changes in v2:
>   - Fixed NO_CMD (0x7) clearing in pci_lmr_run_cmd() before issuing new c=
ommands per PCIe r6.0 sec 8.4.4.
>   - Protected plane->rx updates with mdev->lock in margin_lane_receiver_w=
rite().
>   - Corrected Margining Port Capabilities bit definition to PCI_LMR_PORT_=
CAP_USES_SW_READY (0x0001) in <uapi/linux/pci_regs.h>.
>   - Updated kselftest script (pcie_lmt.sh) to locate LMR debugfs entries.
>   - Validated integer bounds against LMR_MAX_TIMING_STEP / LMR_MAX_VOLTAG=
E_STEP before narrowing u8 cast.
>   - Moved mdev->enabled checks inside mutex_lock(&mdev->lock) to eliminat=
e TOCTOU races.
>   - Checked return values of all pci_read_config_word() calls, propagatin=
g -EIO on failure.
>   - Eliminated dead store of cap in margin_enable_write().
>   - Explicitly checked speed =3D=3D PCIE_SPEED_64_0GT in pci_lmr_init() t=
o avoid misidentifying PCI_SPEED_UNKNOWN (0xFF) as Gen6.
> ---
>  Documentation/PCI/index.rst                  |    1 +
>  Documentation/PCI/pcie-lmr.rst               |  174 +++
>  MAINTAINERS                                  |    8 +
>  drivers/pci/pci-driver.c                     |    2 +
>  drivers/pci/pci.c                            |    1 +
>  drivers/pci/pci.h                            |   17 +
>  drivers/pci/pcie/Kconfig                     |   12 +
>  drivers/pci/pcie/Makefile                    |    1 +
>  drivers/pci/pcie/margin.c                    | 1618 ++++++++++++++++++++=
++++++
>  drivers/pci/probe.c                          |    1 +
>  drivers/pci/remove.c                         |    2 +-
>  include/linux/pci.h                          |    6 +
>  include/uapi/linux/pci_regs.h                |   18 +
>  tools/testing/selftests/Makefile             |    1 +
>  tools/testing/selftests/pcie_lmt/Makefile    |    3 +
>  tools/testing/selftests/pcie_lmt/pcie_lmt.sh |  105 ++
>  16 files changed, 1969 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 5d720d2a415e..9170c98cbf3f 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -20,3 +20,4 @@ PCI Bus Subsystem
>     controller/index
>     boot-interrupts
>     tph
> +   pcie-lmr
> diff --git a/Documentation/PCI/pcie-lmr.rst b/Documentation/PCI/pcie-lmr.=
rst
> new file mode 100644
> index 000000000000..ffcd4fcf72cc
> --- /dev/null
> +++ b/Documentation/PCI/pcie-lmr.rst
> @@ -0,0 +1,174 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +PCI Express Lane Margining at Receiver (LMR) Subsystem
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +:Author: Priyank Rathod <rathodpriyank@google.com>
> +:Copyright: 2026 Google LLC
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Lane Margining at Receiver (LMR), specified in the PCI Express Base
> +Specification (Revision 7.0 sec 7.7.11 & sec 8.4.4; r6.0 sec 7.7.10 & se=
c 8.4.4),
> +allows system software to evaluate high-speed link physical signal integ=
rity and
> +eye margins. LMR measures available timing (jitter/phase) and voltage ma=
rgin
> +offsets for each physical lane and receiver independently while the link=
 is
> +operating in active L0 state.
> +
> +Lane Margining Extended Capability (ID 0x27) is optional for links opera=
ting at
> +16.0 GT/s (PCIe Gen 4) and 32.0 GT/s (Gen 5), and is mandatory for recei=
vers
> +operating at 64.0 GT/s (Gen 6) and higher.
> +
> +Target Receivers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Each physical lane can margin up to 7 distinct receivers per PCIe link:
> +
> +* **Receiver 0 (Local Receiver)**: The receiver in the immediate link pa=
rtner.
> +* **Receivers 1 to 6 (Retimers)**: Retimer pseudo-ports along the physic=
al link
> +  (up to 3 retimers, each with upstream and downstream pseudo-ports).
> +* **Receiver 7**: Reserved per PCIe Base Specification.
> +
> +Kernel Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Enable the kernel configuration option under PCI support:
> +
> +.. code-block:: none
> +
> +   CONFIG_PCIE_LMR=3Dy (or =3Dm)
> +
> +Dependencies:
> +* ``CONFIG_PCI``
> +* ``CONFIG_DEBUG_FS``
> +
> +Debugfs Interface Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When an LMR-capable device is enumerated on a Gen4+ link, the kernel exp=
oses
> +per-device control and status files under debugfs:
> +
> +.. code-block:: none
> +
> +   /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/
> +
> +Device-Level Attributes
> +-----------------------
> +
> +* ``capabilities`` (read-only):
> +  Displays the 16-bit Margining Port Capabilities register and whether t=
he
> +  device uses the Software Ready handshake bit.
> +
> +* ``port_status`` (read-only):
> +  Displays the Margining Port Status register, indicating Margining Read=
y and
> +  SW Ready states.
> +
> +* ``enable`` (read-write):
> +  Enables (``1``) or disables (``0``) Lane Margining on the device.
> +  Enabling margining locks the link into D0, prevents runtime PM suspend=
,
> +  disables ASPM L0s/L1, disables hardware autonomous link width/speed ch=
anges,
> +  and verifies that the link is operating at >=3D 16.0 GT/s.
> +  Disabling margining restores ASPM, hardware autonomous width/speed set=
tings,
> +  and runtime PM, and returns all lanes to nominal (normal) operating se=
ttings.
> +
> +Lane-Level Attributes
> +---------------------
> +
> +For each physical lane (``lane0``, ``lane1``, ...):
> +
> +* ``receiver`` (read-write):
> +  Gets or sets the active target receiver number (``0`` for local receiv=
er,
> +  ``1..6`` for retimers). Switching receivers automatically clears previ=
ous
> +  offsets back to normal settings per PCIe single-receiver margining req=
uirements.
> +
> +* ``caps`` (read-only):
> +  Reports the target receiver's margining capabilities (PCIe Base Specif=
ication
> +  Revision 7.0 Table 4-77 and Table 8-13; r6.0 Table 4-73 & Table 8-11):
> +  - Voltage Margining support (supported vs unsupported)
> +  - Independent Left/Right Timing Margining support (independent vs symm=
etric)
> +  - Independent Up/Down Voltage Margining support (independent vs symmet=
ric)
> +  - Error Sampler vs Main Sampler (independent error sampler vs intrusiv=
e main sampler)
> +  - Sample Reporting Method (sampling rate vs sample count)
> +
> +* ``num_timing_steps`` (read-only):
> +  Maximum timing margin steps supported by the receiver (0..63).
> +
> +* ``num_voltage_steps`` (read-only):
> +  Maximum voltage margin steps supported by the receiver (0..127).
> +
> +* ``margin_timing`` (read-write):
> +  Applies timing margin step offset (+/-). Writing ``0`` clears timing m=
argin
> +  back to nominal.
> +
> +* ``margin_voltage`` (read-write):
> +  Applies voltage margin step offset (+/-). Writing ``0`` clears voltage=
 margin
> +  back to nominal.
> +
> +Manual Margining Example
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. Inspect device capabilities and status:
> +
> +.. code-block:: sh
> +
> +   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
> +   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status
> +
> +2. Enable Lane Margining mode:
> +
> +.. code-block:: sh
> +
> +   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
> +
> +3. Configure target receiver and inspect step limits on lane 0:
> +
> +.. code-block:: sh
> +
> +   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/receiver
> +   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/caps
> +   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_timing_step=
s
> +   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_voltage_ste=
ps
> +
> +4. Apply timing and voltage margin steps:
> +
> +.. code-block:: sh
> +
> +   # Step timing margin +2 steps
> +   echo 2 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_tim=
ing
> +
> +   # Step voltage margin +1 step
> +   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_vol=
tage
> +
> +5. Reset margins back to nominal:
> +
> +.. code-block:: sh
> +
> +   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_tim=
ing
> +   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_vol=
tage
> +
> +6. Disable Lane Margining when complete:
> +
> +.. code-block:: sh
> +
> +   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
> +
> +Automated Testing via Kselftest
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +The kernel includes an automated kselftest script under
> +``tools/testing/selftests/pcie_lmt/pcie_lmt.sh`` to probe, validate, and=
 exercise
> +debugfs controls across all enumerated LMR devices.
> +
> +Run directly as root:
> +
> +.. code-block:: sh
> +
> +   sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh
> +
> +Or run via the kselftest test harness:
> +
> +.. code-block:: sh
> +
> +   make -C tools/testing/selftests TARGETS=3Dpcie_lmt run_tests
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7094a616afd..b5deaae11bfe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21059,6 +21059,14 @@ F:=09Documentation/devicetree/bindings/pci/qcom,=
sa8255p-pcie-ep.yaml
>  F:=09drivers/pci/controller/dwc/pcie-qcom-common.c
>  F:=09drivers/pci/controller/dwc/pcie-qcom-ep.c
> =20
> +PCIE LANE MARGINING AT RECEIVER (LMR)
> +M:=09Priyank Rathod <rathodpriyank@google.com>
> +L:=09linux-pci@vger.kernel.org
> +S:=09Maintained
> +F:=09Documentation/PCI/pcie-lmr.rst
> +F:=09drivers/pci/pcie/margin.c
> +F:=09tools/testing/selftests/pcie_lmt/
> +
>  PCMCIA SUBSYSTEM
>  M:=09Dominik Brodowski <linux@dominikbrodowski.net>
>  S:=09Odd Fixes
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1..ded3925aab1d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -743,6 +743,8 @@ static int pci_pm_prepare(struct device *dev)
> =20
>  =09dev_pm_set_strict_midlayer(dev, true);
> =20
> +=09pci_suspend_lmr(pci_dev);
> +
>  =09if (pm && pm->prepare) {
>  =09=09int error =3D pm->prepare(dev);
>  =09=09if (error < 0)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..e6d8cd0094f1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5058,6 +5058,7 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  =09 */
>  =09pci_set_power_state(dev, PCI_D0);
> =20
> +=09pci_reset_lmr(dev);
>  =09pci_save_state(dev);
>  =09/*
>  =09 * Disable the device by clearing the Command register, except for
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4469e1a77f3c..ea66fb65a848 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -796,6 +796,11 @@ static inline bool pci_dev_test_and_set_removed(stru=
ct pci_dev *dev)
>  =09return test_and_set_bit(PCI_DEV_REMOVED, &dev->priv_flags);
>  }
> =20
> +static inline bool pci_dev_is_removed(struct pci_dev *dev)
> +{
> +=09return test_bit(PCI_DEV_REMOVED, &dev->priv_flags);
> +}
> +
>  static inline void pci_dev_allow_binding(struct pci_dev *dev)
>  {
>  =09set_bit(PCI_DEV_ALLOW_BINDING, &dev->priv_flags);
> @@ -1023,6 +1028,18 @@ static inline void pci_no_tph(void) { }
>  static inline void pci_tph_init(struct pci_dev *dev) { }
>  #endif
> =20
> +#ifdef CONFIG_PCIE_LMR
> +void pci_lmr_init(struct pci_dev *dev);
> +void pci_lmr_exit(struct pci_dev *dev);
> +void pci_suspend_lmr(struct pci_dev *dev);
> +void pci_reset_lmr(struct pci_dev *dev);
> +#else
> +static inline void pci_lmr_init(struct pci_dev *dev) { }
> +static inline void pci_lmr_exit(struct pci_dev *dev) { }
> +static inline void pci_suspend_lmr(struct pci_dev *dev) { }
> +static inline void pci_reset_lmr(struct pci_dev *dev) { }
> +#endif
> +
>  #ifdef CONFIG_PCIE_PTM
>  void pci_ptm_init(struct pci_dev *dev);
>  void pci_save_ptm_state(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 207c2deae35f..3b021ca2fe84 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -137,6 +137,18 @@ config PCIE_PTM
>  =09  This is only useful if you have devices that support PTM, but it
>  =09  is safe to enable even if you don't.
> =20
> +config PCIE_LMR
> +=09bool "PCI Express Lane Margining at Receiver Support"
> +=09depends on DEBUG_FS
> +=09help
> +=09  This enables the PCI Express Lane Margining at Receiver support.
> +=09  Lane Margining allows software to determine the voltage and
> +=09  timing margin of each lane on a PCIe link (16.0 GT/s and above).
> +=09  The margining data is exposed via debugfs.
> +
> +=09  This is only useful if you have devices that support lane
> +=09  margining, but it is safe to enable even if you don't.
> +
>  config PCIE_EDR
>  =09bool "PCI Express Error Disconnect Recover support"
>  =09depends on PCIE_DPC && ACPI
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304..aac45ae0402e 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -13,4 +13,5 @@ obj-$(CONFIG_PCIEAER_INJECT)=09+=3D aer_inject.o
>  obj-$(CONFIG_PCIE_PME)=09=09+=3D pme.o
>  obj-$(CONFIG_PCIE_DPC)=09=09+=3D dpc.o
>  obj-$(CONFIG_PCIE_PTM)=09=09+=3D ptm.o
> +obj-$(CONFIG_PCIE_LMR)=09=09+=3D margin.o
>  obj-$(CONFIG_PCIE_EDR)=09=09+=3D edr.o
> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> index 000000000000..a428726c500d
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
> @@ -0,0 +1,1618 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Express Lane Margining at Receiver
> + *
> + * Copyright (C) 2026 Google LLC
> + * Author: Priyank Rathod <rathodpriyank@google.com>
> + *
> + * Lane Margining at Receiver (PCIe Base Specification Revision 7.0, sec=
 7.7.11 &
> + * sec 8.4.4; r6.0 sec 7.7.10 & sec 8.4.4) allows system software to det=
ermine
> + * the voltage and timing margins of each physical lane on a PCIe link. =
The
> + * Extended Capability (ID 0x27) is available for receivers operating at=
 16.0 GT/s
> + * (Gen4) or higher data rates, and is mandatory for receivers operating=
 at 64.0 GT/s
> + * (Gen6) or higher data rates.
> + *
> + * This driver implements:
> + *   - Probing Extended Capability ID 0x27 and Margining Port Capabiliti=
es.
> + *   - Managing ASPM L0s/L1 link states during active margining with res=
toration.
> + *   - PCIe Base Specification NO_CMD (0x7) clearing handshake per recei=
ver and lane.
> + *   - Caching receiver capabilities & step counts to avoid side-effects
> + *     when setting to normal settings.
> + *   - Handling Symmetric vs Independent Left/Right & Up/Down margin ste=
ps.
> + *   - Runtime PM protection (D0 enforcement) during active margining.
> + *   - Exposing per-device debugfs interfaces under /sys/kernel/debug/pc=
i/.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/jiffies.h>
> +#include <linux/kstrtox.h>
> +#include <linux/minmax.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/sprintf.h>
> +#include <linux/string_choices.h>
> +#include <linux/types.h>
> +
> +#include "../pci.h"
> +
> +/*
> + * Margining Type (MTYPE) field encodings (bits 5:3) in Margining Lane C=
ontrol
> + * and Margining Lane Status registers per PCIe Base Specification Revis=
ion 7.0:
> + * - Section 7.7.11 "Lane Margining at the Receiver Extended Capability =
(ID 0x27)"
> + *   (Margining Lane Control Register & Margining Lane Status Register)
> + *   [r6.0 Section 7.7.10]
> + * - Section 4.2.18.2 "Margin Command and Response Flow"
> + *   (Table 4-77 "Margin Commands and Corresponding Responses")
> + *   [r6.0 Table 4-73]
> + *
> + * Encodings:
> + *   001b (0x1) - Report Margin Control Capabilities
> + *   010b (0x2) - Set Margining Parameters (Go to Normal Settings, Clear=
 Error Log)
> + *   011b (0x3) - Step Margin Timing
> + *   100b (0x4) - Step Margin Voltage
> + *   111b (0x7) - No Command
> + *   (000b, 101b-110b are Reserved)
> + */
> +#define LMR_TYPE_REPORT_CAPS 0x1 /* Report Margin Control Capabilities *=
/
> +#define LMR_TYPE_SET_PARAMS 0x2 /* Set Margining Parameters */
> +#define LMR_TYPE_TIMING 0x3 /* Step Margin Timing */
> +#define LMR_TYPE_VOLTAGE 0x4 /* Step Margin Voltage */
> +#define LMR_TYPE_NO_CMD 0x7 /* No Command */

Align values for better readability in define blocks like this.

> +
> +/* Command Payloads per PCIe Base Specification Revision 7.0 Table 4-77 =
(r6.0 Table 4-73) */
> +#define LMR_PAYLOAD_REPORT_CAPS 0x88 /* Report Margin Control Capabiliti=
es */
> +#define LMR_PAYLOAD_REPORT_VOLT_STEPS 0x89 /* Report Margining Voltage S=
teps */
> +#define LMR_PAYLOAD_REPORT_TIM_STEPS 0x8A /* Report Margining Timing Ste=
ps */
> +#define LMR_PAYLOAD_GO_TO_NORMAL 0x0F /* Go to Normal Settings */
> +#define LMR_PAYLOAD_CLEAR_ERROR_LOG 0x55 /* Clear Error Log */
> +#define LMR_PAYLOAD_NO_CMD 0x9C /* No Command */

Ditto.

> +
> +/* LMR command timing parameters */
> +#define LMR_CMD_TIMEOUT_MS              150
> +#define LMR_CMD_SLEEP_MIN_US            100
> +#define LMR_CMD_SLEEP_MAX_US            250
> +#define LMR_ENABLE_TIMEOUT_MS           150
> +#define LMR_ENABLE_SLEEP_MIN_US         1000
> +#define LMR_ENABLE_SLEEP_MAX_US         2000
> +
> +/*
> + * LMR parameter limits per PCIe Base Specification Revision 7.0:
> + * - Max lanes (32): sec 7.7.11 & Table 8-13 (MMaxLanes max 31)
> + * - Receiver numbers 0..6: Table 4-76 (assignment) & Table 4-77 (valid =
for commands)
> + * - Max timing step (63): sec 4.2.18.1.2, Table 4-77 (8Ah), & Table 8-1=
3
> + * - Max voltage step (127): sec 4.2.18.1.2, Table 4-77 (89h), & Table 8=
-13
> + */
> +#define LMR_MAX_LANES                   32
> +#define LMR_MAX_RX_NUM                  6
> +#define LMR_MAX_TIMING_STEP             63
> +#define LMR_MAX_VOLTAGE_STEP            127
> +
> +/* LMR PCIe generation numbers and helper */
> +#define LMR_GEN6                        6
> +#define LMR_GEN5                        5
> +#define LMR_GEN4                        4
> +
> +#define LMR_SPEED_TO_GEN(speed) \
> +=09((speed) >=3D PCIE_SPEED_64_0GT ? LMR_GEN6 : \
> +=09 (speed) >=3D PCIE_SPEED_32_0GT ? LMR_GEN5 : \
> +=09 LMR_GEN4)
> +
> +/* LMR lane register stride */
> +#define LMR_LANE_REG_STRIDE             4
> +
> +/* LMR receivers and directions */
> +#define LMR_RX_LOCAL                    0
> +#define LMR_STEP_DIR_INCREASE           1
> +#define LMR_STEP_DIR_DECREASE           0
> +
> +/*
> + * Margining Payload field masks for Step Margin Timing and Step Margin =
Voltage
> + * per PCIe Base Specification Revision 7.0 sec 4.2.18.1.2
> + * ("Margin Payload for Step Margin Commands"):
> + *
> + * Step Margin Timing Payload:
> + *   Bit 7:    Reserved (must be 0b)
> + *   Bit 6:    Direction (0 =3D Left/Decrease, 1 =3D Right/Increase)
> + *   Bits 5:0: Margin Step (0..63)
> + *
> + * Step Margin Voltage Payload:
> + *   Bit 7:    Direction (0 =3D Down/Decrease, 1 =3D Up/Increase)
> + *   Bits 6:0: Margin Step (0..127)
> + */
> +#define LMR_TIMING_STEP_MASK=09=09GENMASK(5, 0)
> +#define LMR_TIMING_DIR_MASK=09=09BIT(6)
> +#define LMR_VOLTAGE_STEP_MASK=09=09GENMASK(6, 0)
> +#define LMR_VOLTAGE_DIR_MASK=09=09BIT(7)
> +
> +/*
> + * Margin Payload step direction field encodings per PCIe Base Specifica=
tion
> + * Revision 7.0 sec 4.2.18.1.2 ("Margin Payload for Step Margin Commands=
"):
> + *
> + * For timing:
> + *   Bit 6: 0b =3D Right of normal setting (also 0b Reserved for symmetr=
ic)
> + *          1b =3D Left of normal setting (when MIndLeftRightTiming is S=
et)
> + * For voltage:
> + *   Bit 7: 0b =3D Up from normal setting (also 0b Reserved for symmetri=
c)
> + *          1b =3D Down from normal setting (when MIndUpDownVoltage is S=
et)
> + */
> +#define LMR_STEP_DIR_RIGHT_OR_UP=090
> +#define LMR_STEP_DIR_LEFT_OR_DOWN=091
> +
> +/*
> + * Report Margin Control Capabilities (Command 88h) response payload bit=
 fields
> + * per PCIe Base Specification Revision 7.0 Table 4-77 & Table 8-13 (r6.=
0 Table 4-73 & Table 8-11):

Having the reference numbers for the latest spec version is enough.

> + *   Bit 0:   MVoltageSupported (1 =3D Voltage margining supported; 0 =
=3D Not supported)
> + *   Bit 1:   MIndUpDownVoltage (1 =3D Independent Up/Down voltage suppo=
rted; 0 =3D Symmetric)
> + *   Bit 2:   MIndLeftRightTiming (1 =3D Independent Left/Right timing s=
upported; 0 =3D Symmetric)
> + *   Bit 3:   MSampleReportingMethod (1 =3D Sampling rate supported; 0 =
=3D Sample count supported)
> + *   Bit 4:   MIndErrorSampler (1 =3D Independent error sampler; 0 =3D M=
ain data sampler)

Thanks, this is better now. I have to admit it's not entirely your fault=20
things are as confusing as they are (the spec could have been clearer when=
=20
it comes to defining these).

> + *   Bits 7:5: Reserved
> + */
> +#define LMR_CAP_VOLTAGE_SUPPORTED BIT(0)
> +#define LMR_CAP_IND_UP_DOWN_VOLTAGE BIT(1)
> +#define LMR_CAP_IND_LEFT_RIGHT_TIMING=09BIT(2)
> +#define LMR_CAP_SAMPLE_REPORT_METHOD BIT(3)
> +#define LMR_CAP_IND_ERROR_SAMPLER BIT(4)

Align all BIT()s.

> +
> +/*
> + * Step Margin Execution Status (Bits 7:6 of response payload per PCIe B=
ase
> + * Specification Revision 7.0 sec 4.2.18.1.1 "Step Margin Execution Stat=
us"):
> + * 00b: Too many errors - Receiver autonomously went back to default set=
tings
> + * 01b: Set up for margin in progress
> + * 10b: Margining in progress
> + * 11b: NAK - Unsupported Lane Margining command was issued
> + */
> +#define LMR_STS_EXEC_MASK GENMASK(7, 6)
> +#define LMR_STS_EXEC_TOO_MANY_ERR 0x0
> +#define LMR_STS_EXEC_SETUP_IN_PROGRESS 0x1
> +#define LMR_STS_EXEC_IN_PROGRESS 0x2
> +#define LMR_STS_EXEC_NAK 0x3
> +#define LMR_STS_ERR_CNT_MASK GENMASK(5, 0)
> +
> +/**
> + * struct pci_margin_rx_info - Cached Lane Margining receiver capabiliti=
es
> + * @caps_cached: True if receiver capabilities and step limits are cache=
d
> + * @caps: Margining capabilities byte reported by receiver
> + * @num_timing_steps: Maximum timing margin steps supported by receiver
> + * @num_voltage_steps: Maximum voltage margin steps supported by receive=
r
> + */
> +struct pci_margin_rx_info {
> +=09bool caps_cached;
> +=09u8 caps;
> +=09u8 num_timing_steps;
> +=09u8 num_voltage_steps;
> +};
> +
> +/**
> + * struct pci_margin_lane - Per-lane margining state
> + * @mdev: Parent LMR margin device
> + * @lane: Physical lane index (0..num_lanes - 1)
> + * @rx: Selected target receiver number (0 =3D local, 1..6 =3D retimers)
> + * @timing_val: Current applied timing margin step offset (+/-)
> + * @voltage_val: Current applied voltage margin step offset (+/-)
> + * @rx_info: Cached receiver capabilities per receiver number
> + */
> +struct pci_margin_lane {
> +=09struct pci_margin_dev *mdev;
> +=09int lane;
> +=09u8 rx;
> +=09int timing_val;
> +=09int voltage_val;
> +=09struct pci_margin_rx_info rx_info[LMR_MAX_RX_NUM + 1];
> +};
> +
> +/**
> + * struct pci_margin_dev - PCIe Lane Margining device instance
> + * @dev: Underlying PCI device
> + * @partner: Connected link partner device across the PCIe link
> + * @cap: Extended capability offset (PCI_EXT_CAP_ID_LMR)
> + * @debugfs: Root debugfs dentry for this device
> + * @lock: Mutex protecting LMR hardware access, active margining enablem=
ent,
> + *        target receiver selection, lane margining steps, and ASPM stat=
e
> + * @enabled: True if Lane Margining is currently enabled
> + * @aspm_saved: True if original ASPM configuration has been saved
> + * @saved_dsp_aspm: Saved ASPM control register bits for Downstream Port
> + * @saved_usp_aspm: Saved ASPM control register bits for Upstream Port
> + * @autonomous_saved: True if original autonomous width/speed configurat=
ion has been saved
> + * @saved_dsp_lnkctl: Saved Link Control register bits for Downstream Po=
rt
> + * @saved_dsp_lnkctl2: Saved Link Control 2 register bits for Downstream=
 Port
> + * @saved_usp_lnkctl: Saved Link Control register bits for Upstream Port
> + * @saved_usp_lnkctl2: Saved Link Control 2 register bits for Upstream P=
ort
> + * @num_lanes: Number of lanes on the link
> + * @lanes: Flexible array of per-lane state structures
> + */
> +struct pci_margin_dev {
> +=09struct pci_dev *dev;
> +=09struct pci_dev *partner;
> +=09u16 cap;
> +=09struct dentry *debugfs;
> +=09struct mutex lock;
> +=09bool enabled;
> +=09bool aspm_saved;
> +=09u16 saved_dsp_aspm;
> +=09u16 saved_usp_aspm;
> +=09bool autonomous_saved;
> +=09u16 saved_dsp_lnkctl;
> +=09u16 saved_dsp_lnkctl2;
> +=09u16 saved_usp_lnkctl;
> +=09u16 saved_usp_lnkctl2;
> +=09int num_lanes;
> +=09struct pci_margin_lane lanes[] __counted_by(num_lanes);
> +};
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static DEFINE_MUTEX(pci_debugfs_root_lock);
> +static struct dentry *pci_debugfs_root_dir;
> +
> +static struct dentry *get_pci_debugfs_root(void)
> +{
> +=09mutex_lock(&pci_debugfs_root_lock);
> +=09if (!pci_debugfs_root_dir)
> +=09=09pci_debugfs_root_dir =3D debugfs_lookup("pci", NULL);
> +=09if (!pci_debugfs_root_dir)
> +=09=09pci_debugfs_root_dir =3D debugfs_create_dir("pci", NULL);
> +=09mutex_unlock(&pci_debugfs_root_lock);
> +=09return pci_debugfs_root_dir;
> +}
> +#endif
> +
> +/*
> + * pci_lmr_get_link_partners() - Identify Downstream and Upstream Port l=
ink partners.
> + *
> + * For Root Ports and Switch Downstream Ports, @dev is the Downstream Po=
rt, and the
> + * connected device on the secondary bus is the Upstream Port.
> + * For Endpoints and Switch Upstream Ports, @dev is the Upstream Port, a=
nd the
> + * upstream bridge is the Downstream Port.
> + */
> +static void pci_lmr_get_link_partners(struct pci_dev *dev,
> +=09=09=09=09      struct pci_dev **downstream_port,
> +=09=09=09=09      struct pci_dev **upstream_port)
> +{
> +=09if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
> +=09=09*downstream_port =3D dev;
> +=09=09down_read(&pci_bus_sem);
> +=09=09*upstream_port =3D dev->subordinate ?
> +=09=09=09pci_dev_get(list_first_entry_or_null(&dev->subordinate->devices=
,
> +=09=09=09=09=09=09=09     struct pci_dev, bus_list)) : NULL;
> +=09=09up_read(&pci_bus_sem);
> +=09} else {
> +=09=09*downstream_port =3D pci_upstream_bridge(dev);
> +=09=09*upstream_port =3D dev;
> +=09}
> +}
> +
> +static void pci_lmr_put_link_partners(struct pci_dev *dev,
> +=09=09=09=09      struct pci_dev *downstream_port,
> +=09=09=09=09      struct pci_dev *upstream_port)
> +{
> +=09if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
> +=09=09if (upstream_port)
> +=09=09=09pci_dev_put(upstream_port);
> +=09}
> +}
> +
> +/*
> + * pci_lmr_get_ports() - Identify Downstream and Upstream Port link part=
ners
> + * using the already tracked mdev->dev and mdev->partner devices.
> + *
> + * For Root Ports and Switch Downstream Ports, @dev is the Downstream Po=
rt and
> + * @partner is the Upstream Port. For Endpoints and Switch Upstream Port=
s,
> + * @partner is the Downstream Port and @dev is the Upstream Port.
> + *
> + * Context: Called with mdev->lock held and partner already established.
> + * Does NOT acquire pci_bus_sem, preventing lock inversion deadlocks wit=
h
> + * device_lock.
> + */
> +static void pci_lmr_get_ports(struct pci_margin_dev *mdev,
> +=09=09=09      struct pci_dev **downstream_port,
> +=09=09=09      struct pci_dev **upstream_port)
> +{
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09struct pci_dev *partner =3D mdev->partner;
> +
> +=09if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
> +=09=09*downstream_port =3D dev;
> +=09=09*upstream_port =3D partner;
> +=09} else {
> +=09=09*downstream_port =3D partner;
> +=09=09*upstream_port =3D dev;
> +=09}
> +}

This feels like duplicating similar functionality with the aspm driver=20
that also wants to infer ends of the link when giving a pci_dev in. The=20
aspm driver currently does that within, but it kind of duplicating=20
pci_bus.

It would be nice to avoid the duplication and have something similar for=20
this in PCI core.

I'd have already tried to move it out of the aspm driver into pci_bus but=
=20
I highly suspect pci_bus is allocated too late for it to be trivial to=20
just embed link information into the struct pci_bus.

--
 i.

> +
> +/*
> + * pci_lmr_aspm_inhibit() - Inhibit or restore ASPM L0s/L1 during active=
 margining.
> + * PCIe Base Specification Revision 7.0 sec 7.5.3.7 ("Link Control Regis=
ter"):
> + * - To disable/inhibit ASPM, software on Downstream Component (Endpoint=
 / Upstream Port)
> + *   must disable ASPM prior to disabling ASPM on Upstream Component (Ro=
ot Port / Downstream Port).
> + * - To enable/restore ASPM, software on Upstream Component (Root Port /=
 Downstream Port)
> + *   must enable ASPM prior to enabling ASPM on Downstream Component (En=
dpoint / Upstream Port).
> + */
> +static void pci_lmr_aspm_inhibit(struct pci_margin_dev *mdev, bool inhib=
it)
> +{
> +=09struct pci_dev *downstream_port, *upstream_port;
> +=09struct pci_dev *partner =3D mdev->partner;
> +=09u16 ctl;
> +
> +=09pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
> +
> +=09if (inhibit) {
> +=09=09if (mdev->aspm_saved)
> +=09=09=09return;
> +
> +=09=09/*
> +=09=09 * If link partner already saved ASPM state, inherit it to
> +=09=09 * prevent overwriting with 0.
> +=09=09 */
> +=09=09if (partner && partner->lmr && partner->lmr->aspm_saved) {
> +=09=09=09mdev->saved_dsp_aspm =3D partner->lmr->saved_dsp_aspm;
> +=09=09=09mdev->saved_usp_aspm =3D partner->lmr->saved_usp_aspm;
> +=09=09=09mdev->aspm_saved =3D true;
> +=09=09=09return;
> +=09=09}
> +
> +=09=09/*
> +=09=09 * 1. Downstream Component (upstream_port) must be disabled
> +=09=09 * FIRST per sec 7.5.3.7.
> +=09=09 */
> +=09=09if (upstream_port && pci_is_pcie(upstream_port) &&
> +=09=09    upstream_port->current_state =3D=3D PCI_D0) {
> +=09=09=09if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &=
ctl)) {
> +=09=09=09=09mdev->saved_usp_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +=09=09=09=09pcie_capability_clear_word(upstream_port, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> +=09=09=09}
> +=09=09}
> +
> +=09=09/*
> +=09=09 * 2. Upstream Component (downstream_port) must be disabled
> +=09=09 * SECOND per sec 7.5.3.7.
> +=09=09 */
> +=09=09if (downstream_port && pci_is_pcie(downstream_port) &&
> +=09=09    downstream_port->current_state =3D=3D PCI_D0) {
> +=09=09=09if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL,=
 &ctl)) {
> +=09=09=09=09mdev->saved_dsp_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +=09=09=09=09pcie_capability_clear_word(downstream_port, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> +=09=09=09}
> +=09=09}
> +
> +=09=09mdev->aspm_saved =3D true;
> +
> +=09=09/*
> +=09=09 * Ensure link is settled in L0 mode per PCIe Base
> +=09=09 * Specification Revision 7.0 sec 8.4.4.
> +=09=09 */
> +=09=09usleep_range(2000, 3000);
> +=09} else {
> +=09=09if (!mdev->aspm_saved)
> +=09=09=09return;
> +
> +=09=09/*
> +=09=09 * 1. Upstream Component (downstream_port) MUST be restored
> +=09=09 * FIRST per sec 7.5.3.7.
> +=09=09 */
> +=09=09if (downstream_port && pci_is_pcie(downstream_port) &&
> +=09=09    downstream_port->current_state =3D=3D PCI_D0) {
> +=09=09=09pcie_capability_clear_and_set_word(
> +=09=09=09=09downstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC,
> +=09=09=09=09mdev->saved_dsp_aspm);
> +=09=09}
> +
> +=09=09/*
> +=09=09 * 2. Downstream Component (upstream_port) MUST be restored
> +=09=09 * SECOND per sec 7.5.3.7.
> +=09=09 */
> +=09=09if (upstream_port && pci_is_pcie(upstream_port) &&
> +=09=09    upstream_port->current_state =3D=3D PCI_D0) {
> +=09=09=09pcie_capability_clear_and_set_word(
> +=09=09=09=09upstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC,
> +=09=09=09=09mdev->saved_usp_aspm);
> +=09=09}
> +
> +=09=09mdev->aspm_saved =3D false;
> +=09}
> +}
> +
> +/*
> + * pci_lmr_ensure_aspm_inhibited() - Verify and re-enforce ASPM inhibit =
state.
> + *
> + * Checks both Downstream Port and Upstream Port to guarantee that out-o=
f-band
> + * OS events (e.g. background power transitions or sysfs modifications) =
have
> + * not unexpectedly re-enabled ASPM on either component. If ASPM was re-=
enabled,
> + * re-inhibits it in the spec-mandated order and waits for the link to s=
ettle
> + * in L0 before physical lane margin steps are executed.
> + */
> +static void pci_lmr_ensure_aspm_inhibited(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *downstream_port, *upstream_port;
> +=09u16 dsp_ctl =3D 0, usp_ctl =3D 0;
> +=09bool re_inhibit =3D false;
> +
> +=09pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
> +
> +=09if (upstream_port && pci_is_pcie(upstream_port)) {
> +=09=09if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &usp=
_ctl) &&
> +=09=09    (usp_ctl & PCI_EXP_LNKCTL_ASPMC))
> +=09=09=09re_inhibit =3D true;
> +=09}
> +
> +=09if (downstream_port && pci_is_pcie(downstream_port)) {
> +=09=09if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &d=
sp_ctl) &&
> +=09=09    (dsp_ctl & PCI_EXP_LNKCTL_ASPMC))
> +=09=09=09re_inhibit =3D true;
> +=09}
> +
> +=09if (re_inhibit) {
> +=09=09pci_info_ratelimited(mdev->dev,
> +=09=09=09=09     "ASPM re-enabled unexpectedly; re-enforcing ASPM inhibi=
t for LMR\n");
> +=09=09/* Disable Downstream Component first, Upstream Component second p=
er sec 7.5.3.7 */
> +=09=09if (upstream_port && pci_is_pcie(upstream_port))
> +=09=09=09pcie_capability_clear_word(upstream_port, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> +=09=09if (downstream_port && pci_is_pcie(downstream_port))
> +=09=09=09pcie_capability_clear_word(downstream_port, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> +=09=09/* Ensure link returns to and settles in L0 mode before proceeding=
 */
> +=09=09usleep_range(2000, 3000);
> +=09}
> +}
> +
> +/*
> + * Helpers to manage Autonomous Width/Speed transitions per PCIe Base Sp=
ecification Revision 7.0:
> + * - Section 7.5.3.7 "Link Control Register" (Hardware Autonomous Width =
Disable, bit 9)
> + * - Section 7.5.3.17 "Link Control 2 Register" (Hardware Autonomous Spe=
ed Disable, bit 5)
> + * - Section 4.2.18.4 "Receiver Margin Testing Requirements"
> + * - Section 8.4.4 "Lane Margining at the Receiver - Electrical Requirem=
ents"
> + *
> + * Both Downstream Port and Upstream Port must save and set Hardware Aut=
onomous
> + * Width Disable and Hardware Autonomous Speed Disable bits during margi=
ning to
> + * guarantee that the link remains in a stable active L0 state.
> + */
> +static void pci_lmr_disable_autonomous(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *downstream_port, *upstream_port;
> +=09struct pci_dev *partner =3D mdev->partner;
> +=09u16 lnkctl, lnkctl2;
> +
> +=09if (mdev->autonomous_saved)
> +=09=09return;
> +
> +=09/* If link partner already saved autonomous settings, inherit them */
> +=09if (partner && partner->lmr && partner->lmr->autonomous_saved) {
> +=09=09mdev->saved_dsp_lnkctl =3D partner->lmr->saved_dsp_lnkctl;
> +=09=09mdev->saved_dsp_lnkctl2 =3D partner->lmr->saved_dsp_lnkctl2;
> +=09=09mdev->saved_usp_lnkctl =3D partner->lmr->saved_usp_lnkctl;
> +=09=09mdev->saved_usp_lnkctl2 =3D partner->lmr->saved_usp_lnkctl2;
> +=09=09mdev->autonomous_saved =3D true;
> +=09=09return;
> +=09}
> +
> +=09pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
> +
> +=09/* 1. Downstream Component (upstream_port): Save and Disable FIRST */
> +=09if (upstream_port && pci_is_pcie(upstream_port) &&
> +=09    upstream_port->current_state =3D=3D PCI_D0) {
> +=09=09if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &lnk=
ctl)) {
> +=09=09=09mdev->saved_usp_lnkctl =3D lnkctl;
> +=09=09=09pcie_capability_set_word(upstream_port, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09 PCI_EXP_LNKCTL_HAWD);
> +=09=09}
> +
> +=09=09if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL2, &ln=
kctl2)) {
> +=09=09=09mdev->saved_usp_lnkctl2 =3D lnkctl2;
> +=09=09=09pcie_capability_set_word(upstream_port, PCI_EXP_LNKCTL2,
> +=09=09=09=09=09=09 PCI_EXP_LNKCTL2_HASD);
> +=09=09}
> +=09}
> +
> +=09/* 2. Upstream Component (downstream_port): Save and Disable SECOND *=
/
> +=09if (downstream_port && pci_is_pcie(downstream_port) &&
> +=09    downstream_port->current_state =3D=3D PCI_D0) {
> +=09=09if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &l=
nkctl)) {
> +=09=09=09mdev->saved_dsp_lnkctl =3D lnkctl;
> +=09=09=09pcie_capability_set_word(downstream_port, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09 PCI_EXP_LNKCTL_HAWD);
> +=09=09}
> +
> +=09=09if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL2, &=
lnkctl2)) {
> +=09=09=09mdev->saved_dsp_lnkctl2 =3D lnkctl2;
> +=09=09=09pcie_capability_set_word(downstream_port, PCI_EXP_LNKCTL2,
> +=09=09=09=09=09=09 PCI_EXP_LNKCTL2_HASD);
> +=09=09}
> +=09}
> +
> +=09mdev->autonomous_saved =3D true;
> +}
> +
> +static void pci_lmr_restore_autonomous(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *downstream_port, *upstream_port;
> +
> +=09if (!mdev->autonomous_saved)
> +=09=09return;
> +
> +=09pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
> +
> +=09/* 1. Upstream Component (downstream_port) restored FIRST */
> +=09if (downstream_port && pci_is_pcie(downstream_port) &&
> +=09    downstream_port->current_state =3D=3D PCI_D0) {
> +=09=09pcie_capability_clear_and_set_word(
> +=09=09=09downstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD,
> +=09=09=09mdev->saved_dsp_lnkctl & PCI_EXP_LNKCTL_HAWD);
> +=09=09pcie_capability_clear_and_set_word(
> +=09=09=09downstream_port, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD,
> +=09=09=09mdev->saved_dsp_lnkctl2 & PCI_EXP_LNKCTL2_HASD);
> +=09}
> +
> +=09/* 2. Downstream Component (upstream_port) restored SECOND */
> +=09if (upstream_port && pci_is_pcie(upstream_port) &&
> +=09    upstream_port->current_state =3D=3D PCI_D0) {
> +=09=09pcie_capability_clear_and_set_word(
> +=09=09=09upstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD,
> +=09=09=09mdev->saved_usp_lnkctl & PCI_EXP_LNKCTL_HAWD);
> +=09=09pcie_capability_clear_and_set_word(
> +=09=09=09upstream_port, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD,
> +=09=09=09mdev->saved_usp_lnkctl2 & PCI_EXP_LNKCTL2_HASD);
> +=09}
> +
> +=09mdev->autonomous_saved =3D false;
> +}
> +
> +static inline u8 pci_lmr_sts_payload(u16 sts)
> +{
> +=09return FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
> +}
> +
> +/*
> + * pci_lmr_run_cmd() - Issue LMR command to Lane Control and wait for St=
atus.
> + * Must be called with mdev->lock held.
> + */
> +static int pci_lmr_run_cmd(struct pci_margin_dev *mdev, int lane, u8 rx,=
 u8 type,
> +=09=09=09   u8 usage, u8 payload, u16 *status_val)
> +{
> +=09struct pci_dev *dev;
> +=09u16 lmr, ctrl_offset, sts_offset;
> +=09u16 ctrl, sts;
> +=09unsigned long timeout;
> +=09int ret;
> +
> +=09if (!mdev || lane < 0 || lane >=3D mdev->num_lanes || rx > LMR_MAX_RX=
_NUM)
> +=09=09return -EINVAL;
> +
> +=09dev =3D mdev->dev;
> +=09lmr =3D mdev->cap;
> +=09ctrl_offset =3D lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
> +=09sts_offset =3D lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
> +
> +=09/*
> +=09 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & Table 4-77
> +=09 * (r6.0 Table 4-73), software must issue NO_CMD (0x7) with payload
> +=09 * 0x9C targeting the specific receiver (rx) to clear MTYPE in Lane
> +=09 * Status before issuing a subsequent command.
> +=09 */
> +=09if (type !=3D LMR_TYPE_NO_CMD) {
> +=09=09ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
> +=09=09       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
> +=09=09       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
> +=09=09       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD,
> +=09=09=09=09  LMR_PAYLOAD_NO_CMD);
> +
> +=09=09ret =3D pci_write_config_word(dev, ctrl_offset, ctrl);
> +=09=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09=09return pcibios_err_to_errno(ret);
> +
> +=09=09timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
> +=09=09while (1) {
> +=09=09=09ret =3D pci_read_config_word(dev, sts_offset, &sts);
> +=09=09=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09=09=09return pcibios_err_to_errno(ret);
> +=09=09=09if (PCI_POSSIBLE_ERROR(sts))
> +=09=09=09=09return -ENODEV;
> +=09=09=09if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_C=
MD &&
> +=09=09=09    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
> +=09=09=09=09break;
> +=09=09=09if (time_after(jiffies, timeout))
> +=09=09=09=09return -ETIMEDOUT;
> +=09=09=09usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
> +=09=09}
> +=09}
> +
> +=09ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
> +=09       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, type) |
> +=09       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, usage) |
> +=09       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, payload);
> +
> +=09ret =3D pci_write_config_word(dev, ctrl_offset, ctrl);
> +=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09return pcibios_err_to_errno(ret);
> +
> +=09timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
> +=09while (1) {
> +=09=09ret =3D pci_read_config_word(dev, sts_offset, &sts);
> +=09=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09=09return pcibios_err_to_errno(ret);
> +=09=09if (PCI_POSSIBLE_ERROR(sts))
> +=09=09=09return -ENODEV;
> +
> +=09=09if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D type &&
> +=09=09    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx) {
> +=09=09=09if (status_val)
> +=09=09=09=09*status_val =3D sts;
> +=09=09=09return 0;
> +=09=09}
> +
> +=09=09if (time_after(jiffies, timeout)) {
> +=09=09=09/*
> +=09=09=09 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2
> +=09=09=09 * & Table 4-77 (r6.0 Table 4-73), if receiver echoes
> +=09=09=09 * NO_CMD (0x7) after command issuance, it indicates NAK.
> +=09=09=09 */
> +=09=09=09if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_C=
MD &&
> +=09=09=09    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
> +=09=09=09=09return -EOPNOTSUPP;
> +=09=09=09break;
> +=09=09}
> +
> +=09=09usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
> +=09}
> +
> +=09return -ETIMEDOUT;
> +}
> +
> +/*
> + * pci_lmr_clear_to_normal_lane() - Clear lane margin back to normal set=
tings
> + * per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & Table 4-77 (r=
6.0 Table 4-73).
> + * Issues Set Margining Parameters (MTYPE 010b) with "Go to Normal Setti=
ngs" (Payload 0x0F).
> + */
> +static int pci_lmr_clear_to_normal_lane(struct pci_margin_lane *plane)
> +{
> +=09u16 sts;
> +=09int ret;
> +
> +=09if (!plane || !plane->mdev)
> +=09=09return -EINVAL;
> +
> +=09ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, plane->rx,
> +=09=09=09      LMR_TYPE_SET_PARAMS, 0, LMR_PAYLOAD_GO_TO_NORMAL,
> +=09=09=09      &sts);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09plane->timing_val =3D 0;
> +=09plane->voltage_val =3D 0;
> +=09return 0;
> +}
> +
> +static int pci_lmr_cache_rx_info(struct pci_margin_lane *plane, u8 rx)
> +{
> +=09struct pci_margin_rx_info *info;
> +=09u16 sts;
> +=09int ret;
> +
> +=09if (!plane || rx > LMR_MAX_RX_NUM)
> +=09=09return -EINVAL;
> +
> +=09info =3D &plane->rx_info[rx];
> +
> +=09if (info->caps_cached)
> +=09=09return 0;
> +
> +=09/* Issuing REPORT_CAPS aborts active margin; clear to normal settings=
 */
> +=09ret =3D pci_lmr_clear_to_normal_lane(plane);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Report Capabilities: MTYPE 001b, Payload 0x88 */
> +=09ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
> +=09=09=09      LMR_TYPE_REPORT_CAPS, 0, LMR_PAYLOAD_REPORT_CAPS,
> +=09=09=09      &sts);
> +=09if (ret)
> +=09=09return ret;
> +=09info->caps =3D pci_lmr_sts_payload(sts);
> +
> +=09/* Report Timing Steps: MTYPE 001b, Payload 0x8A */
> +=09ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
> +=09=09=09      LMR_TYPE_REPORT_CAPS, 0,
> +=09=09=09      LMR_PAYLOAD_REPORT_TIM_STEPS, &sts);
> +=09if (ret)
> +=09=09return ret;
> +=09info->num_timing_steps =3D FIELD_GET(LMR_TIMING_STEP_MASK, pci_lmr_st=
s_payload(sts));
> +
> +=09/* Report Voltage Steps: MTYPE 001b, Payload 0x89 */
> +=09ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
> +=09=09=09      LMR_TYPE_REPORT_CAPS, 0,
> +=09=09=09      LMR_PAYLOAD_REPORT_VOLT_STEPS, &sts);
> +=09if (ret)
> +=09=09return ret;
> +=09info->num_voltage_steps =3D FIELD_GET(LMR_VOLTAGE_STEP_MASK, pci_lmr_=
sts_payload(sts));
> +
> +=09info->caps_cached =3D true;
> +=09return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +
> +static int margin_caps_show(struct seq_file *s, void *v)
> +{
> +=09struct pci_margin_dev *mdev =3D s->private;
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09u16 cap;
> +=09int ret;
> +
> +=09/* Wake the hardware and hold the PM reference before accessing regis=
ters */
> +=09ret =3D pm_runtime_resume_and_get(&dev->dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)=
;
> +=09pm_runtime_put_sync(&dev->dev);
> +
> +=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09return pcibios_err_to_errno(ret);
> +
> +=09seq_printf(s, "Port Capabilities: %#06x\n", cap);
> +=09seq_printf(s, "  Uses SW Ready: %s\n",
> +=09=09   str_yes_no(cap & PCI_LMR_PORT_CAP_USES_SW_READY));
> +=09return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_caps);
> +
> +static int margin_port_status_show(struct seq_file *s, void *v)
> +{
> +=09struct pci_margin_dev *mdev =3D s->private;
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09u16 sts;
> +=09int ret;
> +
> +=09/* Wake the hardware and hold the PM reference before accessing regis=
ters */
> +=09ret =3D pm_runtime_resume_and_get(&dev->dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)=
;
> +=09pm_runtime_put_sync(&dev->dev);
> +
> +=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09return pcibios_err_to_errno(ret);
> +
> +=09seq_printf(s, "Port Status: %#06x\n", sts);
> +=09seq_printf(s, "  Margining Ready: %s\n",
> +=09=09   str_yes_no(sts & PCI_LMR_PORT_STS_MARGIN_READY));
> +=09seq_printf(s, "  SW Ready: %s\n",
> +=09=09   str_yes_no(sts & PCI_LMR_PORT_STS_SW_READY));
> +=09return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_port_status);
> +
> +static int margin_enable_show(struct seq_file *s, void *v)
> +{
> +=09struct pci_margin_dev *mdev =3D s->private;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09seq_printf(s, "%d\n", mdev->enabled);
> +=09return 0;
> +}
> +
> +static void pci_lmr_disable_locked(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *dev;
> +=09int i, ret;
> +=09u16 sts;
> +
> +=09if (!mdev)
> +=09=09return;
> +
> +=09lockdep_assert_held(&mdev->lock);
> +
> +=09if (!mdev->enabled)
> +=09=09return;
> +
> +=09dev =3D mdev->dev;
> +
> +=09for (i =3D 0; i < mdev->num_lanes; i++)
> +=09=09pci_lmr_clear_to_normal_lane(&mdev->lanes[i]);
> +
> +=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)=
;
> +=09if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
> +=09=09sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09}
> +=09pci_lmr_aspm_inhibit(mdev, false);
> +=09pci_lmr_restore_autonomous(mdev);
> +
> +=09if (mdev->partner) {
> +=09=09pm_runtime_put_sync(&mdev->partner->dev);
> +=09=09pci_dev_put(mdev->partner);
> +=09=09mdev->partner =3D NULL;
> +=09}
> +
> +=09pm_runtime_put_sync(&dev->dev);
> +=09mdev->enabled =3D false;
> +}
> +
> +static int pci_lmr_enable_locked(struct pci_margin_dev *mdev,
> +=09=09=09=09 struct pci_dev *downstream_port,
> +=09=09=09=09 struct pci_dev *upstream_port)
> +{
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09struct pci_dev *partner =3D NULL;
> +=09unsigned long timeout;
> +=09u16 sts, cap, lnksta;
> +=09int ret, i;
> +
> +=09lockdep_assert_held(&mdev->lock);
> +
> +=09/* Ensure device is powered (D0) before reading configuration registe=
rs */
> +=09ret =3D pm_runtime_resume_and_get(&dev->dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09partner =3D (dev =3D=3D downstream_port) ? upstream_port : downstream=
_port;
> +
> +=09/* Prevent concurrent LMR on both ends of the same link */
> +=09if (partner && partner->lmr && partner->lmr->enabled) {
> +=09=09ret =3D -EBUSY;
> +=09=09goto err_rpm;
> +=09}
> +
> +=09if (partner) {
> +=09=09ret =3D pm_runtime_resume_and_get(&partner->dev);
> +=09=09if (ret < 0)
> +=09=09=09goto err_rpm;
> +=09=09mdev->partner =3D pci_dev_get(partner);
> +=09}
> +
> +=09/*
> +=09 * PCIe Base Specification Revision 7.0 sec 8.4.4: LMR is physically
> +=09 * undefined below 16.0 GT/s. Even if a device supports Gen4+, if the
> +=09 * link is currently trained and operating at Gen1..Gen3 speeds
> +=09 * (< 16.0 GT/s) in Link Status Register (sec 7.5.3.8, Current Link
> +=09 * Speed), reject margining.
> +=09 */
> +=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +=09if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB) {
> +=09=09ret =3D -EOPNOTSUPP;
> +=09=09goto err_partner_rpm;
> +=09}
> +
> +=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)=
;
> +=09if (ret !=3D PCIBIOS_SUCCESSFUL) {
> +=09=09ret =3D pcibios_err_to_errno(ret);
> +=09=09goto err_partner_rpm;
> +=09}
> +
> +=09/* Disable Autonomous Width and Speed transitions */
> +=09pci_lmr_disable_autonomous(mdev);
> +
> +=09/* Inhibit ASPM L0s/L1 during margining with restoration path */
> +=09pci_lmr_aspm_inhibit(mdev, true);
> +
> +=09if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +=09=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &s=
ts);
> +=09=09if (ret !=3D PCIBIOS_SUCCESSFUL) {
> +=09=09=09ret =3D pcibios_err_to_errno(ret);
> +=09=09=09goto err_aspm;
> +=09=09}
> +=09=09sts |=3D PCI_LMR_PORT_STS_SW_READY;
> +=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09}
> +
> +=09timeout =3D jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
> +=09while (1) {
> +=09=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &s=
ts);
> +=09=09if (ret !=3D PCIBIOS_SUCCESSFUL) {
> +=09=09=09ret =3D pcibios_err_to_errno(ret);
> +=09=09=09goto err_sw_ready;
> +=09=09}
> +=09=09if (PCI_POSSIBLE_ERROR(sts)) {
> +=09=09=09ret =3D -ENODEV;
> +=09=09=09goto err_sw_ready;
> +=09=09}
> +=09=09if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
> +=09=09=09break;
> +=09=09if (time_after(jiffies, timeout)) {
> +=09=09=09ret =3D -ETIMEDOUT;
> +=09=09=09goto err_sw_ready;
> +=09=09}
> +=09=09usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
> +=09}
> +
> +=09/* Cache capabilities for configured receiver on all lanes */
> +=09for (i =3D 0; i < mdev->num_lanes; i++) {
> +=09=09ret =3D pci_lmr_cache_rx_info(&mdev->lanes[i], mdev->lanes[i].rx);
> +=09=09if (ret)
> +=09=09=09goto err_sw_ready;
> +=09}
> +=09mdev->enabled =3D true;
> +=09return 0;
> +
> +err_sw_ready:
> +=09if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +=09=09u16 clean_sts;
> +=09=09int clean_ret;
> +
> +=09=09clean_ret =3D pci_read_config_word(
> +=09=09=09dev, mdev->cap + PCI_LMR_PORT_STS, &clean_sts);
> +=09=09if (clean_ret =3D=3D PCIBIOS_SUCCESSFUL) {
> +=09=09=09clean_sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +=09=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS,
> +=09=09=09=09=09      clean_sts);
> +=09=09}
> +=09}
> +err_aspm:
> +=09pci_lmr_aspm_inhibit(mdev, false);
> +=09pci_lmr_restore_autonomous(mdev);
> +err_partner_rpm:
> +=09if (mdev->partner) {
> +=09=09pm_runtime_put_sync(&mdev->partner->dev);
> +=09=09pci_dev_put(mdev->partner);
> +=09=09mdev->partner =3D NULL;
> +=09}
> +err_rpm:
> +=09pm_runtime_put_sync(&dev->dev);
> +=09return ret;
> +}
> +
> +static ssize_t margin_enable_write(struct file *file,
> +=09=09=09=09   const char __user *user_buf, size_t count,
> +=09=09=09=09   loff_t *ppos)
> +{
> +=09struct seq_file *s =3D file->private_data;
> +=09struct pci_margin_dev *mdev =3D s->private;
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09struct pci_dev *downstream_port, *upstream_port;
> +=09bool enable;
> +=09int ret;
> +
> +=09ret =3D kstrtobool_from_user(user_buf, count, &enable);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09pci_lmr_get_link_partners(dev, &downstream_port, &upstream_port);
> +
> +=09/* Strict hierarchical lock order: Downstream Port (parent) before Up=
stream Port (child) */
> +=09if (downstream_port)
> +=09=09pci_dev_lock(downstream_port);
> +=09if (upstream_port && upstream_port !=3D downstream_port)
> +=09=09pci_dev_lock(upstream_port);
> +
> +=09mutex_lock(&mdev->lock);
> +
> +=09if (mdev->enabled =3D=3D enable) {
> +=09=09ret =3D count;
> +=09} else if (!enable) {
> +=09=09pci_lmr_disable_locked(mdev);
> +=09=09ret =3D count;
> +=09} else {
> +=09=09ret =3D pci_lmr_enable_locked(mdev, downstream_port, upstream_port=
);
> +=09=09if (!ret)
> +=09=09=09ret =3D count;
> +=09}
> +
> +=09mutex_unlock(&mdev->lock);
> +
> +=09if (upstream_port && upstream_port !=3D downstream_port)
> +=09=09pci_dev_unlock(upstream_port);
> +=09if (downstream_port)
> +=09=09pci_dev_unlock(downstream_port);
> +
> +=09pci_lmr_put_link_partners(dev, downstream_port, upstream_port);
> +
> +=09return ret;
> +}
> +
> +static int margin_enable_open(struct inode *inode, struct file *file)
> +{
> +=09return single_open(file, margin_enable_show, inode->i_private);
> +}
> +
> +static const struct file_operations margin_enable_fops =3D {
> +=09.open =3D margin_enable_open,
> +=09.read =3D seq_read,
> +=09.write =3D margin_enable_write,
> +=09.llseek =3D seq_lseek,
> +=09.release =3D single_release,
> +};
> +
> +static int margin_lane_receiver_show(struct seq_file *s, void *v)
> +{
> +=09struct pci_margin_lane *plane =3D s->private;
> +
> +=09guard(mutex)(&plane->mdev->lock);
> +=09seq_printf(s, "%d\n", plane->rx);
> +=09return 0;
> +}
> +
> +static ssize_t margin_lane_receiver_write(struct file *file, const char =
__user *user_buf,
> +=09=09=09=09=09  size_t count, loff_t *ppos)
> +{
> +=09struct seq_file *s =3D file->private_data;
> +=09struct pci_margin_lane *plane =3D s->private;
> +=09struct pci_margin_dev *mdev =3D plane->mdev;
> +=09int ret;
> +=09u8 rx;
> +
> +=09ret =3D kstrtou8_from_user(user_buf, count, 0, &rx);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * Valid receiver numbers are 0..6 per PCIe Base Specification
> +=09 * Revision 7.0 sec 4.2.18.1 & Table 4-76 (r6.0 Table 4-72);
> +=09 * 7 is reserved.
> +=09 */
> +=09if (rx > LMR_MAX_RX_NUM)
> +=09=09return -EINVAL;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (plane->rx =3D=3D rx)
> +=09=09return count;
> +
> +=09if (mdev->enabled) {
> +=09=09/* Clear previous receiver to normal settings per single-receiver =
rule */
> +=09=09ret =3D pci_lmr_clear_to_normal_lane(plane);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09ret =3D pci_lmr_cache_rx_info(plane, rx);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09plane->rx =3D rx;
> +=09return count;
> +}
> +
> +static int margin_lane_receiver_open(struct inode *inode, struct file *f=
ile)
> +{
> +=09return single_open(file, margin_lane_receiver_show, inode->i_private)=
;
> +}
> +
> +static const struct file_operations margin_lane_receiver_fops =3D {
> +=09.open =3D margin_lane_receiver_open,
> +=09.read =3D seq_read,
> +=09.write =3D margin_lane_receiver_write,
> +=09.llseek =3D seq_lseek,
> +=09.release =3D single_release,
> +};
> +
> +static int margin_lane_caps_show(struct seq_file *s, void *v)
> +{
> +=09struct pci_margin_lane *plane =3D s->private;
> +=09struct pci_margin_dev *mdev =3D plane->mdev;
> +=09struct pci_margin_rx_info *info;
> +=09int ret;
> +=09u8 val;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (!mdev->enabled)
> +=09=09return -EBUSY;
> +
> +=09ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09info =3D &plane->rx_info[plane->rx];
> +=09val =3D info->caps;
> +=09seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, pla=
ne->rx, val);
> +=09seq_printf(s, "  Voltage Supported: %s\n",
> +=09=09   str_yes_no(val & LMR_CAP_VOLTAGE_SUPPORTED));
> +=09seq_printf(s, "  Left/Right: %s\n",
> +=09=09   (val & LMR_CAP_IND_LEFT_RIGHT_TIMING) ? "independent" : "symmet=
ric");
> +=09seq_printf(s, "  Up/Down: %s\n",
> +=09=09   (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) ? "independent" : "symmetri=
c");
> +=09seq_printf(s, "  Error Sampler: %s\n",
> +=09=09   (val & LMR_CAP_IND_ERROR_SAMPLER) ? "independent" :
> +=09=09=09=09=09=09       "main sampler");
> +=09seq_printf(s, "  Sample Reporting: %s\n",
> +=09=09   (val & LMR_CAP_SAMPLE_REPORT_METHOD) ? "rate" : "count");
> +=09return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
> +
> +static int margin_lane_steps_show(struct seq_file *s, u8 type)
> +{
> +=09struct pci_margin_lane *plane =3D s->private;
> +=09struct pci_margin_dev *mdev =3D plane->mdev;
> +=09struct pci_margin_rx_info *info;
> +=09int ret;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (!mdev->enabled)
> +=09=09return -EBUSY;
> +
> +=09ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09info =3D &plane->rx_info[plane->rx];
> +=09seq_printf(s, "%d\n", (type =3D=3D LMR_TYPE_VOLTAGE) ?
> +=09=09   info->num_voltage_steps : info->num_timing_steps);
> +=09return 0;
> +}
> +
> +static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_steps_show(s, LMR_TYPE_TIMING);
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
> +
> +static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_steps_show(s, LMR_TYPE_VOLTAGE);
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
> +
> +/*
> + * pci_lmr_check_sample_multiple_rx() - Check multi-receiver concurrency=
=2E
> + * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & sec 8.4.4:
> + * "For Receivers where MIndErrorSampler is 0b, at most one such Receive=
r is
> + * permitted to be margined at a time. However, margining may be perform=
ed on
> + * multiple Lanes simultaneously, as long as it is within the maximum nu=
mber of
> + * Lanes the device supports."
> + *
> + * If the target receiver uses an independent error sampler (MIndErrorSa=
mpler =3D=3D 1b),
> + * margining will not produce errors in the live data stream, and multip=
le receivers
> + * may be margined concurrently. If MIndErrorSampler is 0b (main data sa=
mpler),
> + * software must ensure that no other receiver on any lane is currently =
margined.
> + */
> +static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev=
,
> +=09=09=09=09=09     struct pci_margin_lane *plane)
> +{
> +=09struct pci_margin_rx_info *info =3D &plane->rx_info[plane->rx];
> +=09int i;
> +
> +=09/* If receiver has an independent error sampler, concurrent margining=
 is permitted */
> +=09if (info->caps & LMR_CAP_IND_ERROR_SAMPLER)
> +=09=09return true;
> +
> +=09for (i =3D 0; i < mdev->num_lanes; i++) {
> +=09=09struct pci_margin_lane *other =3D &mdev->lanes[i];
> +=09=09struct pci_margin_rx_info *other_info;
> +
> +=09=09if (i =3D=3D plane->lane)
> +=09=09=09continue;
> +
> +=09=09other_info =3D &other->rx_info[other->rx];
> +=09=09/*
> +=09=09 * For receivers using the main data sampler, reject only if anoth=
er lane
> +=09=09 * is actively margining a DIFFERENT receiver that ALSO uses the m=
ain data sampler.
> +=09=09 */
> +=09=09if (other->rx !=3D plane->rx &&
> +=09=09    !(other_info->caps & LMR_CAP_IND_ERROR_SAMPLER) &&
> +=09=09    (other->timing_val !=3D 0 || other->voltage_val !=3D 0))
> +=09=09=09return false;
> +=09}
> +=09return true;
> +}
> +
> +static ssize_t margin_lane_step_write(struct file *file, const char __us=
er *user_buf,
> +=09=09=09=09      size_t count, u8 type)
> +{
> +=09struct seq_file *s =3D file->private_data;
> +=09struct pci_margin_lane *plane =3D s->private;
> +=09struct pci_margin_dev *mdev =3D plane->mdev;
> +=09struct pci_margin_rx_info *info;
> +=09u8 step, dir, payload;
> +=09int max_step, val, ret;
> +=09u16 sts;
> +=09u8 caps;
> +
> +=09ret =3D kstrtoint_from_user(user_buf, count, 0, &val);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (!mdev->enabled)
> +=09=09return -EBUSY;
> +
> +=09/*
> +=09 * Ensure ASPM remains inhibited on both link partners before issuing
> +=09 * margin steps. PCIe Base Specification Revision 7.0 sec 8.4.4 requi=
res
> +=09 * the link to stay in L0.
> +=09 */
> +=09pci_lmr_ensure_aspm_inhibited(mdev);
> +
> +=09if (val =3D=3D 0) {
> +=09=09/* Step this specific axis to 0 without resetting the orthogonal a=
xis */
> +=09=09if (type =3D=3D LMR_TYPE_TIMING) {
> +=09=09=09if (plane->voltage_val =3D=3D 0) {
> +=09=09=09=09ret =3D pci_lmr_clear_to_normal_lane(plane);
> +=09=09=09} else {
> +=09=09=09=09ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
> +=09=09=09=09=09=09      LMR_TYPE_TIMING, 0, 0, &sts);
> +=09=09=09=09if (!ret)
> +=09=09=09=09=09plane->timing_val =3D 0;
> +=09=09=09}
> +=09=09} else {
> +=09=09=09if (plane->timing_val =3D=3D 0) {
> +=09=09=09=09ret =3D pci_lmr_clear_to_normal_lane(plane);
> +=09=09=09} else {
> +=09=09=09=09ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
> +=09=09=09=09=09=09      LMR_TYPE_VOLTAGE, 0, 0, &sts);
> +=09=09=09=09if (!ret)
> +=09=09=09=09=09plane->voltage_val =3D 0;
> +=09=09=09}
> +=09=09}
> +=09=09return ret ? ret : count;
> +=09}
> +
> +=09ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (!pci_lmr_check_sample_multiple_rx(mdev, plane))
> +=09=09return -EBUSY;
> +
> +=09info =3D &plane->rx_info[plane->rx];
> +=09caps =3D info->caps;
> +
> +=09switch (type) {
> +=09case LMR_TYPE_TIMING:
> +=09=09if (val < -LMR_MAX_TIMING_STEP || val > LMR_MAX_TIMING_STEP)
> +=09=09=09return -EINVAL;
> +=09=09if (val < 0) {
> +=09=09=09if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING))
> +=09=09=09=09return -EINVAL;
> +=09=09=09step =3D -val;
> +=09=09=09dir =3D LMR_STEP_DIR_LEFT_OR_DOWN; /* 1b: Left */
> +=09=09} else {
> +=09=09=09step =3D val;
> +=09=09=09dir =3D LMR_STEP_DIR_RIGHT_OR_UP; /* 0b: Right or Symmetric (Re=
served 0b) */
> +=09=09}
> +=09=09max_step =3D info->num_timing_steps;
> +=09=09if (step > max_step)
> +=09=09=09return -EINVAL;
> +
> +=09=09payload =3D FIELD_PREP(LMR_TIMING_DIR_MASK, dir) |
> +=09=09=09  FIELD_PREP(LMR_TIMING_STEP_MASK, step);
> +=09=09ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
> +=09=09=09=09      LMR_TYPE_TIMING, 0, payload, &sts);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
> +=09=09    LMR_STS_EXEC_NAK)
> +=09=09=09return -EOPNOTSUPP;
> +=09=09if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
> +=09=09    LMR_STS_EXEC_TOO_MANY_ERR) {
> +=09=09=09plane->timing_val =3D 0;
> +=09=09=09plane->voltage_val =3D 0;
> +=09=09=09return -EIO;
> +=09=09}
> +=09=09plane->timing_val =3D val;
> +=09=09break;
> +
> +=09case LMR_TYPE_VOLTAGE:
> +=09=09if (!(caps & LMR_CAP_VOLTAGE_SUPPORTED))
> +=09=09=09return -EOPNOTSUPP;
> +=09=09if (val < -LMR_MAX_VOLTAGE_STEP || val > LMR_MAX_VOLTAGE_STEP)
> +=09=09=09return -EINVAL;
> +=09=09if (val < 0) {
> +=09=09=09if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE))
> +=09=09=09=09return -EINVAL;
> +=09=09=09step =3D -val;
> +=09=09=09dir =3D LMR_STEP_DIR_LEFT_OR_DOWN; /* 1b: Down */
> +=09=09} else {
> +=09=09=09step =3D val;
> +=09=09=09dir =3D LMR_STEP_DIR_RIGHT_OR_UP; /* 0b: Up or Symmetric (Reser=
ved 0b) */
> +=09=09}
> +=09=09max_step =3D info->num_voltage_steps;
> +=09=09if (step > max_step)
> +=09=09=09return -EINVAL;
> +
> +=09=09payload =3D FIELD_PREP(LMR_VOLTAGE_DIR_MASK, dir) |
> +=09=09=09  FIELD_PREP(LMR_VOLTAGE_STEP_MASK, step);
> +=09=09ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
> +=09=09=09=09      LMR_TYPE_VOLTAGE, 0, payload, &sts);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
> +=09=09    LMR_STS_EXEC_NAK)
> +=09=09=09return -EOPNOTSUPP;
> +=09=09if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
> +=09=09    LMR_STS_EXEC_TOO_MANY_ERR) {
> +=09=09=09plane->timing_val =3D 0;
> +=09=09=09plane->voltage_val =3D 0;
> +=09=09=09return -EIO;
> +=09=09}
> +=09=09plane->voltage_val =3D val;
> +=09=09break;
> +
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +
> +=09return count;
> +}
> +
> +static ssize_t margin_lane_timing_write(struct file *file, const char __=
user *user_buf,
> +=09=09=09=09=09size_t count, loff_t *ppos)
> +{
> +=09return margin_lane_step_write(file, user_buf, count, LMR_TYPE_TIMING)=
;
> +}
> +
> +static int margin_lane_step_show(struct seq_file *s, u8 type)
> +{
> +=09struct pci_margin_lane *plane =3D s->private;
> +
> +=09guard(mutex)(&plane->mdev->lock);
> +=09seq_printf(s, "%d\n", (type =3D=3D LMR_TYPE_VOLTAGE) ?
> +=09=09   plane->voltage_val : plane->timing_val);
> +=09return 0;
> +}
> +
> +static int margin_lane_timing_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_step_show(s, LMR_TYPE_TIMING);
> +}
> +
> +static int margin_lane_timing_open(struct inode *inode, struct file *fil=
e)
> +{
> +=09return single_open(file, margin_lane_timing_show, inode->i_private);
> +}
> +
> +static const struct file_operations margin_lane_timing_fops =3D {
> +=09.open =3D margin_lane_timing_open,
> +=09.read =3D seq_read,
> +=09.write =3D margin_lane_timing_write,
> +=09.llseek =3D seq_lseek,
> +=09.release =3D single_release,
> +};
> +
> +static ssize_t margin_lane_voltage_write(struct file *file, const char _=
_user *user_buf,
> +=09=09=09=09=09 size_t count, loff_t *ppos)
> +{
> +=09return margin_lane_step_write(file, user_buf, count, LMR_TYPE_VOLTAGE=
);
> +}
> +
> +static int margin_lane_voltage_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_step_show(s, LMR_TYPE_VOLTAGE);
> +}
> +
> +static int margin_lane_voltage_open(struct inode *inode, struct file *fi=
le)
> +{
> +=09return single_open(file, margin_lane_voltage_show, inode->i_private);
> +}
> +
> +static const struct file_operations margin_lane_voltage_fops =3D {
> +=09.open =3D margin_lane_voltage_open,
> +=09.read =3D seq_read,
> +=09.write =3D margin_lane_voltage_write,
> +=09.llseek =3D seq_lseek,
> +=09.release =3D single_release,
> +};
> +
> +static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09struct dentry *parent;
> +=09char dirname[64];
> +=09int i;
> +
> +=09parent =3D get_pci_debugfs_root();
> +=09scnprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev=
));
> +=09mdev->debugfs =3D debugfs_create_dir(dirname, parent);
> +
> +=09debugfs_create_file("capabilities", 0444, mdev->debugfs, mdev, &margi=
n_caps_fops);
> +=09debugfs_create_file("port_status", 0444, mdev->debugfs, mdev, &margin=
_port_status_fops);
> +=09debugfs_create_file("enable", 0644, mdev->debugfs, mdev, &margin_enab=
le_fops);
> +
> +=09for (i =3D 0; i < mdev->num_lanes; i++) {
> +=09=09struct pci_margin_lane *plane =3D &mdev->lanes[i];
> +=09=09struct dentry *lane_dir;
> +=09=09char lane_name[16];
> +
> +=09=09scnprintf(lane_name, sizeof(lane_name), "lane%d", i);
> +=09=09lane_dir =3D debugfs_create_dir(lane_name, mdev->debugfs);
> +
> +=09=09debugfs_create_file("receiver", 0644, lane_dir, plane, &margin_lan=
e_receiver_fops);
> +=09=09debugfs_create_file("caps", 0444, lane_dir, plane, &margin_lane_ca=
ps_fops);
> +=09=09debugfs_create_file("num_timing_steps", 0444, lane_dir, plane,
> +=09=09=09=09    &margin_lane_timing_steps_fops);
> +=09=09debugfs_create_file("num_voltage_steps", 0444, lane_dir, plane,
> +=09=09=09=09    &margin_lane_voltage_steps_fops);
> +=09=09debugfs_create_file("margin_timing", 0644, lane_dir, plane,
> +=09=09=09=09    &margin_lane_timing_fops);
> +=09=09debugfs_create_file("margin_voltage", 0644, lane_dir, plane,
> +=09=09=09=09    &margin_lane_voltage_fops);
> +=09}
> +}
> +
> +static void pci_margin_debugfs_remove(struct pci_margin_dev *mdev)
> +{
> +=09debugfs_remove_recursive(mdev->debugfs);
> +}
> +
> +#else
> +static inline void pci_margin_debugfs_init(struct pci_margin_dev *mdev) =
{ }
> +static inline void pci_margin_debugfs_remove(struct pci_margin_dev *mdev=
) { }
> +#endif
> +
> +void pci_lmr_init(struct pci_dev *dev)
> +{
> +=09struct pci_margin_dev *mdev;
> +=09enum pci_bus_speed speed;
> +=09u32 lnkcap;
> +=09u16 lmr;
> +=09int num_lanes, ret, i;
> +
> +=09if (WARN_ON_ONCE(!dev) || !pci_is_pcie(dev))
> +=09=09return;
> +
> +=09/*
> +=09 * Per PCIe Base Specification Revision 7.0 sec 7.7.11:
> +=09 * For devices associated with an Upstream Port (Endpoints),
> +=09 * the Lane Margining Extended Capability must be implemented in
> +=09 * Function 0 (and only Function 0).
> +=09 */
> +=09if (pci_is_pcie(dev) && pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ENDPOI=
NT &&
> +=09    PCI_FUNC(dev->devfn) !=3D 0)
> +=09=09return;
> +
> +=09speed =3D pcie_get_speed_cap(dev);
> +=09if (speed < PCIE_SPEED_16_0GT || speed =3D=3D PCI_SPEED_UNKNOWN)
> +=09=09return;
> +
> +=09lmr =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LMR);
> +=09if (!lmr) {
> +=09=09if (speed >=3D PCIE_SPEED_64_0GT)
> +=09=09=09pci_warn(dev,
> +=09=09=09=09 "Missing Lane Margining at Receiver Capability (mandatory f=
or Gen6+)\n");
> +=09=09else
> +=09=09=09pci_dbg(dev,
> +=09=09=09=09"Optional Lane Margining at Receiver Capability not found\n"=
);
> +=09=09return;
> +=09}
> +
> +=09/*
> +=09 * Maximum Link Width (MLW) per PCIe Base Specification Revision 7.0 =
sec 7.5.3.6
> +=09 * ("Link Capabilities Register", bits 9:4).
> +=09 */
> +=09ret =3D pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +=09if (ret !=3D PCIBIOS_SUCCESSFUL)
> +=09=09return;
> +=09num_lanes =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
> +=09if (num_lanes =3D=3D 0 || num_lanes > LMR_MAX_LANES) {
> +=09=09pci_warn(dev, "Invalid link width %d for LMR\n", num_lanes);
> +=09=09return;
> +=09}
> +
> +=09dev->lmr_cap =3D lmr;
> +
> +=09mdev =3D kzalloc(struct_size(mdev, lanes, num_lanes), GFP_KERNEL);
> +=09if (!mdev)
> +=09=09return;
> +
> +=09mdev->num_lanes =3D num_lanes;
> +=09mdev->dev =3D dev;
> +=09mdev->cap =3D lmr;
> +=09mutex_init(&mdev->lock);
> +
> +=09for (i =3D 0; i < num_lanes; i++) {
> +=09=09mdev->lanes[i].mdev =3D mdev;
> +=09=09mdev->lanes[i].lane =3D i;
> +=09=09mdev->lanes[i].rx =3D LMR_RX_LOCAL;
> +=09}
> +
> +=09pci_margin_debugfs_init(mdev);
> +
> +=09dev->lmr =3D mdev;
> +
> +=09pci_dbg(dev, "Lane Margining at Receiver (Gen%u) Capability detected\=
n",
> +=09=09LMR_SPEED_TO_GEN(speed));
> +}
> +
> +void pci_lmr_exit(struct pci_dev *dev)
> +{
> +=09struct pci_margin_dev *mdev;
> +
> +=09if (!dev || !dev->lmr)
> +=09=09return;
> +
> +=09mdev =3D dev->lmr;
> +
> +=09/* 1. Tear down user-facing debugfs files FIRST to prevent concurrent=
 access */
> +=09pci_margin_debugfs_remove(mdev);
> +
> +=09/* 2. Disarm dev->lmr under device_lock to serialize with pci_reset_l=
mr */
> +=09pci_dev_lock(dev);
> +=09mdev =3D dev->lmr;
> +=09if (!mdev) {
> +=09=09pci_dev_unlock(dev);
> +=09=09return;
> +=09}
> +=09scoped_guard(mutex, &mdev->lock) {
> +=09=09dev->lmr =3D NULL;
> +=09=09pci_lmr_disable_locked(mdev);
> +=09}
> +=09pci_dev_unlock(dev);
> +
> +=09/* 3. Safe to destroy structures */
> +=09mutex_destroy(&mdev->lock);
> +=09kfree(mdev);
> +}
> +
> +void pci_suspend_lmr(struct pci_dev *dev)
> +{
> +=09struct pci_margin_dev *mdev =3D dev->lmr;
> +
> +=09if (!dev || !mdev)
> +=09=09return;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09pci_lmr_disable_locked(mdev);
> +}
> +
> +void pci_reset_lmr(struct pci_dev *dev)
> +{
> +=09struct pci_margin_dev *mdev;
> +=09u16 sts;
> +=09int ret, i;
> +
> +=09if (!dev || pci_dev_is_removed(dev))
> +=09=09return;
> +
> +=09device_lock_assert(&dev->dev);
> +
> +=09mdev =3D dev->lmr;
> +=09if (!mdev)
> +=09=09return;
> +
> +=09guard(mutex)
> +=09=09(&mdev->lock);
> +=09if (mdev->enabled) {
> +=09=09for (i =3D 0; i < mdev->num_lanes; i++) {
> +=09=09=09/*
> +=09=09=09 * FLR does not reset Physical Layer registers like LMR.
> +=09=09=09 * Return physical samplers to nominal in hardware to prevent
> +=09=09=09 * persistent receiver eye skew.
> +=09=09=09 */
> +=09=09=09pci_lmr_clear_to_normal_lane(&mdev->lanes[i]);
> +=09=09=09mdev->lanes[i].timing_val =3D 0;
> +=09=09=09mdev->lanes[i].voltage_val =3D 0;
> +=09=09}
> +
> +=09=09/* Clear SW_READY in hardware to reset margining state machine */
> +=09=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &s=
ts);
> +=09=09if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
> +=09=09=09sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +=09=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09=09}
> +
> +=09=09/* Restore original hardware ASPM before saved states can seal the=
 leak */
> +=09=09pci_lmr_aspm_inhibit(mdev, false);
> +=09=09pci_lmr_restore_autonomous(mdev);
> +
> +=09=09if (mdev->partner) {
> +=09=09=09/*
> +=09=09=09 * Drop remote partner's PM reference and schedule idle check
> +=09=09=09 * asynchronously so the partner does not remain stranded in
> +=09=09=09 * RPM_ACTIVE (D0) indefinitely.
> +=09=09=09 */
> +=09=09=09pm_runtime_put(&mdev->partner->dev);
> +=09=09=09pci_dev_put(mdev->partner);
> +=09=09=09mdev->partner =3D NULL;
> +=09=09}
> +
> +=09=09/*
> +=09=09 * Decrement runtime PM usage counter without triggering synchrono=
us
> +=09=09 * suspend, ensuring the device remains in D0 during pci_save_stat=
e()
> +=09=09 * and the subsequent reset sequence.
> +=09=09 */
> +=09=09pm_runtime_put_noidle(&dev->dev);
> +=09=09mdev->enabled =3D false;
> +=09}
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..352b95568ebf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2666,6 +2666,7 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)
>  =09pci_pasid_init(dev);=09=09/* Process Address Space ID */
>  =09pci_acs_init(dev);=09=09/* Access Control Services */
>  =09pci_ptm_init(dev);=09=09/* Precision Time Measurement */
> +=09pci_lmr_init(dev);=09=09/* Lane Margining at Receiver */
>  =09pci_aer_init(dev);=09=09/* Advanced Error Reporting */
>  =09pci_dpc_init(dev);=09=09/* Downstream Port Containment */
>  =09pci_rcec_init(dev);=09=09/* Root Complex Event Collector */
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d8bffa21498a..11f8d129d8ea 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -36,7 +36,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
> =20
>  =09pci_doe_sysfs_teardown(dev);
>  =09pci_npem_remove(dev);
> -
> +=09pci_lmr_exit(dev);
>  =09/*
>  =09 * While device is in D0 drop the device from TSM link operations
>  =09 * including unbind and disconnect (IDE + SPDM teardown).
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..ef1275f4c5b6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -349,6 +349,8 @@ struct rcec_ea;
>   *=09=09=09number resources to allow for hierarchy expansion.
>   * @is_pciehp:=09=09PCIe Hot-Plug Capable bridge.
>   */
> +struct pci_margin_dev;
> +
>  struct pci_dev {
>  =09struct list_head bus_list;=09/* Node in per-bus list */
>  =09struct pci_bus=09*bus;=09=09/* Bus this device is on */
> @@ -528,6 +530,10 @@ struct pci_dev {
>  =09atomic_t=09ptm_enable_cnt;
>  =09u8=09=09ptm_granularity;
>  #endif
> +#ifdef CONFIG_PCIE_LMR
> +=09u16=09=09=09lmr_cap;=09/* Lane Margining Capability */
> +=09struct pci_margin_dev=09*lmr;
> +#endif
>  #ifdef CONFIG_PCI_MSI
>  =09void __iomem=09*msix_base;
>  =09raw_spinlock_t=09msi_lock;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index facaa324bd86..90cbe310e62f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -757,6 +757,7 @@
>  #define PCI_EXT_CAP_ID_VF_REBAR 0x24=09/* VF Resizable BAR */
>  #define PCI_EXT_CAP_ID_DLF=090x25=09/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT=090x26=09/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_LMR=090x27=09/* Lane Margining at Receiver */
>  #define PCI_EXT_CAP_ID_NPEM=090x29=09/* Native PCIe Enclosure Management=
 */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE=090x2E=09/* Data Object Exchange */
> @@ -1181,6 +1182,23 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK=09=090x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT=094
> =20
> +/* Lane Margining at Receiver */
> +#define PCI_LMR_PORT_CAP=09=090x04=09/* Margining Port Capabilities */
> +#define  PCI_LMR_PORT_CAP_USES_SW_READY=090x0001=09/* Margining Uses Sof=
tware Ready */
> +#define PCI_LMR_PORT_STS=09=090x06=09/* Margining Port Status */
> +#define  PCI_LMR_PORT_STS_MARGIN_READY=090x0001=09/* Margining Ready */
> +#define  PCI_LMR_PORT_STS_SW_READY=090x0002=09/* Margining SW Ready */
> +#define PCI_LMR_LANE_CTRL=09=090x08=09/* Margining Lane Control */
> +#define  PCI_LMR_LANE_CTRL_RX_NUM=090x0007=09/* Receiver Number */
> +#define  PCI_LMR_LANE_CTRL_MTYPE=090x0038=09/* Margining Type */
> +#define  PCI_LMR_LANE_CTRL_USAGE=090x0040=09/* Margining Usage Model */
> +#define  PCI_LMR_LANE_CTRL_PAYLOAD=090xFF00=09/* Margining Payload */
> +#define PCI_LMR_LANE_STS=09=090x0A=09/* Margining Lane Status */
> +#define  PCI_LMR_LANE_STS_RX_NUM=090x0007=09/* Receiver Number */
> +#define  PCI_LMR_LANE_STS_MTYPE=09=090x0038=09/* Margining Type */
> +#define  PCI_LMR_LANE_STS_USAGE=09=090x0040=09/* Margining Usage Model *=
/
> +#define  PCI_LMR_LANE_STS_PAYLOAD=090xFF00=09/* Margining Payload */
> +
>  /* Physical Layer 32.0 GT/s */
>  #define PCI_PL_32GT_LE_CTRL=090x20=09/* Lane Equalization Control Regist=
er */
> =20
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 8a4b6ddc68df..6990d999388a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -91,6 +91,7 @@ TARGETS +=3D net/tcp_ao
>  TARGETS +=3D nolibc
>  TARGETS +=3D pci_endpoint
>  TARGETS +=3D pcie_bwctrl
> +TARGETS +=3D pcie_lmt
>  TARGETS +=3D perf_events
>  TARGETS +=3D pidfd
>  TARGETS +=3D pid_namespace
> diff --git a/tools/testing/selftests/pcie_lmt/Makefile b/tools/testing/se=
lftests/pcie_lmt/Makefile
> new file mode 100644
> index 000000000000..36ac85937d78
> --- /dev/null
> +++ b/tools/testing/selftests/pcie_lmt/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_PROGS =3D pcie_lmt.sh
> +include ../lib.mk
> diff --git a/tools/testing/selftests/pcie_lmt/pcie_lmt.sh b/tools/testing=
/selftests/pcie_lmt/pcie_lmt.sh
> new file mode 100755
> index 000000000000..22c00c2b8956
> --- /dev/null
> +++ b/tools/testing/selftests/pcie_lmt/pcie_lmt.sh
> @@ -0,0 +1,105 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2026 Google LLC
> +# Author: Priyank Rathod <rathodpriyank@google.com>
> +#
> +# Kselftest for PCIe Lane Margining at Receiver (LMR / LMT)
> +# Tests the debugfs interface exposed by drivers/pci/pcie/margin.c
> +# (/sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/)
> +
> +set -e
> +
> +TESTNAME=3D"pcie_lmt"
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=3D4
> +retval=3D0
> +skipmsg=3D"skip all tests:"
> +
> +if [ $UID !=3D 0 ]; then
> +=09echo "$skipmsg must be run as root" >&2
> +=09exit $ksft_skip
> +fi
> +
> +DEBUGFS=3D$(mount -t debugfs | head -1 | awk '{ print $3 }')
> +if [ -z "$DEBUGFS" ]; then
> +=09if [ -d "/sys/kernel/debug" ]; then
> +=09=09DEBUGFS=3D"/sys/kernel/debug"
> +=09else
> +=09=09echo "$skipmsg debugfs is not mounted" >&2
> +=09=09exit $ksft_skip
> +=09fi
> +fi
> +
> +if [ ! -d "$DEBUGFS/pci" ]; then
> +=09# Allow searching debugfs root or pci directory
> +=09:
> +fi
> +
> +LMR_DEVS=3D$(ls -d $DEBUGFS/pci/pcie_lmr_* $DEBUGFS/pcie_lmr_* 2>/dev/nu=
ll || true)
> +if [ -z "$LMR_DEVS" ]; then
> +=09echo "$skipmsg no PCIe LMR devices found in $DEBUGFS/" >&2
> +=09exit $ksft_skip
> +fi
> +
> +cleanup_dev()
> +{
> +=09local dev=3D"$1"
> +=09echo 0 > "$dev/enable" 2>/dev/null || true
> +}
> +
> +echo "$TESTNAME: testing PCIe LMR debugfs entries"
> +
> +for dev in $LMR_DEVS; do
> +=09dev_name=3D$(basename "$dev")
> +=09echo "$TESTNAME: probing device $dev_name"
> +
> +=09if [ ! -r "$dev/capabilities" ] || [ ! -r "$dev/port_status" ] ||
> +=09   [ ! -r "$dev/enable" ] || [ ! -w "$dev/enable" ]; then
> +=09=09echo "$TESTNAME: $dev_name missing mandatory root attributes"
> +=09=09retval=3D1
> +=09=09continue
> +=09fi
> +
> +=09caps=3D$(cat "$dev/capabilities")
> +=09status=3D$(cat "$dev/port_status")
> +=09echo "  $dev_name: capabilities read OK"
> +=09echo "  $dev_name: port_status read OK"
> +
> +=09trap 'cleanup_dev "$dev"' EXIT
> +
> +=09if ! echo 1 > "$dev/enable" 2>/dev/null; then
> +=09=09echo "  $dev_name: margining not ready by hardware (skipping activ=
e lanes)"
> +=09=09continue
> +=09fi
> +
> +=09echo "  $dev_name: margining enabled OK"
> +
> +=09for lane_dir in $(ls -d "$dev"/lane* 2>/dev/null || true); do
> +=09=09lane=3D$(basename "$lane_dir")
> +=09=09echo "  $dev_name: testing $lane"
> +
> +=09=09# Test setting receiver (Rx 0 is always local receiver)
> +=09=09echo 0 > "$lane_dir/receiver"
> +=09=09cat "$lane_dir/caps" > /dev/null
> +=09=09cat "$lane_dir/num_timing_steps" > /dev/null
> +=09=09cat "$lane_dir/num_voltage_steps" > /dev/null
> +
> +=09=09# Test resetting timing and voltage margin
> +=09=09echo 0 > "$lane_dir/margin_timing"
> +=09=09echo 0 > "$lane_dir/margin_voltage"
> +=09done
> +
> +=09echo 0 > "$dev/enable"
> +=09trap - EXIT
> +=09echo "  $dev_name: margining disabled OK"
> +done
> +
> +if [ $retval -eq 0 ]; then
> +=09echo "$TESTNAME [PASS]"
> +else
> +=09echo "$TESTNAME [FAIL]"
> +fi
> +
> +exit $retval
>=20
> ---
> base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> change-id: 20260818-pcie-lmt-3044d586aaec
>=20
> Best regards,
>=20

--=20
 i.

--8323328-957476827-1788190613=:2637--
