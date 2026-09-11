Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3179840F8FC;
	Fri, 11 Sep 2026 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107981; cv=none; b=sWS3m2J65rHs8wJ7HE1lUSPnw8Qs6s2SN/EDbAodR0X+9a+Z7lxWi0WlM5E5aSbpxFk2RWQb+Q4fcw5hqUp2OV4SLoh3YBcPSOlVTszidkseBGa4tJ6ig/smIF4T7eVG9jeqC6Jz0oTDS59f4PCJiQpRieIZD11tD7jsj3Oi55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107981; c=relaxed/simple;
	bh=fVVGVlehzVIWBISjpZ3/KuYtoVwsp+i7x9a1ZqiDaYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf3wUcZBVyt+ChSSXUzE1xxTT98ZQzOZP4DmYJW68fSwak4bDaYRDrfSzIlRQKC2Xo7/NKvRBcq4u7ry4jcKnGYut9i0rjUCPNu/7sM/Mc2SFJ7NjjN0/0DaFMxk1D7Zotah4vqEwmnD5ofEkyDnNcknWktjq7W9HlbqvP8h9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3jqbpHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3jqbpHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E231F000FF;
	Fri, 11 Sep 2026 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789107971;
	bh=u312A2m2n9whh+YAzomoy5RcItfwn3J6HBKYk7CiYjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j3jqbpHLBdjIrBZalRxhpttvGEuKIuIdOzZBoVJEYjNfwybawgzFyALtrtrAy43fh
	 +D4BFJZrAodZtmByHVF/ACk4ymfZ0eu9Kr7gsJhIDaIBpKUe9mq5Aviud6c6qMelFb
	 0qcJXdoZJdCXILXOLxDnXrJbXT3gpuIgJnij/6UHsU2cVUjA9ejlL3/8SDd4JQq2uo
	 +CrA8sX/0JB0x+S/YngJbUKhd490l5TQWi9uwZQNz8MuoLHO0NI4YTnhANp0eNsI0f
	 H1QQo6tmlqHPM+98Fkoi1z3Dc9djIhgGqReu8BgQ0wivCdGKicsli94pjstL7lILmE
	 Z1RiKuyCOg5kQ==
Date: Fri, 11 Sep 2026 08:26:04 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Add register dump support for PCIe Link
 Down events
Message-ID: <7upumnrmgwfswq3udvmow7qkoqjpd4z7cwtsyursqlaazhw2bl@fvboulpljazo>
References: <20260905-regdump-v2-1-f7d34f9d4f46@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905-regdump-v2-1-f7d34f9d4f46@oss.qualcomm.com>

On Sat, Sep 05, 2026 at 06:59:29AM +0530, Krishna Chaitanya Chundru wrote:
> When the PCIe link goes down unexpectedly, being able to inspect the
> state of key controller registers at the time of failure is valuable
> for root-causing the issue.
> 
> If a storage endpoint is present downstream, the dump is printed
> directly via dev_err() so it is visible in dmesg immediately, since a
> devcoredump read from userspace could otherwise race with a storage
> failure.

Make it clear that the devcoredump would be unavailable if the storage device is
used as the RootFS and we cannot detect it from the driver. So to be on the
conservative side, the regdump is printed directly as dev_err().

