Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from server1.meinberg.de ([85.10.202.66]:54837 "EHLO
	server1.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2ARSWY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 13:22:24 -0500
Message-ID: <4F170DDB.3010105@meinberg.de>
Date: Wed, 18 Jan 2012 19:22:19 +0100
From: Martin Burnicki <martin.burnicki@meinberg.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-pci@vger.kernel.org
Subject: Re: PCI card not accessible; I/O ports at <ignored>
References: <4F16EA07.4000607@meinberg.de> <20120118162858.GB22156@kroah.com>
In-Reply-To: <20120118162858.GB22156@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg KH wrote:
> On Wed, Jan 18, 2012 at 04:49:27PM +0100, Martin Burnicki wrote:
>> Hi folks,
>>
>> I'm maintaining the driver software for the PCI cards manufactured
>> by our company, Meinberg Funkuhren in Germany. Basically our Linux
>> driver supports all our PCI cards on all Linux kernels 2.6.x and
>> 3.x. The PCI cards are e.g. GPS receivers, radio clocks, or IRIG
>> time code receivers.
>
> Nice, any reason why these drivers aren't in the main kernel.org tree?

Yes, you wouldn't like the coding style of our driver ;-)

Seriously, I have discussed this with some Linux guys before, and also 
with some folks from *BSD who also wanted to pick up the driver into 
their *BSD source trees.


The disadvantages of this approach were:

- If someone wanted to use a new type of PCI card then he was forced to 
upgrade the kernel to get support for it. We have quite a number of 
customers who want to stick with a specific Linux distribution version 
(and thus kernel version) for some reason, so they wouldn't be able to 
use a newer PCI card model unless they backport a newer driver to an 
older kernel. E.g. we have a number of customers who still run some old 
RHEL versions with kernels around 2.6.16 or so, but they are using 
current PCI card models.

- Sometimes it happens that new features are implemented in the firmware 
of the PCI cards, often even on request of a customer. To benefit from 
such new features the appropriate changes needed to be made in the 
driver code, and again this would require some backporting if the user 
is not willing to upgrade the kernel.

- The driver code would have to be reformatted for Linux to comply with 
the Linux coding style, for FreeBSD to comply with the FreeBSD coding 
style, etc.


Our cards are often used as reference time source for ntpd, but also for 
measurement applications which access the cards directly. In any way, 
the cards provide usually quite a number of configuration parameters 
which can be or need to be set up properly, depending on the requirements.

API calls required for these cards include reading high resolution,high 
accurate timestamps from the card, but also lots of configuration stuff, 
e.g. reading which IRIG code formats are supported by a given IRIG 
receiver card, and configuring the selected IRIG code to be decoded by 
the card. The huge amount of API calls is very specific to our cards.

Actually our driver code is divided into some pieces of OS-specific code 
and a huge piece of code which is shared for all supported operating 
systems, including Linux, Windows, FreeBSD, NetBSD, Novell Netware, DOS, 
formerly OS/2, and even by the firmware for the microcontrollers on the 
PCI devices.

There is one driver package for Linux, which can be used with all 2.6.x 
and 3.x kernels, one package for FreeBSD, a single driver for all 
Windows versions from WinNT up to Win7 and Server 2008. All these 
drivers share a lot of source code, and in fact the API calls available 
to applications are source code compatible across all supported 
operating systems. We have had quite a number of customers who started 
to use our cards under Windows, and then switched to Linux, and didn't 
have to change the way API calls for our PCI cards are used by their 
application.

Since many years our Linux driver is available as source code on our 
download page:
http://www.meinberg.de/english/sw/#linux

I must admit that the driver on this page is a little bit outdated. 
However, we are currently preparing a new release:
http://www.meinberg.de/download/drivers/mbgtools-lx-dev-2011-12-19.tar.gz

There's also a corresponding driver version for FreeBSD, the first 
release of which will be available with the next version of the Linux 
driver:
http://www.meinberg.de/download/drivers/mbgtools-fbsd-dev-2011-12-21.tar.gz

If you look into both archives you'll see that the user space tools and 
mostly all the stuff below the mbglib directory is shared by both driver 
packages.

For example, there is one common source code module which implements the 
basic functions usually required by kernel drivers, e.g.:

- check if a particular device is supported

- start the device and detect the features it provides, which depend on 
the type of card but may also depend on the firmware version actually 
installed on the card

- provide different low level functions required to access cards 
depending on the PCI interface chip assembled on the detected card

In addition, there is an OS-specific skeleton driver which calls those 
routines if e.g. the kernel calls the probe or ioctl routine for a given 
device.


So the advantages of our approach to maintain the drivers out of the 
Linux or *BSD source trees are:

- we can implement new features and support new card types by making 
changes *once* in the source code, and the new feature is available 
immediately for all supported operating systems.

- it provides most possible flexibility for the folks who use our PCI 
cards since they can use our latest driver for the newest cards even 
with older distributions/kernels. Just unpack the archive, type
make && make install
and that's it.


I'd like to point out explicitely that our approach is *not* because we 
want to keep some stuff as secret. Everything is available as source 
code, and you can grab a copy of the code and merge it into the kernel 
tree, if you want. However, maintaining the driver code would be much 
harder then since for a new feature the Linux tree needed to be updated, 
*BSD trees needed to be updated, and we'd need to maintain our local 
code base anyway to support those operating systems which are not open 
source.

BTW, we are currently also working on a GUI application which is based 
on wxWidgets and can be used to view and modify configuration parameters 
on our different PCI card types under different operating systems. This 
project also shares much of the common code, so once more it is easier 
to provide common driver packages than having a specific driver in the 
kernel only.

Sorry for the lengthy reply, but I've tried to make our point as clear 
as possible, and hope you understand and accept the reasoning.


Martin
-- 
Martin Burnicki

Meinberg Funkuhren
Bad Pyrmont
Germany
