Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:38577 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab2ITI1k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2012 04:27:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Huang Ying <ying.huang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
References: <1347872076-5260-1-git-send-email-ying.huang@intel.com>
	<1347872076-5260-2-git-send-email-ying.huang@intel.com>
	<CAErSpo5fVbN2vD5Omc7dGJFWUccYZoCOVRF4YmXPe2Oxm81u5g@mail.gmail.com>
	<877grpywhy.fsf@xmission.com> <1348129173.8212.218.camel@yhuang-dev>
Date: Thu, 20 Sep 2012 01:27:33 -0700
In-Reply-To: <1348129173.8212.218.camel@yhuang-dev> (Huang Ying's message of
	"Thu, 20 Sep 2012 16:19:33 +0800")
Message-ID: <87fw6dxfnu.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC 1/3] PCI/PM: Fix kexec for D3cold and bridge suspending
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Huang Ying <ying.huang@intel.com> writes:

> On Thu, 2012-09-20 at 00:38 -0700, Eric W. Biederman wrote:
>> Bjorn Helgaas <bhelgaas@google.com> writes:
>> 
>> > +cc Eric and kexec list
>> >
>> > On Mon, Sep 17, 2012 at 2:54 AM, Huang Ying <ying.huang@intel.com> wrote:
>> >> If PCI devices are put into D3cold before kexec, because the
>> >> configuration registers of PCI devices in D3cold are not accessible.
>> >>
>> >> And if PCI bridges are put into low power state before kexec,
>> >> configuration registers of PCI devices underneath the PCI bridges are
>> >> not accessible too.
>> >>
>> >> These will make some PCI devices can not be scanned after kexec, so
>> >> resume the PCI devices in D3cold or PCI bridges in low power state
>> >> before kexec.
>> >
>> > Don't we need to resume the device even without the kexec issue?  And
>> > even if it's in D1 or D2?
>> 
>> The basic requirement is that the device needs to be visible so we can
>> auto discover it.  As I recall most sleep states don't make the device
>> invisible and we can handle the rest in the device initializatoin code.
>
> PCI devices in D3cold or under a bridge in D3hot will not be visible, so
> we must fix that for kexec to run properly.

That seems reasonable to me.

>> > It looks to me like pci_msi_shutdown() (and probably drv->shutdown())
>> > depend on the device being in D0.
>> 
>> There is certainly a depenency on the config registers being visible.
>> Although I don't know if much will go wrong if they aren't.
>> 
>> Ceratinly pci_msi_shutdown doesn't have anything to do if the device has
>> had so much power removed that the device is not even exectuing.
>
> Don't know which power state device should be in for pci_msi_shutdown
> etc.  But it appears that normal shutdown/reboot and kexec works at most
> times so far.  D3cold and bridge in D3hot works for normal
> shutdown/reboot, but not for kexec.  So I write some fix.

To be clear.  Has someone picked up this patch yet?

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

As for reboot it tends to always work because frequently the firmware
code triggers a soft reset of the entire machine, which puts devices in
their power on reset state, which is not a suspended state.  Although
that behavior is not required for a software reboot.

Eric



> Best Regards,
> Huang Ying
>
>> >> Signed-off-by: Huang Ying <ying.huang@intel.com>
>> >> ---
>> >>  drivers/pci/pci-driver.c |    4 ++++
>> >>  1 file changed, 4 insertions(+)
>> >>
>> >> --- a/drivers/pci/pci-driver.c
>> >> +++ b/drivers/pci/pci-driver.c
>> >> @@ -421,6 +421,10 @@ static void pci_device_shutdown(struct d
>> >>         struct pci_dev *pci_dev = to_pci_dev(dev);
>> >>         struct pci_driver *drv = pci_dev->driver;
>> >>
>> >> +       /* Resume bridges and devices in D3cold for kexec to work properly */
>> >> +       if (pci_dev->current_state == PCI_D3cold || pci_dev->subordinate)
>> >> +               pm_runtime_resume(dev);
>> >> +
>> >>         if (drv && drv->shutdown)
>> >>                 drv->shutdown(pci_dev);
>> >>         pci_msi_shutdown(pci_dev);
>> >
>> > _______________________________________________
>> > kexec mailing list
>> > kexec@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/kexec
