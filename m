Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42937 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab3EaTMo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 15:12:44 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so265776oag.28
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 12:12:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t8LLAV5y97shV=8QBrVrRDcC3=D_2fnX_-G9TQde_j96Q@mail.gmail.com>
References: <CAH9N0t-DOC0iOMjtHUTznCzk=C7RpbdBOhYR=mK1zaAmeH-Rqw@mail.gmail.com>
 <CAE9FiQXCf-h84sXqGPKbdd66oNbzWOtfea+PcHFiJPLPBc6oGQ@mail.gmail.com>
 <CAH9N0t_4uxJ21wasRSNKBt+5X-cQGwqStakRccfggm1TAbOAqQ@mail.gmail.com>
 <CAErSpo7m=m89ixrHA9KaqQKJOfZ_vozHSwnUwy_FHZszXLMgLw@mail.gmail.com> <CAH9N0t8LLAV5y97shV=8QBrVrRDcC3=D_2fnX_-G9TQde_j96Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 31 May 2013 13:12:23 -0600
Message-ID: <CAErSpo4KupLiCuJvcXbOb5uCEJrLqu9UeoSmgkHBZrfMy9zehw@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
To: Paulo Ricardo Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 2:24 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Hello,
> From the point of view of pciehp.ko module yes everything is correct.
> Now im trying to automatize the remove and insertion of device driver
> modules by putting hotplug scripts in the system specyfied
> directories.

The driver should be automatically loaded via udev if you have
everything set up correctly.  I don't know all the details of udev,
but I don't think the driver is normally unloaded automatically when
you remove the device.

Let us know if you have problems.

Bjorn

> 2013/5/30, Bjorn Helgaas <bhelgaas@google.com>:
>> On Thu, May 30, 2013 at 2:49 AM, Paulo Fortuna Carvalho
>> <pricardofc@ipfn.ist.utl.pt> wrote:
>>> Hello Yinghai,
>>> Im sending you the boot.log file in attach with the grub.conf changed
>>> to add debug ignore_loglevel.
>>> Also I could manage to load pciehp.ko (not fakephp.ko) module at boot
>>> time.
>>
>> The log of interest would be the *dmesg* log, i.e., the output of the
>> "dmesg" command.
>>
>> Is there any remaining problem, or is everything working as you expect?
>>
>>> 2013/5/29, Yinghai Lu <yinghai@kernel.org>:
>>>> On Wed, May 29, 2013 at 10:30 AM, Paulo Fortuna Carvalho
>>>> <pricardofc@ipfn.ist.utl.pt> wrote:
>>>>> Hello Yinghai and Bjorn,
>>>>> Issue solved.
>>>>> You were correct. The module fakephp.ko was not loaded.
>>>>
>>>> No, you should not use fackephp.ko. As it was removed already
>>>> in recent kernel.
>>>> It is replaced by pci slot driver.
>>>>
>>>> In your case you should pciehp.ko
>>>>
>>>> Please post boot log with "debug ignore_loglevel"
>>>>
>>>>
>>>>> Now everything works ok and device driver need not to be changed.
>>>>> As you said is a normal PCI Device Driver.
>>>>>
>>>>> Now I want that that when ATCA card is without energy ( 11:00.0 DPIO
>>>>> module: PLD APPLICATIONS Device 6014 (rev ff) )
>>>>>
>>>>> the command:
>>>>> echo 0 > /sys/bus/pci/slots/0000*/power is automatically executed.
>>>>>
>>>>> At the moment i'm doing it manually and after that my atca card driver
>>>>> is removed.
>>>>>
>>>>> And when i give energy to the ATCA card i have to manually perform pci
>>>>> bus re-enumeration
>>>>> with command:
>>>>> echo 1 > /sys/bus/pci/rescan
>>>>>
>>>>> and the ATCA card driver is automatically inserted. How can
>>>>> re-enumeration be done automatically?
>>>>
>>>> If you can enable pciehp.ko for 04:08.0, then you can use
>>>> echo 0 > /sys/bus/pci/slots/48/power
>>>> echo 1 > /sys/bus/pci/slots/48/power
>>>>
>>>> that should probe devices and load driver automatically.
>>>>
>>>> Yinghai
>>>>
>>
