Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3961518126;
	Fri, 18 Sep 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749506; cv=none; b=gzBaMeZXvMaun7Pft7izdSQfcqfyRaQQ241IV+pbeSrd2vB1ZgDX5rvwn1B3QciapyUqUKEikegfv7bjs5SXHcDVg6eEg/qb60lof276g/1My6W3PEyVvbzqWfDPvWuwsnFWYZ2yBt+7Opbnl6aGIDpPyqOnaR3bwyDXzKjXqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749506; c=relaxed/simple;
	bh=VkUEa9iirfywSdSIEyadpoYL75y1GY8w88GvIDTqYqk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WiAC7H377xidBJn5wjdGvcQnXNnmfASLl280E80DhB02DnebtB2K1rOYlV39KS2X8dKOBPHml/8MsJX4ZU9ISXAL+pIjaIIotC8MvCyWne5rCexbpKXYmSB095YoWpJUubRtL4DT3RAK4VRC94u5dPa7Ew6agSJeMIHxnR+zxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6zyl3Qr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6zyl3Qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789749502; x=1821285502;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=VkUEa9iirfywSdSIEyadpoYL75y1GY8w88GvIDTqYqk=;
  b=k6zyl3Qr+G2YXzznPnlWoJ8ncdtjPUScnFcGFBeLjclH0lfbCfsmpu4Q
   wPxM9KOJFsKk5kCV6UC187n4rnKRaY4GUM8CdIbQWsrUi4qETRpYuVyvl
   oN1Zc3UNZ6Mjv5bfqa339yF4GhBr8TXWMM8+ysySNcwuFRALzY+VD4oK+
   aG5bOz1S3gFGGPyIauKW9uHdIQpPy3p+ct8OXCSNhX13fnHnxuRWtV2FR
   EVKzQzi9VJi+AMIyhbJCPp22/NcXeWDIymn/BuucAREgr1IiarjDXRbIJ
   Flp5Q+nU69pJnAkS3YMjxUn/lterxE3dnPWVRR9b/5XxjKfe3nOEAUTe6
   Q==;
X-CSE-ConnectionGUID: 2JtCAWmrSCu8hPZ2Sny/Vg==
X-CSE-MsgGUID: DJ0o3axFQ8mKkPLgxlmxig==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77833234"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="77833234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:38:22 -0700
X-CSE-ConnectionGUID: FzvT5zQcTD+hL8SI1lKICg==
X-CSE-MsgGUID: kIo5oPCWSVyn1VXQaomZgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271806924"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:38:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Sep 2026 19:38:16 +0300 (EEST)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
    bhelgaas@google.com
Subject: Re: [PATCH v2 07/10] PCI/FLIT: Add support for Flit Logging Extended
 Capability
In-Reply-To: <20260918145619.3016889-8-yazen.ghannam@amd.com>
Message-ID: <3d907699-9f79-0740-2b84-7990f1e9eac1@linux.intel.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com> <20260918145619.3016889-8-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-511656051-1789749152=:17235"
Content-ID: <227c8c7f-e038-5f1d-c8d5-b6684fbda87a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-511656051-1789749152=:17235
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <41210b32-0af5-f440-ef67-ea59111d7734@linux.intel.com>

On Fri, 18 Sep 2026, Yazen Ghannam wrote:

