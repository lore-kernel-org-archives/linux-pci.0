Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <35aab5e1-c86d-efbb-f0c8-288469aeb52f@deltatee.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com> <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
 <35aab5e1-c86d-efbb-f0c8-288469aeb52f@deltatee.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 1 Feb 2017 12:10:59 +0000
Message-ID: <CACvgo520=CXUHNwd75Er0zPCiEQVfOu0h=eeHNDQ-uQn66kAJA@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31 January 2017 at 23:13, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hi Emil,
>
> Thanks for the feedback.
>
> On 31/01/17 01:48 PM, Emil Velikov wrote:
>>> +struct switchtec_ioctl_fw_info {
>>> +       __u32 flash_length;
>>> +
>>> +       struct {
>>> +               __u32 address;
>>> +               __u32 length;
>>> +               __u32 active;
>> Something to keep in mind, not sure how likely it is here:
>> If you embed structs (partition in this case), you will not be able to
>> extend it [the embedded one] it in the future without the risk of ABI
>> breakage.
>
> Based on this feedback, I'll rework the fw_info IOCTL so the user only
> requests one partition at a time. This will get rid of the embedded
> struct and any concerns about size changes. I was originally trying to
> make the ioctl RO to make it simpler but that maybe isn't the case.
>
You can keep it roughly as-is if you're ~reasonably certain one won't
change it in the future.

>> then you need a driver feature flag or revision number somewhere.
>
> We don't have this specifically. A new version ioctl could be added
> later when and if changes occur; or the userspace code could easily read
> the module version through sysfs and we could increment that with ioctl
> changes.
>
Some teams frown upon adding new IOCTL(s) where existing ones can be
made backward/forward compatible.
I'm not fully aware of the general direction/consensus on the topic,
so it might be a minority.

On the other hand, reading through sysfs for module version in order
to use IOCTL A or B sounds quite hacky. Do you have an example where
this is used or pointed out as good approach ?

>> A couple more generic suggestions, which I may have noticed while
>> skimming through:
>>  - please ensure that all the input is properly sanitised, before,
>> going into the actual implementation
>> Afaict having the separate step/separation helps clarity and reduces
>> chances of you/others getting it wrong down the line.
>
> The inputs are indeed properly checked in the code. Most of the ioctls
> that take inputs are so simple it's hard to separate the two steps. ie.
> Verifying that the input is right pretty much gives you the answer you
> need to send back to userspace.
>
>>  - user provided storage must not be changed when the ioctl fails.
>
> This should already be true.
>
You're spot on [for both points]. I must have imagined something.

>> Additionally you want to provide a reference to open-source userspace
>> [alongside acknowledgement of the maintainers/co-developers about the
>> design] which makes use of said IOCTL(s). But please, do _not_ merge
>> userspace code before the kernel work has landed.
>
> I'm having trouble understanding what you're asking here. We provided a
> reference to the userspace code in the commit message. Currently the
> userspace code is completely useless without the kernel module and it is
> entirely independent of other projects. I'm also the only committer so
> far on the userspace code. So I assume this only applies if we were
> merging changes to other existing code?
>
Yes, I'm blind - you have links to the userspace.

Afaict the idea is to not ship/bundle/release userspace until kernel
parts are in.
The "do not commit the changes" is implied as [very rarely] distros
package from "random" git checkouts. Leading to all sorts of fun when
it is mismatched wrt the kernel parts. Likelihood of doing that here
is virtually none here, so this is a JFYI inspired by some past
experiences.

>> Hope that provided you with sufficient good points wrt IOCTL design.
>
> Thanks, this was very helpful.
>
Glad to hear. Then again you already had most of the things nicely done, imho.

-Emil
