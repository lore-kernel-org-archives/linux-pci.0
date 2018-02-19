Return-Path: <SRS0=ZELb=FN=jonmasters.org=jcm@kernel.org>
Return-Path: <SRS0=ZELb=FN=jonmasters.org=jcm@kernel.org>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 George Cherian <gcherian@caviumnetworks.com>,
 George Cherian <george.cherian@cavium.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 Jayachandran.Nair@cavium.com, Robert.Richter@cavium.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <dd104986-81e2-e7a2-353c-91827078bc4c@caviumnetworks.com>
 <20180214201653.GA62268@bhelgaas-glaptop.roam.corp.google.com>
 <26660034.hqiP3ND89J@aspire.rjw.lan>
 <20180215233900.GA195653@bhelgaas-glaptop.roam.corp.google.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <4adb69b4-f566-cca8-6038-ab2e6be59d12@jonmasters.org>
Date: Mon, 19 Feb 2018 14:08:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180215233900.GA195653@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Rafael, others,

On 02/15/2018 06:39 PM, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2018 at 10:57:25PM +0100, Rafael J. Wysocki wrote:
>> On Wednesday, February 14, 2018 9:16:53 PM CET Bjorn Helgaas wrote:
>>> On Wed, Feb 14, 2018 at 04:58:08PM +0530, George Cherian wrote:
>>>> On 02/13/2018 08:39 PM, Bjorn Helgaas wrote:
>>>>> On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
>>>>>> The PCIe Controller on Cavium ThunderX2 processors does not
>>>>>> respond to downstream CFG/ECFG cycles when root port is
>>>>>> in power management D3-hot state.
>>>>>
>>>>> I think you're talking about the CPU initiating a config cycle to
>>>>> a device below the root port, right?
>>>> Yes
>>>
>>> If a bridge, e.g., a Root Port in your case, is in D3hot, we should be
>>> able to access config space of the bridge itself, but the secondary
>>> bus will be in B2 or B3 and we won't be able to access config space
>>> for any devices below the bridge.  This is true for *all* bridges, not
>>> just this Cavium Root Port.
>>
>> Right.
>>
>> But AFAICS config space reads from devices that aren't there (which
>> effectively is what happens if the bridge is in D3hot) are at least
>> expected to return all ones.
> 
> Yes.  AIUI, the PCIe spec doesn't actually *require* all ones

Indeed. This was my reading of the spec last year when I originally
discovered this bug (and suggested the temporary bandaid of the runtime
kernel parameter to disable pm for the port). I've seen this on certain
Cavium ThunderX2 systems in specific configurations, but in my debug
sessions it seemed that the problem was we're expecting all 1s and we
don't get those, so we then ultimately get an SError and go to lunch.

<snip>

> But from the discussion below, it sounds like this may have helped
> uncover a more serious Linux bug, i.e., we don't resume a device
> before trying to use it.

I suspected this too, but didn't get chance to followup. I had expected
the above would have been posted many months ago.

Jon.

-- 
Computer Architect
