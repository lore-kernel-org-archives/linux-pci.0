Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve1eur01on0046.outbound.protection.outlook.com ([104.47.1.46]:54624
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752583AbdHXSRJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 14:17:09 -0400
From: Roy Zang <roy.zang@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Subject: Re: [PATCHv4 0/9] PCI: dwc: refactor ls-pcie ->host_init() and fix
 bug for dw_pcie_setup_rc
Date: Thu, 24 Aug 2017 18:17:05 +0000
Message-ID: <DB6PR04MB2949583D9D281EF0D42671E28B9A0@DB6PR04MB2949.eurprd04.prod.outlook.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
 <20170824171752.GR31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/24/2017 12:17 PM, Bjorn Helgaas wrote:=0A=
> On Wed, Aug 23, 2017 at 02:08:47PM +0800, Zhiqiang Hou wrote:=0A=
>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>=0A=
>>=0A=
>> Drop the change for qcom pcie driver's fixup from 9/9, it seems qcom=0A=
>> pcie controller did not implement the register MISC_CONTROL_1_OFF.=0A=
>>=0A=
>> Hou Zhiqiang (9):=0A=
>>   PCI: layerscape: Add dw_pcie_setup_rc to ls-pcie common host init=0A=
>>   PCI: layerscape: move STRFMR1 access out from the DBI write-enable=0A=
>>     bracket=0A=
>>   PCI: layerscape: add class code and multifunction fixups for ls1021a=
=0A=
>>   PCI: layerscape: refactor the host_init function=0A=
>>   PCI: layerscape: Disable the outbound windows configured by bootloader=
=0A=
>>   PCI: designware: add accessors for write permission of DBI read-only=
=0A=
>>     registers=0A=
>>   PCI: layerscape: use accessors to enable/disable DBI RO registers'=0A=
>>     write permission=0A=
>>   PCI: designware: enable write permission before updating DBI RO=0A=
>>     registers=0A=
>>   PCI: dwc: remove the obsolete fixups=0A=
>>=0A=
>>  drivers/pci/dwc/pci-layerscape.c       | 90 ++++++++++++++++++---------=
-------=0A=
>>  drivers/pci/dwc/pcie-artpec6.c         |  6 ---=0A=
>>  drivers/pci/dwc/pcie-designware-host.c |  6 +++=0A=
>>  drivers/pci/dwc/pcie-designware.h      | 25 ++++++++++=0A=
>>  4 files changed, 80 insertions(+), 47 deletions(-)=0A=
> I had a couple minor comments on these, but mostly looks very nice.=0A=
>=0A=
> I'll be looking for an ack from Minghuan, Mingkai, or Roy for all the=0A=
> layerscape changes.  And from Niklas or Jesper for the artpec6 ones.=0A=
>=0A=
> Thanks, Joao, for already looking at all the designware stuff!=0A=
>=0A=
Bjorn,=0A=
=0A=
thanks.=0A=
=0A=
 Acked-by: Roy Zang <tie-fei.zang@freescale.com>=0A=
=0A=
Roy=0A=
=0A=
=0A=
=0A=
