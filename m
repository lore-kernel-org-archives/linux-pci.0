Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713DCC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 11:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415292184A
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 11:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbeLSLNU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:13:20 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:29505 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeLSLNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 06:13:20 -0500
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 19 Dec
 2018 19:13:47 +0800
Subject: Re: [PATCH v8 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
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
References: <1545120286-129258-1-git-send-email-hanjie.lin@amlogic.com>
 <1545120286-129258-3-git-send-email-hanjie.lin@amlogic.com>
 <20181218224708.GB22610@google.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <df9e974d-cac8-3522-fdbe-1811160bb4fc@amlogic.com>
Date:   Wed, 19 Dec 2018 19:13:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218224708.GB22610@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018/12/19 6:47, Bjorn Helgaas wrote:
> On Tue, Dec 18, 2018 at 04:04:46PM +0800, Hanjie Lin wrote:
>> From: Yue Wang <yue.wang@amlogic.com>
>>
>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>> PCI core. This patch adds the driver support for Meson PCIe controller.
> 
> I don't have any comments on the code itself; just the trivial things
> below.  No need to repost for these unless you're changing something
> else.
> 
> I thought it looked very pretty overall, thanks for paying attention
> to that!
> 
>> +static int meson_size_to_payload(struct meson_pcie *mp, int size)
>> +{
>> +	struct device *dev = mp->pci.dev;
>> +
>> +	/*
>> +	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
>> +	 * So if input size is not 2^order alignment or less than 2^7 or bigger
>> +	 * than 2^12, just set to default size 2^(1+7).
>> +	 */
>> +	if (!is_power_of_2(size) || size < 128 || size > 4096) {
>> +		dev_warn(dev, "playload size %d, set to default 256\n", size);
> 
> s/playload/payload/
> 
>> +static void meson_set_max_payload(struct meson_pcie *mp, int size)
>> +{
>> +	u32 val = 0;
> 
> Unnecessary initialization.
> 
>> +	int max_payload_size = meson_size_to_payload(mp, size);
>> +
>> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
> 
>> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>> +				  u32 *val)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	int ret;
>> +
>> +	ret = dw_pcie_read(pci->dbi_base + where, size, val);
>> +	if (ret != PCIBIOS_SUCCESSFUL)
>> +		return ret;
>> +
>> +	/*
>> +	 * There is a bug in the MESON AXG pcie controller whereby software
>> +	 * cannot programme the PCI_CLASS_DEVICE register, so we must fabricate
>> +	 * the return value in the config accessors.
> 
> s/pcie/PCIe/
> s/programme/program/ (IIUC, "programme" is British and only used as a
> noun, where here you need a verb)
> 
>> +static int meson_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct meson_pcie *mp = to_meson_pcie(pci);
>> +	struct device *dev = pci->dev;
>> +	u32 smlh_up = 0;
>> +	u32 ltssm_up = 0;
>> +	u32 rdlh_up = 0;
> 
> Unnecessary initialization of smlh_up, ltssm_up, and rdlh_up.
> 
>> +	u32 speed_okay = 0;
>> +	u32 cnt = 0;
>> +	u32 state12, state17;
>> +
>> +	do {
>> +		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
>> +		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
>> +		smlh_up = IS_SMLH_LINK_UP(state12);
>> +		rdlh_up = IS_RDLH_LINK_UP(state12);
>> +		ltssm_up = IS_LTSSM_UP(state12);
> 
>> +	dev_err(dev, "Error: Wait linkup timeout.\n");
> 
> Message doesn't match others from driver (capitalization and trailing
> period).
> 
>> +			dev_err(dev, "failed to get msi irq\n");
> 
> s/msi irq/MSI IRQ/
> 
>> +	ret = meson_add_pcie_port(mp, pdev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Add PCIE port failed, %d\n", ret);
> 
> s/PCIE/PCIe/
> 
> All the messages in this function are capitalized differently than
> other messages in the driver.
> 
> Bjorn
> 
> .
> 

hi Bjorn:

Thanks for the all suggestions and corrections.

There were too many code details unnecessary initialization, typing errors
and coding style etc. I will pay more attention to these rules and code-details
in the future patches also my daily work.

thanks again

hanjie.
