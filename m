Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170103163130.GC9763@al>
 <20170103181221.GB25398@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
Cc: Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <3ce9e85d-381c-1c5d-b01d-65b8cf64e1ae@quantumtechnology.info>
Date: Tue, 3 Jan 2017 22:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <3913750.OA6IItgEjC@aspire.rjw.lan>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

I have not checked if suspend/resume broken.
Which patch should I check suspend resume for.
When I wrote about firefox and lockscreen issue resolved
I forgot to check about the suspend/resume.


On 03-Jan-17 22:38, Rafael J. Wysocki wrote:
> On Tuesday, January 03, 2017 12:12:21 PM Bjorn Helgaas wrote:
>> On Tue, Jan 03, 2017 at 05:31:30PM +0100, Peter Wu wrote:
>>> On Tue, Jan 03, 2017 at 05:11:23PM +0100, Lukas Wunner wrote:
>>>> [cc += Dave Airlie:
>>>>
>>>> Dave, we're about to lose support for newer Optimus laptops which use
>>>> _PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
>>>> a commit on his for-linus branch to remove runtime PM for PCIe ports.
>>>> This fixes a regression on Kilian Singer's laptop on which locking the
>>>> screen breaks USB and PS/2 input devices:  Mouse movements are still
>>>> visible, but button or key presses no longer have any effect.  The GPU
>>>> is powered down upon locking the screen and the current theory is that
>>>> this causes the issues.]
>>> (+cc Alex: this might affect amdgpu/radeon too.]
>>>
>>> Bjorn, please reconsider the rpm patch. Reverting support would
>>> introduce other regressions (see issues below) and make future
>>> Thunderbolt work harder (according to Lukas). If Kilian's laptop has
>>> issues, what about a "temporary" quirk?
>> As I mentioned at the beginning, the outcome I'm hoping for is a patch
>> that fixes Kilian's laptop while preserving the runtime PM support.
>>
>> As I also mentioned at the beginning, preserving the runtime PM
>> support at the expense of breaking Kilian's laptop is not one of the
>> options.
> But the revert doesn't really help.
>
> It doesn't fix system suspend/resume on that laptop, which also breaks when
> PCIe ports PM is enabled on it.
>
> If you really want to use a sledgehammer approach here (which I don't recommend,
> but that's your call), you can change the initial value of pci_bridge_d3_disable to
> "true" (and update the pcie_ports_pm= command line to take "on" in case
> someone wants to enable the feature).  That at least will take care of the
> regression entirely and not just partly.
>
> Thanks,
> Rafael
>
