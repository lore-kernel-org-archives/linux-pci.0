Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF822370A;
	Tue, 25 Aug 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655768; cv=none; b=gVrh1lzyELSyCiBhh2gBbx81LGYqp7Yzs0RJNCztLGelQRKstnln0TmEclfCH1Wld4eproKMqytfz8qgwv7WaegaTt6CK/3o3B1ljzhnmffPpe9WHcL9ni6zW9i+9t4SwduzjzH9srW0w13Cq0jqyYc7MB/ntoC6UCPlUT9yYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655768; c=relaxed/simple;
	bh=ssRXVEMAlif2EcNFswy56JcuSnCCGbSB55Jkhj0Xyxc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JoasaLMYCLN+iMvIfon4UAJFBjVs6YDWPoeXyECjZfdYiuPY25XIC9Hp3YYVKN/n7C//6hwRwIpwt1GPWc80BQkCtjykANXHjH39/D9YuWsOdsBOZI7nIkdh1l5I9sdB8eaKKL0uKeCkj2G5ZyClnWQR2qEDWd+KhFr3un467iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVSMK+7I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVSMK+7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787655765; x=1819191765;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ssRXVEMAlif2EcNFswy56JcuSnCCGbSB55Jkhj0Xyxc=;
  b=VVSMK+7I555xfZBtQHilRbU7yALAlUKB9t7kE8vU2n6InWIq/iuU3pT/
   ZlnTOMDMGoCGNgmr1eFpjNu5BD1RO3pLGyzysFXZqoOHILQXicMAroBz7
   oZfwkDAywF7fx8GUgwFFdoRXIJXz3j+LHUu5CaXjDaKDpERGG2S34Z26t
   KH+nCaA2YIRwLx9O5/c6davxS60OAjWeRGqSQH+5Ls+lD3ZYADi+ysbOi
   VvrWBQUYVpJrRurEpga5sDkDwEY4GsKK/xGwQ+Ze5542Fl9VutTFe/cIH
   a8+XphD+tXr4D3KjQgb2dnzU5ilwJLmaB9jhIwZQJOW0mZd4BRi/AMPuo
   w==;
X-CSE-ConnectionGUID: ungMP83pQqSOrvkMgoiE/Q==
X-CSE-MsgGUID: MiqNX801SBuiZMLGKUrDAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88321323"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88321323"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 04:02:44 -0700
X-CSE-ConnectionGUID: flC90eFlSQiJ8o+dEyUFzQ==
X-CSE-MsgGUID: 01oyMW/NToOl06mdsQmP1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="270720385"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 04:02:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Aug 2026 14:02:35 +0300 (EEST)
To: Priyank Rathod <rathodpriyank@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>, 
    Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
