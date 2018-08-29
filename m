Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <c21a2e25c934d19f913f625542f505cf45754f23.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Hanjie Lin <hanjie.lin@amlogic.com>, Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 29 Aug 2018 17:57:43 +0200
In-Reply-To: <1535096006-152091-3-git-send-email-hanjie.lin@amlogic.com>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096006-152091-3-git-send-email-hanjie.lin@amlogic.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-pci@vger.kernel.org, Yixun Lan <yixun.lan@amlogic.com>,
 Yue Wang <yue.wang@amlogic.com>, Qiufang Dai <qiufang.dai@amlogic.com>,
 Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Liang Yang <liang.yang@amlogic.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-24 at 15:33 +0800, Hanjie Lin wrote:
> +static int meson_pcie_phy_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct meson_pcie_phy *mphy;
> +       struct meson_pcie_reset *mrst;
> +       struct phy *generic_phy;
> +       struct phy_provider *phy_provider;
> +       struct resource *res;
> +       const struct meson_pcie_phy_data *data;
> +
> +       data = of_device_get_match_data(dev);
> +       if (!data)
> +               return -ENODEV;
> +
> +       mphy = devm_kzalloc(dev, sizeof(*mphy), GFP_KERNEL);
> +       if (!mphy)
> +               return -ENOMEM;
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       mphy->phy_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(mphy->phy_base))
> +               return PTR_ERR(mphy->phy_base);
> +
> +       mrst = &mphy->reset;
> +
> +       mrst->phy = devm_reset_control_get_shared(dev, "phy");

I thought you said there was only phy on this platform.
If that's the case, what is this reset shared with ?

> +       if (IS_ERR(mrst->phy)) {
> +               if (PTR_ERR(mrst->phy) != -EPROBE_DEFER)
> +                       dev_err(dev, "couldn't get phy reset\n");
> +
> +               return PTR_ERR(mrst->phy);
> +       }
> +
> +       reset_control_deassert(mrst->phy);

Is it really necessary before init() is called by the consumer ?

> +
> +       mphy->data = data;
> +
> +       generic_phy = devm_phy_create(dev, dev->of_node, mphy->data->ops);
> +       if (IS_ERR(generic_phy)) {
> +               if (PTR_ERR(generic_phy) != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to create PHY\n");
> +
> +               return PTR_ERR(generic_phy);
> +       }
> +
> +       phy_set_drvdata(generic_phy, mphy);
> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static struct platform_driver meson_pcie_phy_driver = {
> +       .probe  = meson_pcie_phy_probe,
> +       .driver = {
> +               .of_match_table = meson_pcie_phy_match,
> +               .name           = "meson-pcie-phy",
> +       }
> +};



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
