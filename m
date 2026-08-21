Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764F394490;
	Fri, 21 Aug 2026 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310066; cv=none; b=SIrWndtKhwbZZvK0qaXK+U9EL3xRBKf8tS+85MoKznEvTRUI8MinyZtd1bEWW78/w6DDWYFUtNfqLcs7UUurNggAZ2Mide18T8dABY5pVsBNtdDwzwDaQS4wX6wgjDzuiV0QvtXzGDoqETGn29mB/XuDMnUjsSo7WwEM5zECabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310066; c=relaxed/simple;
	bh=cjekwS2vjAiDifewDknA7hRhhRZrL+rMrWni8bXm2CU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dheEpr8ItIbafgQTLRM1ldUuytIY9ZusngRUl2vooIILfUp23gLp3SbiOP4tBmg1kgX3OtmUtj5+w3cWdW7ke0zDfN1PHoLWLEJVbLj133C3EFqLp+UafvfE3PTnMUsakkzV/Lj/P8bsiM+N9LInwPOdz5xVszTFeFEcCmXow/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfgOVU7f; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfgOVU7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787310064; x=1818846064;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=cjekwS2vjAiDifewDknA7hRhhRZrL+rMrWni8bXm2CU=;
  b=nfgOVU7f/q8hmZn2VjLwe6DaP3g54ypdPNe36V3vhDeaIEWueZSFeawF
   4Q8mUoq9aHjEdf8hAddq152z4o7sHLOR/XZk2T9W6lPiYrOipBjaRLVHR
   nPE4j2V7GpN4N781Dybvx/E8j309OIRI2fY8GEHuk16IZvMLD05lqs6Ea
   43s1L/9iQl0uJnT/4mqrjpKRym/WgZEFgPcEiubHhYURQV8lJN9uD1boy
   dgAf/HyMBhOy1nbMXydRHTmjGEKiH+ky+mqn7BqLMppcAU/BlDQi4uElM
   8j/L0wuPSqZldLBX3dc2Ngpw2gqMLBP4b9nnmEMRWRJPaNvD1TQ10rWKx
   Q==;
X-CSE-ConnectionGUID: y6FtwJzoTvKyDNJfsYx+6Q==
X-CSE-MsgGUID: 40Jrg+D7T0OX9onefb8eOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87874859"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87874859"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 04:01:03 -0700
X-CSE-ConnectionGUID: 8lhOsRB1TH+INaqQB2DIIw==
X-CSE-MsgGUID: HSIb5i89TN+r22F7ApbY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="270129928"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 04:00:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Aug 2026 14:00:55 +0300 (EEST)
To: Priyank Rathod <rathodpriyank@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>, 
    Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
In-Reply-To: <20260820-pcie-lmt-v5-1-943b3b0e18bf@google.com>
Message-ID: <de01b370-75d4-ae77-bf84-30fed247239a@linux.intel.com>
References: <20260820-pcie-lmt-v5-1-943b3b0e18bf@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1781632769-1787302182=:1195"
Content-ID: <c8968ca7-04d4-86e2-d53a-524b0e01c2ce@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1781632769-1787302182=:1195
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <85f3cc57-3aef-f120-3cf2-d2f1c1788889@linux.intel.com>

On Thu, 20 Aug 2026, Priyank Rathod wrote:

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

How about moving this guide into somewhere under Documentation/ ? It seems=
=20
wasted effort if it is only available in the archives after the patch gets=
=20
accepted.

> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shuah Khan <shuah@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Changes in v5:
>   - Sorted #include directives alphabetically and added missing includes =
for bits.h, bitfield.h, cleanup.h, overflow.h, and slab.h (Ilpo J=E4rvinen)=
=2E
>   - Converted bitmasks to GENMASK() and BIT() macros and used FIELD_PREP(=
) and FIELD_GET() instead of manual bit shifts (Ilpo J=E4rvinen).
>   - Added pci_lmr_sts_payload() helper to cleanly extract the status payl=
oad byte before applying step and capability masks (Ilpo J=E4rvinen).
>   - Replaced manual mutex locking sequences with guard(mutex)(&mdev->lock=
) across show and write callbacks to simplify control flow (Ilpo J=E4rvinen=
).
>   - Documented mutex lock protection scope in kerneldoc for struct pci_ma=
rgin_dev (Ilpo J=E4rvinen).
>   - Used standard PCI_POSSIBLE_ERROR(), str_yes_no(), and scnprintf() hel=
pers throughout the driver (Ilpo J=E4rvinen).
>   - Clarified receiver range (0..6 per PCIe r6.0 sec 8.4.4; 7 reserved) i=
n comments and validation checks (Ilpo J=E4rvinen).
>   - Deduplicated timing and voltage show/write handlers using margin_lane=
_steps_show() and margin_lane_step_write() (Ilpo J=E4rvinen).
>   - Placed speed check immediately following pcie_get_speed_cap() and han=
dled PCI_SPEED_UNKNOWN (Ilpo J=E4rvinen).
>   - Converted lanes in struct pci_margin_dev to a flexible array member w=
ith __counted_by(num_lanes) allocated via struct_size() (Ilpo J=E4rvinen).
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
>  MAINTAINERS                                  |   7 +
>  drivers/pci/pci-driver.c                     |   1 +
>  drivers/pci/pci.c                            |   4 +-
>  drivers/pci/pci.h                            |  12 +
>  drivers/pci/pcie/Kconfig                     |  12 +
>  drivers/pci/pcie/Makefile                    |   1 +
>  drivers/pci/pcie/margin.c                    | 970 +++++++++++++++++++++=
++++++
>  drivers/pci/probe.c                          |   1 +
>  drivers/pci/remove.c                         |   1 +
>  include/linux/pci.h                          |   6 +
>  include/uapi/linux/pci_regs.h                |  18 +
>  tools/testing/selftests/Makefile             |   1 +
>  tools/testing/selftests/pcie_lmt/Makefile    |   3 +
>  tools/testing/selftests/pcie_lmt/pcie_lmt.sh | 105 +++
>  14 files changed, 1141 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7094a616afd..2935b624ac67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21059,6 +21059,13 @@ F:=09Documentation/devicetree/bindings/pci/qcom,=
sa8255p-pcie-ep.yaml
>  F:=09drivers/pci/controller/dwc/pcie-qcom-common.c
>  F:=09drivers/pci/controller/dwc/pcie-qcom-ep.c
> =20
> +PCIE LANE MARGINING AT RECEIVER (LMR)
> +M:=09Priyank Rathod <rathodpriyank@google.com>
> +L:=09linux-pci@vger.kernel.org
> +S:=09Maintained
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
> index 000000000000..59649ed7dc4f
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
> @@ -0,0 +1,970 @@
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
> +/* LMR capabilities report bit fields */
> +#define LMR_CAP_MARGIN_HV=09=09BIT(0)
> +#define LMR_CAP_MARGIN_EV_IV=09=09BIT(1)
> +#define LMR_CAP_IND_LEFT_RIGHT_TIMING=09BIT(2)
> +#define LMR_CAP_IND_UP_DOWN_VOLTAGE=09BIT(3)
> +#define LMR_CAP_ERROR_SAMPLER=09=09BIT(4)
> +#define LMR_CAP_SAMPLE_MULTIPLE_RX=09BIT(5)

I just cannot find these from r7.0 spec. Where these are? Or does your=20
naming differ so much from the spec names that I cannot make the=20
connection?

I can sort of find LMR_CAP_IND_LEFT_RIGHT_TIMING,=20
LMR_CAP_IND_UP_DOWN_VOLTAGE and LMR_CAP_ERROR_SAMPLER from 8.4.4 but no=20
idea about the rest.

