Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:55263 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcCDIJk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2016 03:09:40 -0500
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <56D5E3DF.9030906@tekno-soft.it> <56D71F27.7070708@tekno-soft.it>
 <20160302195634.GA19223@localhost>
 <DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D80435.90408@tekno-soft.it>
 <DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D8180A.1050708@tekno-soft.it> <56D84B6D.1050800@tekno-soft.it>
 <56D883AD.5060601@tekno-soft.it>
 <DBXPR04MB270332ED36095F8A86EA2828CBE0@DBXPR04MB270.eurprd04.prod.outlook.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56D942B1.9080802@tekno-soft.it>
Date: Fri, 4 Mar 2016 09:09:21 +0100
MIME-Version: 1.0
In-Reply-To: <DBXPR04MB270332ED36095F8A86EA2828CBE0@DBXPR04MB270.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/04/2016 08:11 AM, Richard Zhu wrote:

Hi Richard,

>> -----Original Message-----
>> > From: Roberto Fichera [mailto:kernel@tekno-soft.it]
>> > Sent: Friday, March 04, 2016 2:34 AM
>> > To: Richard Zhu; Bjorn Helgaas
>> > Cc: linux-pci@vger.kernel.org; Richard Zhu; Lucas Stach
>> > Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
>> > 
>> > On 03/03/2016 03:34 PM, Roberto Fichera wrote:
>> > 
>> > I've also checked clock, pll, PMU_MISC1 and CCGR[45] registers, all looks fine
>> > and exactly equal to uboot settings.
>> > 
>> > However I'm investigating a possible HW issue in the LDVS pad wiring against
>> > the bridge XIO2001. Let's see once this is also clarified.
>> > 
> [Zhu hongxing] it means there are no differences of the pcie initialization between uboot and kernel.
> But, pcie link is up in uboot, but failed to link up in kernel.
> Thus, we have to take look at the procedures of the initialization between uboot and kernel.
> As I remember that, the usage of the #PERST is different at least.
>
Yes! I've applied the logic below to properly reset the XIO2001

int imx6_pcie_toggle_power(struct pcie_port *pp)
{
    struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);

        /*
         * TI XIO2001 Power Up procedure:
         *
         * 1) Assert both GRST# and PERST# without power voltages
         */
    gpio_set_value(imx6_pcie->pwr_gpio, 0);
    gpio_set_value(imx6_pcie->reset_gpio, 0);
    gpio_set_value(imx6_pcie->grst_gpio, 0);
    usleep_range(10000, 20000);

        /*
         * 2) Apply 1.5V and 3.3V voltages
         */
    gpio_set_value(imx6_pcie->pwr_gpio, 1);
    usleep_range(10000, 20000);

        /*
         * 3) Deassert GRST#
         */
    gpio_set_value(imx6_pcie->grst_gpio, 1);

        /*
         * 4) After that we should apply a stable PCIe reference clock
         */
    return 0;
}

and in the imx6_pcie_deassert_core_reset() I have:

static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
{
    struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
    int ret;

-->>>    imx6_pcie_toggle_power(pp);

    ret = clk_prepare_enable(imx6_pcie->pcie_phy);
    if (ret) {
        dev_err(pp->dev, "unable to enable pcie_phy clock\n");
        goto err_pcie_phy;
    }
...
...
    /* allow the clocks to stabilize */
    usleep_range(200, 500);

    /* Some boards don't have PCIe reset GPIO. */
    if (gpio_is_valid(imx6_pcie->reset_gpio)) {
        gpio_set_value(imx6_pcie->reset_gpio, 0);
        msleep(100);
        gpio_set_value(imx6_pcie->reset_gpio, 1);
    }
    return 0;

