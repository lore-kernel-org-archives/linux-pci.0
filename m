Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B416C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C5F20843
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C5F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeIZMy6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:54:58 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:64293 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZMy6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 08:54:58 -0400
Received: from [10.18.16.3] (10.18.16.3) by mail-sh2.amlogic.com (10.18.11.6)
 with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 14:44:01
 +0800
Subject: Re: [RESEND PATCH v3 2/2] PCI: meson: add the Amlogic Meson PCIe
 controller driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>
References: <1537509820-52040-1-git-send-email-hanjie.lin@amlogic.com>
 <1537509820-52040-3-git-send-email-hanjie.lin@amlogic.com>
 <20180921144740.GA21644@e107981-ln.cambridge.arm.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <49059c4c-f395-7d09-16be-eba16dad1555@amlogic.com>
Date:   Wed, 26 Sep 2018 14:44:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921144740.GA21644@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.16.3]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018/9/21 22:47, Lorenzo Pieralisi wrote:
> On Fri, Sep 21, 2018 at 02:03:40PM +0800, Hanjie Lin wrote:
>> From: Yue Wang <yue.wang@amlogic.com>
>>
>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>> PCI core. This patch adds the driver support for Meson PCIe controller.
> 
> Please read:
> 
> https://marc.info/?l=linux-pci&m=150905742808166&w=2
> 
> update the $SUBJECT accordingly, I can do it but you will repost anyway
> so please do it yourself while at it.
> 

OK, I will follow the list and check the patch. 

>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>> ---
>>  drivers/pci/controller/dwc/Kconfig     |  12 +
>>  drivers/pci/controller/dwc/Makefile    |   1 +
>>  drivers/pci/controller/dwc/pci-meson.c | 617 +++++++++++++++++++++++++++++++++
>>  3 files changed, 630 insertions(+)
>>  create mode 100644 drivers/pci/controller/dwc/pci-meson.c
> 
> I would request a MAINTAINERS update too.
> 

I will update MAINTAINERS in this patch of next-version.

>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 91b0194..6cb36f6 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -193,4 +193,16 @@ config PCIE_HISI_STB
>>  	help
>>            Say Y here if you want PCIe controller support on HiSilicon STB SoCs
>>  
>> +config PCI_MESON
>> +	bool "MESON PCIe controller"
>> +	depends on PCI
> 
> This is redundant, remove it.
>

Yes, really redundant I will remove it.
 
>> +	depends on PCI_MSI_IRQ_DOMAIN
>> +	select PCIEPORTBUS
> 
> There is no real dependency on it, this should be left to kernel
> configuration, remove it.
>

Yes, I will remove it.
 
>> +	select PCIE_DW_HOST
>> +	help
>> +	  Say Y here if you want to enable PCI controller support on Amlogic
>> +	  SoCs. The PCI controller on Amlogic is based on DesignWare hardware
>> +	  and therefore the driver re-uses the DesignWare core functions to
>> +	  implement the driver.
>> +
>>  endmenu
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index 5d2ce72..cf676bd 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>> +obj-$(CONFIG_PCI_MESON) += pci-meson.o
>>  
>>  # The following drivers are for devices that use the generic ACPI
>>  # pci_root.c driver but don't support standard ECAM config access.
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> new file mode 100644
>> index 0000000..9c92a89
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -0,0 +1,617 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe host controller driver for Amlogic MESON SoCs
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yue Wang <yue.wang@amlogic.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/resource.h>
>> +#include <linux/types.h>
>> +#include <linux/reset.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define to_meson_pcie(x) dev_get_drvdata((x)->dev)
> 
> Side note: this macro can be made dwc global since it is the same for all
> dwc based host bridges.
> 

Yes, actually this patch refers to the other drivers in dwc directory.