(I got here when trying to figure out what LMR_CAP_SAMPLE_MULTIPLE_RX=20
does and I'm no the wiser after spending considerable time reading the=20
spec.)

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

I suspect it would be better to perform ASPMC changes through aspm driver.

There's also a pending series to improve ASPM interfaces to actually=20
allow lifting disabled restrictions which may be useful for this case as=20
well.

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
> +static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type=
,
> +=09=09=09   u8 usage, u8 payload, u16 *status_val)
> +{
> +=09u16 lmr, ctrl_offset, sts_offset;
> +=09u16 ctrl, sts;
> +=09unsigned long timeout;
> +
> +=09if (!dev || !dev->lmr || lane < 0 || lane >=3D dev->lmr->num_lanes ||

Can dev ever be NULL? It always comes from mdev->dev and that is assigned=
=20
to right after creating mdev. (I suppose sashiko might have incorrectly=20
requested it but we don't do clearly unnecessary NULL checks in kernel=20
for internal interfaces.)

Also, I don't like the interface. This function wants to check=20
dev->lmr->num_lanes so it would feel more natural to pass to pass mdev=20
directly from the caller instead of pci_dev.

> +=09    rx > LMR_MAX_RX_NUM)
> +=09=09return -EINVAL;
> +
> +=09lmr =3D dev->lmr_cap;
> +=09ctrl_offset =3D lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
> +=09sts_offset =3D lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
> +
> +=09/*
> +=09 * Per PCIe Base Spec r6.0 sec 8.4.4, software must issue NO_CMD (0x7=
)
> +=09 * targeting the specific receiver (rx) to clear MTYPE in Lane Status
> +=09 * before issuing a subsequent command.
> +=09 */
> +=09if (type !=3D LMR_TYPE_NO_CMD) {
> +=09=09ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
> +=09=09       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
> +=09=09       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
> +=09=09       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, 0);
> +
> +=09=09pci_write_config_word(dev, ctrl_offset, ctrl);
> +
> +=09=09timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
> +=09=09while (1) {
> +=09=09=09if (pci_read_config_word(dev, sts_offset, &sts))
> +=09=09=09=09return -EIO;

Please use:

=09=09=09ret =3D pci_read_config_word(dev, sts_offset, &sts);
=09=09=09if (ret !=3D PCIBIOS_SUCCESSFUL)
=09=09=09=09return pcibios_err_to_errno(ret);

There may be similar cases elsewhere.

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
> +=09pci_write_config_word(dev, ctrl_offset, ctrl);
> +
> +=09timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
> +=09while (1) {
> +=09=09if (pci_read_config_word(dev, sts_offset, &sts))
> +=09=09=09return -EIO;
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
> +=09=09/*
> +=09=09 * Per PCIe Base Spec r6.0 sec 8.4.4, if receiver echoes NO_CMD (0=
x7)
> +=09=09 * after a command was sent, it indicates command rejection/NAK.
> +=09=09 */
> +=09=09if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD =
&&
> +=09=09    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
> +=09=09=09return -EOPNOTSUPP;
> +
> +=09=09if (time_after(jiffies, timeout))
> +=09=09=09break;
> +
> +=09=09usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
> +=09}
> +
> +=09return -ETIMEDOUT;
> +}
> +
> +static int pci_lmr_demargin_lane(struct pci_margin_lane *plane)
> +{
> +=09u16 sts;
> +=09int ret;
> +
> +=09if (!plane || !plane->mdev)
> +=09=09return -EINVAL;
> +
> +=09if (plane->timing_val =3D=3D 0 && plane->voltage_val =3D=3D 0)
> +=09=09return 0;
> +
> +=09ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, plane->rx,
> +=09=09=09      LMR_TYPE_DEMARGIN, 0, 0, &sts);
> +=09if (!ret) {
> +=09=09plane->timing_val =3D 0;
> +=09=09plane->voltage_val =3D 0;
> +=09}
> +=09return ret;

Please reverse the logic so that error handling returns immediately.

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
> +=09/* Issuing REPORT_CAPS aborts any active margin per PCIe spec */
> +=09ret =3D pci_lmr_demargin_lane(plane);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
> +=09=09=09      LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
> +=09if (ret)
> +=09=09return ret;
> +=09info->caps =3D pci_lmr_sts_payload(sts);
> +
> +=09ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
> +=09=09=09      LMR_TYPE_REPORT_TIMING_STEPS, 0, 0, &sts);
> +=09if (ret)
> +=09=09return ret;
> +=09info->num_timing_steps =3D FIELD_GET(LMR_STEPS_MASK, pci_lmr_sts_payl=
oad(sts));
> +
> +=09ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
> +=09=09=09      LMR_TYPE_REPORT_VOLTAGE_STEPS, 0, 0, &sts);
> +=09if (ret)
> +=09=09return ret;
> +=09info->num_voltage_steps =3D FIELD_GET(LMR_STEPS_MASK, pci_lmr_sts_pay=
load(sts));
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
> +
> +=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap))
> +=09=09return -EIO;
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
> +
> +=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts))
> +=09=09return -EIO;
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
> +static void __pci_suspend_lmr_locked(struct pci_dev *dev)

