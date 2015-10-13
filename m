Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34123 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbbJMIBc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 04:01:32 -0400
Received: by wicgb1 with SMTP id gb1so77893127wic.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2015 01:01:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1729985.4Y6lgbpPqx@vostro.rjw.lan>
References: <4970284.9k6NVjxDce@vostro.rjw.lan>
	<1729985.4Y6lgbpPqx@vostro.rjw.lan>
Date: Tue, 13 Oct 2015 10:01:29 +0200
Message-ID: <CAPDyKFoERBD00U1Wwr==K4E8bj+gaWJsZ7qZt5wRsUFmvFW6Tw@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: Drop pm_request_idle() from pm_generic_complete()
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12 October 2015 at 22:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 30, 2015 02:44:29 AM Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The pm_request_idle() in pm_generic_complete() is pointless as it is
>> called with the runtime PM usage counter different from zero (bumped
>> up by the core during the prepare phase of system suspend) and the
>> core calls pm_runtime_put() for all devices after executing their
>> complete callbacks, so drop it.
>>
>> This allows the PCI PM layer to use pm_generic_complete() too.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> On top of https://patchwork.kernel.org/patch/7291251/ .
>
> Due to the lack of comments for the last several days (which I'm taking as
> the lack of objections), I'm tentatively queing this up for v4.4.
>
> Please let me know if there are any problems with that.

Looks good to me, so unless it's too late you may add my reviewed-by tag.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> Thanks,
> Rafael
>
>
>> ---
>>  drivers/base/power/generic_ops.c |    6 ------
>>  drivers/pci/pci-driver.c         |    9 ++-------
>>  2 files changed, 2 insertions(+), 13 deletions(-)
>>
>> Index: linux-pm/drivers/base/power/generic_ops.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/generic_ops.c
>> +++ linux-pm/drivers/base/power/generic_ops.c
>> @@ -296,11 +296,5 @@ void pm_generic_complete(struct device *
>>
>>       if (drv && drv->pm && drv->pm->complete)
>>               drv->pm->complete(dev);
>> -
>> -     /*
>> -      * Let runtime PM try to suspend devices that haven't been in use before
>> -      * going into the system-wide sleep state we're resuming from.
>> -      */
>> -     pm_request_idle(dev);
>>  }
>>  #endif /* CONFIG_PM_SLEEP */
>> Index: linux-pm/drivers/pci/pci-driver.c
>> ===================================================================
>> --- linux-pm.orig/drivers/pci/pci-driver.c
>> +++ linux-pm/drivers/pci/pci-driver.c
>> @@ -686,13 +686,8 @@ static int pci_pm_prepare(struct device
>>
>>  static void pci_pm_complete(struct device *dev)
>>  {
>> -     struct device_driver *drv = dev->driver;
>> -     struct pci_dev *pci_dev = to_pci_dev(dev);
>> -
>> -     pci_dev_complete_resume(pci_dev);
>> -
>> -     if (drv && drv->pm && drv->pm->complete)
>> -             drv->pm->complete(dev);
>> +     pci_dev_complete_resume(to_pci_dev(dev));
>> +     pm_generic_complete(dev);
>>  }
>>
>>  #else /* !CONFIG_PM_SLEEP */
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
