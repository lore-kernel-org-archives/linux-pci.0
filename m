Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Feb 2017 15:54:26 +0100
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
Subject: Re: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
Message-ID: <20170210145426.GB24594@kroah.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486058763-7730-1-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 11:05:59AM -0700, Logan Gunthorpe wrote:
> Changes since v1:
> 
> * Rebased onto 4.10-rc6 (cleanly)
> * Split the patch into a few more easily digestible patches (as
>   suggested by Greg Kroah-Hartman)
> * Folded switchtec.c into switchtec.h (per Greg)
> * Fixed a bunch of 32bit build warnings caught by the kbuild test robot
> * Fixed some issues in the documentation so it has a proper
>   reStructredText format (as noted by Jonathan Corbet)
> * Fixed padding and sizes in the IOCTL structures as noticed by Emil
>   Velikov and used pahole to verify their consistency across 32 and 64
>   bit builds
> * Reworked one of the IOCTL interfaces to be more future proof (per
>   Emil).
> 
> Changes since RFC:
> 
> * Fixed incorrect use of the drive model as pointed out by Greg
>   Kroah-Hartman
> * Used devm functions as suggested by Keith Busch
> * Added a handful of sysfs attributes to the switchtec class
> * Added a handful of IOCTLs to the switchtec device
> * A number of miscellaneous bug fixes

I didn't audit the ioctl code, but the driver model and sysfs stuff
looks sane to me, nice job cleaning it up.

thanks,

greg k-h