In-Reply-To: <20260824-pcie-lmt-v6-1-bab4ce233fa5@google.com>
Message-ID: <9cf10f6d-9b77-e657-a5f9-7de9eeaea6d7@linux.intel.com>
References: <20260824-pcie-lmt-v6-1-bab4ce233fa5@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1733059533-1787655755=:1165"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1733059533-1787655755=:1165
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 24 Aug 2026, Priyank Rathod wrote:

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
>  Documentation/PCI/pcie-lmr.rst               |  171 +++++
>  MAINTAINERS                                  |    8 +
>  drivers/pci/pci-driver.c                     |    1 +
>  drivers/pci/pci.c                            |    4 +-
>  drivers/pci/pci.h                            |   12 +
>  drivers/pci/pcie/Kconfig                     |   12 +
>  drivers/pci/pcie/Makefile                    |    1 +
>  drivers/pci/pcie/margin.c                    | 1061 ++++++++++++++++++++=
++++++
>  drivers/pci/probe.c                          |    1 +
>  drivers/pci/remove.c                         |    1 +
>  include/linux/pci.h                          |    6 +
>  include/uapi/linux/pci_regs.h                |   18 +
>  tools/testing/selftests/Makefile             |    1 +
>  tools/testing/selftests/pcie_lmt/Makefile    |    3 +
>  tools/testing/selftests/pcie_lmt/pcie_lmt.sh |  105 +++
>  16 files changed, 1405 insertions(+), 1 deletion(-)
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
> index 000000000000..1ebb8317cc83
> --- /dev/null
> +++ b/Documentation/PCI/pcie-lmr.rst
> @@ -0,0 +1,171 @@
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
> +Specification (r6.0+ sec 8.4.4), allows system software to evaluate high=
-speed
> +link physical signal integrity and eye margins. LMR measures available t=
iming
> +(jitter/phase) and voltage margin offsets for each physical lane and rec=
eiver
> +independently while the link is operating in active L0 state.
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
> +  disables ASPM L0s/L1, and verifies that the link is operating at >=3D =
16.0 GT/s.
> +  Disabling margining restores ASPM and runtime PM, and returns all lane=
s to
> +  nominal (demargined) state.
> +
> +Lane-Level Attributes
> +---------------------
> +
> +For each physical lane (``lane0``, ``lane1``, ...):
> +
> +* ``receiver`` (read-write):
> +  Gets or sets the active target receiver number (``0`` for local receiv=
er,
> +  ``1..6`` for retimers). Switching receivers automatically demargins pr=
evious
> +  offsets per PCIe single-receiver margining requirements.
> +
> +* ``caps`` (read-only):
> +  Reports the target receiver's margining capabilities:
> +  - Margining uses Driver Software (vs hardware autonomous)
> +  - Independent Left/Right Timing Margining support
> +  - Independent Up/Down Voltage Margining support
> +  - Error Sampler vs Main Sampler
> +  - Sample Multiple Receivers support
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
> index f36778e62ac1..17544a7023fc 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -821,6 +821,7 @@ static int pci_pm_suspend(struct device *dev)
>  =09 * since Coffee Lake, to enter a lower-power PM state.
>  =09 */
>  =09pci_suspend_ptm(pci_dev);
> +=09pci_suspend_lmr(pci_dev);
> =20
>  =09if (pci_has_legacy_pm_support(pci_dev))
>  =09=09return pci_legacy_suspend(dev, PMSG_SUSPEND);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..dc9724cb7b4d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5145,8 +5145,10 @@ int __pci_reset_function_locked(struct pci_dev *de=
v)
>  =09=09method =3D &pci_reset_fn_methods[m];
>  =09=09pci_dbg(dev, "reset via %s\n", method->name);
>  =09=09rc =3D method->reset_fn(dev, PCI_RESET_DO_RESET);
> -=09=09if (!rc)
> +=09=09if (!rc) {
> +=09=09=09pci_reset_lmr(dev);
>  =09=09=09return 0;
> +=09=09}
> =20
>  =09=09pci_dbg(dev, "%s failed with %d\n", method->name, rc);
>  =09=09if (rc !=3D -ENOTTY)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4469e1a77f3c..6322a81f9e50 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1023,6 +1023,18 @@ static inline void pci_no_tph(void) { }
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
> index 000000000000..45646b5952d6
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
> @@ -0,0 +1,1061 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Express Lane Margining at Receiver
> + *
> + * Copyright (C) 2026 Google LLC
> + * Author: Priyank Rathod <rathodpriyank@google.com>
> + *
> + * Lane Margining at Receiver (PCIe Base Specification r6.0, sec 8.4.4)
> + * allows system software to determine the voltage and timing margins of
> + * each physical lane on a PCIe link. The Extended Capability (ID 0x27)
> + * is available for receivers operating at 16.0 GT/s (Gen4) or higher da=
ta
> + * rates, and is mandatory for receivers operating at 64.0 GT/s (Gen6) o=
r
> + * higher data rates.
> + *
> + * This driver implements:
> + *   - Probing Extended Capability ID 0x27 and Margining Port Capabiliti=
es.
> + *   - Managing ASPM L0s/L1 link states during active margining with res=
toration.
> + *   - PCIe r6.0 NO_CMD (0x7) clearing handshake per receiver and lane.
> + *   - Caching receiver capabilities & step counts to avoid DEMARGIN sid=
e-effects.
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
> +/* Margin type encodings per PCIe Base Spec r6.0 sec 8.4.4 */
> +#define LMR_TYPE_DEMARGIN               0x0
> +#define LMR_TYPE_REPORT_CAPS            0x1
> +#define LMR_TYPE_REPORT_VOLTAGE_STEPS   0x2
> +#define LMR_TYPE_REPORT_TIMING_STEPS    0x3
> +#define LMR_TYPE_TIMING                 0x4
> +#define LMR_TYPE_VOLTAGE                0x5
> +#define LMR_TYPE_NO_CMD                 0x7
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
> + * LMR limits:
> + * Valid receiver numbers are 0 (local receiver) to 6 (up to 3 retimers)
> + * per PCIe Base Specification r6.0 sec 8.4.4. Receiver number 7 is rese=
rved.
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
> +/* LMR payload field masks per PCIe Base Spec r6.0 sec 8.4.4 */
> +#define LMR_STEPS_MASK=09=09=09GENMASK(6, 0)
> +#define LMR_TIMING_STEP_MASK=09=09GENMASK(5, 0)
> +#define LMR_TIMING_DIR_MASK=09=09BIT(6)
> +#define LMR_VOLTAGE_STEP_MASK=09=09GENMASK(6, 0)
> +#define LMR_VOLTAGE_DIR_MASK=09=09BIT(7)
> +
> +/*
> + * Margining Capabilities report bit fields (PCIe Base Spec r6.0 sec 8.4=
=2E4,
> + * Table "Report Margining Capabilities Payload"):

In 8.4.4, my copy of r6.0.1 (and same with r7.0) PCIe spec, I only have=20
one table and that is called:

"Table 8-13 Lane Margining"

And no search finds "Report Margining Capabilities Payload" table anywhere.

=2E..So I still fail to find it.

(AI has tendencity to come up non-existing things, I hope it's not the=20
case here as it would be rather rude to waste reviewers time on chasing=20
non-existing things.)

> + * Bit 0: Margining Uses Driver Software (1 =3D Driver software sequence=
; 0 =3D Hardware)
> + * Bit 2: Independent Left/Right Timing Margining Supported (1 =3D Suppo=
rted; 0 =3D Symmetric)
> + * Bit 3: Independent Up/Down Voltage Margining Supported (1 =3D Support=
ed; 0 =3D Symmetric)
> + * Bit 4: Margining Error Sampler (1 =3D Error Sampler; 0 =3D Main Sampl=
er)
> + * Bit 5: Sample Multiple Receivers (1 =3D Multiple receivers; 0 =3D Sin=
gle receiver only)
> + */
> +#define LMR_CAP_USES_DRIVER_SW=09=09BIT(0)
> +#define LMR_CAP_IND_LEFT_RIGHT_TIMING=09BIT(2)
> +#define LMR_CAP_IND_UP_DOWN_VOLTAGE=09BIT(3)
> +#define LMR_CAP_ERROR_SAMPLER=09=09BIT(4)
> +#define LMR_CAP_SAMPLE_MULTIPLE_RX=09BIT(5)
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
> + * @cap: Extended capability offset (PCI_EXT_CAP_ID_LMR)
> + * @debugfs: Root debugfs dentry for this device
> + * @lock: Mutex protecting LMR hardware access, active margining enablem=
ent,
> + *        target receiver selection, lane margining steps, and ASPM stat=
e
> + * @enabled: True if Lane Margining is currently enabled
> + * @aspm_saved: True if original ASPM configuration has been saved
> + * @saved_aspm: Saved ASPM control register bits for the device
> + * @saved_parent_aspm: Saved ASPM control register bits for parent bridg=
e
> + * @num_lanes: Number of lanes on the link
> + * @lanes: Flexible array of per-lane state structures
> + */
> +struct pci_margin_dev {
> +=09struct pci_dev *dev;
> +=09u16 cap;
> +=09struct dentry *debugfs;
> +=09struct mutex lock;
> +=09bool enabled;
> +=09bool aspm_saved;
> +=09u16 saved_aspm;
> +=09u16 saved_parent_aspm;
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
> + * pci_lmr_disable_aspm() - Temporarily disable ASPM L0s/L1 during activ=
e
> + * margining per PCIe Base Spec r6.0 sec 8.4.4, saving original ASPMC bi=
ts.
> + */
> +static void pci_lmr_disable_aspm(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09struct pci_dev *parent =3D pci_upstream_bridge(dev);
> +=09u16 ctl;
> +
> +=09if (mdev->aspm_saved)
> +=09=09return;
> +
> +=09if (!pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &ctl)) {
> +=09=09mdev->saved_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +=09=09pcie_capability_clear_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASP=
MC);
> +=09}
> +
> +=09if (parent && pci_is_pcie(parent)) {
> +=09=09if (!pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &ctl)) {
> +=09=09=09mdev->saved_parent_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +=09=09=09pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKC=
TL_ASPMC);
> +=09=09}
> +=09}
> +=09mdev->aspm_saved =3D true;

