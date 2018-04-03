Return-Path: <SRS0=KMEE=GY=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=KMEE=GY=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180403141646.GC60020@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402162203.3370-1-keith.busch@intel.com> <20180402162203.3370-2-keith.busch@intel.com>
 <20180402212302.GN9322@bhelgaas-glaptop.roam.corp.google.com>
 <20180402230949.GA4485@localhost.localdomain> <20180403141646.GC60020@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Apr 2018 16:31:15 +0200
Message-ID: <CAJZ5v0gpgJQSvkBX-PcXrPZ2bx_CCSAsfvpGz_zE-thqBF3X0w@mail.gmail.com>
Subject: Re: [PATCHv2 1/7] PCI/DPC: Enable ERR_COR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Oza Pawandeep <poza@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Rafael, linux-acpi]

Thanks.

> On Mon, Apr 02, 2018 at 05:09:49PM -0600, Keith Busch wrote:
>> On Mon, Apr 02, 2018 at 04:23:02PM -0500, Bjorn Helgaas wrote:
>> > On Mon, Apr 02, 2018 at 10:21:57AM -0600, Keith Busch wrote:
>> > > A DPC port may be configured to send ERR_COR message when the
>> > > triggered. This patch enables this feature so additional notification
>> > > of the event is possible.
>> >
>> > Who is the intended consumer of the ERR_COR message?  I guess if the
>> > root port supports AER, we'll see AER logging when we didn't before?
>> > Is that what you mean by "additional notification"?
>> >
>> > Or, since the DPC ERR_COR implementation note (sec 6.2.10.2) suggests
>> > that ERR_COR is primarily intended for use by platform firmware, does
>> > this change enable notification via the firmware?  If so, how does
>> > that work?  Does it require the platform to retain control of AER so
>> > it can see these events?  But if the platform retains AER control, I
>> > don't think we'd be enabling DPC in Linux.  I'm confused.
>> >
>> > The similar implementation note in 6.2.10.5 suggests that
>> > DL_ACTIVE_ERR_COR is also intended for use by the platform.  Should we
>> > be setting that for the same reason we're setting
>> > PCI_EXP_DPC_CTL_ERR_COR?
>>
>> I think there are various ways this could play out. I added this to
>> the series per a request for future use, but I actually don't have an
>> environment where I could test as intended. As I understand, it was
>> for platform firmware that may own the root port, but not switches in
>> an external enclosure, so the OS would own the DPC control. The ERR_COR
>> is to notify firmware so it may note an event in a platform log.
>
> This picture doesn't make sense to me yet.  Per the PCI Firmware spec,
> r3.2, sec 4.5.2, we use _OSC to negotiate control over AER (and now
> DPC).  I think _OSC is only allowed directly under a host bridge
> device (PNP0A08 or PNP0A03), and it applies to the entire hierarchy
> under the host bridge.
>
> I don't know how firmware could claim to own AER on a root port, but
> not on switches (external or otherwise) below that root port.
>
> If _OSC says firmware owns AER, we won't touch AER on the root port,
> but we also won't touch DPC on switches below the root port.  So I
> don't see how this change will help.

This matches my understanding of that part of the spec.