This seems to be called from non-suspend paths but the naming misleadingly=
=20
collides with suspend/resume terminology.

So this is just "disable lane margining" and has nothing to do with=20
suspend?

For any _locked function, please add a lockdep assert to ensure the=20
required lock is always held.

> +{
> +=09struct pci_margin_dev *mdev =3D dev->lmr;
> +=09int i;
> +=09u16 sts;
> +
> +=09if (!mdev || !mdev->enabled)
> +=09=09return;
> +
> +=09for (i =3D 0; i < mdev->num_lanes; i++)
> +=09=09pci_lmr_demargin_lane(&mdev->lanes[i]);
> +
> +=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=
=3D 0) {

=3D=3D PCIBIOS_SUCCESSFUL

Use ret variable to avoid making line very long.

> +=09=09sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09}
> +=09pci_lmr_restore_aspm(mdev);
> +=09pm_runtime_put(&dev->dev);
> +=09mdev->enabled =3D false;

So the lack of resume function implies that Lane Margining user enabled=20
will always get auto-disabled on suspend and not re-enabled from resume?

Is that intentional?

Is that preferrable?

If yes, is that documented?

> +}
> +
> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +=09=09=09       size_t count, loff_t *ppos)
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
> +=09=09__pci_suspend_lmr_locked(dev);
> +=09=09return count;
> +=09}
> +
> +=09/* PCIe r6.0 sec 8.4.4: LMR is physically undefined below 16.0 GT/s (=
Gen4) */
> +=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +=09if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB)
> +=09=09return -EOPNOTSUPP;

Shouldn't pci_lmr_init() catch this already?

Or this is for links that support 16GT/s+ but operate currently below it?=
=20
In which case it would be more useful to mention that detail in the=20
comment.