>> +/* External local bus interface registers */
>> +#define PLR_OFFSET			0x700
>> +#define PCIE_PORT_LINK_CTRL_OFF		(PLR_OFFSET + 0x10)
>> +#define FAST_LINK_MODE			BIT(7)
>> +#define LINK_CAPABLE_MASK		GENMASK(21, 16)
>> +#define LINK_CAPABLE_X1			BIT(16)
>> +
>> +#define PCIE_GEN2_CTRL_OFF		(PLR_OFFSET + 0x10c)
>> +#define NUM_OF_LANES_MASK		GENMASK(12, 8)
>> +#define NUM_OF_LANES_X1			BIT(8)
>> +#define DIRECT_SPEED_CHANGE		BIT(17)
>> +
>> +#define TYPE1_HDR_OFFSET		0x0
>> +#define PCIE_STATUS_COMMAND		(TYPE1_HDR_OFFSET + 0x04)
>> +#define PCI_IO_EN			BIT(0)
>> +#define PCI_MEM_SPACE_EN		BIT(1)
>> +#define PCI_BUS_MASTER_EN		BIT(2)
>> +
>> +#define PCIE_BASE_ADDR0			(TYPE1_HDR_OFFSET + 0x10)
>> +#define PCIE_BASE_ADDR1			(TYPE1_HDR_OFFSET + 0x14)
>> +
>> +#define PCIE_CAP_OFFSET			0x70
>> +#define PCIE_DEV_CTRL_DEV_STUS		(PCIE_CAP_OFFSET + 0x08)
>> +#define PCIE_CAP_MAX_PAYLOAD_MASK	GENMASK(7, 5)
>> +#define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
>> +#define PCIE_CAP_MAX_READ_REQ_MASK	GENMASK(14, 12)
>> +#define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
>> +
>> +#define PCI_CLASS_REVISION_MASK		GENMASK(7, 0)
>> +
>> +/* PCIe specific config registers */
>> +#define PCIE_CFG0			0x0
>> +#define APP_LTSSM_ENABLE		BIT(7)
>> +
>> +#define PCIE_CFG_STATUS12		0x30
>> +#define IS_SMLH_LINK_UP(x)		((x) & (1 << 6))
>> +#define IS_RDLH_LINK_UP(x)		((x) & (1 << 16))
>> +#define IS_LTSSM_UP(x)			((((x) >> 10) & 0x1f) == 0x11)
>> +
>> +#define PCIE_CFG_STATUS17		0x44
>> +#define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
>> +
>> +#define WAIT_LINKUP_TIMEOUT		2000
>> +#define PORT_CLK_RATE			100000000UL
>> +#define MAX_PAYLOAD_SIZE		256
>> +#define MAX_READ_REQ_SIZE		256
>> +#define MESON_PCIE_PHY_POWERUP		0x1c
>> +#define PCIE_RESET_DELAY		500
>> +#define PCIE_SHARED_RESET		1
>> +#define PCIE_NORMAL_RESET		0
>> +
>> +enum pcie_data_rate {
>> +	PCIE_GEN1,
>> +	PCIE_GEN2,
>> +	PCIE_GEN3,
>> +	PCIE_GEN4
>> +};
>> +
>> +struct meson_pcie_mem_res {
>> +	void __iomem *elbi_base; /* DT 0th resource */
>> +	void __iomem *cfg_base; /* DT 1nd resource */
>> +	void __iomem *phy_base; /* DT 2nd resource */
>> +};
>> +
>> +struct meson_pcie_clk_res {
>> +	struct clk *clk;
>> +	struct clk *mipi_gate;
>> +	struct clk *port_clk;
>> +	struct clk *general_clk;
>> +};
>> +
>> +struct meson_pcie_rc_reset {
>> +	struct reset_control *phy;
>> +	struct reset_control *port;
>> +	struct reset_control *apb;
>> +};
>> +
>> +struct meson_pcie {
>> +	struct dw_pcie pci;
>> +	struct meson_pcie_mem_res mem_res;
>> +	struct meson_pcie_clk_res clk_res;
>> +	struct meson_pcie_rc_reset mrst;
>> +	struct gpio_desc *reset_gpio;
>> +
>> +	enum of_gpio_flags gpio_flag;
>> +	int pcie_num;
>> +	u32 port_num;
>> +	u32 device_attch;
> 
> What's this variable for and is it really needed ?
> 

It was designed for dw_pcie_host_ops operations protection.
It seems to be unnecessary when we looking into the code.
We will continue to confirm and remove it if necessary.

>> +};
>> +
>> +static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
>> +						  const char *id,
>> +						  u32 reset_type)
>> +{
>> +	struct device *dev = mp->pci.dev;
>> +	struct reset_control *reset;
>> +
>> +	if (reset_type == PCIE_SHARED_RESET)
>> +		reset = devm_reset_control_get_shared(dev, id);
>> +	else
>> +		reset = devm_reset_control_get(dev, id);
>> +
>> +	return reset;
>> +}
>> +
>> +static int meson_pcie_get_resets(struct meson_pcie *mp)
>> +{
>> +	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>> +
>> +	mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
>> +	if (IS_ERR(mrst->phy))
>> +		return PTR_ERR(mrst->phy);
>> +	reset_control_deassert(mrst->phy);
>> +
>> +	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
>> +	if (IS_ERR(mrst->port))
>> +		return PTR_ERR(mrst->port);
>> +	reset_control_deassert(mrst->port);
>> +
>> +	mrst->apb = meson_pcie_get_reset(mp, "apb", PCIE_SHARED_RESET);
>> +	if (IS_ERR(mrst->apb))
>> +		return PTR_ERR(mrst->apb);
>> +	reset_control_deassert(mrst->apb);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
>> +					       struct meson_pcie *mp,
>> +					       const char *id)
>> +{
>> +	struct resource *res;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
>> +
>> +	return ioremap(res->start, resource_size(res));
>> +}
>> +
>> +static void __iomem *meson_pcie_get_mem(struct platform_device *pdev,
>> +					struct meson_pcie *mp,
>> +					const char *id)
>> +{
>> +	struct device *dev = mp->pci.dev;
>> +	struct resource *res;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
>> +
>> +	return devm_ioremap_resource(dev, res);
>> +}
>> +
>> +static int meson_pcie_get_mems(struct platform_device *pdev,
>> +			       struct meson_pcie *mp)
>> +{
>> +	mp->mem_res.elbi_base = meson_pcie_get_mem(pdev, mp, "elbi");
>> +	if (IS_ERR(mp->mem_res.elbi_base))
>> +		return PTR_ERR(mp->mem_res.elbi_base);
>> +
>> +	mp->mem_res.cfg_base = meson_pcie_get_mem(pdev, mp, "cfg");
>> +	if (IS_ERR(mp->mem_res.cfg_base))
>> +		return PTR_ERR(mp->mem_res.cfg_base);
>> +
>> +	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
>> +	if (IS_ERR(mp->mem_res.phy_base))
>> +		return PTR_ERR(mp->mem_res.phy_base);
> 
> I do no understand the logic behind this _shared() extension and how
> it would work in the failure path.
> 

Yes, this 'shared' likely to leads to some confusion.
Because we have two PCI controllers in meson SoC and they share one phy register
bank to handle power-on thing, so it's just a prompt.
Currently there is no error-handler and does not check the res before ioremap().
I think it's better to use devm_ioremap_resource() instead and give a comment for
'phy' register.

>> +	return 0;
>> +}
>> +
>> +static void meson_pcie_power_on(struct meson_pcie *mp)
>> +{
>> +	writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
>> +}
>> +
>> +static void meson_pcie_reset(struct meson_pcie *mp)
>> +{
>> +	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>> +
>> +	reset_control_assert(mrst->phy);
>> +	udelay(PCIE_RESET_DELAY);
>> +	reset_control_deassert(mrst->phy);
>> +	udelay(PCIE_RESET_DELAY);
>> +
>> +	reset_control_assert(mrst->port);
>> +	reset_control_assert(mrst->apb);
>> +	udelay(PCIE_RESET_DELAY);
>> +	reset_control_deassert(mrst->port);
>> +	reset_control_deassert(mrst->apb);
>> +	udelay(PCIE_RESET_DELAY);
>> +}
>> +
>> +static inline struct clk *meson_pcie_probe_clock(struct device *dev,
>> +						 const char *id, u64 rate)
>> +{
>> +	struct clk *clk = NULL;
> 
> Nit: useless initialization.
> 

OK, I will remove it.

>> +	int ret;
>> +
>> +	clk = devm_clk_get(dev, id);
>> +	if (IS_ERR(clk))
>> +		return clk;
>> +
>> +	if (rate) {
>> +		ret = clk_set_rate(clk, rate);
>> +		if (ret) {
>> +			dev_err(dev, "set clk rate failed, ret = %d\n", ret);
>> +			return ERR_PTR(ret);
>> +		}
>> +	}
>> +
>> +	ret = clk_prepare_enable(clk);
>> +	if (ret) {
>> +		dev_err(dev, "couldn't enable clk\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	devm_add_action_or_reset(dev,
>> +				 (void (*) (void *))clk_disable_unprepare,
>> +				 clk);
>> +
>> +	return clk;
>> +}
>> +
>> +static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>> +{
>> +	struct device *dev = mp->pci.dev;
>> +	struct meson_pcie_clk_res *res = &mp->clk_res;
>> +
>> +	res->port_clk = meson_pcie_probe_clock(dev, "port", PORT_CLK_RATE);
>> +	if (IS_ERR(res->port_clk))
>> +		return PTR_ERR(res->port_clk);
>> +
>> +	res->mipi_gate = meson_pcie_probe_clock(dev, "pcie_mipi_en", 0);
>> +	if (IS_ERR(res->mipi_gate))
>> +		return PTR_ERR(res->mipi_gate);
>> +
>> +	res->general_clk = meson_pcie_probe_clock(dev, "pcie_general", 0);
>> +	if (IS_ERR(res->general_clk))
>> +		return PTR_ERR(res->general_clk);
>> +
>> +	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
>> +	if (IS_ERR(res->clk))
>> +		return PTR_ERR(res->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 reg)
>> +{
>> +	writel(val, mp->mem_res.elbi_base + reg);
>> +}
>> +
>> +static inline u32 meson_elb_readl(struct meson_pcie *mp, u32 reg)
>> +{
>> +	return readl(mp->mem_res.elbi_base + reg);
>> +}
>> +
>> +static inline u32 meson_cfg_readl(struct meson_pcie *mp, u32 reg)
>> +{
>> +	return readl(mp->mem_res.cfg_base + reg);
>> +}
>> +
>> +static inline void meson_cfg_writel(struct meson_pcie *mp, u32 val, u32 reg)
>> +{
>> +	writel(val, mp->mem_res.cfg_base + reg);
>> +}
>> +
>> +static void meson_pcie_assert_reset(struct meson_pcie *mp)
>> +{
>> +	gpiod_set_value_cansleep(mp->reset_gpio, 0);
>> +	udelay(500);
>> +	gpiod_set_value_cansleep(mp->reset_gpio, 1);
>> +}
>> +
>> +static void meson_pcie_init_dw(struct meson_pcie *mp)
>> +{
>> +	u32 val = 0;
> 
> Useless initialization.
> 

OK, I will remove it.

>> +	val = meson_cfg_readl(mp, PCIE_CFG0);
>> +	val |= APP_LTSSM_ENABLE;
>> +	meson_cfg_writel(mp, val, PCIE_CFG0);
>> +
>> +	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
>> +	val &= ~LINK_CAPABLE_MASK;
>> +	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
>> +
>> +	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
>> +	val |= LINK_CAPABLE_X1 | FAST_LINK_MODE;
>> +	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
>> +
>> +	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
>> +	val &= ~NUM_OF_LANES_MASK;
>> +	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
>> +
>> +	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
>> +	val |= NUM_OF_LANES_X1 | DIRECT_SPEED_CHANGE;
>> +	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
>> +
>> +	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR0);
>> +	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR1);
>> +}
>> +
>> +static int meson_size_to_payload(int size)
>> +{
>> +	if (size & (size - 1) || size < 128 || size > 4096)
>> +		return 1;
> 
> Please expain this statement. It deserves a comment at least.
> 

Yes, I will add the comment in next-version.

>> +
>> +	return fls(size) - 8;
>> +}
>> +
>> +static void meson_set_max_payload(struct meson_pcie *mp, int size)
>> +{
>> +	u32 val = 0;
>> +	int max_payload_size = meson_size_to_payload(size);
>> +
>> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
>> +	val &= ~PCIE_CAP_MAX_PAYLOAD_MASK;
>> +	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
>> +
>> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
>> +	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
>> +	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
>> +}
>> +
>> +static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>> +{
>> +	u32 val = 0;
> 
> Useless initialization.
> 

OK, I will remove it.

>> +	int max_rd_req_size = meson_size_to_payload(size);
>> +
>> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
>> +	val &= ~PCIE_CAP_MAX_READ_REQ_MASK;
>> +	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
>> +
>> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
>> +	val |= PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size);
>> +	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
>> +}
>> +
>> +static inline void meson_enable_memory_space(struct meson_pcie *mp)
>> +{
>> +	/* Set the RC Bus Master, Memory Space and I/O Space enables */
>> +	meson_elb_writel(mp, PCI_IO_EN | PCI_MEM_SPACE_EN | PCI_BUS_MASTER_EN,
>> +			 PCIE_STATUS_COMMAND);
>> +}
>> +
>> +static int meson_pcie_establish_link(struct meson_pcie *mp)
>> +{
>> +	struct dw_pcie *pci = &mp->pci;
>> +	struct pcie_port *pp = &pci->pp;
>> +
>> +	meson_pcie_init_dw(mp);
>> +	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
>> +	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
>> +
>> +	dw_pcie_setup_rc(pp);
>> +	meson_enable_memory_space(mp);
>> +
>> +	meson_pcie_assert_reset(mp);
>> +
>> +	/* check if the link is up or not */
>> +	if (!dw_pcie_wait_for_link(pci))
>> +		return 0;
>> +
>> +	return -ETIMEDOUT;
> 
> 	return dw_pcie_wait_for_link(pci));
> 
> ?
> 

