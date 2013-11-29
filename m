Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31751 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab3K2Bdm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2013 20:33:42 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Joe Perches' <joe@perches.com>,
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	'Andrew Morton' <akpm@linux-foundation.org>,
	'Andy Whitcroft' <apw@canonical.com>,
	linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
 <20131128040750.GA29917@kroah.com>
 <006001ceebfa$c85a1020$590e3060$%han@samsung.com>
 <1385617213.12210.5.camel@joe-AO722> <20131128055328.GA565@kroah.com>
 <1385619863.12210.14.camel@joe-AO722>
In-reply-to: <1385619863.12210.14.camel@joe-AO722>
Subject: Re: [PATCH 1/5] serial: 8250_pci: use DEFINE_PCI_DEVICE_TABLE macro
Date: Fri, 29 Nov 2013 10:33:35 +0900
Message-id: <001d01ceeca3$0557d630$10078290$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 28, 2013 3:24 PM, Joe Perches wrote:
>On Wed, 2013-11-27 at 21:53 -0800, 'Greg Kroah-Hartman' wrote:
>>On Wed, Nov 27, 2013 at 09:40:13PM -0800, Joe Perches wrote:
>>>On Thu, 2013-11-28 at 14:29 +0900, Jingoo Han wrote:
>>>>On Thursday, November 28, 2013 1:08 PM, Greg Kroah-Hartman wrote:
>>>>>On Thu, Nov 28, 2013 at 10:55:35AM +0900, Jingoo Han wrote:
>>>>>> This macro is used to create a struct pci_device_id array.
>>>>>
>>>>> Yeah, and it's a horrid macro that deserves to be removed, please don't
>>>>> use it in more places.
>>>>>
>>>>> Actually, if you could just remove it, that would be best, sorry, I'm
>>>>> not going to take these patches.
>>>>
>>>> (+cc Joe Perches, Andrew Morton, Andy Whitcroft)
>>>>
>>>> Hi Joe Perches,
>>>>
>>>> Would you fix checkpatch.pl about DEFINE_PCI_DEVICE_TABLE?
>>>> Currently, checkpatch.pl guides to use DEFINE_PCI_DEVICE_TABLE
>>>> as below.
>>>>
>>>>   WARNING: Use DEFINE_PCI_DEVICE_TABLE for struct pci_device_id
>>>>   #331: FILE: drivers/usb/host/ehci-pci.c:331:
>>>>   +static const struct pci_device_id pci_ids [] = { {
>>>>
>>>> However, Greg Kroah-Hartman mentioned that DEFINE_PCI_DEVICE_TABLE
>>>> shouldn't be used anymore.
>>>>
>>>> So, would you change checkpatch.pl in order to guide to use
>>>> struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE?
>>>>
>>>> For example,
>>>>   WARNING: Use struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE
>>>
>>> The documentation doesn't agree with Greg.
>[]
>> I say just remove it, I should have done that years ago when I was the
>> PCI maintainer, just never got around to it.  No other bus has something
>> like this for their device ids, why should PCI be "special"?
>
>Anyone else have an opinion?
>
>I don't care one way or another, but please, one way
>not two.

(+cc Bjorn Helgaas, linux-pci)

Then, how about the following steps?

1. Fix ./Documentation/PCI/pci.txt as below.
   (Jingoo Han)
   The ID table is an array of struct pci_device_id entries ending with an
   -all-zero entry; use of the macro DEFINE_PCI_DEVICE_TABLE is the preferred
   -method of declaring the table.  Each entry consists of:
   +all-zero entry; Each entry consists of:

2. Fix ./scripts/checkpatch.pl in order to guide to use
    struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE.
    (Joe Perches)

3. Replace DEFINE_PCI_DEVICE_TABLE of ./drivers/*
    with 'const struct pci_device_id'.
   (Jingoo Han)

4. These patches will be merged through 'driver-core.git'
    with 'Acked-by' of each subsystem maintainer.
   (Greg Kroah-Hartman)

Best regards,
Jingoo Han

>Changing checkpatch is a trifle, but there are a _lot_
>of maintainers to work through if it's to be removed.
>
>It'll probably take several releases.
>
>$ git grep --name-only -w DEFINE_PCI_DEVICE_TABLE | \
>  cut -f1,2 -d/ | uniq -c
>      1 Documentation/PCI
>      1 arch/x86
>      1 drivers/bcma
>      3 drivers/block
>      1 drivers/char
>      1 drivers/cpufreq
>      2 drivers/dma
>     18 drivers/edac
>      6 drivers/gpio
>      6 drivers/gpu
>      6 drivers/hwmon
>     20 drivers/i2c
>      2 drivers/infiniband
>      1 drivers/ipack
>      1 drivers/leds
>      3 drivers/media
>     10 drivers/mfd
>      2 drivers/misc
>      1 drivers/mmc
>      1 drivers/mtd
>    132 drivers/net
>      1 drivers/ntb
>      1 drivers/pci
>      5 drivers/pcmcia
>      2 drivers/platform
>      1 drivers/ptp
>      1 drivers/rapidio
>      7 drivers/scsi
>      3 drivers/spi
>     65 drivers/staging
>      3 drivers/tty
>      1 drivers/uio
>      5 drivers/usb
>      1 drivers/video
>      1 drivers/virtio
>      3 drivers/vme
>      9 drivers/watchdog
>      1 drivers/xen
>      1 include/linux
>      1 scripts/checkpatch.pl
>      1 scripts/tags.sh
>      1 sound/oss
>     67 sound/pci

