Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Jan 2017 18:26:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MicroSemi Switchtec management interface driver
Message-ID: <20170131172630.GB12595@kroah.com>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485882204-26947-2-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 10:03:24AM -0700, Logan Gunthorpe wrote:
> Microsemi's "Switchtec" line of PCI switch devices is already well
> supported by the kernel with standard PCI switch drivers. However, the
> Switchtec device advertises a special management endpoint with a separate
> PCI function address and class code. This endpoint enables some additional
> functionality which includes:
> 
>  * Packet and Byte Counters
>  * Switch Firmware Upgrades
>  * Event and Error logs
>  * Querying port link status
>  * Custom user firmware commands
> 
> This patch introduces the switchtec kernel module which provides
> PCI driver that exposes a char device. The char device provides
> userspace access to this interface through read, write and (optionally)
> poll calls. A couple of special IOCTLs are provided to:
> 
> * Inform userspace of firmware partition locations
> * Pass event counts and allow userspace to wait on events
> 
> A short text file is provided which documents the switchtec driver,
> outlines the semantics of using the char device and describes the
> IOCTLs.
> 
> The device also exposes a few read-only sysfs attributes which provide
> some device information component names and versions which is provided
> by the hardware. These are documented in
> Documentation/ABI/testing/sysfs-class-switchtec
> 
> A userspace tool and library which utilizes this interface is available
> at [1]. This tool takes inspiration (and borrows some code) from
> nvme-cli [2]. The tool is largely complete at this time but additional
> features may be added in the future.
> 
> [1] https://github.com/sbates130272/switchtec-user
> [2] https://github.com/linux-nvme/nvme-cli
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Stephen Bates <stephen.bates@microsemi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-switchtec |   96 ++
>  Documentation/ioctl/ioctl-number.txt            |    1 +
>  Documentation/switchtec.txt                     |   80 ++
>  MAINTAINERS                                     |   11 +
>  drivers/pci/Kconfig                             |    1 +
>  drivers/pci/Makefile                            |    1 +
>  drivers/pci/switch/Kconfig                      |   13 +
>  drivers/pci/switch/Makefile                     |    1 +
>  drivers/pci/switch/switchtec.c                  | 1320 +++++++++++++++++++++++
>  drivers/pci/switch/switchtec.h                  |  266 +++++
>  include/uapi/linux/switchtec_ioctl.h            |  129 +++
>  11 files changed, 1919 insertions(+)

That's one big patch to review, would you want to do that?

Can you break it up into smaller parts?  At least put the documentation
separately, right?

And don't dump a .txt file into Documentation/ anymore, people are
working to move to the newer format.

Also, please rebase against Linus's tree at the least, we can't go back
in time and apply this to the 4.9 kernel tree.

thanks,

greg k-h