Yes, it's more clear.
	
>> +}
>> +
>> +static void meson_pcie_msi_init(struct meson_pcie *mp)
>> +{
>> +	struct pcie_port *pp = &mp->pci.pp;
>> +
>> +	dw_pcie_msi_init(pp);
>> +}
>> +
>> +static void meson_pcie_enable_interrupts(struct meson_pcie *mp)
>> +{
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		meson_pcie_msi_init(mp);
>> +}
> 
> You do not need two functions to do what can be done in one.
> 
> All you need is struct pcie_port instead of calling this function
> with struct meson_pci.
> 

Yes, these two functions are too redundant.
I will remove function meson_pcie_msi_init().

>> +
>> +static u32 meson_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
>> +			       u32 reg, size_t size)
>> +{
>> +	u32 val;
>> +
>> +	dw_pcie_read(base + reg, size, &val);
>> +
>> +	return val;
>> +}
>> +
>> +static void meson_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
>> +				 u32 reg, size_t size, u32 val)
>> +{
>> +	dw_pcie_write(base + reg, size, val);
>> +}
> 
> Nit: there is nothing dbi specific in these two functions.
> 

We will check this code.

>> +
>> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>> +				  u32 *val)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct meson_pcie *mp = to_meson_pcie(pci);
>> +
>> +	if (!mp->device_attch)
>> +		return 0;
> 
> Why do you need this guard ?
> 

