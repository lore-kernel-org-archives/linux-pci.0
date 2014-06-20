Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65379 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbaFTCZj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Jun 2014 22:25:39 -0400
Message-ID: <53A39BA1.4050606@intel.com>
Date: Fri, 20 Jun 2014 10:25:37 +0800
From: "Chen, Tiejun" <tiejun.chen@intel.com>
MIME-Version: 1.0
To: jon.baker@viasat.com, linux-pci@vger.kernel.org
CC: "Gogineni, Naveen" <Naveen.Gogineni@viasat.com>
Subject: Re: PCI rescan issue
References: <53A23DF7.60104@viasat.com> <53A28DE8.6030105@intel.com> <53A2E395.5010702@viasat.com>
In-Reply-To: <53A2E395.5010702@viasat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 2014/6/19 21:20, Jon Baker wrote:
>
> On 06/19/2014 03:14 AM, Chen, Tiejun wrote:
>> On 2014/6/19 9:33, Jon Baker wrote:
>>> I am trying to find a solution to a Linux PCI rescan problem.
>>>
>>> I have CentOS 6.5
>>>
>>>     [jbaker@server0 ~]$ uname -a
>>>     Linux server0 2.6.32-431.5.1.el6.x86_64 #1 SMP Wed Feb 12 
>>> 00:41:43 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> I have an Altera FPGA PCIe protoboard I am trying to test in a TYAN 
>>> FT77A-B7059.
>>>
>>> We are trying to solve some hotplug/FPGA reload issues; when we 
>>> reload the FPGA the PCI interface reloads confusing linux pci code.
>>>
>>> After bootup the board is seen by the kernel; lscpi shows Altera 
>>> FPGA PCIe protoboard settings and config space.  We can load our 
>>> driver and all is well.
>>>
>>> When we reload the FPGA lscpi display shows all "ff" for config 
>>> space.  As
>>
>> Are you saying all values in the config space are 0xff? If yes, this 
>> mean the vendor/device ids are invalid, so I'm just curious how OS 
>> identify this device, and you really can see that with lspci?
>>
>> Tiejun
> Yes.
>
> After system power up (case where everything works expected):
>
>     $ lspci -vvv -xx -s 13:00.0
>     13:00.0 Non-VGA unclassified device: Device 1b83:f002 (rev 01)
>             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
>     VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>     >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>             Latency: 0, Cache Line Size: 64 bytes
>             Interrupt: pin A routed to IRQ 11
>             Region 0: Memory at dcc00000 (32-bit, non-prefetchable)
>     [size=256K]
>             Region 1: Memory at dcb00000 (32-bit, non-prefetchable)
>     [size=1M]
>             Capabilities: <access denied>
>     00: 83 1b 02 f0 06 00 10 00 01 00 00 00 10 00 00 00
>     10: 00 00 c0 dc 00 00 b0 dc 00 00 00 00 00 00 00 00
>     20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
>
>
> After FPGA reload:
>
>     $ lspci -vvv -xx -s 13:00.0
>     13:00.0 Non-VGA unclassified device: Device 1b83:f002 (rev ff)
>     (prog-if ff)
>             !!! Unknown header type 7f
>     00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>     10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>     20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>     30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>

Looks you rescan directly with any first remove action. But seems you 
can't find your device again after you remove that firstly. So firstly 
you need to check if the host and device support hotplug before you 
validate hotplug feature.

If rescan manually, you may need to check if the link is established 
before rescan. If yes, probably the FPGA doesn't response any read 
config from bus actually, so all value are 0xff. You can use PCIE 
analyzer to check this.

Tiejun
