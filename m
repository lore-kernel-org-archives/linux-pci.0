Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:58825 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab2ITHir (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2012 03:38:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
References: <1347872076-5260-1-git-send-email-ying.huang@intel.com>
	<1347872076-5260-2-git-send-email-ying.huang@intel.com>
	<CAErSpo5fVbN2vD5Omc7dGJFWUccYZoCOVRF4YmXPe2Oxm81u5g@mail.gmail.com>
Date: Thu, 20 Sep 2012 00:38:33 -0700
In-Reply-To: <CAErSpo5fVbN2vD5Omc7dGJFWUccYZoCOVRF4YmXPe2Oxm81u5g@mail.gmail.com>
	(Bjorn Helgaas's message of "Mon, 17 Sep 2012 14:54:16 -0600")
Message-ID: <877grpywhy.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC 1/3] PCI/PM: Fix kexec for D3cold and bridge suspending
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

> +cc Eric and kexec list
>
> On Mon, Sep 17, 2012 at 2:54 AM, Huang Ying <ying.huang@intel.com> wrote:
>> If PCI devices are put into D3cold before kexec, because the
>> configuration registers of PCI devices in D3cold are not accessible.
>>
>> And if PCI bridges are put into low power state before kexec,
>> configuration registers of PCI devices underneath the PCI bridges are
>> not accessible too.
>>
>> These will make some PCI devices can not be scanned after kexec, so
>> resume the PCI devices in D3cold or PCI bridges in low power state
>> before kexec.
>
> Don't we need to resume the device even without the kexec issue?  And
> even if it's in D1 or D2?

The basic requirement is that the device needs to be visible so we can
auto discover it.  As I recall most sleep states don't make the device
invisible and we can handle the rest in the device initializatoin code.

> It looks to me like pci_msi_shutdown() (and probably drv->shutdown())
> depend on the device being in D0.

There is certainly a depenency on the config registers being visible.
Although I don't know if much will go wrong if they aren't.

Ceratinly pci_msi_shutdown doesn't have anything to do if the device has
had so much power removed that the device is not even exectuing.

Eric

>> Signed-off-by: Huang Ying <ying.huang@intel.com>
>> ---
>>  drivers/pci/pci-driver.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -421,6 +421,10 @@ static void pci_device_shutdown(struct d
>>         struct pci_dev *pci_dev = to_pci_dev(dev);
>>         struct pci_driver *drv = pci_dev->driver;
>>
>> +       /* Resume bridges and devices in D3cold for kexec to work properly */
>> +       if (pci_dev->current_state == PCI_D3cold || pci_dev->subordinate)
>> +               pm_runtime_resume(dev);
>> +
>>         if (drv && drv->shutdown)
>>                 drv->shutdown(pci_dev);
>>         pci_msi_shutdown(pci_dev);
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
