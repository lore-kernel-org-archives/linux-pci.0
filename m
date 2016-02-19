Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36767 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422953AbcBSUZq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2016 15:25:46 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so84754753vkb.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Feb 2016 12:25:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160204172544.GA19957@localhost>
References: <1452871476-11752-1-git-send-email-justin.waters@timesys.com> <20160204172544.GA19957@localhost>
From: Justin Waters <justin.waters@timesys.com>
Date: Fri, 19 Feb 2016 15:25:26 -0500
Message-ID: <CAENNV6+gn1hpz2PFp05F2Mf8zUcc8kN7MZEijDrY6JPMUcueAg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: imx6: Add DT bindings to configure Tx Driver settings
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 4, 2016 at 12:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Richard]
>
> On Fri, Jan 15, 2016 at 10:24:35AM -0500, Justin Waters wrote:
>> The settings in GPR8 are dependent upon the particular layout of the
>> hardware platform. As such, they should be configurable via the device
>> tree.
>>
>> As many boards have been using the default values, this implementation
>> uses the old values if they are not specified in the device tree.
>>
>> Signed-off-by: Justin Waters <justin.waters@timesys.com>
>
> Waiting for an ack from Lucas, since he had comments on the last version.
>

Lucas, I just wanted to check in and see if you had any additional
feedback for me. Did v2 address your concerns?

Thank you,

-Justin

>> ---
>>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  7 ++++
>>  drivers/pci/host/pci-imx6.c                        | 42 +++++++++++++++++++---
>>  2 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> index 6fbba53..3be80c6 100644
>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
>> @@ -13,6 +13,13 @@ Required properties:
>>  - clock-names: Must include the following additional entries:
>>       - "pcie_phy"
>>
>> +Optional properties:
>> +- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
>> +- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
>> +- fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
>> +- fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
>> +- fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
>> +
>>  Example:
>>
>>       pcie@0x01000000 {
>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> index 230ebf9..cc04497 100644
>> --- a/drivers/pci/host/pci-imx6.c
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -39,6 +39,11 @@ struct imx6_pcie {
>>       struct pcie_port        pp;
>>       struct regmap           *iomuxc_gpr;
>>       void __iomem            *mem_base;
>> +     u32                     tx_deemph_gen1;
>> +     u32                     tx_deemph_gen2_3p5db;
>> +     u32                     tx_deemph_gen2_6db;
>> +     u32                     tx_swing_full;
>> +     u32                     tx_swing_low;
>>  };
>>
>>  /* PCIe Root Complex registers (memory-mapped) */
>> @@ -317,15 +322,20 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>>                       IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
>>
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> -                     IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
>> +                        IMX6Q_GPR8_TX_DEEMPH_GEN1,
>> +                        imx6_pcie->tx_deemph_gen1 << 0);
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> -                     IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB, 0 << 6);
>> +                        IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
>> +                        imx6_pcie->tx_deemph_gen2_3p5db << 6);
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> -                     IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB, 20 << 12);
>> +                        IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
>> +                        imx6_pcie->tx_deemph_gen2_6db << 12);
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> -                     IMX6Q_GPR8_TX_SWING_FULL, 127 << 18);
>> +                        IMX6Q_GPR8_TX_SWING_FULL,
>> +                        imx6_pcie->tx_swing_full << 18);
>>       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> -                     IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
>> +                        IMX6Q_GPR8_TX_SWING_LOW,
>> +                        imx6_pcie->tx_swing_low << 25);
>>  }
>>
>>  static int imx6_pcie_wait_for_link(struct pcie_port *pp)
>> @@ -565,6 +575,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>>       struct imx6_pcie *imx6_pcie;
>>       struct pcie_port *pp;
>>       struct resource *dbi_base;
>> +     struct device_node *node = pdev->dev.of_node;
>>       int ret;
>>
>>       imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
>> @@ -617,6 +628,27 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>>               return PTR_ERR(imx6_pcie->iomuxc_gpr);
>>       }
>>
>> +     /* Grab PCIe PHY Tx Settings */
>> +     if (of_property_read_u32
>> +         (node, "fsl,tx-deemph-gen1", &imx6_pcie->tx_deemph_gen1))
>> +             imx6_pcie->tx_deemph_gen1 = 0;
>> +
>> +     if (of_property_read_u32
>> +         (node, "fsl,tx-deemph-gen2-3p5db", &imx6_pcie->tx_deemph_gen2_3p5db))
>> +             imx6_pcie->tx_deemph_gen2_3p5db = 0;
>> +
>> +     if (of_property_read_u32
>> +         (node, "fsl,tx-deemph-gen2-6db", &imx6_pcie->tx_deemph_gen2_6db))
>> +             imx6_pcie->tx_deemph_gen2_6db = 20;
>> +
>> +     if (of_property_read_u32
>> +         (node, "fsl,tx-swing-full", &imx6_pcie->tx_swing_full))
>> +             imx6_pcie->tx_swing_full = 127;
>> +
>> +     if (of_property_read_u32
>> +         (node, "fsl,tx-swing-low", &imx6_pcie->tx_swing_low))
>> +             imx6_pcie->tx_swing_low = 127;
>> +
>>       ret = imx6_add_pcie_port(pp, pdev);
>>       if (ret < 0)
>>               return ret;
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