> PCIe r6.4 defines the Flit Logging Extended Capability for logging
> erroneous flits, and requires it on ports and RCRBs that support PCIe
> Flit Mode.[1]
>=20
> Add a port service driver for it. Include _OSC negotiation for control
> of the capability.
>=20
> The driver claims only the port types the PCIe port bus driver binds to.
> An Endpoint implements the capability on its Upstream Port too, and _OSC
> is negotiated per host bridge, so accepting control leaves those
> instances with neither firmware nor the OS managing them. Covering them
> needs a home outside the port bus driver.
>=20
> [1] PCI Express=AE Base Specification Revision 6.4, section 7.7.8
>=20
> Link: https://pcisig.com/specification/extend-osc-negotiate-control-pcie-=
flit-logging-extended-capability
> Originally-by: Avadhut Naik <avadhut.naik@amd.com>
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/pci_root.c       |  11 ++
>  drivers/pci/pci.c             |   2 +
>  drivers/pci/pci.h             |  12 ++
>  drivers/pci/pcie/Kconfig      |   9 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/flit.c       | 324 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.c    |   7 +
>  drivers/pci/pcie/portdrv.h    |  13 +-
>  drivers/pci/probe.c           |   3 +
>  include/linux/acpi.h          |   1 +
>  include/linux/pci.h           |   6 +
>  include/uapi/linux/pci_regs.h |  19 +-
>  12 files changed, 405 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/pcie/flit.c
>=20
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 88c65f34e305..402686a9ca4c 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -137,6 +137,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[=
] =3D {
>  =09{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
>  =09{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
>  =09{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
> +=09{ OSC_PCI_EXPRESS_FLIT_CONTROL, "FlitLogging" },
>  };
> =20
>  static struct pci_osc_bit_struct cxl_osc_support_bit[] =3D {
> @@ -520,6 +521,14 @@ static u32 calculate_control(void)
>  =09if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
>  =09=09control |=3D OSC_PCI_EXPRESS_DPC_CONTROL;
> =20
> +=09/*
> +=09 * An OS that requests Flit Logging control must request AER control
> +=09 * as well, so pair it with the bit that was actually requested above=
=2E
> +=09 */
> +=09if (IS_ENABLED(CONFIG_PCIE_FLIT) &&
> +=09    (control & OSC_PCI_EXPRESS_AER_CONTROL))
> +=09=09control |=3D OSC_PCI_EXPRESS_FLIT_CONTROL;
> +
>  =09return control;
>  }
> =20
> @@ -1040,6 +1049,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pc=
i_root *root,
>  =09=09host_bridge->native_ltr =3D 0;
>  =09if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>  =09=09host_bridge->native_dpc =3D 0;
> +=09if (!(root->osc_control_set & OSC_PCI_EXPRESS_FLIT_CONTROL))
> +=09=09host_bridge->native_flit =3D 0;
> =20
>  =09if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
>  =09=09host_bridge->native_cxl_error =3D 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..c1cfa0e3d75c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1798,6 +1798,7 @@ int pci_save_state(struct pci_dev *dev)
> =20
>  =09pci_save_dpc_state(dev);
>  =09pci_save_aer_state(dev);
> +=09pci_save_flit_state(dev);
>  =09pci_save_ptm_state(dev);
>  =09pci_save_tph_state(dev);
>  =09return pci_save_vc_state(dev);
> @@ -1870,6 +1871,7 @@ void pci_restore_state(struct pci_dev *dev)
> =20
>  =09pci_aer_clear_status(dev);
>  =09pci_restore_aer_state(dev);
> +=09pci_restore_flit_state(dev);
> =20
>  =09pci_restore_config_space(dev);
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f43c5330fca3..53a90f75cd76 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1000,6 +1000,18 @@ static inline void pci_dpc_init(struct pci_dev *pd=
ev) { }
>  static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return fals=
e; }
>  #endif
> =20
> +#ifdef CONFIG_PCIE_FLIT
> +void pci_flit_init(struct pci_dev *pdev);
> +void pci_flit_exit(struct pci_dev *pdev);
> +void pci_save_flit_state(struct pci_dev *pdev);
> +void pci_restore_flit_state(struct pci_dev *pdev);
> +#else
> +static inline void pci_flit_init(struct pci_dev *pdev) { }
> +static inline void pci_flit_exit(struct pci_dev *pdev) { }
> +static inline void pci_save_flit_state(struct pci_dev *pdev) { }
> +static inline void pci_restore_flit_state(struct pci_dev *pdev) { }
> +#endif
> +
>  #ifdef CONFIG_PCIEPORTBUS
>  void pci_rcec_init(struct pci_dev *dev);
>  void pci_rcec_exit(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 207c2deae35f..7ddadad57d3f 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -146,3 +146,12 @@ config PCIE_EDR
>  =09  the PCI Firmware Specification r3.2.  Enable this if you want to
>  =09  support hybrid DPC model which uses both firmware and OS to
>  =09  implement DPC.
> +
> +config PCIE_FLIT
> +=09bool "PCI Express Flit Logging support"
> +=09depends on PCIEPORTBUS && PCIEAER
> +=09help
> +=09  This enables support for the PCI Express Flit Logging Extended
> +=09  Capability, which logs errors encountered by a port operating
> +=09  in PCIe Flit Mode.  If your system doesn't have this capability
> +=09  or you do not want to use this feature, it is safe to answer N.
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304..14a5222920b9 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_PCIE_PME)=09=09+=3D pme.o
>  obj-$(CONFIG_PCIE_DPC)=09=09+=3D dpc.o
>  obj-$(CONFIG_PCIE_PTM)=09=09+=3D ptm.o
>  obj-$(CONFIG_PCIE_EDR)=09=09+=3D edr.o
> +obj-$(CONFIG_PCIE_FLIT)=09=09+=3D flit.o
> diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
> new file mode 100644
> index 000000000000..7c0b9c8dd481
> --- /dev/null
> +++ b/drivers/pci/pcie/flit.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Service driver for PCIe Flit Logging Extended Capability
> + *
> + * Copyright (c) 2026, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Authors:=09Avadhut Naik <Avadhut.Naik@amd.com>
> + *=09=09Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#define pr_fmt(fmt) "Flit: " fmt
> +#define dev_fmt pr_fmt

But you lack the actual include for printing??

> +#include <linux/bitfield.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

Add empty line.

> +#include "portdrv.h"
> +#include "../pci.h"
> +
> +/*
> + * Report only a link accumulating errors far faster than the counter dr=
ains.
> + * 0xff never fires, since an event needs the counter to exceed the trig=
ger.
> + */
> +#define FLIT_DEFAULT_TRIGGER=090xfe
> +
> +/*
> + * Per PCIe r6.4, sec 7.7.8.2, table 7-93, More Entries can be set again
> + * mid-drain, so bound the loop.
> + */
> +#define FLIT_MAX_LOG_ENTRIES=090xff
> +
> +/*
> + * Per PCIe r6.4, sec 7.7.8.2, table 7-92, an entry with none of these s=
et
> + * and Flit Error Log 2 zero is Reserved.
> + */
> +#define FLIT_ERR_LOG1_ERROR=09(PCI_FLIT_ERR_LOG1_UNRECOG | \
> +=09=09=09=09 PCI_FLIT_ERR_LOG1_FEC_UNCOR | \
> +=09=09=09=09 PCI_FLIT_ERR_LOG1_SYND_PARITY0 | \
> +=09=09=09=09 PCI_FLIT_ERR_LOG1_SYND_CHECK0)
> +
> +/* Only the port types pcie_portdrv_probe() claims get a Flit service. *=
/
> +static bool flit_is_port(struct pci_dev *pdev)
> +{
> +=09if (!pci_is_pcie(pdev))
> +=09=09return false;
> +
> +=09switch (pci_pcie_type(pdev)) {
> +=09case PCI_EXP_TYPE_ROOT_PORT:
> +=09case PCI_EXP_TYPE_UPSTREAM:
> +=09case PCI_EXP_TYPE_DOWNSTREAM:
> +=09case PCI_EXP_TYPE_RC_EC:
> +=09=09return true;
> +=09default:
> +=09=09return false;
> +=09}
> +}
> +
> +/*
> + * Without _OSC control the OS must not touch the capability. Flit Loggi=
ng
> + * control is only meaningful alongside AER control, so require both.
> + */
> +static bool flit_is_native(struct pci_dev *pdev)
> +{
> +=09struct pci_host_bridge *host =3D pci_find_host_bridge(pdev->bus);
> +
> +=09if (pcie_ports_native)
> +=09=09return true;
> +
> +=09return host->native_flit && host->native_aer;
> +}
> +
> +struct flit_info {
> +=09spinlock_t lock;=09/* serializes Counter Control read-modify-write */
> +=09bool cntr_enabled;=09/* Counter Enable as the driver intends it */
> +};

Move before functions.

> +
> +void pci_flit_init(struct pci_dev *pdev)
> +{
> +=09if (!flit_is_port(pdev) || !flit_is_native(pdev))
> +=09=09return;
> +
> +=09pdev->flit_cap =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_FLIT)=
;
> +=09if (!pdev->flit_cap)
> +=09=09return;
> +
> +=09pdev->flit_info =3D kzalloc_obj(*pdev->flit_info);
> +=09if (!pdev->flit_info) {
> +=09=09pdev->flit_cap =3D 0;
> +=09=09return;
> +=09}
> +
> +=09spin_lock_init(&pdev->flit_info->lock);
> +
> +=09pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_FLIT, sizeof(u16));
> +
> +=09pci_dbg(pdev, "Flit Logging Extended Capability present.\n");
> +}
> +
> +void pci_flit_exit(struct pci_dev *pdev)
> +{
> +=09kfree(pdev->flit_info);
> +=09pdev->flit_info =3D NULL;
> +=09pdev->flit_cap =3D 0;
> +}
> +
> +void pci_save_flit_state(struct pci_dev *pdev)
> +{
> +=09struct pci_cap_saved_state *save_state;
> +=09u16 *cap;
> +
> +=09if (!pdev->flit_cap)
> +=09=09return;
> +
> +=09save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_FLIT);
> +=09if (!save_state)
> +=09=09return;
> +
> +=09/*
> +=09 * Take Counter Enable from the driver rather than the register.
> +=09 * flit_isr() clears it and only flit_ist() sets it again once the lo=
g
> +=09 * is drained, and a save landing in between would capture a zero tha=
t
> +=09 * the next restore writes back for good.
> +=09 */
> +=09cap =3D (u16 *)&save_state->cap.data[0];
> +=09pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, c=
ap);
> +=09if (pdev->flit_info->cntr_enabled)
> +=09=09*cap |=3D PCI_FLIT_ERR_CNTR_CTRL_EN;
> +=09else
> +=09=09*cap &=3D ~PCI_FLIT_ERR_CNTR_CTRL_EN;
> +}
> +
> +void pci_restore_flit_state(struct pci_dev *pdev)
> +{
> +=09struct pci_cap_saved_state *save_state;
> +=09u16 *cap;
> +
> +=09if (!pdev->flit_cap)
> +=09=09return;
> +
> +=09save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_FLIT);
> +=09if (!save_state)
> +=09=09return;
> +
> +=09cap =3D (u16 *)&save_state->cap.data[0];
> +=09pci_write_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, =
*cap);
> +}
> +
> +/*
> + * Serializes the Counter Control read-modify-write against flit_isr(), =
which
> + * runs in hard irq context on the vector this port shares with PME, hot=
plug
> + * and bandwidth notification. A lost update here leaves Trigger Event o=
n Error
> + * Count at zero, and per PCIe r6.4, sec 7.7.8.4, table 7-95, a zero tri=
gger
> + * never generates an event.
> + */
> +static void flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 s=
et)
> +{
> +=09unsigned long flags;
> +=09u16 ctrl;
> +
> +=09spin_lock_irqsave(&pdev->flit_info->lock, flags);
> +=09pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, &=
ctrl);
> +=09ctrl &=3D ~clear;
> +=09ctrl |=3D set;
> +=09pci_write_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, =
ctrl);

