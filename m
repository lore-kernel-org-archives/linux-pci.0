Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36780 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbdBCNt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 08:49:58 -0500
MIME-Version: 1.0
In-Reply-To: <fd54d9a2-5613-29b0-35fe-3db3ecbcdd05@deltatee.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com> <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
 <35aab5e1-c86d-efbb-f0c8-288469aeb52f@deltatee.com> <CACvgo520=CXUHNwd75Er0zPCiEQVfOu0h=eeHNDQ-uQn66kAJA@mail.gmail.com>
 <fd54d9a2-5613-29b0-35fe-3db3ecbcdd05@deltatee.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 3 Feb 2017 13:49:56 +0000
Message-ID: <CACvgo506LPBscY6gdcV=3PSQ+ZaZ8HePZ58pczQ2WVdf_CuK9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2 February 2017 at 16:37, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 01/02/17 05:10 AM, Emil Velikov wrote:
>> You can keep it roughly as-is if you're ~reasonably certain one won't
>> change it in the future.
>
> I've made the change anyway. I think it's better now.
>
>> Some teams frown upon adding new IOCTL(s) where existing ones can be
>> made backward/forward compatible.
>> I'm not fully aware of the general direction/consensus on the topic,
>> so it might be a minority.
>
> Sure, I just don't know what might be needed in the future so it's hard
> to add a version or flags ioctl now.
>
Yes knowing how things will need to change in the is hard. That's why
the documentation suggestions adding a flag to the ioctl structs.
It [the flag] might imply certain functional/implementation change,
support for new/deprecation of old features and others.

>> On the other hand, reading through sysfs for module version in order
>> to use IOCTL A or B sounds quite hacky. Do you have an example where
>> this is used or pointed out as good approach ?
>
> I don't know of anything doing it that way now. But it sure would be
> easy and make a bit of sense. (We'd actually use the module version for
> something useful.) Either way, it would really depend on if and how
> things change in the future. The point is there are options to expand if
> needed.
>
The part that nobody else is doing such a thing should ring a bell ;-)

It's no my call, but if it was I'd stick with the existing approach
and not "reinvent the wheel" sort of speak.

Thanks
Emil
