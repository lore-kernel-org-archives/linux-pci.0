Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35290 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeFJOgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jun 2018 10:36:16 -0400
Subject: Re: [PATCH V2 4/5] PCI: rcar: Support runtime PM, link state L1
 handling
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-5-marek.vasut+renesas@gmail.com>
 <20171117174906.GB22599@red-moon>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3e0bc374-d296-675c-f290-256cc530feb7@gmail.com>
Date: Sun, 10 Jun 2018 15:57:10 +0200
MIME-Version: 1.0
In-Reply-To: <20171117174906.GB22599@red-moon>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2017 06:49 PM, Lorenzo Pieralisi wrote:
> Hi Marek,

Hi,

> On Fri, Nov 10, 2017 at 10:58:42PM +0100, Marek Vasut wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> Most PCIe host controllers support L0s and L1 power states via ASPM.
>> The R-Car hardware only supports L0s, so when the system suspends and
>> resumes we have to manually handle L1.
>> When the system suspends, cards can put themselves into L1 and send a
> 
> I assumed L1 entry has to be negotiated depending upon the PCIe
> hierarchy capabilities, I would appreciate if you can explain to
> me what's the root cause of the issue please.

You should probably ignore the suspend/resume part altogether. The issue
here is that the cards can enter L1 state, while the controller won't do
that automatically, it can only detect that the link went into L1 state.
If that happens,the driver must manually put the controller to L1 state.
The controller can transition out of L1 state automatically though.

>> PM_ENTER_L1 DLLP to the host controller. At this point, we can no longer
>> access the card's config registers.
>>
>> The R-Car host controller will handle taking cards out of L1 as long as
>> the host controller has also been transitioned to L1 link state.
> 
> I wonder why this can't be done in a PM restore hook but that's not
> really where my question is.

I suspect because the link can be in L1 during startup too?

>> Ideally, we would detect the PM_ENTER_L1 DLLP using an interrupt and
>> transition the host to L1 immediately. However, this patch just ensures
>> that we can talk to cards after they have gone into L1.
> 
>> When attempting a config access, it checks to see if the card has gone
>> into L1, and if so, does the same for the host controller.
>>
>> This is based on a patch by Hien Dang <hien.dang.eb@rvc.renesas.com>
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: - Drop extra parenthesis
>>     - Use GENMASK()
>>     - Fix comment "The HW will handle coming of of L1.", s/of of/out of/
>> ---
>>  drivers/pci/host/pcie-rcar.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index ab61829db389..068bf9067ec1 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -92,6 +92,13 @@
>>  #define MACCTLR			0x011058
>>  #define  SPEED_CHANGE		BIT(24)
>>  #define  SCRAMBLE_DISABLE	BIT(27)
>> +#define PMSR			0x01105c
>> +#define  L1FAEG			BIT(31)
>> +#define  PM_ENTER_L1RX		BIT(23)
>> +#define  PMSTATE		GENMASK(18, 16)
>> +#define  PMSTATE_L1		GENMASK(17, 16)
>> +#define PMCTLR			0x011060
>> +#define  L1_INIT		BIT(31)
>>  #define MACS2R			0x011078
>>  #define MACCGSPSETR		0x011084
>>  #define  SPCNGRSN		BIT(31)
>> @@ -191,6 +198,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>>  		unsigned int devfn, int where, u32 *data)
>>  {
>>  	int dev, func, reg, index;
>> +	u32 val;
>>  
>>  	dev = PCI_SLOT(devfn);
>>  	func = PCI_FUNC(devfn);
>> @@ -232,6 +240,22 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>>  	if (pcie->root_bus_nr < 0)
>>  		return PCIBIOS_DEVICE_NOT_FOUND;
>>  
>> +	/*
>> +	 * If we are not in L1 link state and we have received PM_ENTER_L1 DLLP,
>> +	 * transition to L1 link state. The HW will handle coming out of L1.
>> +	 */
>> +	val = rcar_pci_read_reg(pcie, PMSR);
>> +	if (val & PM_ENTER_L1RX && (val & PMSTATE) != PMSTATE_L1) {
>> +		rcar_pci_write_reg(pcie, L1_INIT, PMCTLR);
>> +
>> +		/* Wait until we are in L1 */
>> +		while (!(val & L1FAEG))
>> +			val = rcar_pci_read_reg(pcie, PMSR);
>> +
>> +		/* Clear flags indicating link has transitioned to L1 */
>> +		rcar_pci_write_reg(pcie, L1FAEG | PM_ENTER_L1RX, PMSR);
>> +	}
> 
> I do not get why you need to add the DLLP check for _every_ given config
> access and how/why it is just related to suspend/resume and not eg cold
> boot (I supposed it is because devices can enter L1 upon suspend(?)), I
> would ask you please to provide a thorough explanation so that I can
> actually review this patch (the commit log must be rewritten nonetheless,
> I do not think it is clear, at least it is not for me).

See above

-- 
Best regards,
Marek Vasut