I suggest adding the generic clear+set accessor into access.c, there's=20
already one for dword but not for config word.

> +=09spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
> +}
> +
> +static void flit_cntr_enable(struct pci_dev *pdev)
> +{
> +=09u16 flit =3D pdev->flit_cap;
> +=09unsigned long flags;
> +=09u16 reg;
> +
> +=09pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &reg);
> +=09pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, reg);
> +
> +=09pdev->flit_info->cntr_enabled =3D true;
> +
> +=09spin_lock_irqsave(&pdev->flit_info->lock, flags);
> +=09pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &reg);
> +
> +=09/* Set default trigger count if not set by platform, since zero never=
 fires */
> +=09if (!(reg & PCI_FLIT_ERR_CNTR_CTRL_TRIGGER))
> +=09=09reg |=3D FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, FLIT_DEFAULT_T=
RIGGER);
> +
> +=09reg |=3D PCI_FLIT_ERR_CNTR_CTRL_EN | PCI_FLIT_ERR_CNTR_CTRL_INTR_EN;
> +=09pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, reg);
> +=09spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
> +}
> +
> +static void flit_cntr_disable(struct pci_dev *pdev)
> +{
> +=09pdev->flit_info->cntr_enabled =3D false;
> +=09flit_cntr_ctrl_update(pdev, PCI_FLIT_ERR_CNTR_CTRL_EN | PCI_FLIT_ERR_=
CNTR_CTRL_INTR_EN, 0);
> +}
> +
> +static void flit_report(struct pci_dev *pdev, u32 err_log1, u32 err_log2=
)
> +{
> +=09/* Software should silently discard a Reserved entry */
> +=09if (!(err_log1 & FLIT_ERR_LOG1_ERROR) && !err_log2)
> +=09=09return;
> +
> +=09pci_warn(pdev, "ErrLog1: 0x%08x ErrLog2: 0x%08x\n", err_log1, err_log=
2);
> +}
> +
> +static irqreturn_t flit_ist(int irq, void *context)
> +{
> +=09struct pcie_device *dev =3D (struct pcie_device *)context;
> +=09struct pci_dev *pdev =3D dev->port;
> +=09u16 flit =3D pdev->flit_cap;
> +=09u32 err_log1, err_log2;
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < FLIT_MAX_LOG_ENTRIES; i++) {
> +=09=09pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, &err_log1);
> +
> +=09=09if (PCI_POSSIBLE_ERROR(err_log1) || !(err_log1 & PCI_FLIT_ERR_LOG1=
_VALID))
> +=09=09=09break;
> +
> +=09=09pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
> +
> +=09=09flit_report(pdev, err_log1, err_log2);
> +
> +=09=09pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
> +
> +=09=09if (!(err_log1 & PCI_FLIT_ERR_LOG1_MORE))
> +=09=09=09break;
> +=09}
> +
> +=09/*
> +=09 * Re-enable the counter. Per PCIe r6.4, sec 7.7.8.5, table 7-96, the
> +=09 * status bit is "Cleared on 0b to 1b transition of Flit Error Counte=
r
> +=09 * Enable", which also clears the counter and re-arms interrupt
> +=09 * generation.
> +=09 */
> +=09flit_cntr_ctrl_update(pdev, 0, PCI_FLIT_ERR_CNTR_CTRL_EN);
> +=09return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t flit_isr(int irq, void *context)
> +{
> +=09struct pcie_device *dev =3D (struct pcie_device *)context;
> +=09struct pci_dev *pdev =3D dev->port;
> +=09u16 flit =3D pdev->flit_cap;
> +=09u16 cntr_sta;
> +
> +=09pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &cntr_sta);
> +=09if (PCI_POSSIBLE_ERROR(cntr_sta) || !(cntr_sta & PCI_FLIT_ERR_CNTR_ST=
A_INTR_GEN))
> +=09=09return IRQ_NONE;
> +
> +=09/*
> +=09 * Clear Flit Error Counter Enable first, so the counter cannot reach
> +=09 * the trigger again while the thread runs, then clear the status bit=
=2E
> +=09 * A message-signaled vector needs no more than that, but this servic=
e
> +=09 * can land on INTx, where the line stays asserted until the status i=
s
> +=09 * cleared. flit_ist() transitions Counter Enable back 0->1.
> +=09 */
> +=09flit_cntr_ctrl_update(pdev, PCI_FLIT_ERR_CNTR_CTRL_EN, 0);
> +=09pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA,
> +=09=09=09      PCI_FLIT_ERR_CNTR_STA_INTR_GEN);
> +=09return IRQ_WAKE_THREAD;
> +}
> +
> +static int flit_probe(struct pcie_device *dev)
> +{
> +=09struct pci_dev *pdev =3D dev->port;
> +=09int status;
> +
> +=09/*
> +=09 * Not devm_request_threaded_irq(): devres would free the IRQ only
> +=09 * after .remove() runs, too late to stop flit_ist() re-enabling the
> +=09 * counter.
> +=09 */
> +=09status =3D request_threaded_irq(dev->irq, flit_isr, flit_ist,
> +=09=09=09=09      IRQF_SHARED, "pcie-flit", dev);
> +=09if (status) {
> +=09=09pci_warn(pdev, "request Flit IRQ %d failed: %d\n", dev->irq, statu=
s);
> +=09=09return status;
> +=09}
> +
> +=09flit_cntr_enable(pdev);
> +=09pci_info(pdev, "enabled with IRQ %d\n", dev->irq);

Success path should be silent.

--=20
 i.

> +
> +=09return 0;
> +}
> +
> +/*
> + * No .suspend or .runtime_suspend counterpart. pci_save_state() runs af=
ter
> + * both, so disabling the counter there would put a transient value in t=
he
> + * save buffer, and pcie_portdrv_slot_reset() restores that buffer after
> + * calling .slot_reset.
> + */
> +static int flit_cntr_restore(struct pcie_device *dev)
> +{
> +=09flit_cntr_enable(dev->port);
> +=09return 0;
> +}
> +
> +static void flit_cntr_remove(struct pcie_device *dev)
> +{
> +=09/* Drop the IRQ first: free_irq() waits for the threaded handler. */
> +=09free_irq(dev->irq, dev);
> +=09flit_cntr_disable(dev->port);
> +}
> +
> +static struct pcie_port_service_driver flitdriver =3D {
> +=09.name=09=09=3D "flit",
> +=09.port_type=09=3D PCIE_ANY_PORT,
> +=09.service=09=3D PCIE_PORT_SERVICE_FLIT,
> +=09.probe=09=09=3D flit_probe,
> +=09.resume=09=09=3D flit_cntr_restore,
> +=09.runtime_resume=09=3D flit_cntr_restore,
> +=09.slot_reset=09=3D flit_cntr_restore,
> +=09.remove=09=09=3D flit_cntr_remove,
> +};
> +
> +int __init pcie_flit_init(void)
> +{
> +=09return pcie_port_service_register(&flitdriver);
> +}
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index ca1b9dbb8b08..6328233c75d7 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -278,6 +278,12 @@ static int get_port_device_capability(struct pci_dev=
 *dev)
