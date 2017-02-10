Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Feb 2017 15:54:38 +0100
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
Subject: Re: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
Message-ID: <20170210145438.GC24594@kroah.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486058763-7730-2-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 11:06:00AM -0700, Logan Gunthorpe wrote:
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
> poll calls.
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

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