Since you ignored my previous inquiry, I'm asking again...

How exactly you intend to prevent the aspm driver from re-enabling ASPM=20
while this driver wants it to remain off?

> +}
> +
> +/*
> + * pci_lmr_restore_aspm() - Restore original ASPM L0s/L1 state when marg=
ining
> + * is disabled or torn down.
> + */
> +static void pci_lmr_restore_aspm(struct pci_margin_dev *mdev)
> +{
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09struct pci_dev *parent =3D pci_upstream_bridge(dev);
> +
> +=09if (!mdev->aspm_saved)
> +=09=09return;
> +
> +=09pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> +=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC,
> +=09=09=09=09=09   mdev->saved_aspm);
> +=09if (parent && pci_is_pcie(parent))
> +=09=09pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> +=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC,
> +=09=09=09=09=09=09   mdev->saved_parent_aspm);
> +=09mdev->aspm_saved =3D false;
> +}



> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +=09=09=09=09   size_t count, loff_t *ppos)
> +{
> +=09struct seq_file *s =3D file->private_data;
> +=09struct pci_margin_dev *mdev =3D s->private;
> +=09struct pci_dev *dev =3D mdev->dev;
> +=09unsigned long timeout;
> +=09u16 sts, cap, lnksta;
> +=09bool enable;
> +=09int ret, i;
> +
> +=09ret =3D kstrtobool_from_user(user_buf, count, &enable);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09guard(mutex)(&mdev->lock);
> +
> +=09if (mdev->enabled =3D=3D enable)
> +=09=09return count;
> +
> +=09if (!enable) {
> +=09=09pci_lmr_disable_locked(mdev);
> +=09=09return count;
> +=09}
> +
> +=09/* Ensure device is powered (D0) before reading configuration registe=
rs */
> +=09ret =3D pm_runtime_resume_and_get(&dev->dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09/*
> +=09 * PCIe r6.0 sec 8.4.4: LMR is physically undefined below 16.0 GT/s.
> +=09 * Even if a device supports Gen4+, if the link is currently trained
> +=09 * and operating at Gen1..Gen3 speeds (< 16.0 GT/s), reject margining=
=2E
> +=09 */
> +=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +=09if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB) {
> +=09=09ret =3D -EOPNOTSUPP;
> +=09=09goto err_rpm;
> +=09}
> +
> +=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)=
;
> +=09if (ret !=3D PCIBIOS_SUCCESSFUL) {
> +=09=09ret =3D pcibios_err_to_errno(ret);
> +=09=09goto err_rpm;
> +=09}
> +
> +=09/* Disable ASPM L0s/L1 during margining with restoration path */
> +=09pci_lmr_disable_aspm(mdev);

What about the other steps besides ASPM that the spec required to be=20
disabled during Lane Margining?

> +=09/* Ensure link is settled in L0 mode per PCIe r6.0 sec 8.4.4 */
> +=09usleep_range(2000, 3000);
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
> +=09return count;
> +
> +err_sw_ready:
> +=09if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +=09=09ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &s=
ts);
> +=09=09if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
> +=09=09=09sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +=09=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09=09}
> +=09}
> +err_aspm:
> +=09pci_lmr_restore_aspm(mdev);
> +err_rpm:
> +=09pm_runtime_put_sync(&dev->dev);
> +=09return ret;
> +}


--=20
 i.

--8323328-1733059533-1787655755=:1165--
