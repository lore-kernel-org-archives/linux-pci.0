Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3576289.1ltj0IceQ5@vostro.rjw.lan>
References: <1454058340-7904-1-git-send-email-jchandra@broadcom.com>
 <CAKc_7PXYtFt1MQE-UGO0O5vvQ+xFKa2b5=F8wXB=EN-JUJVzZw@mail.gmail.com>
 <20160205094740.GA31547@red-moon> <3576289.1ltj0IceQ5@vostro.rjw.lan>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Sat, 6 Feb 2016 15:28:26 +0530
Message-ID: <CAKc_7PV69xZ-+yeq+fVAMykuQ53HsjpACz9yH9LpJE-=X5xggA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] PCI: ACPI: Add a generic ACPI based host controller
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jayachandran C <jchandra@broadcom.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Tomasz Nowicki <tn@semihalf.com>,
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Sat, Feb 6, 2016 at 4:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, February 05, 2016 09:47:40 AM Lorenzo Pieralisi wrote:
>> On Fri, Feb 05, 2016 at 02:05:37PM +0530, Jayachandran Chandrashekaran Nair wrote:
>>
>> [...]
>>
>> > pci_host_acpi.c is a generic implementation of these using a sysdata
>> > pointing to acpi_pci_root_info, and using a pointer to the pci_mmcfg_region
>> > to access ECAM area, Maybe I can rename this file to
>> > pci_acpi_host_generic.c to reflect this better.
>>
>> Maybe you should stop sending this series and work with Tomasz to
>> get this done, you are confusing everyone and I am really really
>> annoyed about this.
>>
>> Do you realize there is no point in having two patch series doing
>> the same thing and wasting everyone's review time ?
>>
>> Do you realize he started this work long before you and went through
>> several rounds of review already (I told you before but in case you
>> forgot) ?
>>
>> Tomasz posted a version yesterday, integrating comments following months
>> of review and testing and I think it is ready to get upstream:
>>
>> https://lkml.org/lkml/2016/2/4/646
>>
>> Did you even consider reviewing his code or helping him instead of
>> churning out more patches doing the *SAME* thing ?
>>
>> Do you want all of us to go through your code and re-fix what has
>> already been fixed in Tomasz's series with the end result of missing
>> yet another merge window ?
>>
>> This is really annoying, stop it please, really.
>
> OK, so to be crystal clear here.
>
> I'm going to ignore the series the $subject patch belongs to going forward.

It looks like you can already reviewed Tomasz's patchset and as Lorenzo
says thinks that it can be merged.

When I first posted the patchset the state of arm64 ACPI/PCI was not that
clear - and I thought an alternative will help. Ideally I would expect
maintainers to look at technical merit, but in this case any working solution
merged will be great news.

Thanks,
JC.