> Otherwise, the buffer is handed to the devcoredump framework
> so it can be collected from /sys/class/devcoredump/ for offline
> analysis.
> 
> To keep the dump readable given the number of registers involved,
> entries are packed as "offset: value" pairs, QCOM_PCIE_DUMP_REGS_PER_LINE
> (4) per dmesg line, with a section header ("DBI registers:", "PARF
> registers:", "MHI registers:") identifying each register group.
> 
> Also expose the same dump on demand via a new "regdump" debugfs file
> under the existing per-controller debugfs directory, so the register
> state can be inspected without needing an actual Link Down event.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v2:
> - Fixed the sashiko comments, add missed qcom_pcie_ext_parf_dump_regs
>   usage, print the dump one line at a time instead of as a single dev_err() call,
>   create debugfs even if mhi is not present.
> - Link to v1: https://patch.msgid.link/20260811-regdump-v1-1-f22db3fb37c2@oss.qualcomm.com
> ---
>  drivers/pci/controller/dwc/pcie-designware.h |   6 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 351 ++++++++++++++++++++++++++-
>  include/uapi/linux/pci_regs.h                |   2 +
>  3 files changed, 355 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0735ae940924..ee97a5e9ed9e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -290,6 +290,12 @@
>  
>  #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
>  
> +/* SD-EQ (Gen5 32 GT/s per-lane pre/post cursor equalization) registers */
> +#define PCIE_RAS_DES_SD_EQ_CONTROL1		0xd0
> +#define PCIE_RAS_DES_SD_EQ_CONTROL1_LANE_SEL	GENMASK(3, 0)
> +#define PCIE_RAS_DES_SD_EQ_STATUS2		0xe4
> +#define PCIE_RAS_DES_SD_EQ_STATUS3		0xe8
> +
>  /* PTM register definitions */
>  #define PTM_RES_REQ_CTRL		0x8
>  #define PTM_RES_CCONTEXT_VALID		BIT(0)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..ba41a0eb43dc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/crc8.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/devcoredump.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/interrupt.h>
> @@ -33,8 +34,10 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
> +#include <linux/vmalloc.h>
>  
>  #include "../../pci.h"
>  #include "../pci-host-common.h"
> @@ -44,6 +47,8 @@
>  /* PARF registers */
>  #define PARF_SYS_CTRL				0x00
>  #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
> +#define PARF_PM_STTS_1				0x28
>  #define PARF_PCS_DEEMPH				0x34
>  #define PARF_PCS_SWING				0x38
>  #define PARF_PHY_CTRL				0x40
> @@ -62,11 +67,17 @@
>  #define PARF_STATUS				0x230
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
> +#define PARF_CLKREQ_OVERRIDE			0x2b0
>  #define PARF_DBI_BASE_ADDR_V2			0x350
>  #define PARF_DBI_BASE_ADDR_V2_HI		0x354
>  #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>  #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>  #define PARF_NO_SNOOP_OVERRIDE			0x3d4
> +#define PARF_CORE_ERRORS			0x3c0
> +#define PARF_L1SS_SLEEP_MODE_HANDLER_STATUS	0x4d0
> +#define PARF_L1SS_SLEEP_MODE_HANDLER_CFG	0x4d4
> +#define PARF_INT_ALL_2_STATUS			0x500
> +#define PARF_LINK_DOWN_AXI_ECAM_BLOCK_STATUS	0x630
>  #define PARF_ATU_BASE_ADDR			0x634
>  #define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_DEVICE_TYPE			0x1000
> @@ -83,8 +94,12 @@
>  
>  /* MHI registers */
>  #define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
> +#define PARF_DEBUG_CNT_PM_LINKST_IN_L1SUB	0xc08
>  #define PARF_DEBUG_CNT_PM_LINKST_IN_L1		0xc0c
>  #define PARF_DEBUG_CNT_PM_LINKST_IN_L0S		0xc10
> +#define PARF_DEBUG_CNT_AUX_CLK_APP_REQ_EXIT_L1		0xc14
> +#define PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L23	0xc18
> +#define PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L1	0xc1c
>  #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
>  #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
>  
> @@ -188,11 +203,48 @@
>  #define PERST_DELAY_US				1000
>  #define FLUSH_TIMEOUT_US			100
>  
> +/* Dump buffer size for the link-down register dump */
> +#define QCOM_PCIE_DUMP_BUF_SIZE			SZ_8K
> +
>  #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
>  
>  #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
>  		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_get_link_speed(speed)))
>  
> +#define QCOM_PCIE_DUMP_REGS_PER_LINE	4
> +
> +static const u32 qcom_pcie_parf_dump_regs[] = {
> +	PARF_LTSSM,
> +	PARF_INT_ALL_STATUS,
> +	PARF_SYS_CTRL,
> +};
> +
> +static const u32 qcom_pcie_ext_parf_dump_regs[] = {
> +	PARF_PM_STTS,
> +	PARF_PM_STTS_1,
> +	PARF_INT_ALL_STATUS,
> +	PARF_INT_ALL_2_STATUS,
> +	PARF_CLKREQ_OVERRIDE,
> +	PARF_L1SS_SLEEP_MODE_HANDLER_STATUS,
> +	PARF_L1SS_SLEEP_MODE_HANDLER_CFG,
> +	PARF_CORE_ERRORS,
> +	PARF_LINK_DOWN_AXI_ECAM_BLOCK_STATUS,
> +	PARF_STATUS,
> +	PARF_SYS_CTRL,
> +};
> +
> +static const u32 qcom_pcie_mhi_dump_regs[] = {
> +	PARF_DEBUG_CNT_PM_LINKST_IN_L2,
> +	PARF_DEBUG_CNT_PM_LINKST_IN_L1SUB,
> +	PARF_DEBUG_CNT_PM_LINKST_IN_L1,
> +	PARF_DEBUG_CNT_PM_LINKST_IN_L0S,
> +	PARF_DEBUG_CNT_AUX_CLK_APP_REQ_EXIT_L1,
> +	PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L23,
> +	PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L1,
> +	PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1,
> +	PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2,
> +};
> +
>  struct qcom_pcie_resources_1_0_0 {
>  	struct clk_bulk_data *clks;
>  	int num_clks;
> @@ -275,12 +327,15 @@ struct qcom_pcie_ops {
>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>    * snooping
>    * @firmware_managed: Set if the Root Complex is firmware managed
> +  * @has_ext_parf_regs: Set if the PARF block implements the extended
> +  * register set used by qcom_pcie_dump_regs().
>    */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	bool override_no_snoop;
>  	bool firmware_managed;
>  	bool no_l0s;
> +	bool has_ext_parf_regs;
>  };
>  
>  struct qcom_pcie_perst {
> @@ -1597,12 +1652,14 @@ static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  
>  static const struct qcom_pcie_cfg cfg_1_9_0 = {
>  	.ops = &ops_1_9_0,
> +	.has_ext_parf_regs = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_1_34_0 = {
>  	.ops = &ops_1_9_0,
>  	.override_no_snoop = true,
>  	.no_l0s = true,
> +	.has_ext_parf_regs = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_2_1_0 = {
> @@ -1624,6 +1681,7 @@ static const struct qcom_pcie_cfg cfg_2_4_0 = {
>  
>  static const struct qcom_pcie_cfg cfg_2_7_0 = {
>  	.ops = &ops_2_7_0,
> +	.has_ext_parf_regs = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_2_9_0 = {
> @@ -1633,6 +1691,7 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>  static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.ops = &ops_1_21_0,
>  	.no_l0s = true,
> +	.has_ext_parf_regs = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_fw_managed = {
> @@ -1760,6 +1819,287 @@ static int qcom_pcie_set_max_opp(struct device *dev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_has_storage_ep_cb(struct pci_dev *pdev, void *data)
> +{
> +	bool *found = data;
> +
> +	if (pdev->class >> 16 == PCI_BASE_CLASS_STORAGE) {
> +		*found = true;
> +		return 1;
> +	}

Add pci_is_storage() helper in include/linux/pci.h

- Mani

-- 
மணிவண்ணன் சதாசிவம்