> +=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap))
> +=09=09return -EIO;
> +
> +=09/* Prevent D3hot runtime PM transition during active margining */
> +=09ret =3D pm_runtime_resume_and_get(&dev->dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09/* Disable ASPM L0s/L1 during margining with restoration path */

I don't know what "during margining with restoration path" is supposed to=
=20
mean.

> +=09pci_lmr_disable_aspm(mdev);

What about other things beyond ASPM mentioned in r7.0 4.2.18.4 (HW=20
autonomous speed/width disable bits)?

> +
> +=09/* Ensure link is settled in L0 mode per PCIe r6.0 sec 8.4.4 */
> +=09usleep_range(2000, 3000);
> +
> +=09if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +=09=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts))=
 {
> +=09=09=09ret =3D -EIO;
> +=09=09=09goto err_enable;

Should there be another label to only rollback the aspm + rpm count=20
changed?

> +=09=09}
> +=09=09sts |=3D PCI_LMR_PORT_STS_SW_READY;
> +=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09}
> +
> +=09timeout =3D jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
> +=09while (1) {
> +=09=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts))=
 {
> +=09=09=09ret =3D -EIO;
> +=09=09=09goto err_enable;
> +=09=09}
> +=09=09if (PCI_POSSIBLE_ERROR(sts)) {
> +=09=09=09ret =3D -ENODEV;
> +=09=09=09goto err_enable;
> +=09=09}
> +=09=09if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
> +=09=09=09break;
> +=09=09if (time_after(jiffies, timeout)) {
> +=09=09=09ret =3D -ETIMEDOUT;
> +=09=09=09goto err_enable;
> +=09=09}
> +=09=09usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
> +=09}
> +
> +=09/* Cache capabilities for configured receiver on all lanes */
> +=09for (i =3D 0; i < mdev->num_lanes; i++) {
> +=09=09ret =3D pci_lmr_cache_rx_info(&mdev->lanes[i],
> +=09=09=09=09=09    mdev->lanes[i].rx);

Fit's to one line.

> +=09=09if (ret)
> +=09=09=09goto err_enable;
> +=09}
> +=09mdev->enabled =3D true;
> +=09return count;
> +
> +err_enable:
> +=09if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +=09=09if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =
=3D=3D 0) {
> +=09=09=09sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +=09=09=09pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +=09=09}
> +=09}
> +=09pci_lmr_restore_aspm(mdev);
> +=09pm_runtime_put(&dev->dev);
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
> +=09=09=09=09      size_t count, loff_t *ppos)
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
> +=09/* Valid receiver numbers are 0..6 per PCIe r6.0 sec 8.4.4; 7 is rese=
rved */
> +=09if (rx > LMR_MAX_RX_NUM)
> +=09=09return -EINVAL;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (plane->rx =3D=3D rx)
> +=09=09return count;
> +
> +=09if (mdev->enabled) {
> +=09=09/* Demargin previous receiver per single-receiver spec rule */
> +=09=09ret =3D pci_lmr_demargin_lane(plane);
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
> +=09=09return -EACCES;

This seems wrong errno. !enabled leads to "Access denied"?

> +
> +=09ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09info =3D &plane->rx_info[plane->rx];
> +=09val =3D info->caps;
> +=09seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, pla=
ne->rx, val);
> +=09seq_printf(s, "  Margining H/V: %s\n", (val & LMR_CAP_MARGIN_HV) ? "b=
oth" : "either");
> +=09seq_printf(s, "  Margining eV/iV: %s\n",
> +=09=09   (val & LMR_CAP_MARGIN_EV_IV) ? "both (close & open)" : "one (cl=
ose only)");
> +=09seq_printf(s, "  Left/Right: %s\n", (val & LMR_CAP_IND_LEFT_RIGHT_TIM=
ING) ? "both" : "one");
> +=09seq_printf(s, "  Up/Down: %s\n", (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) =
? "both" : "one");
> +=09seq_printf(s, "  Error Sampler: %s\n",
> +=09=09   (val & LMR_CAP_ERROR_SAMPLER) ? "yes" : "no (main sampler)");
> +=09seq_printf(s, "  Sample Multiple Receivers: %s\n",
> +=09=09   str_yes_no(val & LMR_CAP_SAMPLE_MULTIPLE_RX));
> +=09return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
> +
> +static int margin_lane_steps_show(struct seq_file *s, bool is_voltage)
> +{
> +=09struct pci_margin_lane *plane =3D s->private;
> +=09struct pci_margin_dev *mdev =3D plane->mdev;
> +=09struct pci_margin_rx_info *info;
> +=09int ret;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (!mdev->enabled)
> +=09=09return -EACCES;

Wrong return code.

> +=09ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09info =3D &plane->rx_info[plane->rx];
> +=09seq_printf(s, "%d\n", is_voltage ? info->num_voltage_steps : info->nu=
m_timing_steps);
> +=09return 0;
> +}
> +
> +static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_steps_show(s, false);
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
> +
> +static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_steps_show(s, true);
> +}
> +DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
> +
> +static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev=
,
> +=09=09=09=09=09     struct pci_margin_lane *plane)
> +{
> +=09struct pci_margin_rx_info *info =3D &plane->rx_info[plane->rx];
> +=09int i;
> +
> +=09if (info->caps & LMR_CAP_SAMPLE_MULTIPLE_RX)
> +=09=09return true;
> +
> +=09for (i =3D 0; i < mdev->num_lanes; i++) {
> +=09=09struct pci_margin_lane *other =3D &mdev->lanes[i];
> +
> +=09=09if (i =3D=3D plane->lane)
> +=09=09=09continue;
> +=09=09if (other->rx =3D=3D plane->rx &&
> +=09=09    (other->timing_val !=3D 0 || other->voltage_val !=3D 0))
> +=09=09=09return false;

I fail to understand what's going on here, it could be in part because of=
=20
not knowing what LMR_CAP_SAMPLE_MULTIPLE_RX means.

> +=09}
> +=09return true;
> +}
> +
> +static ssize_t margin_lane_step_write(struct file *file, const char __us=
er *user_buf,
> +=09=09=09=09      size_t count, bool is_voltage)
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
> +=09max_step =3D is_voltage ? LMR_MAX_VOLTAGE_STEP : LMR_MAX_TIMING_STEP;

