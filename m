Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:49820 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab3DLTD7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 15:03:59 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so2896986oah.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 12:03:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2781744.X672n7t2jq@vostro.rjw.lan>
References: <20130221155329.GA26729@arm.com> <20130411234426.GA10196@google.com>
 <2781744.X672n7t2jq@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 12 Apr 2013 13:03:39 -0600
Message-ID: <CAErSpo78TrUtBBFM9AYciXWDtkPaQDnZt3kdYeBCpF3BOwhrng@mail.gmail.com>
Subject: Re: [PATCH] pci: Remove unnecessary dependency between PME and ACPI.
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Murray <Andrew.Murray@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 12, 2013 at 5:13 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, April 11, 2013 05:44:26 PM Bjorn Helgaas wrote:
>> On Thu, Feb 21, 2013 at 03:53:29PM +0000, Andrew Murray wrote:
>> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
>> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> > ---
>> >  drivers/pci/pcie/Kconfig |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> > index 6c8bc58..4cccd8c 100644
>> > --- a/drivers/pci/pcie/Kconfig
>> > +++ b/drivers/pci/pcie/Kconfig
>> > @@ -82,4 +82,4 @@ endchoice
>> >
>> >  config PCIE_PME
>> >     def_bool y
>> > -   depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL && ACPI
>> > +   depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
>>
>> I think we can go even further and remove the ACPI-related #includes
>> as in the patch below.  Any objections to this?
>>
>>
>> commit 8bde83b5f5519b630e7630fb735f76c184c74289
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu Apr 11 17:36:50 2013 -0600
>>
>>     PCI: Remove unnecessary dependencies between PME and ACPI
>>
>>     PCIe PME doesn't depend on ACPI, so remove the #includes and
>>     Kconfig dependency.
>>
>>     Based-on-patch-by: Andrew Murray <Andrew.Murray@arm.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I applied this for v3.10, thanks!

Bjorn

>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index fde4a32..569f82f 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -82,4 +82,4 @@ endchoice
>>
>>  config PCIE_PME
>>       def_bool y
>> -     depends on PCIEPORTBUS && PM_RUNTIME && ACPI
>> +     depends on PCIEPORTBUS && PM_RUNTIME
>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>> index 9ca0dc9..795db1f 100644
>> --- a/drivers/pci/pcie/pme.c
>> +++ b/drivers/pci/pcie/pme.c
>> @@ -19,8 +19,6 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/device.h>
>>  #include <linux/pcieport_if.h>
>> -#include <linux/acpi.h>
>> -#include <linux/pci-acpi.h>
>>  #include <linux/pm_runtime.h>
>>
>>  #include "../pci.h"
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
