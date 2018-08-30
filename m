Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51249 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeH3MDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 08:03:36 -0400
Subject: Re: [PATCH v2 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-pci@vger.kernel.org>, Yixun Lan <yixun.lan@amlogic.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096006-152091-3-git-send-email-hanjie.lin@amlogic.com>
 <c21a2e25c934d19f913f625542f505cf45754f23.camel@baylibre.com>
From: Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <b8deb2ef-5e73-b508-616e-b0303a0adc78@amlogic.com>
Date: Thu, 30 Aug 2018 16:02:53 +0800
MIME-Version: 1.0
In-Reply-To: <c21a2e25c934d19f913f625542f505cf45754f23.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/8/29 23:57, Jerome Brunet wrote:
> On Fri, 2018-08-24 at 15:33 +0800, Hanjie Lin wrote:
>> +static int meson_pcie_phy_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct meson_pcie_phy *mphy;
>> +       struct meson_pcie_reset *mrst;
>> +       struct phy *generic_phy;
>> +       struct phy_provider *phy_provider;
>> +       struct resource *res;
>> +       const struct meson_pcie_phy_data *data;
>> +
>> +       data = of_device_get_match_data(dev);
>> +       if (!data)
>> +               return -ENODEV;
>> +
>> +       mphy = devm_kzalloc(dev, sizeof(*mphy), GFP_KERNEL);
>> +       if (!mphy)
>> +               return -ENOMEM;
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       mphy->phy_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(mphy->phy_base))
>> +               return PTR_ERR(mphy->phy_base);
>> +
>> +       mrst = &mphy->reset;
>> +
>> +       mrst->phy = devm_reset_control_get_shared(dev, "phy");
> 
> I thought you said there was only phy on this platform.
> If that's the case, what is this reset shared with ?

Amlogic axg soc includes two pcie controllers and they share the same pcie phy.
Because of two pcie controllers, meson_pcie_phy_probe() will be called two times.
So, the phy reset must be shared.

> 
>> +       if (IS_ERR(mrst->phy)) {
>> +               if (PTR_ERR(mrst->phy) != -EPROBE_DEFER)
>> +                       dev_err(dev, "couldn't get phy reset\n");
>> +
>> +               return PTR_ERR(mrst->phy);
>> +       }
>> +
>> +       reset_control_deassert(mrst->phy);
> 
> Is it really necessary before init() is called by the consumer ?
> 

For shared reset we must deassert first before do assert,
currently if we don't do this deassert, we will get the below warning when
controller driver do the share reset.

int reset_control_assert(struct reset_control *rstc)
{
...
	if (rstc->shared) {
		if (WARN_ON(atomic_read(&rstc->deassert_count) == 0))




>> +
>> +       mphy->data = data;
>> +
>> +       generic_phy = devm_phy_create(dev, dev->of_node, mphy->data->ops);
>> +       if (IS_ERR(generic_phy)) {
>> +               if (PTR_ERR(generic_phy) != -EPROBE_DEFER)
>> +                       dev_err(dev, "failed to create PHY\n");
>> +
>> +               return PTR_ERR(generic_phy);
>> +       }
>> +
>> +       phy_set_drvdata(generic_phy, mphy);
>> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +       return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static struct platform_driver meson_pcie_phy_driver = {
>> +       .probe  = meson_pcie_phy_probe,
>> +       .driver = {
>> +               .of_match_table = meson_pcie_phy_match,
>> +               .name           = "meson-pcie-phy",
>> +       }
>> +};
> 
> 
> .
> 

Thanks for the review.

As described during the discussion [0], we consider it's too overkill to
have a dedicated phy driver which only process reset line. So we will abandon phy driver 
and integrate phy reset into the controller driver int the next version. 

[0] https://lkml.kernel.org/r/1535096165-45827-1-git-send-email-hanjie.lin@amlogic.
