Return-Path: <SRS0=r7nf=EA=ncentric.com=koen.vandeputte@kernel.org>
Return-Path: <SRS0=r7nf=EA=ncentric.com=koen.vandeputte@kernel.org>
Subject: Re: [PATCH] imx6: fix pcie enumeration
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <a2d7afee-7a41-6da6-e5a4-a36a6fcde55d@ncentric.com>
Date: Fri, 5 Jan 2018 10:56:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180104202430.GC189897@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-01-04 21:24, Bjorn Helgaas wrote:
> [+cc Richard, Lucas, Lorenzo, linux-arm-kernel]
>
> Hi Koen,
>
> Thanks a lot for the fix!
>
> Please run "git log --oneline drivers/pci/dwc/pci-imx6.c" and follow
> the style convention, including "PCIe" capitalization.
>
> "fix pcie enumeration" is not very descriptive.  It should say something
> about the specific problem, e.g., setting the root port's subordinate
> bus number.
>
> On Thu, Jan 04, 2018 at 04:48:03PM +0100, Koen Vandeputte wrote:
>> By default, when the imx6 PCIe RC boots up, the subordinate is set
> Not sure what "RC boots up" means.  Maybe you're talking about a
> hardware-defined default value at power-up, or maybe a value
> programmed by a boot-loader?  Please clarify and update the similar
> comment in the code.
>
>> equally to the secondary bus (1), and does not alter afterwards.
>>
>> This means that theoretically, the highest bus reachable downstream is
>> bus 1.
> Not just theoretically.  If the bridge is operating correctly, it
> should not forward any config transaction for a bus number greater
> than the subordinate bus number.
>
>> Before commit a20c7f36bd3d ("PCI: Do not allocate more buses than
>> available in parent"), the driver ignored the subord value and just
>> allowed up to 0xff on each device downstream.
>>
>> This caused a lot of errors to be printed, as this is not logical
>> according to spec. (but it worked ..)
> Including a sample error in the changelog might help somebody
> suffering from the problem find this solution.
>
>> After this commit, the driver stopped scanning deeper when the last
>> allocated busnr equals the subordinate of it's master, causing devices
>> to be undiscovered (especially behind bridges), uncovering the impact of
>> this bug.
>>
>> Before:
>>
>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 ...
>> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>
>> 00:00.0 0604: 16c3:abcd (rev 01)
>> 01:00.0 0604: 10b5:8604 (rev ba)
>> ... stops after bus 1 ...
>>
>> After:
>>
>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
>> ...
>> 	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
>>
>> 00:00.0 0604: 16c3:abcd (rev 01)
>> 01:00.0 0604: 10b5:8604 (rev ba)
>> 02:01.0 0604: 10b5:8604 (rev ba)
>> 02:04.0 0604: 10b5:8604 (rev ba)
>> 02:05.0 0604: 10b5:8604 (rev ba)
>> 03:00.0 0280: 168c:0033 (rev 01)
>> 05:00.0 0280: 168c:0033 (rev 01)
>>
> Should have a "Fixes: a20c7f36bd3d ..." tag if that's really the
> correct commit.
>
>> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
>> ---
>>
>> Needs backports to 4.14 & 4.9 stables
> Add a "CC: stable@vger.kernel.org" after your signed-off-by to handle
> this.  But something's wrong because a20c7f36bd3d only appeared in
> v4.15-rc1, so either that's the wrong commit or stable kernels don't
> need the fix.
>
>>   drivers/pci/dwc/pci-imx6.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
>> index b73483534a5b..3d13fa8c2eb1 100644
>> --- a/drivers/pci/dwc/pci-imx6.c
>> +++ b/drivers/pci/dwc/pci-imx6.c
>> @@ -76,6 +76,9 @@ struct imx6_pcie {
>>   
>>   #define PCIE_RC_LCSR				0x80
>>   
>> +#define PCIE_RC_BNR				0x18
>> +#define PCIE_RC_BNR_MAX_SUBORDINATE		(0xff << 16)
>> +
>>   /* PCIe Port Logic registers (memory-mapped) */
>>   #define PL_OFFSET 0x700
>>   #define PCIE_PL_PFLR (PL_OFFSET + 0x08)
>> @@ -562,6 +565,17 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>>   	int ret;
>>   
>>   	/*
>> +	 * By default, the subordinate is set equally to the secondary
>> +	 * bus (0x01) when the RC boots.
>> +	 * This means that theoretically, only bus 1 is reachable from the RC.
>> +	 * Force the PCIe RC subordinate to 0xff, otherwise no downstream
>> +	 * devices will be detected behind bus 1.
>> +	*/
>> +	tmp = dw_pcie_readl_rc(pp, PCIE_RC_BNR);
>> +	tmp |= PCIE_RC_BNR_MAX_SUBORDINATE;
>> +	dw_pcie_writel_rc(pp, PCIE_RC_BNR, tmp);
> This functionality is not related to establishing the link, so I think
> it should be put elsewhere, maybe either directly in imx6_pcie_probe()
> or in imx6_pcie_host_init().
>
> The DT really should contain a "bus-range" property and
> dw_pcie_host_init() will already pay attention to that if it's
> present, and I think it defaults to 0-0xff if it's not present.
>
> So I think you should be using pp->busn instead of hard-coding
> PCIE_RC_BNR_MAX_SUBORDINATE.
>
>> +	/*
>>   	 * Force Gen1 operation when starting the link.  In case the link is
>>   	 * started in Gen2 mode, there is a possibility the devices on the
>>   	 * bus will not be detected at all.  This happens with PCIe switches.
>> -- 
>> 2.7.4
>>




Hi Bjorn,

Thanks for your time and patience writing extended comments on all points,
especially since this is my first commit to this list.

Highly appreciated!


Secondly,

Based on your suggestions, I've dug around deeper in the code and found 
the actual line that initially causes it:  [1]


*drivers/pci/dwc/pcie-designware-host.c* 
<http://elixir.free-electrons.com/linux/v4.15-rc6/source/drivers/pci/dwc/pcie-designware-host.c#L588> 
void  dw_pcie_setup_rc 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/dw_pcie_setup_rc>(struct  pcie_port <http://elixir.free-electrons.com/linux/v4.15-rc6/ident/pcie_port>  *pp <http://elixir.free-electrons.com/linux/v4.15-rc6/ident/pp>)
{
...

	/* setup bus numbers */
	val  =  dw_pcie_readl_dbi 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/dw_pcie_readl_dbi>(pci 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/pci>,  PCI_PRIMARY_BUS 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/PCI_PRIMARY_BUS>);
	val  &=  0xff000000;
	val  |=  0x00010100; <---
	dw_pcie_writel_dbi 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/dw_pcie_writel_dbi>(pci 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/pci>,  PCI_PRIMARY_BUS 
<http://elixir.free-electrons.com/linux/v4.15-rc6/ident/PCI_PRIMARY_BUS>,  val); ... The i.MX6 reference manual (page 417 - section 48.8.7 "Bus 
Number Registers (PCIE_RC_BNR)") shows the following layout [2]: 31 23 
15 7 0 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ 
| Sec lat timer | Subord num | Sec busnum | Prim busnum | 
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ 
Shouldn't this:"val |= 0x00010100;" change to: "val |= 0x00ff0100;"
?



It seems other platforms also use this function (and thus register layout) to setup the PCIe RC [3],
so instead of doing a single fix for i.MX6 maybe it's best to fix it here so other platforms also benefit?

As you know the code a lot better than me, what's your opinion on this? (or from anyone in CC)


[1] http://elixir.free-electrons.com/linux/v4.15-rc6/source/drivers/pci/dwc/pcie-designware-host.c#L588
[2] https://community.nxp.com/servlet/JiveServlet/downloadBody/101783-102-6-17831/IMX6DQRMr2_part2.pdf
[3] http://elixir.free-electrons.com/linux/v4.15-rc6/ident/dw_pcie_setup_rc


Koen
