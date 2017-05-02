Return-Path: <SRS0=AgWd=4I=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=AgWd=4I=codeaurora.org=okaya@kernel.org>
Subject: Re: [GIT PULL] PCI fixes for v4.10
To: Lukas Wunner <lukas@wunner.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yinghai Lu <yinghai@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209182328.GB77900@otc-nc-03> <20170209184613.GA78375@otc-nc-03>
 <20170502015405.GA13918@wunner.de>
 <65f46b49-950a-270f-8bc4-c3fb7513866e@codeaurora.org>
 <20170502104929.GA14029@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5db97592-4153-c55a-fe44-260d717d1ef0@codeaurora.org>
Date: Tue, 2 May 2017 10:15:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170502104929.GA14029@wunner.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 5/2/2017 6:49 AM, Lukas Wunner wrote:
> On Mon, May 01, 2017 at 10:41:20PM -0400, Sinan Kaya wrote:
>> On 5/1/2017 9:54 PM, Lukas Wunner wrote:
>>> (b) ASPM L1 enabled on boot, but disabled after powering off and back on
>>>     => I believe Sinan is working on this (+cc).
>>
>> The decision was made not to touch ASPM registers following hotplug insertion
>> unless pcie_aspm.policy=powersave is specified.
>>
>> The discussion is here: https://lkml.org/lkml/2017/4/17/255
>>
>> This was done to maintain existing behavior and not break things.
> 
> Thanks for the reference, I hadn't followed the discussion in April
> very closely, but I think the outcome of the discussion is unfortunate.
> 
> As can be seen in Ashok's tests, merely turning slot power off and back
> on is sufficient to end up with a setting that draws more power.  That
> may be equally surprising for users as the issues would be that we seek
> to avoid with a "safety-first" ASPM policy.  In any case it seems
> undesirable.
> 
> I hope this is not the end if it and would like to encourage you to
> keep working on this.  Perhaps it is too simple to just define a
> default policy, and what is really needed is a policy that adjusts
> itself dynamically to specific devices or workloads, or that can be
> influenced by device drivers.
> 

I think our conclusion was to push PM decision to a userspace utility.
ASPM already has a knob in sysfs that can be adjusted at runtime. The
name of the file is policy. Same argument as the kernel command line
but it is writable. Different policies can be programmed into this
field after OS boot.

It is really the system power management entity that needs to decide
how system should behave. 

We just need to educate the userspace utility about the presence
of ASPM policy variable.

1. OS could still boot with the default parameters. 
2. Userspace utility sets the policy variable to powersave
3. User performs hotplug remove + insert
4. ASPM is enabled due to policy change.

I don't know anything about what this userspace utility is or if
it understands about PCIE ASPM at all. 

As an analogy, we can choose the level of power management in windows
through Power Policy.

control panel -> power options -> change advanced power options ->
PCI Express -> Link State Power Management

We want to have the same level of configuration.

> Thanks for your efforts,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
