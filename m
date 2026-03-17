Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8857C9F;
	Tue, 17 Mar 2026 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729080; cv=none; b=EZuoEmfUJdEZy8Np08I8E5SKUCMzEx3KC4Ah0ry0yw/mENOYqIci41gVe6jVC762mb4gVOrogUIhZL+b4FUvqnEDT8oBa64zmdRyh4uGTjlvEZ/iZMq9B99EE7aaDBivh7i3emAwl77Y+vpy93QeO5TtspIoRCDhxF+VDSo8wuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729080; c=relaxed/simple;
	bh=IE9I/3Xu0N5Xs4x1vV1Jr9yxRFc7JOfB5hcUMR48GBw=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AbwumWwmNu5vQ0n2+2WlM3L5s9UyvIs5W7vcQcrPgenE5soJCqh8X0YzsPl5tJ/Dxol4E8BymybnvxJG1sUhim85CEwY5GtRHooo/I9E/A508aLPqMyBXftFL1B7BLsjxDAJ/lUAXW8T4fhQ1Mfnm7FVU14QQiJpNsvqrPTYl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eaqN2c6S; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eaqN2c6S"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 37392c9c0;
	Tue, 17 Mar 2026 14:31:06 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: cadence: Add debugfs property to provide LTSSM
 status of the PCIe link
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 hans.zhang@cixtech.com
References: <20260315155514.127255-1-18255117159@163.com>
 <20260315155514.127255-3-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <65b00ea8-1936-18ae-115b-3e356bd1cbaa@rock-chips.com>
Date: Tue, 17 Mar 2026 14:31:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260315155514.127255-3-18255117159@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cfa7dad0309cckunm3e318598477e79
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1DSVZMGR9NT0sYTBodHR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eaqN2c6SNpMDEJdOu/TgohWCFFftuAT4zK+4rKIQLfZb1/Mh1+Li7NMPF6FAV4oUFl7+kyoQ3KmswQqh08/OiNrlm0cepmZGIV21H9SxZHPvmyliXiho1TYySsyKQkvYZ6f0KgtEIXVBJ/dkH/vR/gXHf/+jpTxgXQb30EiQQwE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=riZH6UUTz0o/iQqcRJrWwF7sFHFMwrV9pyxivRkONW8=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/15 星期日 23:55, Hans Zhang 写道:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the Root Port device.
> 
> Test example:
>    # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>    L0_STATE (0x29)
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>   drivers/pci/controller/cadence/Kconfig        |   9 +
>   drivers/pci/controller/cadence/Makefile       |   1 +
>   .../controller/cadence/pcie-cadence-debugfs.c | 211 ++++++++++++++++++
>   .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +
>   .../cadence/pcie-cadence-host-hpa.c           |   8 +-
>   .../controller/cadence/pcie-cadence-host.c    |   8 +-
>   drivers/pci/controller/cadence/pcie-cadence.h | 145 ++++++++++++
>   8 files changed, 387 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
> new file mode 100644
> index 000000000000..4118303e75f3
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
> @@ -0,0 +1,5 @@
> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
> +Date:		January 2026

March?

> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both
> +		string and raw value.
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..b277c5f6e196 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>   config PCIE_CADENCE
>   	tristate
>   
> +config PCIE_CADENCE_DEBUGFS
> +	bool "Cadence PCIe debugfs entries"
> +	depends on DEBUG_FS
> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
> +	help
> +	  Say Y here to enable debugfs entries for the PCIe controller. These
> +	  entries provide various debug features related to the controller and
> +	  the LTSSM status of link can be displayed.
> +
>   config PCIE_CADENCE_HOST
>   	tristate
>   	depends on OF
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b8ec1cecfaa8..2cdc4617e0c2 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
>   pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>   
>   obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>   obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> new file mode 100644
> index 000000000000..568c7af6e18f
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe controller driver for CIX's sky1 SoCs
> + *
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + * Author: Hans Zhang <hans.zhang@cixtech.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-cadence.h"
> +
> +#define CDNS_DEBUGFS_BUF_MAX		128
> +
> +static const char *ltssm_status_string(enum cdns_pcie_ltssm ltssm)
> +{
> +	const char *str;
> +
> +	switch (ltssm) {
> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_QUIET);

Seriously? Synopsys code in cdns driver?

> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RCVR_DETECTED_ST);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RCVR_DETECTED_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_IDLE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_IDLE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0_STATE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_IDLE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_IDLE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_5);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_6);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_7);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_5);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_IDLE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_EXIT);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_5);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_IDLE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1);
> +	DW_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2);
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
> +		ltssm = FIELD_GET(GENMASK(27, 20), reg);
> +	} else {
> +		reg = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
> +		ltssm = FIELD_GET(GENMASK(29, 24), reg);
> +	}

