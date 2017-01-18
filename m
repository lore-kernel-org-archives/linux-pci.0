Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
To: Bjorn Helgaas <helgaas@kernel.org>, David Daney <ddaney@caviumnetworks.com>
References: <20170117151444.GE22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170117152548.GB27312@n2100.armlinux.org.uk>
 <20170117174649.GA11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117175115.GD27312@n2100.armlinux.org.uk>
 <20170117175728.GE27312@n2100.armlinux.org.uk>
 <20170117181458.GB11063@bhelgaas-glaptop.roam.corp.google.com>
 <20170117193414.GG27312@n2100.armlinux.org.uk>
 <20170117210258.GH27312@n2100.armlinux.org.uk>
 <20170117222229.GA6534@bhelgaas-glaptop.roam.corp.google.com>
 <e0ccb7a0-9cc7-c595-7f06-e63c0927f36d@caviumnetworks.com>
 <20170118142250.GB6534@bhelgaas-glaptop.roam.corp.google.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <1137f732-f31e-8162-af8f-6a7f577a9648@caviumnetworks.com>
Date: Wed, 18 Jan 2017 09:36:55 -0800
MIME-Version: 1.0
In-Reply-To: <20170118142250.GB6534@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
 David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 01/18/2017 06:22 AM, Bjorn Helgaas wrote:
> On Tue, Jan 17, 2017 at 03:37:10PM -0800, David Daney wrote:
[...]
>>
>>
>> Link (re)training can fail for several reasons including, but not
>> limited to:
>>
>> - Poor signal propagation through the
>> chips/packages/boards/connectors, also known as Signal Integrity
>> (SI) problmes.
>>
>> - Incorrect implementation, in hardware, of link training protocols
>> at either end of the link
>>
>> Usually, system and PCIe device vendors do a lot of testing and
>> signal analysis across a variety of configurations with the end goal
>> being that PCIe looks like a bullet-proof interconnect to the end
>> consumer.
>>
>> Unfortunatly, sometimes it doesn't work.  In these cases, the
>> vendors of the devices on each end of the link tend to point fingers
>> at the link partner for being detective in some way.
>>
>> This patch:
>>
>>>
>>> The only one that comes to mind is this patch from David (CC'd) that
>>> avoids ASPM-related retrains when we know the link doesn't support ASPM:
>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e53f9a28bee3
>>>
>>
>> Is an attempt to work around the problem from the system (host) end.
>> If the system vendor knows a priori that a defective PCIe device is
>> present in the system, the PCIe root port can be configured to
>> indicate no ASPM is supported, resulting (with the patch) in no link
>> retraining being attempted.
>>
>> To me it feels that we need a black list of devices that fail at a
>> high rate in the link retraining, that when encountered would
>> disable ASPM on the link where they reside.
>
> I should have asked you for details about the defective devices
> related to e53f9a28bee3 :)  If we had included that in the changelog,
> we would have something to seed a blacklist with.

The device I saw failing I don't have access to any more, so I don't 
know the PCI IDs.  It was a solid-state storage device with a Xilinx 
FPGA acting as the PCIe endpoint.  In any event, it would only fail in 
about 0.5% of system boots, it wasn't the case that it could be made to 
reliably fail.

The tricky thing here is assigning the blame for failure in link 
training.  In the case in question we spent many months analysing the 
analog properties of the bus and examining/decoding  analog scope 
captures of the failures before credibly assigning blame to the other 
guy.  Usually what happens is the device vendor accurately claims that 
their device works flawlessly in conjunction with certain Intel root 
ports, so the problem must be fixed in the root port of the failing 
system.  If you have a black list, you may be disabling ASPM in systems 
where it can work without failures.



>
> There are several situations other than ASPM where link retraining is
> required per spec (rate change, error handling, etc), and I guess we'd
> have to avoid all of them.   So I suppose e53f9a28bee3 avoids the most
> obvious failures, but maybe we could still see issues in those other
> cases.
>
> Bjorn
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
