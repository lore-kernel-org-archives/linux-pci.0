Return-Path: <SRS0=K2CA=HR=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=K2CA=HR=codeaurora.org=okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 28 Apr 2018 09:03:09 -0400
From: okaya@codeaurora.org
To: Dave Young <dyoung@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Paul
 Menzel <pmenzel+linux-pci@molgen.mpg.de>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Eric Biederman
 <ebiederm@xmission.com>, Bjorn Helgaas <bhelgaas@google.com>, Vivek Goyal
 <vgoyal@redhat.com>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
In-Reply-To: <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
 <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
 <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
Message-ID: <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-04-27 21:18, Dave Young wrote:
> On 04/28/18 at 08:56am, Dave Young wrote:
>> On 04/27/18 at 04:12pm, Bjorn Helgaas wrote:
>> > [+cc Eric, Vivek, kexec list]
>> >
>> > On Fri, Apr 27, 2018 at 03:34:30PM -0400, Sinan Kaya wrote:
>> > > On 4/27/2018 3:22 PM, Bjorn Helgaas wrote:
>> > > > Sinan mooted the idea of using a "no-wait" path of sending the "don't
>> > > > generate hotplug interrupts" command.  I think we should work on this
>> > > > idea a little more.  If we're shutting down the whole system, I can't
>> > > > believe there's much value in *anything* we do in the pciehp_remove()
>> > > > path.
>> > > >
>> > > > Maybe we should just get rid of pciehp_remove() (and probably
>> > > > pcie_port_remove_service() and the other service driver remove methods)
>> > > > completely.  That dates from when the service drivers could be modules that
> 
> Hmm, if it is the remove() method then kexec does not use it.  kexec 
> use
> the shutdown() method instead.  I missed this details when I replied.

Portdrv hooks up remove handler to shutdown. That's why remove is 
getting called.

> 
>> > > > could be potentially unloaded, but unloading them hasn't been possible for
>> > > > years.
>> > >
>> > > Shutdown path is also used for kexec. Leaving hotplug interrupts
>> > > pending is dangerous for the newly loaded kernel as it leaves
>> > > spurious interrupts during the new kernel boot.
>> > >
>> > > I think we should always disable the hotplug interrupt on shutdown.
>> > > We might think of not waiting for command-completion as a
>> > > middle-ground or go to polling path instead of interrupts all the
>> > > time.
>> >
>> > Ah, I forgot about the kexec path.  The kexec path is used for
>> > crashdump, too, so ideally the newly-loaded kernel would defend itself
>> > when possible so it doesn't depend on the original kernel doing things
>> > correctly.
>> 
>> It is true for kdump.  But kexec needs device shutdown.
>> 
>> >
>> > Seems like this question of whether to do things in the original
>> > kernel or the kexec-ed kernel comes up periodically, but I can never
>> > remember a definitive answer.  My initial reaction is that it'd be
>> > nice if we didn't have to do *any* shutdown in the original kernel,
>> > but I'm sure there are reasons that's not practical.
>> 
>> Devices sometimes assume it is in a good state initialized in firmware 
>> boot
>> phase, so we need a shutdown in 1st kernel so that kexec kernel can 
>> boot
>> correctly for those devices.  For kdump since kernel already panicked
>> and it is not reliable so we do as less as we can in the 1st kernel
>> crash path, but there are some special handling for kdump in various 
>> drivers
>> to reset the devices in 2nd kernel, eg. when it see "reset_devices" 
>> kernel parameter.
>> 
>> >
>> > I copied Eric (kexec maintainer) and Vivek (contact listed in
>> > Documentation/kdump/kdump.txt) in case they have suggestions or would
>> > consider some sort of Documentation/ update.
>> >
>> > Bjorn
>> >
>> > _______________________________________________
>> > kexec mailing list
>> > kexec@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/kexec
>> 
>> Thanks
>> Dave
>> 
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
