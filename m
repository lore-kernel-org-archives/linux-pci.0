Return-Path: <SRS0=+gJW=YS=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=+gJW=YS=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
 <20170103222509.GA4499@bhelgaas-glaptop.roam.corp.google.com>
 <16155135.jUckSz7QPL@aspire.rjw.lan>
 <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <peter@lekensteyn.nl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <83901bcb-1315-fbca-e1e3-960bfefbd9c0@quantumtechnology.info>
Date: Wed, 4 Jan 2017 11:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170104081639.GA21076@wunner.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Dear all,

the weird thing is also that when calling:

echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
or
echo on > /sys/bus/pci/devices/0000:01:00.0/power/control

on a command line then the command line crashes. The system stays responsive but still
becomes unresponsive when I lock the screen.

Maybe a similar thing are happening in the kernel. Maybe one could use the above fact
and a timeout to test for the problem and then take measures to deactivate the pm.

I hope this gives you some more clues.

Best regards
Kilian

PS: let me know which patches I should test. I am currently terribly busy with work. So if you would select the most urgent patches I would be delighted.



On 04-Jan-17 09:16, Lukas Wunner wrote:
> On Tue, Jan 03, 2017 at 06:05:57PM -0600, Bjorn Helgaas wrote:
>> I don't *want* to apply the revert.  It's on my for-linus branch as a
>> worst-case scenario change if we can't figure out a better fix.
>>
>> The patch below is preferable, but I'd rather not take even it,
>> because it takes away functionality and forces people to use a boot
>> parameter to restore it.  I expect that somebody will figure out how
>> to fix the regression Kilian found and also keep the new functionality
>> (without requiring boot parameters) before v4.10.
> The issue is constrained to hybrid graphics laptops with Nvidia discrete
> GPU using nouveau.  Hence it needs to be fixed in nouveau, not in the
> PCI core.
>
> (AFAIUI, laptops with AMD discrete GPU are not affected as it is known
> when and how to call an ACPI method versus using PR3.)
>
> (Neither are laptops using the Nvidia proprietary driver as it doesn't
> runtime suspend the card.  But battery life will be terrible then.)
>
> We're at rc2 so the time frame for coming up with a fix is probably
> 4 weeks.  Peter and others have tried for months to reverse-engineer
> how to handle runtime PM on newer Nvidia cards.  It seems likely that
> we'll not find the ultimate solution to the problem within 4 weeks.
>
> The way it is now, i.e. defaulting to PR3 when available, regresses
> certain laptops such as Kilian's.  If on the other hand we default to
> DSM when available, we'll regress certain other laptops, as Peter has
> pointed out.  Whitelisting or blacklisting laptops doesn't seem a good
> approach either, ideally we'd want to use PR3 as Windows does.
>
> As said, the only short-term solution I see is to add an "optimus"
> module_param to nouveau to allow users to select which method to use.
> So in Kilian's case an additional command line parameter would be
> necessary to fix the issue.
>
> Does anyone see a better solution or can we agree on this one?  If so
> I can come up with a patch.  This could go in via Dave Airlie's tree.
>
> Thanks,
>
> Lukas
