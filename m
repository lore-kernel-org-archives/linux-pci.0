Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
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
Message-ID: <35aab5e1-c86d-efbb-f0c8-288469aeb52f@deltatee.com>
Date: Tue, 31 Jan 2017 16:13:50 -0700
MIME-Version: 1.0
In-Reply-To: <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Emil,

Thanks for the feedback.

On 31/01/17 01:48 PM, Emil Velikov wrote:
>> +struct switchtec_ioctl_fw_info {
>> +       __u32 flash_length;
>> +
>> +       struct {
>> +               __u32 address;
>> +               __u32 length;
>> +               __u32 active;
> Something to keep in mind, not sure how likely it is here:
> If you embed structs (partition in this case), you will not be able to
> extend it [the embedded one] it in the future without the risk of ABI
> breakage.

Based on this feedback, I'll rework the fw_info IOCTL so the user only
requests one partition at a time. This will get rid of the embedded
struct and any concerns about size changes. I was originally trying to
make the ioctl RO to make it simpler but that maybe isn't the case.

>> +       } partition[SWITCHTEC_IOCTL_NUM_PARTITIONS];
>> +};
>> +
> Afaict this and most/all other structs [in this patch] are in
> violation of Prerequisites#2 and/or #3.
> Personally I find pahole quite useful - reference all the UABI structs
> in a dummy userspace app, compile with gcc -g -O0 and observe the
> output across 32 and 64bit builds. Members _must_ be at the same
> offset, otherwise things will be broken with 64bit kernel on a 32bit
> userspace. Something which people will eventually end up trying/using,
> even if you don't plan to support it.

I've made some changes to the padding and sizes to accommodate this.
I'll also do some testing with pahole before v2.


> Please check that Basics (#2 and #5 in particular) are also covered.

> then you need a driver feature flag or revision number somewhere.

We don't have this specifically. A new version ioctl could be added
later when and if changes occur; or the userspace code could easily read
the module version through sysfs and we could increment that with ioctl
changes.

> A couple more generic suggestions, which I may have noticed while
> skimming through:
>  - please ensure that all the input is properly sanitised, before,
> going into the actual implementation
> Afaict having the separate step/separation helps clarity and reduces
> chances of you/others getting it wrong down the line.

The inputs are indeed properly checked in the code. Most of the ioctls
that take inputs are so simple it's hard to separate the two steps. ie.
Verifying that the input is right pretty much gives you the answer you
need to send back to userspace.

>  - user provided storage must not be changed when the ioctl fails.

This should already be true.

> Additionally you want to provide a reference to open-source userspace
> [alongside acknowledgement of the maintainers/co-developers about the
> design] which makes use of said IOCTL(s). But please, do _not_ merge
> userspace code before the kernel work has landed.

I'm having trouble understanding what you're asking here. We provided a
reference to the userspace code in the commit message. Currently the
userspace code is completely useless without the kernel module and it is
entirely independent of other projects. I'm also the only committer so
far on the userspace code. So I assume this only applies if we were
merging changes to other existing code?

> Hope that provided you with sufficient good points wrt IOCTL design.

Thanks, this was very helpful.

Logan
