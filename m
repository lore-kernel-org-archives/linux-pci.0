Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34350 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdAaUsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2017 15:48:37 -0500
MIME-Version: 1.0
In-Reply-To: <1485882204-26947-2-git-send-email-logang@deltatee.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com> <1485882204-26947-2-git-send-email-logang@deltatee.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 31 Jan 2017 20:48:34 +0000
Message-ID: <CACvgo50ruxTOfhGF=bV+xWVq+5UZ_xWeoTqxA+SzSwFNCVaS8g@mail.gmail.com>
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

Hi Logan,

NOTE: Please take my comments with a healthy pinch of salt.

I'd imagine that core/more experienced developers have more thorough
feedback, so I'll mention a few things on the less common part -
robust/compat UABI.
Above all, please read through the in-tree documentation on the topic [1]

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/ioctl/botching-up-ioctls.txt?id=refs/tags/v4.10-rc6

On 31 January 2017 at 17:03, Logan Gunthorpe <logang@deltatee.com> wrote:

> --- /dev/null
> +++ b/include/uapi/linux/switchtec_ioctl.h


> +enum switchtec_ioctl_partition {

> +       SWITCHTEC_IOCTL_NUM_PARTITIONS,
> +};
I'm not sure what the overall consensus on the topic of 'enums vs
defines in UABI'. Fwiw personally I'm in favour of defines since enums
can lead to subtle issues if one is not extra careful. For example:
 - add new enum amidst the list - ABI break
 - add new enum at the end of the list [just before NUM_PARTITIONS] - ABI break.
 - opt for negative value for existing/new enum - ABI break
 - other

With a variable size in mind, carefully consider how you'll copy data
back and forth in the case of new kernel (supports partition[X) + old
userspace (partition [X-1]) and vice-versa. Feel free to look at the
drm ioctl handler and/or others through the kernel.

Hint - as-is we'll end up with buffer overflows/other issues.

> +
> +struct switchtec_ioctl_fw_info {
> +       __u32 flash_length;
> +
> +       struct {
> +               __u32 address;
> +               __u32 length;
> +               __u32 active;
Something to keep in mind, not sure how likely it is here:
If you embed structs (partition in this case), you will not be able to
extend it [the embedded one] it in the future without the risk of ABI
breakage.

> +       } partition[SWITCHTEC_IOCTL_NUM_PARTITIONS];
> +};
> +
Afaict this and most/all other structs [in this patch] are in
violation of Prerequisites#2 and/or #3.
Personally I find pahole quite useful - reference all the UABI structs
in a dummy userspace app, compile with gcc -g -O0 and observe the
output across 32 and 64bit builds. Members _must_ be at the same
offset, otherwise things will be broken with 64bit kernel on a 32bit
userspace. Something which people will eventually end up trying/using,
even if you don't plan to support it.

Please check that Basics (#2 and #5 in particular) are also covered.

A couple more generic suggestions, which I may have noticed while
skimming through:
 - please ensure that all the input is properly sanitised, before,
going into the actual implementation
Afaict having the separate step/separation helps clarity and reduces
chances of you/others getting it wrong down the line.
 - user provided storage must not be changed when the ioctl fails.

Additionally you want to provide a reference to open-source userspace
[alongside acknowledgement of the maintainers/co-developers about the
design] which makes use of said IOCTL(s). But please, do _not_ merge
userspace code before the kernel work has landed.

Hope that provided you with sufficient good points wrt IOCTL design.

Regards,
Emil
