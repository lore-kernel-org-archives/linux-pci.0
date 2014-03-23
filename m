Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <532EEFF9.4020706@numascale.com>
Date: Sun, 23 Mar 2014 22:30:17 +0800
From: Daniel J Blueman <daniel@numascale.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	kim.naru@amd.com,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] Fix northbridge quirk to assign correct NUMA node
References: <1394710981-3596-1-git-send-email-daniel@numascale.com> <CAErSpo6psgDr3XYh6m+vYcAOix2Vttrwz1jK7bS47Liy2Lw-=g@mail.gmail.com> <532BB431.7020501@numascale.com> <532C73DA.7060008@amd.com>
In-Reply-To: <532C73DA.7060008@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/22/2014 01:16 AM, Suravee Suthikulpanit wrote:
> On 3/20/2014 10:38 PM, Daniel J Blueman wrote:
>> On 21/03/2014 06:07, Bjorn Helgaas wrote:
>>> [+cc linux-pci, Myron, Suravee, Kim, Aravind]
>>>
>>> On Thu, Mar 13, 2014 at 5:43 AM, Daniel J Blueman
>>> <daniel@numascale.com> wrote:
>>>> For systems with multiple servers and routed fabric, all
>>>> northbridges get
>>>> assigned to the first server. Fix this by also using the node
>>>> reported from
>>>> the PCI bus. For single-fabric systems, the northbriges are on PCI
>>>> bus 0
>>>> by definition, which are on NUMA node 0 by definition, so this is
>>>> invarient
>>>> on most systems.
>>>>
>>>> Tested on fam10h and fam15h single and multi-fabric systems and
>>>> candidate
>>>> for stable.
>>
>>> I wish this had been cc'd to linux-pci.  We're talking about a related
>>> change by Suravee there.  In fact, we were hoping this quirk could be
>>> removed altogether.
>>
>> Noted.
>>
>>> I don't understand what this quirk is doing.  Normally we discover the
>>> NUMA node for a PCI host bridge via the ACPI _PXM method.  The way
>>> _PXM works is that every PCI device in the hierarchy below the bridge
>>> inherits the same node number as the host bridge.  I first thought
>>> this might be a workaround for a system that lacks _PXM, but I don't
>>> think that can be right, because you're only changing the node for a
>>> few devices, not the whole hierarchy.
>>  >
>>> So I suspect the problem is more complicated, and maybe _PXM is
>>> insufficient to describe the topology?  Are there subtrees that should
>>> have nodes different from the host bridge?
>>
>> Yes; see below.
>>
>>> I know this patch is already in v3.14-rc7, but I'd still like to
>>> understand it so we can do the right thing with Suravee's patch.
>>
>> The _PXM method associates each northbridge with the first NUMA node,
>> 0 in single-fabric systems, and eg 4 for the second server in a
>> multi-fabric system with 2 dual-module Opterons (with 2 NUMA nodes
>> internally) etc, since the northbridges appear in the
>> PCI tree, under the host bridge, not above it [1].
> Daniel,
>
> That lspci looks interesting, what is the value returned from
> pci_bus_to_node() on your system for each fabric?

pci_bus_to_node returns 0 for PCI domain 0000, 2 for PCI domain 0001, 4 
for PCI domain 0002 and so on.

Our processor fabric interconnect has HyperTransport NodeId 2 on each 
server (as they start from bus 0, device 0x18 of course):
0000:00:1a.0 Host bridge: Device 1b47:0601 (rev 02)
0000:00:1a.1 Host bridge: Device 1b47:0602 (rev 02)

Thanks,
   Daniel
-- 
Daniel J Blueman
Principal Software Engineer, Numascale
