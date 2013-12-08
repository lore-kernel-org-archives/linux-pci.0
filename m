Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64694 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3LHD0Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 22:26:25 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so4066277iec.30
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 19:26:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
References: <20131009163304.62b439a9@endymion.delvare>
	<CAErSpo6ikaTXXvWzX_Z0=mabwD4aedoLoSVjsd+_E5kV9YJpuA@mail.gmail.com>
Date: Sat, 7 Dec 2013 19:26:24 -0800
Message-ID: <CAE9FiQWGWPVO0W5e9qtbMx7PTEKDq8kUPi1RRT8tucMEy7prYw@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Set master earlier
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean Delvare <jdelvare@suse.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+to BenH]

On Sat, Dec 7, 2013 at 2:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Yinghai]
>
> On Wed, Oct 9, 2013 at 8:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> Since kernel 3.12-rc3, I get the following warning messages at boot:
>> pcieport 0000:00:07.0: driver skip pci_set_master, fix it!
>> pcieport 0000:00:01.0: driver skip pci_set_master, fix it!
>
> cf3e1feba7f9 ("PCI: Workaround missing pci_set_master in pci drivers")
> added this warning and, at the same time, turned on bus mastering.
>
> There didn't seem to be any reason for the warning and no reason why
> bus mastering should be enabled in the driver rather than the core, so
> fbeeb822f6f4 ("PCI: Drop warning about drivers that don't use
> pci_set_master()") just dropped the warning.
>
> This should resolve the problem, so I don't think there's a need for
> this patch.  Let me know if otherwise.

BenH mentioned that get_port_device_capability have some problem on powerpc
and will return null.

>>
>>  drivers/pci/pcie/portdrv_core.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-3.12-rc4.orig/drivers/pci/pcie/portdrv_core.c 2013-09-24 00:41:09.000000000 +0200
>> +++ linux-3.12-rc4/drivers/pci/pcie/portdrv_core.c      2013-10-09 15:43:54.205943783 +0200
>> @@ -366,13 +366,13 @@ int pcie_port_device_register(struct pci
>>         status = pci_enable_device(dev);
>>         if (status)
>>                 return status;
>> +       pci_set_master(dev);
>>
>>         /* Get and check PCI Express port services */
>>         capabilities = get_port_device_capability(dev);
>>         if (!capabilities)
>>                 return 0;
>>
>> -       pci_set_master(dev);
>>         /*
>>          * Initialize service irqs. Don't use service devices that
>>          * require interrupts if there is no way to generate them.
>>
>>