We'll continue to check this guard and remove it if necessary.

>> +
>> +	/* the device class is not reported correctly from the register */
>> +	if (where == PCI_CLASS_REVISION) {
>> +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
>> +		/* keep revision id */
>> +		*val &= PCI_CLASS_REVISION_MASK;
>> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
>> +		return PCIBIOS_SUCCESSFUL;
>> +	}
>> +
>> +	return dw_pcie_read(pci->dbi_base + where, size, val);
>> +}
>> +
>> +static int meson_pcie_wr_own_conf(struct pcie_port *pp, int where,
>> +				  int size, u32 val)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct meson_pcie *mp = to_meson_pcie(pci);
>> +
>> +	if (!mp->device_attch)
>> +		return 0;
> 
> Same question.
> 
>> +
>> +	return dw_pcie_write(pci->dbi_base + where, size, val);
>> +}
>> +
>> +static int meson_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct meson_pcie *mp = to_meson_pcie(pci);
>> +	struct device *dev = pci->dev;
>> +	u32 smlh_up = 0;
>> +	u32 ltssm_up = 0;
>> +	u32 rdlh_up = 0;
>> +	u32 speed_okay = 0;
>> +	u32 cnt = 0;
>> +	u32 state12, state17;
>> +
>> +	while (smlh_up == 0 || rdlh_up == 0 || ltssm_up == 0 ||
>> +	       speed_okay == 0) {
>> +		udelay(20);
>> +
>> +		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
>> +		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
>> +		smlh_up = IS_SMLH_LINK_UP(state12);
>> +		rdlh_up = IS_RDLH_LINK_UP(state12);
>> +		ltssm_up = IS_LTSSM_UP(state12);
>> +
>> +		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
>> +			speed_okay = 1;
>> +
>> +		if (smlh_up)
>> +			dev_dbg(dev, "smlh_link_up is on\n");
>> +		if (rdlh_up)
>> +			dev_dbg(dev, "rdlh_link_up is on\n");
>> +		if (ltssm_up)
>> +			dev_dbg(dev, "ltssm_up is on\n");
>> +		if (speed_okay)
>> +			dev_dbg(dev, "speed_okay\n");
>> +
>> +		cnt++;
>> +
>> +		if (cnt >= WAIT_LINKUP_TIMEOUT) {
>> +			dev_err(dev, "Error: Wait linkup timeout.\n");
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static int meson_pcie_host_init(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct meson_pcie *mp = to_meson_pcie(pci);
>> +	int ret;
>> +
>> +	ret = meson_pcie_establish_link(mp);
>> +
> 
> Remove this empty line.
> 

OK.

>> +	if (ret)
>> +		return ret;
>> +
>> +	mp->device_attch = 1;
> 
> I want to understand why you need this variable at all (and why it is
> an u32).
> 
>> +	meson_pcie_enable_interrupts(mp);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dw_pcie_host_ops meson_pcie_host_ops = {
>> +	.rd_own_conf = meson_pcie_rd_own_conf,
>> +	.wr_own_conf = meson_pcie_wr_own_conf,
>> +	.host_init = meson_pcie_host_init,
>> +};
>> +
>> +static int meson_add_pcie_port(struct meson_pcie *mp,
>> +			       struct platform_device *pdev)
>> +{
>> +	struct dw_pcie *pci = &mp->pci;
>> +	struct pcie_port *pp = &pci->pp;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +		pp->msi_irq = platform_get_irq(pdev, 0);
>> +		if (pp->msi_irq < 0) {
>> +			dev_err(dev, "failed to get msi irq\n");
>> +			return pp->msi_irq;
>> +		}
>> +	}
>> +
>> +	pp->root_bus_nr = -1;
> 
> This is useless, since it is initialized in dw_pcie_host_init(), remove
> it.
> 

Yes, we will remove it.

>> +	pp->ops = &meson_pcie_host_ops;
>> +	pci->dbi_base = mp->mem_res.elbi_base;
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(dev, "failed to initialize host\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +	.read_dbi = meson_pcie_read_dbi,
>> +	.write_dbi = meson_pcie_write_dbi,
>> +	.link_up = meson_pcie_link_up,
>> +};
>> +
>> +static int meson_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct dw_pcie *pci;
>> +	struct meson_pcie *mp;
>> +	int ret;
>> +
>> +	mp = devm_kzalloc(dev, sizeof(*mp), GFP_KERNEL);
>> +	if (!mp)
>> +		return -ENOMEM;
>> +
>> +	pci = &mp->pci;
>> +	pci->dev = dev;
>> +	pci->ops = &dw_pcie_ops;
>> +
>> +	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(mp->reset_gpio)) {
>> +		dev_err(dev, "Get reset gpio failed\n");
>> +		return PTR_ERR(mp->reset_gpio);
>> +	}
>> +
>> +	ret = meson_pcie_get_resets(mp);
>> +	if (ret) {
>> +		dev_err(dev, "Get reset resource failed, %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = meson_pcie_get_mems(pdev, mp);
>> +	if (ret) {
>> +		dev_err(dev, "Get memory resource failed, %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	meson_pcie_power_on(mp);
>> +	meson_pcie_reset(mp);
>> +
>> +	ret = meson_pcie_probe_clocks(mp);
>> +	if (ret) {
>> +		dev_err(dev, "Init clock resources failed, %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, mp);
>> +
>> +	ret = meson_add_pcie_port(mp, pdev);
>> +	if (ret < 0)
>> +		dev_err(dev, "Add PCIE port failed, %d\n", ret);
> 
> Isn't this fatal ?
> 
> Thanks,
> Lorenzo
> 

Yes, it's a fatal error we will fix it.

Thanks,
Hanjie

>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id meson_pcie_of_match[] = {
>> +	{
>> +		.compatible = "amlogic,axg-pcie",
>> +	},
>> +	{},
>> +};
>> +
>> +static struct platform_driver meson_pcie_driver = {
>> +	.probe = meson_pcie_probe,
>> +	.driver = {
>> +		.name = "meson-pcie",
>> +		.of_match_table = meson_pcie_of_match,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(meson_pcie_driver);
>> -- 
>> 2.7.4
>>
> 
> .
> 
