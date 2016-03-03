Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:48449 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbcCCSen (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2016 13:34:43 -0500
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <56D5E3DF.9030906@tekno-soft.it> <56D71F27.7070708@tekno-soft.it>
 <20160302195634.GA19223@localhost>
 <DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D80435.90408@tekno-soft.it>
 <DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D8180A.1050708@tekno-soft.it> <56D84B6D.1050800@tekno-soft.it>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56D883AD.5060601@tekno-soft.it>
Date: Thu, 3 Mar 2016 19:34:21 +0100
MIME-Version: 1.0
In-Reply-To: <56D84B6D.1050800@tekno-soft.it>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/03/2016 03:34 PM, Roberto Fichera wrote:

I've also checked clock, pll, PMU_MISC1 and CCGR[45] registers, all looks fine
and exactly equal to uboot settings.

However I'm investigating a possible HW issue in the LDVS pad wiring against
the bridge XIO2001. Let's see once this is also clarified.

> On 03/03/2016 11:55 AM, Roberto Fichera wrote:
>> On 03/03/2016 10:39 AM, Richard Zhu wrote:
>>
>> Hi Richard,
>>
>>> [Zhu hongxing] The registers configured during the initialization.
>>> Regarding to the current situation at your side, the pcie link is up in uboot, but is down in kernel.
>>> So, you can compare the dump of the register configured during the pcie initialization between uboot and kernel.
>> Here is the register status before to start LTSSM under uboot
>>
>> ...
>> I2C:   ready
>> DRAM:  2 GiB
>> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
>>>>> GPR[1] (0x020e0004): 0x48611005
>>>>> GPR[5] (0x020e0014): 0x00000000
>>>>> GPR[8] (0x020e0020): 0xfffd4000
>>>>> GPR[12] (0x020e0030): 0x0f004090
>>>>> GPC_BASE_ADDR + 0 (0x020dc000): 0x00100000
>>>>> MX6_DBI_ADDR + 0x7c (0x01ffc07c): 0x0011cc11
>> DEBUG_R0: 0x036e2b11, DEBUG_R1: 0x08000410
>>   LTSSM current state: 0x11 (S_L0)
>>   PIPE transmit K indication: 0
>>   PIPE Transmit data: 0x6e2b
>>   Receiver is receiving logical idle: yes
>>
>> but the funny thing is under kernel, maybe related to some clock setting? see below
> Was my fault! Value are exactly the same I'm getting under uboot:
>
> I2C:   ready
> DRAM:  2 GiB
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
>>>> GPR[1] (0x020e0004): 0x48611005
>>>> GPR[8] (0x020e0020): 0xfffd4000
>>>> GPR[12] (0x020e0030): 0x0f004090
>>>> MX6_DBI_ADDR + 0x7c (0x01ffc07c): 0x0011cc11
> kernel:
>
> [    0.377668] imx6q-pcie 1ffc000.pcie: >>> GPR[1]: 0x48611005
> [    0.377705] imx6q-pcie 1ffc000.pcie: >>> GPR[8]: 0xfffd4000
> [    0.377720] imx6q-pcie 1ffc000.pcie: >>> GPR[12]: 0x0f004090
> [    0.377734] imx6q-pcie 1ffc000.pcie: >>> PCIE_RC_LCR (0xf08f007c): 0x0011cc11
> [    0.586591] imx6q-pcie 1ffc000.pcie: phy link never came up
>
>
>> [    0.235456] PCI host bridge /soc/pcie@0x01000000 ranges:
>> [    0.235475]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
>> [    0.235527]   err 0x01f00000..0x01f7ffff -> 0x01f00000
>> [    0.235577]    IO 0x01f80000..0x01f8ffff -> 0x00000000
>> [    0.235659]   MEM 0x01000000..0x01efffff -> 0x01000000
>> [    0.377644] imx6q-pcie 1ffc000.pcie: >>> GPR[1] (0x00000004): 0x00000000
>> [    0.377666] imx6q-pcie 1ffc000.pcie: >>> GPR[5] (0x00000014): 0x00000000
>> [    0.377684] imx6q-pcie 1ffc000.pcie: >>> GPR[8] (0x00000020): 0x00000000
>> [    0.377701] imx6q-pcie 1ffc000.pcie: >>> GPR[12] (0x00000030): 0x00000000
>> [    0.377717] imx6q-pcie 1ffc000.pcie: >>> PCIE_RC_LCR (0xf08f007c): 0x0011cc11
>> [    0.586532] imx6q-pcie 1ffc000.pcie: phy link never came up
>> [    0.586551] imx6q-pcie 1ffc000.pcie: LTSSM current state: 0x3 (S_POLL_COMPLIANCE)
>> [    0.586566] imx6q-pcie 1ffc000.pcie: PIPE transmit K indication: 1
>> [    0.586579] imx6q-pcie 1ffc000.pcie: PIPE Transmit data: 0xb5bc
>> [    0.586592] imx6q-pcie 1ffc000.pcie: Receiver is receiving logical idle: no
>>
>> The code I've used to dump the register is using regmap_read(),
>>
>> #define IMX6_DUMP_REGISTER(__map, __reg, __name) \
>>   do {\
>>     uint32_t val;\
>>     val = regmap_read(__map, __reg, &val);\
>>     dev_err(pp->dev, ">>> " __name " (0x%08p): 0x%08x\n", __reg, val);\
>>   } while(0)
>>
>> #define IMX6_DUMP_REGISTER2(__reg, __name) \
>>   do {\
>>     uint32_t val;\
>>     val = readl(__reg);\
>>     dev_err(pp->dev, ">>> " __name " (0x%08p): 0x%08x\n", __reg, val);\
>>   } while(0)
>>
>>
>> static void imx6_pcie_dump_registers(struct pcie_port *pp)
>> {
>>     struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>>
>>         IMX6_DUMP_REGISTER(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, "GPR[1]");
>>         IMX6_DUMP_REGISTER(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5, "GPR[5]");
>>         IMX6_DUMP_REGISTER(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8, "GPR[8]");
>>         IMX6_DUMP_REGISTER(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, "GPR[12]");
>>         IMX6_DUMP_REGISTER2(pp->dbi_base + PCIE_RC_LCR, "PCIE_RC_LCR");
>> }
>>
>> Cheers,
>> Roberto Fichera.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

