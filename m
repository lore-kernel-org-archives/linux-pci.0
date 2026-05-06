Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328748BD3E;
	Wed,  6 May 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082239; cv=none; b=Erago/R8iA3dnImv811sim6xKlR3YtVfIUaCGITlbWOnjFlhSss/F3L/9D6DisKaeWAT1hMUWbvSKJ/84mugwGmAYXIbsyZ4D3eUlfYLCeuMQAI4MhpbnNu5nIZR9DPec5ABhevwOWiox1QDVO45JmerdkPqNiezSYyVz+iSOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082239; c=relaxed/simple;
	bh=zjcd85zFCrtep8qWbNfm9PYfy2DJZ5mLQBaKE/42MqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDyh/3GkD+bh1xw0YkcSIBdt7W1H8cmOEtPZw4xSE2yRgBdzWoxlUugOdky+S3VCThf58QgZD3eWzFdMpXk+xmASYiavWZU+Yp1nFqVbPlOPM6+/LONnVpIVzQifo8YdmfVqrhX18niDpoiLNisxUXxQr943fHrk7OT+G4cYoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxEpNWow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxEpNWow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A193C2BCB0;
	Wed,  6 May 2026 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778082239;
	bh=zjcd85zFCrtep8qWbNfm9PYfy2DJZ5mLQBaKE/42MqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxEpNWowbrHhPT0PMvMgv74DYwJ4BjeohfNbqX9jSwPhZZMFts0c+M/xofdLBZjJm
	 cA/jkMXv7EQ0+8vB0tsbHwvOspcDlBgXkEgDfZOgoz/EGalz+GenX9yIFv5VE1bDgy
	 kAmtsf2hX0oiK2EwJgzssE1DXSlSi7ClwTmK8pveZPFN+2DMnM9ViqcUFusixGv0fq
	 nUrkrJWWWlqr/8FJIFRue5Q6EovIF6/1foK6zJwv59yXwYaj+/t6tm729fjFJs6e6/
	 sSY/6w5/YEpMxjhPZcOMD/iPZn7MyAhcc1/AQ3TwnNcTEdjTlbYEoCu8DFzV+CkPnr
	 xXOWB58ySj8FA==
Date: Wed, 6 May 2026 21:13:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	hans.zhang@cixtech.com, robh@kernel.org, mpillai@cadence.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Message-ID: <7g32xmc5juraumjexmjmptrwvpsbni43csjw727zzkdetforzs@y5xumpko2lf2>
References: <20260406103237.1203127-1-18255117159@163.com>
 <20260406103237.1203127-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406103237.1203127-3-18255117159@163.com>

On Mon, Apr 06, 2026 at 06:32:37PM +0800, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the Root Port device.
> 
> Test example:
>   # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>   L0_STATE (0x29)
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>  drivers/pci/controller/cadence/Kconfig        |   9 +
>  drivers/pci/controller/cadence/Makefile       |   1 +
>  drivers/pci/controller/cadence/pci-sky1.c     |   3 +
>  .../controller/cadence/pcie-cadence-debugfs.c | 215 ++++++++++++++++++
>  .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
>  .../cadence/pcie-cadence-host-hpa.c           |   8 +-
>  .../controller/cadence/pcie-cadence-host.c    |   9 +-
>  drivers/pci/controller/cadence/pcie-cadence.h | 145 ++++++++++++
>  9 files changed, 396 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
> new file mode 100644
> index 000000000000..659ad2ab70e4
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
> @@ -0,0 +1,5 @@
> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
> +Date:		March 2026
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both
> +		string and raw value.
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..b277c5f6e196 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	tristate
>  
> +config PCIE_CADENCE_DEBUGFS
> +	bool "Cadence PCIe debugfs entries"

Why not tristate?

> +	depends on DEBUG_FS
> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
> +	help
> +	  Say Y here to enable debugfs entries for the PCIe controller. These
> +	  entries provide various debug features related to the controller and
> +	  the LTSSM status of link can be displayed.
> +
>  config PCIE_CADENCE_HOST
>  	tristate
>  	depends on OF
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b8ec1cecfaa8..2cdc4617e0c2 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
>  pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>  
>  obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
> index e1f4a98e2ab6..093f20466339 100644
> --- a/drivers/pci/controller/cadence/pci-sky1.c
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -221,7 +221,10 @@ MODULE_DEVICE_TABLE(of, of_sky1_pcie_match);
>  static void sky1_pcie_remove(struct platform_device *pdev)
>  {
>  	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
> +	struct cdns_pcie_rc *rc;
>  
> +	rc = container_of(pcie->cdns_pcie, struct cdns_pcie_rc, pcie);
> +	cdns_pcie_debugfs_deinit(&rc->pcie);

You are calling cdns_pcie_debugfs_init() from pcie-cadence-host-hpa.c driver. So
you should call cdns_pcie_debugfs_deinit() there only in an exported API.

>  	pci_ecam_free(pcie->cfg);
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> new file mode 100644
> index 000000000000..d83007ae218e
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence PCIe controller debugfs driver
> + *
> + * Copyright (C) 2026 Hans Zhang <18255117159@163.com>
> + * Author: Hans Zhang <18255117159@163.com>

Since copyright belongs to you, there is no need to mention 'Author'.

> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-cadence.h"
> +
> +#define CDNS_DEBUGFS_BUF_MAX		128
> +#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
> +#define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
> +
> +static const char *cdns_pcie_ltssm_status_string(enum cdns_pcie_ltssm ltssm)
> +{
> +	const char *str;
> +
> +	switch (ltssm) {
> +#define CDNS_PCIE_LTSSM_NAME(n) case n: str = #n; break
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_QUIET);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RCVR_DETECTED_ST);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RCVR_DETECTED_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_IDLE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_IDLE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0_STATE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_IDLE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_IDLE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_5);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_6);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_7);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_5);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_IDLE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_EXIT);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_5);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_IDLE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1);
> +	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2);
> +	default:
> +		str = "CDNS_PCIE_LTSSM_UNKNOWN";
> +		break;
> +	}
> +
> +	return str + strlen("CDNS_PCIE_LTSSM_");
> +}
> +
> +static int ltssm_status_show(struct seq_file *s, void *v)
> +{
> +	struct cdns_pcie *pci = s->private;
> +	enum cdns_pcie_ltssm ltssm;
> +	u32 reg;
> +
> +	if (pci->is_hpa) {
> +		reg = cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
> +					CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
> +		ltssm = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, reg);
> +	} else {
> +		reg = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
> +		ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, reg);
> +	}
> +
> +	seq_printf(s, "%s (0x%02x)\n", cdns_pcie_ltssm_status_string(ltssm), ltssm);
> +
> +	return 0;
> +}
> +
> +static int ltssm_status_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ltssm_status_show, inode->i_private);
> +}
> +
> +static const struct file_operations cdns_pcie_ltssm_status_ops = {
> +	.open = ltssm_status_open,
> +	.read = seq_read,
> +};

Sashiko pointed out that you could use DEFINE_SHOW_ATTRIBUTE() to simplify the
code here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
