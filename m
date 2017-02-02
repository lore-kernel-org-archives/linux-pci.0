Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36065 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbdBBQh0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Feb 2017 11:37:26 -0500
To: Emil Velikov <emil.l.velikov@gmail.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
 <35aab5e1-c86d-efbb-f0c8-288469aeb52f@deltatee.com>
 <CACvgo520=CXUHNwd75Er0zPCiEQVfOu0h=eeHNDQ-uQn66kAJA@mail.gmail.com>
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fd54d9a2-5613-29b0-35fe-3db3ecbcdd05@deltatee.com>
Date: Thu, 2 Feb 2017 09:37:14 -0700
MIME-Version: 1.0
In-Reply-To: <CACvgo520=CXUHNwd75Er0zPCiEQVfOu0h=eeHNDQ-uQn66kAJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/02/17 05:10 AM, Emil Velikov wrote:
> You can keep it roughly as-is if you're ~reasonably certain one won't
> change it in the future.

I've made the change anyway. I think it's better now.

> Some teams frown upon adding new IOCTL(s) where existing ones can be
> made backward/forward compatible.
> I'm not fully aware of the general direction/consensus on the topic,
> so it might be a minority.

Sure, I just don't know what might be needed in the future so it's hard
to add a version or flags ioctl now.

> On the other hand, reading through sysfs for module version in order
> to use IOCTL A or B sounds quite hacky. Do you have an example where
> this is used or pointed out as good approach ?

I don't know of anything doing it that way now. But it sure would be
easy and make a bit of sense. (We'd actually use the module version for
something useful.) Either way, it would really depend on if and how
things change in the future. The point is there are options to expand if
needed.


> Afaict the idea is to not ship/bundle/release userspace until kernel
> parts are in.
> The "do not commit the changes" is implied as [very rarely] distros
> package from "random" git checkouts. Leading to all sorts of fun when
> it is mismatched wrt the kernel parts. Likelihood of doing that here
> is virtually none here, so this is a JFYI inspired by some past
> experiences.

Understood.

> Glad to hear. Then again you already had most of the things nicely done, imho.

Great, thanks.

Logan