Instead of is_voltage, it would be better to just pass most of these=20
define variations in arguments. If some complex cases remains (probably=20
the direction), they should be derived from=20
LMR_TYPE_VOLTAGE/LMR_TYPE_TIMING (preferrably with a switch/case for=20
clarity), so you don't need to pass a boolean at all.

> +=09if (val > max_step || val < -max_step)
> +=09=09return -EINVAL;
> +
> +=09guard(mutex)(&mdev->lock);
> +=09if (!mdev->enabled)
> +=09=09return -EACCES;

Wrong return code.

> +
> +=09if (val =3D=3D 0)
> +=09=09return pci_lmr_demargin_lane(plane) ?: count;

So this reset both voltage and timing? Is that intentional?

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
> +=09if (val < 0) {
> +=09=09step =3D -val;
> +=09=09if (is_voltage) {
> +=09=09=09/* Symmetric voltage margining requires dir=3D1 per spec */
> +=09=09=09if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE))
> +=09=09=09=09return -EINVAL;
> +=09=09=09dir =3D 0;
> +=09=09} else {
> +=09=09=09/* Symmetric timing margining requires dir=3D1 per spec */
> +=09=09=09if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING))
> +=09=09=09=09return -EINVAL;
> +=09=09=09dir =3D LMR_STEP_DIR_DECREASE;
> +=09=09}
> +=09} else {
> +=09=09step =3D val;
> +=09=09dir =3D is_voltage ? 1 : LMR_STEP_DIR_INCREASE;
> +=09}
> +
> +=09max_step =3D is_voltage ? info->num_voltage_steps : info->num_timing_=
steps;
> +=09if (step > max_step)

Why you need the first check if you then do this as well?