What are these magic numbers? Please use macro with proper
names.

> +
> +	seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(ltssm), ltssm);
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
> +
> +static void cdns_pcie_ltssm_debugfs_init(struct cdns_pcie *pci, struct dentry *dir)
> +{
> +	debugfs_create_file("ltssm_status", 0444, dir, pci,
> +			    &cdns_pcie_ltssm_status_ops);
> +}
> +
> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
> +{
> +	if (!pci->debug_dir)
> +		return;
> +
> +	debugfs_remove_recursive(pci->debug_dir);
> +}
> +
> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
> +{
> +	char dirname[CDNS_DEBUGFS_BUF_MAX];
> +	struct device *dev = pci->dev;
> +
> +	/* Create main directory for each platform driver. */
> +	snprintf(dirname, CDNS_DEBUGFS_BUF_MAX, "cdns_pcie_%s", dev_name(dev));
> +	pci->debug_dir = debugfs_create_dir(dirname, NULL);
> +
> +	cdns_pcie_ltssm_debugfs_init(pci, pci->debug_dir);
> +}
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index c0e1194a936b..7849f63f53ab 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -761,6 +761,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>   
>   	pci_epc_init_notify(epc);
>   
> +	cdns_pcie_debugfs_init(pcie);
> +
>   	return 0;
>   
>    free_epc_mem:
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e8..38bd74d9e071 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> @@ -360,7 +360,13 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
>   	if (!bridge->ops)
>   		bridge->ops = &cdns_pcie_hpa_host_ops;
>   
> -	return pci_host_probe(bridge);
> +	ret = pci_host_probe(bridge);
> +	if (ret)
> +		return ret;
> +
> +	cdns_pcie_debugfs_init(pcie);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_setup);
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index db3154c1eccb..23ca1e703953 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -416,7 +416,13 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>   	if (!bridge->ops)
>   		bridge->ops = &cdns_pcie_host_ops;
>   
> -	return pci_host_probe(bridge);
> +	ret = pci_host_probe(bridge);
> +	if (ret)
> +		return ret;
> +
> +	cdns_pcie_debugfs_init(pcie);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(cdns_pcie_host_setup);
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index c8cb19f7622f..6db98b7d24cb 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -42,6 +42,137 @@ enum cdns_pcie_reg_bank {
>   	REG_BANKS_MAX,
>   };
>   
> +enum cdns_pcie_ltssm {
> +	CDNS_PCIE_LTSSM_DETECT_QUIET		= 0,
> +	CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY	= 1,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE		= 2,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_1		= 3,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_2		= 4,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_3		= 5,
> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_ST	= 6,
> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_1		= 7,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE		= 8,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_1	= 9,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_2	= 10,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_3	= 11,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE	= 12,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1	= 13,
> +	CDNS_PCIE_LTSSM_POLLING_CONFIG		= 14,
> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_1	= 15,
> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_2	= 16,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC	= 17,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1	= 18,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2	= 19,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC	= 20,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC	= 21,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1 = 22,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC	= 23,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP	= 24,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1	= 25,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2	= 26,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP	= 27,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP	= 28,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1 = 29,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP	= 30,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1	= 31,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_1		= 32,
> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE		= 33,
> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1	= 34,
> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2	= 35,
> +	CDNS_PCIE_LTSSM_CONFIG_IDLE		= 36,
> +	CDNS_PCIE_LTSSM_CONFIG_IDLE_1		= 37,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_2		= 38,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_3		= 39,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_4		= 40,
> +	CDNS_PCIE_LTSSM_L0_STATE		= 41,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK	= 42,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1	= 43,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG	= 44,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1	= 45,
> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE		= 46,
> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE_1		= 47,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK		= 48,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_1		= 49,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_2		= 50,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_3		= 51,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_4		= 52,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_5		= 53,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_6		= 54,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_7		= 55,
> +	CDNS_PCIE_LTSSM_HOT_RESET		= 56,
> +	CDNS_PCIE_LTSSM_HOT_RESET_1		= 57,
> +	CDNS_PCIE_LTSSM_HOT_RESET_2		= 58,
> +	CDNS_PCIE_LTSSM_HOT_RESET_3		= 59,
> +	CDNS_PCIE_LTSSM_L0S_ENTRY		= 60,
> +	CDNS_PCIE_LTSSM_L0S_1			= 61,
> +	CDNS_PCIE_LTSSM_L0S_2			= 62,
> +	CDNS_PCIE_LTSSM_L0S_3			= 63,
> +	CDNS_PCIE_LTSSM_L0S_4			= 64,
> +	CDNS_PCIE_LTSSM_L0S_5			= 65,
> +	CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX	= 66,
> +	CDNS_PCIE_LTSSM_TX_FTS_ENTRY		= 67,
> +	CDNS_PCIE_LTSSM_TX_FTS_1		= 68,
> +	CDNS_PCIE_LTSSM_TX_FTS_2		= 69,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST		= 70,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1		= 71,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2		= 72,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3		= 73,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED		= 74,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_1	= 75,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_2	= 76,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_3	= 77,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23 = 78,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1 = 79,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2 = 80,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3 = 81,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4 = 82,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5 = 83,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6 = 84,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7 = 85,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8 = 86,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY	= 87,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1	= 89,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT	= 90,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1	= 91,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2	= 92,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3	= 93,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4	= 94,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5	= 95,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE	= 96,
> +	CDNS_PCIE_LTSSM_L1_ENTRY		= 97,
> +	CDNS_PCIE_LTSSM_L1_1			= 98,
> +	CDNS_PCIE_LTSSM_L1_2			= 99,
> +	CDNS_PCIE_LTSSM_L1_3			= 100,
> +	CDNS_PCIE_LTSSM_L1_4			= 101,
> +	CDNS_PCIE_LTSSM_L1_IDLE			= 102,
> +	CDNS_PCIE_LTSSM_L1_EXIT			= 103,
> +	CDNS_PCIE_LTSSM_L2_ENTRY		= 104,
> +	CDNS_PCIE_LTSSM_L2_1			= 105,
> +	CDNS_PCIE_LTSSM_L2_2			= 106,
> +	CDNS_PCIE_LTSSM_L2_3			= 107,
> +	CDNS_PCIE_LTSSM_L2_4			= 108,
> +	CDNS_PCIE_LTSSM_L2_5			= 109,
> +	CDNS_PCIE_LTSSM_L2_IDLE			= 110,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY	= 111,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1	= 112,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2	= 113,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3	= 114,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4	= 115,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5	= 116,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY = 117,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE	= 118,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT	= 119,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1	= 120,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2	= 121,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
> +};
> +
>   struct cdns_pcie_ops {
>   	int     (*start_link)(struct cdns_pcie *pcie);
>   	void    (*stop_link)(struct cdns_pcie *pcie);
> @@ -87,6 +218,7 @@ struct cdns_plat_pcie_of_data {
>    * @ops: Platform-specific ops to control various inputs from Cadence PCIe
>    *       wrapper
>    * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
> + * @debug_dir: debugfs node
>    */
>   struct cdns_pcie {
>   	void __iomem		             *reg_base;
> @@ -100,6 +232,7 @@ struct cdns_pcie {
>   	struct device_link	             **link;
>   	const  struct cdns_pcie_ops          *ops;
>   	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
> +	struct dentry			     *debug_dir;
>   };
>   
>   /**
> @@ -522,4 +655,16 @@ bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
>   
>   extern const struct dev_pm_ops cdns_pcie_pm_ops;
>   
> +#ifdef CONFIG_PCIE_CADENCE_DEBUGFS
> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci);
> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci);
> +#else
> +static inline void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
> +{
> +}
> +static inline void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
> +{
> +}
> +#endif
> +
>   #endif /* _PCIE_CADENCE_H */
> 