>  =09=09=09services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  =09}
> =20
> +#ifdef CONFIG_PCIE_FLIT
> +=09/* flit_cap is set only when the capability is OS-managed */
> +=09if (dev->flit_cap)
> +=09=09services |=3D PCIE_PORT_SERVICE_FLIT;
> +#endif
> +
>  =09return services;
>  }
> =20
> @@ -834,6 +840,7 @@ static void __init pcie_init_services(void)
>  =09pcie_dpc_init();
>  =09pcie_bwctrl_init();
>  =09pcie_hp_init();
> +=09pcie_flit_init();
>  }
> =20
>  static int __init pcie_portdrv_init(void)
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index bf18ca415990..975f83134a5b 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -22,13 +22,16 @@
>  #define PCIE_PORT_SERVICE_DPC=09=09(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
>  #define PCIE_PORT_SERVICE_BWCTRL_SHIFT=094=09/* Bandwidth Controller (no=
tifications) */
>  #define PCIE_PORT_SERVICE_BWCTRL=09(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
> +#define PCIE_PORT_SERVICE_FLIT_SHIFT=095=09/* Flit Logging */
> +#define PCIE_PORT_SERVICE_FLIT=09=09(1 << PCIE_PORT_SERVICE_FLIT_SHIFT)
> =20
>  /* Services sharing the PCI Express Capability Interrupt Message Number =
*/
>  #define PCIE_PORT_SERVICES_EXPCAP=09(PCIE_PORT_SERVICE_PME | \
>  =09=09=09=09=09 PCIE_PORT_SERVICE_HP | \
> -=09=09=09=09=09 PCIE_PORT_SERVICE_BWCTRL)
> +=09=09=09=09=09 PCIE_PORT_SERVICE_BWCTRL | \
> +=09=09=09=09=09 PCIE_PORT_SERVICE_FLIT)
> =20
> -#define PCIE_PORT_DEVICE_MAXSERVICES   5
> +#define PCIE_PORT_DEVICE_MAXSERVICES   6
> =20
>  extern bool pcie_ports_dpc_native;
> =20
> @@ -56,6 +59,12 @@ int pcie_dpc_init(void);
>  static inline int pcie_dpc_init(void) { return 0; }
>  #endif
> =20
> +#ifdef CONFIG_PCIE_FLIT
> +int pcie_flit_init(void);
> +#else
> +static inline int pcie_flit_init(void) { return 0; }
> +#endif
> +
>  int pcie_bwctrl_init(void);
> =20
>  /* Port Type */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..6bf62bdadc8d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -674,6 +674,7 @@ static void pci_init_host_bridge(struct pci_host_brid=
ge *bridge)
>  =09bridge->native_pme =3D 1;
>  =09bridge->native_ltr =3D 1;
>  =09bridge->native_dpc =3D 1;
> +=09bridge->native_flit =3D 1;
>  =09bridge->domain_nr =3D PCI_DOMAIN_NR_NOT_SET;
>  =09bridge->native_cxl_error =3D 1;
>  =09bridge->dev.type =3D &pci_host_bridge_type;
> @@ -2465,6 +2466,7 @@ static void pci_configure_device(struct pci_dev *de=
v)
> =20
>  static void pci_release_capabilities(struct pci_dev *dev)
>  {
> +=09pci_flit_exit(dev);
>  =09pci_aer_exit(dev);
>  =09pci_rcec_exit(dev);
>  =09pci_iov_release(dev);
> @@ -2666,6 +2668,7 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)
>  =09pci_pasid_init(dev);=09=09/* Process Address Space ID */
>  =09pci_acs_init(dev);=09=09/* Access Control Services */
>  =09pci_ptm_init(dev);=09=09/* Precision Time Measurement */
> +=09pci_flit_init(dev);=09=09/* Flit Logging */
>  =09pci_aer_init(dev);=09=09/* Advanced Error Reporting */
>  =09pci_dpc_init(dev);=09=09/* Downstream Port Containment */
>  =09pci_rcec_init(dev);=09=09/* Root Complex Event Collector */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ddacac812094..b3d8a5bb79e9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -667,6 +667,7 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL=090x00000010
>  #define OSC_PCI_EXPRESS_LTR_CONTROL=09=090x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL=09=090x00000080
> +#define OSC_PCI_EXPRESS_FLIT_CONTROL=09=090x00000800
> =20
>  /* CXL _OSC: Capabilities DWORD 4: Support Field */
>  #define OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT=090x00000001
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8650c627bebb..37d01fab50bb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -598,6 +598,11 @@ struct pci_dev {
>  =09u8=09=09tph_mode;=09/* TPH mode */
>  =09u8=09=09tph_req_type;=09/* TPH requester type */
>  #endif
> +
> +#ifdef CONFIG_PCIE_FLIT
> +=09u16=09=09flit_cap;=09/* Flit Logging Capability offset */
> +=09struct flit_info *flit_info;=09/* Flit Logging state */
> +#endif
>  };
> =20
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> @@ -663,6 +668,7 @@ struct pci_host_bridge {
>  =09unsigned int=09native_pme:1;=09=09/* OS may use PCIe PME */
>  =09unsigned int=09native_ltr:1;=09=09/* OS may use PCIe LTR */
>  =09unsigned int=09native_dpc:1;=09=09/* OS may use PCIe DPC */
> +=09unsigned int=09native_flit:1;=09=09/* OS may use PCIe Flit logging */
>  =09unsigned int=09native_cxl_error:1;=09/* OS may use CXL RAS/Events */
>  =09unsigned int=09preserve_config:1;=09/* Preserve FW resource setup */
>  =09unsigned int=09size_windows:1;=09=09/* Enable root bus sizing */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index facaa324bd86..73482024359b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -763,7 +763,8 @@
>  #define PCI_EXT_CAP_ID_DEV3=090x2F=09/* Device 3 Capability/Control/Stat=
us */
>  #define PCI_EXT_CAP_ID_IDE=090x30    /* Integrity and Data Encryption */
>  #define PCI_EXT_CAP_ID_PL_64GT=090x31=09/* Physical Layer 64.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX=09PCI_EXT_CAP_ID_PL_64GT
> +#define PCI_EXT_CAP_ID_FLIT=090x32=09/* Flit Logging */
> +#define PCI_EXT_CAP_ID_MAX=09PCI_EXT_CAP_ID_FLIT
> =20
>  #define PCI_EXT_CAP_DSN_SIZEOF=0912
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1187,6 +1188,22 @@
>  /* Physical Layer 64.0 GT/s */
>  #define PCI_PL_64GT_LE_CTRL=090x20=09/* Lane Equalization Control Regist=
er */
> =20
> +/* Flit Logging Extended Capability */
> +#define PCI_FLIT_ERR_LOG1=09=090x04=09=09/* Flit Error Log 1 Register */
> +#define  PCI_FLIT_ERR_LOG1_VALID=090x00000001=09/* Flit Error Log Valid =
*/
> +#define  PCI_FLIT_ERR_LOG1_MORE=09=090x00002000=09/* More Entries Valid =
*/
> +#define  PCI_FLIT_ERR_LOG1_UNRECOG=090x00004000=09/* Unrecognized Flit *=
/
> +#define  PCI_FLIT_ERR_LOG1_FEC_UNCOR=090x00008000=09/* FEC Uncorrectable=
 Error in Flit */
> +#define  PCI_FLIT_ERR_LOG1_SYND_PARITY0=090x00ff0000=09/* Syndrome Parit=
y for ECC Group 0 */
> +#define  PCI_FLIT_ERR_LOG1_SYND_CHECK0=090xff000000=09/* Syndrome Check =
for ECC Group 0 */
> +#define PCI_FLIT_ERR_LOG2=09=090x08=09=09/* Flit Error Log 2 Register */
> +#define PCI_FLIT_ERR_CNTR_CTRL=09=090x0c=09=09/* Flit Error Counter Cont=
rol Register */
> +#define  PCI_FLIT_ERR_CNTR_CTRL_EN=090x0001=09=09/* Flit Error Counter E=
nable */
> +#define  PCI_FLIT_ERR_CNTR_CTRL_INTR_EN=090x0002=09=09/* Flit Error Coun=
ter Interrupt Enable */
> +#define  PCI_FLIT_ERR_CNTR_CTRL_TRIGGER=090x0ff0=09=09/* Trigger Event o=
n Error Count */
> +#define PCI_FLIT_ERR_CNTR_STA=09=090x0e=09=09/* Flit Error Counter Statu=
s Register */
> +#define  PCI_FLIT_ERR_CNTR_STA_INTR_GEN=090x0008=09=09/* Interrupt Gener=
ated based on Trigger */
> +
>  /* Native PCIe Enclosure Management */
>  #define PCI_NPEM_CAP     0x04 /* NPEM capability register */
>  #define  PCI_NPEM_CAP_CAPABLE     0x00000001 /* NPEM Capable */
>=20
--8323328-511656051-1789749152=:17235--