> +=09=09return -EINVAL;
> +
> +=09if (is_voltage) {
> +=09=09payload =3D FIELD_PREP(LMR_VOLTAGE_DIR_MASK, dir) |
> +=09=09=09  FIELD_PREP(LMR_VOLTAGE_STEP_MASK, step);
> +=09=09ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
> +=09=09=09=09      LMR_TYPE_VOLTAGE, 0, payload, &sts);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09step =3D FIELD_GET(LMR_VOLTAGE_STEP_MASK, pci_lmr_sts_payload(sts)=
);
> +=09=09plane->voltage_val =3D (dir =3D=3D 0) ? -step : step;
> +=09} else {
> +=09=09payload =3D FIELD_PREP(LMR_TIMING_DIR_MASK, dir) |
> +=09=09=09  FIELD_PREP(LMR_TIMING_STEP_MASK, step);
> +=09=09ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
> +=09=09=09=09      LMR_TYPE_TIMING, 0, payload, &sts);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09step =3D FIELD_GET(LMR_TIMING_STEP_MASK, pci_lmr_sts_payload(sts))=
;
> +=09=09plane->timing_val =3D (dir =3D=3D LMR_STEP_DIR_DECREASE) ? -step :=
 step;
> +=09}
> +
> +=09return count;
> +}
> +
> +static ssize_t margin_lane_timing_write(struct file *file, const char __=
user *user_buf,
> +=09=09=09=09=09size_t count, loff_t *ppos)
> +{
> +=09return margin_lane_step_write(file, user_buf, count, false);
> +}
> +
> +static int margin_lane_step_show(struct seq_file *s, bool is_voltage)
> +{
> +=09struct pci_margin_lane *plane =3D s->private;
> +
> +=09guard(mutex)(&plane->mdev->lock);
> +=09seq_printf(s, "%d\n", is_voltage ? plane->voltage_val : plane->timing=
_val);
> +=09return 0;
> +}
> +
> +static int margin_lane_timing_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_step_show(s, false);
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
> +=09return margin_lane_step_write(file, user_buf, count, true);
> +}
> +
> +static int margin_lane_voltage_show(struct seq_file *s, void *v)
> +{
> +=09return margin_lane_step_show(s, true);
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
> +=09if (IS_ERR_OR_NULL(mdev->debugfs))
> +=09=09return;

(IIRC) to avoid boilerplate, debugfs APIs will handle NULLs for you so you=
=20
don't need to error check like this if you don't dereference it yourself.

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
> +=09=09if (IS_ERR_OR_NULL(lane_dir))
> +=09=09=09continue;
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
> +=09u16 lmr, lnksta;
> +=09int num_lanes, i;
> +
> +=09if (!dev || !pci_is_pcie(dev))
> +=09=09return;

IMO, it would a programming error on caller side to call this with NULL,=20
so this would be more appropriate to catch the problem early:

=09if (WARN_ON_ONCE(!dev))
=09=09return;

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
> +=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +=09num_lanes =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
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
> +=09pci_info(dev, "Lane Margining at Receiver (Gen%u) Capability detected=
\n",
> +=09=09 LMR_SPEED_TO_GEN(speed));

I suppose this will be a major source of log spam (for a facility that is=
=20
mostly meant for debugging) so it would be better on debug level.

> +}
> +
> +void pci_lmr_exit(struct pci_dev *dev)
> +{
> +=09struct pci_margin_dev *mdev =3D dev->lmr;
> +
> +=09if (!dev || !mdev)
> +=09=09return;
> +
> +=09pci_suspend_lmr(dev);
> +
> +=09pci_margin_debugfs_remove(mdev);
> +=09mutex_destroy(&mdev->lock);
> +=09kfree(mdev);
> +=09dev->lmr =3D NULL;
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
> +=09__pci_suspend_lmr_locked(dev);
> +}
> +
> +void pci_reset_lmr(struct pci_dev *dev)
> +{
> +=09pci_suspend_lmr(dev);
> +}

In general, my feel is the code was easier to read now (except for the=20
is_voltage mess in that one function).

--=20
 i.

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
> index d8bffa21498a..6fba29040e44 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -36,6 +36,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
> =20
>  =09pci_doe_sysfs_teardown(dev);
>  =09pci_npem_remove(dev);
> +=09pci_lmr_exit(dev);
>  =09/*
>  =09 * While device is in D0 drop the device from TSM link operations
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
--8323328-1781632769-1787302182=:1195--
