Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35028 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdBWUhU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 15:37:20 -0500
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <2eb2b814-d621-5d8d-8366-4c4e9f789208@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
Date: Thu, 23 Feb 2017 13:36:51 -0700
MIME-Version: 1.0
In-Reply-To: <2eb2b814-d621-5d8d-8366-4c4e9f789208@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

We're still waiting on any kind of response from Bjorn. (If you're
listening please say something!)

Does anyone have any suggestions for dealing with an unresponsive
maintainer? Or a way for us to move forward with this quickly and get it
merged?

ie. Can anyone else pick this up through another route? In the end, it's
just a fairly basic driver and doesn't touch any core PCI functionality
and we've had a fair amount of review from other kernel contributors,
all of which we've addressed.

Thanks,

Logan




On 17/02/17 01:36 PM, Logan Gunthorpe wrote:
> Hi Bjorn,
> 
> Can you give us an idea of when you might be able to comment on our
> patchset? We've addressed all the outstanding issues and have a couple
> of reviewed and tested tags. So we'd like to see this move forward as
> soon as possible.
> 
> I can do a respin with the tags collected or address any concerns you
> may have, just please let us know.
> 
> Thanks,
> 
> Logan
> 
> On 02/02/17 11:05 AM, Logan Gunthorpe wrote:
>> Changes since v1:
>>
>> * Rebased onto 4.10-rc6 (cleanly)
>> * Split the patch into a few more easily digestible patches (as
>>   suggested by Greg Kroah-Hartman)
>> * Folded switchtec.c into switchtec.h (per Greg)
>> * Fixed a bunch of 32bit build warnings caught by the kbuild test robot
>> * Fixed some issues in the documentation so it has a proper
>>   reStructredText format (as noted by Jonathan Corbet)
>> * Fixed padding and sizes in the IOCTL structures as noticed by Emil
>>   Velikov and used pahole to verify their consistency across 32 and 64
>>   bit builds
>> * Reworked one of the IOCTL interfaces to be more future proof (per
>>   Emil).
>>
>> Changes since RFC:
>>
>> * Fixed incorrect use of the drive model as pointed out by Greg
>>   Kroah-Hartman
>> * Used devm functions as suggested by Keith Busch
>> * Added a handful of sysfs attributes to the switchtec class
>> * Added a handful of IOCTLs to the switchtec device
>> * A number of miscellaneous bug fixes
>>
>> --
>>
>> Hi,
>>
>> This is a continuation of the RFC we posted lasted month [1] which
>> proposes a management driver for Microsemi's Switchtec line of PCI
>> switches. This hardware is still looking to be used in the Open
>> Compute Platform
>>
>> To make this entirely clear: the Switchtec products are compliant
>> with the PCI specifications and are supported today with the standard
>> in-kernel driver. However, these devices also expose a management endpoint
>> on a separate PCI function address which can be used to perform some
>> advanced operations. This is a driver for that function. See the patch
>> for more information.
>>
>> Since the RFC, we've made the changes requested by Greg Kroah-Hartman
>> and Keith Busch, and we've also fleshed out a number of features. We've
>> added a couple of IOCTLs and sysfs attributes which are documented in
>> the patch. Significant work has also been done on the userspace tool
>> which is available under a GPL license at [2]. We've also had testing
>> done by some of the interested parties.
>>
>> We hope to see this work included in either 4.11 or 4.12 assuming a
>> smooth review process.
>>
>> The patch is based off of the v4.10-rc6 release.
>>
>> Thanks for your review,
>>
>> Logan
>>
>> [1] https://www.spinics.net/lists/linux-pci/msg56897.html
>> [2] https://github.com/sbates130272/switchtec-user
>>
>> --
>>
>> Logan Gunthorpe (4):
>>   MicroSemi Switchtec management interface driver
>>   switchtec: Add user interface documentation
>>   switchtec: Add sysfs attributes to the Switchtec driver
>>   switchtec: Add IOCTLs to the Switchtec driver
>>
>>  Documentation/ABI/testing/sysfs-class-switchtec |   96 ++
>>  Documentation/ioctl/ioctl-number.txt            |    1 +
>>  Documentation/switchtec.txt                     |   80 ++
>>  MAINTAINERS                                     |   11 +
>>  drivers/pci/Kconfig                             |    1 +
>>  drivers/pci/Makefile                            |    1 +
>>  drivers/pci/switch/Kconfig                      |   13 +
>>  drivers/pci/switch/Makefile                     |    1 +
>>  drivers/pci/switch/switchtec.c                  | 1608 +++++++++++++++++++++++
>>  include/uapi/linux/switchtec_ioctl.h            |  132 ++
>>  10 files changed, 1944 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
>>  create mode 100644 Documentation/switchtec.txt
>>  create mode 100644 drivers/pci/switch/Kconfig
>>  create mode 100644 drivers/pci/switch/Makefile
>>  create mode 100644 drivers/pci/switch/switchtec.c
>>  create mode 100644 include/uapi/linux/switchtec_ioctl.h
>>
>> --
>> 2.1.4
>>
