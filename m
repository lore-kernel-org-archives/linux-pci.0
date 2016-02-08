Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160205094740.GA31547@red-moon>
References: <1454058340-7904-1-git-send-email-jchandra@broadcom.com>
 <1454058340-7904-6-git-send-email-jchandra@broadcom.com> <20160205001907.GJ7031@localhost>
 <CAKc_7PXYtFt1MQE-UGO0O5vvQ+xFKa2b5=F8wXB=EN-JUJVzZw@mail.gmail.com> <20160205094740.GA31547@red-moon>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Mon, 8 Feb 2016 16:57:46 +0530
Message-ID: <CAKc_7PVNm7z8nv_+Tr9FYhrVAA+-vh4CDMB83WAyT8tdi+CHzA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] PCI: ACPI: Add a generic ACPI based host controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jayachandran C <jchandra@broadcom.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,

On Fri, Feb 5, 2016 at 3:17 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Feb 05, 2016 at 02:05:37PM +0530, Jayachandran Chandrashekaran Nair wrote:
>
> [...]
>
>> pci_host_acpi.c is a generic implementation of these using a sysdata
>> pointing to acpi_pci_root_info, and using a pointer to the pci_mmcfg_region
>> to access ECAM area, Maybe I can rename this file to
>> pci_acpi_host_generic.c to reflect this better.
>
> Maybe you should stop sending this series and work with Tomasz to
> get this done, you are confusing everyone and I am really really
> annoyed about this.
>
> Do you realize there is no point in having two patch series doing
> the same thing and wasting everyone's review time ?
>
> Do you realize he started this work long before you and went through
> several rounds of review already (I told you before but in case you
> forgot) ?
>
> Tomasz posted a version yesterday, integrating comments following months
> of review and testing and I think it is ready to get upstream:
>
> https://lkml.org/lkml/2016/2/4/646
>
> Did you even consider reviewing his code or helping him instead of
> churning out more patches doing the *SAME* thing ?

This is getting ridiculous, I had replied to your earlier mails on why
my patchset is NOT doing the exact same thing. I had also explained
why helping was not feasible.

The basic point again: I am trying to give a much simpler patchset
to solve the same problem, I take it that you haven't reviewed my
patchset before writing this mail. I would have appreciated
a technical discussion rather than this pointless flamefest.

If you have reviewed it, you can see that there are just 5 patches
instead of 23, and that overall it is a much simpler approach.

> Do you want all of us to go through your code and re-fix what has
> already been fixed in Tomasz's series with the end result of missing
> yet another merge window ?

Again, as I said, the whole point of my patchset is that is much  easier
to go thru and validate and merge or drop as needed.

Anyway, if you are on target to hit this merge window, I really hope
that happens and there will no need for me to spend further time on
this.

Regards,
JC.
