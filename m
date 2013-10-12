Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:43199
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752256Ab3JLCQX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Oct 2013 22:16:23 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>
CC: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: RE: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Sat, 12 Oct 2013 02:16:17 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40A9C9@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
	<201310110418.56460.marex@denx.de>
	<CAE9FiQXKgkwgzA0ciRyahObDHvnFtEJxzOhHRo6gytdeKQ-XQQ@mail.gmail.com>
	<201310111644.22844.marex@denx.de>
 <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
In-Reply-To: <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim:
As I know that the clock of pcie controller should be always running.
There are not clock gate on/off operations in host driver after the initialization.


Best Regards
Richard Zhu


-----Original Message-----
From: Tim Harvey [mailto:tharvey@gateworks.com] 
Sent: Friday, October 11, 2013 11:25 PM
To: Marek Vasut
Cc: Yinghai Lu; Bjorn Helgaas; Zhu Richard-R65037; linux-arm-kernel@lists.infradead.org; Shawn Guo; linux-pci@vger.kernel.org; Frank Li; Sean Cross; Sascha Hauer
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q

Marek,

Looks like you and I are getting the same results now.  Device enumeration is working fine through the switch however when I attempt to use a device behind the switch (gige adapter in my case) I find that I get a few interrupts to that devices irq handler then the system hangs (like what occurs when a read is done to dbi without the pcie controllers clock running).

Anyone have any ideas?

Tim

On Fri, Oct 11, 2013 at 7:44 AM, Marek Vasut <marex@denx.de> wrote:
> Hi Yinghai,
>
>> On Thu, Oct 10, 2013 at 7:18 PM, Marek Vasut <marex@denx.de> wrote:
>> > And so does the probe log (but the pcieport failure still persists):
>> >
>> >
>> > pci_bus 0000:04: bus scan returning with max=04 pci_bus 0000:04: 
>> > busn_res: [bus 04-ff] end is updated to 04 pci_bus 0000:02: bus 
>> > scan returning with max=04 pci_bus 0000:02: busn_res: [bus 02-ff] 
>> > end is updated to 04 pci_bus 0000:01: bus scan returning with 
>> > max=04 pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 04 
>> > pci_bus 0000:00: bus scan returning with max=04 pci_bus 0000:00: 
>> > busn_res: [bus 00-ff] end is updated to 04
>> > PCI: Device 0000:00:00.0 not available because of resource 
>> > collisions
>> > pcieport: probe of 0000:00:00.0 failed with error -22
>>
>> load pcieport driver too early.
>
> OK
>
> [...]
>
>> > pci_bus 0000:00: resource 4 [io  0x1000-0x10000] pci_bus 0000:00: 
>> > resource 5 [mem 0x01000000-0x01efffff] pci_bus 0000:01: resource 0 
>> > [io  0x1000-0x1fff] pci_bus 0000:01: resource 1 [mem 
>> > 0x01000000-0x01bfffff] pci_bus 0000:02: resource 0 [io  
>> > 0x1000-0x1fff] pci_bus 0000:02: resource 1 [mem 
>> > 0x01000000-0x01bfffff] pci_bus 0000:03: resource 0 [io  
>> > 0x1000-0x1fff] pci_bus 0000:03: resource 1 [mem 
>> > 0x01000000-0x01bfffff]
>>
>> Looks your arch call pci_assign_unassigned_resources() too late.
>>
>> you should have call it with fs_initcall()...
>
> You're right, the pci_assign_unassigned_resources() is called from 
> probe() call of the MX6 PCIe driver, which is called from module_init().
>
> imx6_pcie_init() -> imx6_pcie_probe() -> imx6_add_pcie_port() ->
> dw_pcie_host_init() -> pci_assign_unassigned_resources()
>
>> please try to boot with "debug ignore_loglevel initcall_debug" to 
>> sort out the initcall sequence.
>
> Yes, probing the MX6 PCIe driver in fs_initcall() actually fixed my issues:
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c 
> index 32b30ca..771892a 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
>
> @@ -587,7 +590,7 @@ static int __init imx6_pcie_init(void)  {
>         return platform_driver_probe(&imx6_pcie_driver, 
> imx6_pcie_probe);  } -module_init(imx6_pcie_init);
> +fs_initcall(imx6_pcie_init);
>
>  MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");  
> MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver");
>
> Best regards,
> Marek Vasut


