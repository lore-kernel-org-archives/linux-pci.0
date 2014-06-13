Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46282 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaFMIFW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jun 2014 04:05:22 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so1335259lbi.5
        for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2014 01:05:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140605125842.GL5214@lahna.fi.intel.com>
References: <CA+eFSM2CBiWZNmpnSNGKZGjEpK6gc=T0a5r7m6sbORi==XTCjQ@mail.gmail.com>
	<22265253.jvFXIxhohU@vostro.rjw.lan>
	<CA+eFSM0Cnij7EEUZhWNsyrERquUiOE4Jt8d_Ra=bt5VZZtLDwA@mail.gmail.com>
	<1784093.b0o8Rzal2W@vostro.rjw.lan>
	<20140605125842.GL5214@lahna.fi.intel.com>
Date: Fri, 13 Jun 2014 16:05:20 +0800
Message-ID: <CA+eFSM2ffc2=eyBj+Xs3084L-c6-AiFje4DqV+ynN7id8Vf5=w@mail.gmail.com>
Subject: Re: PCI-to-USB ExpressCard Hotplugging can't work in v3.15-rc5
From: Gavin Guo <gavin.guo@canonical.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, YK <yk@canonical.com>,
	Yung Shen <yung.shen@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 5, 2014 at 8:58 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Jun 05, 2014 at 02:08:57PM +0200, Rafael J. Wysocki wrote:
>> CC: Mika
>>
>> On Thursday, June 05, 2014 07:46:06 PM Gavin Guo wrote:
>> > On Thu, May 22, 2014 at 7:36 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > > On Wednesday, May 21, 2014 07:53:37 AM Bjorn Helgaas wrote:
>> > >> On Wed, May 21, 2014 at 3:45 AM, Gavin Guo <gavin.guo@canonical.com> wrote:
>> > >> > Hi Bjorn,
>> > >> >
>> > >> > On Wed, May 21, 2014 at 12:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > >> >> On Tue, May 20, 2014 at 10:36 PM, Gavin Guo <gavin.guo@canonical.com> wrote:
>> > >> >>> Hi all,
>> > >> >>>
>> > >> >>> I have a APIOTEK PCI-to-USB ExpressCard and found that when it is
>> > >> >>> plugged at cold boot, the card can be detected. But, hotplug cannot
>> > >> >>> work at run time. The bug may be related to the commit which I
>> > >> >>> reported last year:
>> > >> >>>
>> > >> >>> commit 3f327e39b4b8f760c331bb2836735be6d83fbf53
>> > >> >>
>> > >> >> Where is your report from last year?  How did you identify this
>> > >> >> commit?  Did you verify that it works correctly with v3.10-rc1, but
>> > >> >> fails when you add this commit?
>> > >> >
>> > >> > The mail about the bug I reported last year is attached. And I'm sorry
>> > >> > about not describing clearly. This commit is the one to fix the bug
>> > >> > before. So, I think it will be a clue to find out what's wrong. I've
>> > >> > built v3.10 and tested it on the platform. It works fine. The bug
>> > >> > seems like a regression.
>> > >> >
>> > >> > I also attached the dmesg of v3.10 which works correctly with hotplug.
>> > >>
>> > >> v3.10 contains 3f327e39b4b8 (it appeared in v3.10-rc3).  So since it
>> > >> works correctly in v3.10, that commit is probably not the cause of the
>> > >> regression.
>> > >>
>> > >> So apparently it worked in v3.10 and broke sometime later.  Do you
>> > >> know when it broke?
>> > >>
>> > >> We're getting Bus Check events:
>> > >>
>> > >>   ACPI: \_SB_.PCI0: ACPI_NOTIFY_BUS_CHECK event
>> > >>
>> > >> but apparently we aren't handling them correctly.  Can you turn on the
>> > >> debug in the acpi_hotplug_schedule() path and add more if necessary to
>> > >> if we get to acpi_hotplug_work_fn(), acpi_device_hotplug(), etc.?  I'm
>> > >> not familiar with that path, so either you'll have to narrow it down,
>> > >> or we can hope that Yinghai or Rafael has some insight.
>> > >
>> > > Well, it would be good to create a bug entry for this at bugzilla.kernel.org
>> > > against ACPI/Config-hotplug and mark it as a regression.
>> >
>> > I've completed the bisect and found
>> > 2d8b1d566a5f4874f4d92361f5cdbb50baa396f8 is the first bad commit. The
>> > "git bisect log" is also attached.
>> >
>> > commit 2d8b1d566a5f4874f4d92361f5cdbb50baa396f8
>> > Author: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Date: Sat Jul 13 20:09:59 2013 +0300
>> >
>> >     ACPI / hotplug / PCI: Get rid of check_sub_bridges()
>> >
>> >     Now that acpiphp_check_bridge() always enumerates devices behind the
>> >     bridge, there is no need to do that for each sub-bridge anymore like
>> >     it is done in the current ACPI-based PCI hotplug (ACPIPHP) code.
>> >
>> >     Given this we don't need check_sub_bridges() anymore, so drop that
>> >     function completely.
>> >
>> >     This also simplifies the ACPIPHP code a bit.
>> >
>> >     Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > :040000 040000 1f3f81404e06c92c01d6848ed7a6c5bffdb5f878
>> > 4e7ca3e4af42738f90555640cafbb6e6522ceedf M drivers
>
> Gavin,
>
> Can you send dmesg and your ACPI DSDT table to me (or attach them
> to a bug if you are filing one)? I wasn't able to dig up the original
> dmesg from the linux-pci archives.
>
> Please also make sure that you have CONFIG_DYNAMIC_DEBUG=y and
> "acpiphp.dyndbg=+p" in the kernel command line.

The bug was fixed already and can be found on the
https://bugzilla.kernel.org/show_bug.cgi?id=76901.
