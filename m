Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Mar 2017 13:55:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] New Microsemi PCI Switch Management Driver
Message-ID: <20170309195531.GB19517@bhelgaas-glaptop.roam.corp.google.com>
References: <1488497074-14186-1-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488497074-14186-1-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 02, 2017 at 04:24:30PM -0700, Logan Gunthorpe wrote:
> Because getting it right correctly the first time is appearantly hard
> and I caught this mistake while reading the email I had just sent :(
> 
> I'm very sorry about the extra noise.
> 
> Logan
> 
> --
> 
> Changes since v6:
> 
> * I screwed up the device_unregister path and left a potential use
>   after free bug in. I'm not sure why I didn't see a failure because of
>   it but it all tested fine. This version is correct though.
> 
> Changes since v5:
> 
> * Reworked cleanup during unbind again. This time we follow the pattern
>   roughly suggested by Jason Gunthorpe: we use an alive flag
>   that's checked with a rw semaphore held by the cdev ops. Except
>   instead of using the rwsem we just use the already existing
>   mrpc_mutex. (Seeing the vast majority of locations that would use the
>   semaphore overlap with the existing mutex.)
> * Added a small performance enhancement so the code reads less io memory
>   if the user is quick in submitting their read request.
> 
> Changes since v4:
> 
> * Turns out pushing the pci release code into the device release
>   function didn't work as I would have liked. If you try to unbind the
>   device with an instance open, then you hit a kernel bug at
>   drivers/pci/msi.c:371. (This didn't occur in v3.)
> 
>   To solve this, we've moved the pci release code back into the
>   unregister function and reintroduced an alive flag. This time,
>   however, the alive flag is protected by mrpc_mutex and we're very
>   careful about what happens to devices still in use (they should
>   all be released through the timeout path and an ENODEV error
>   returned to userspace; while new commands are blocked with the
>   same error).
> 
> Changes since v3:
> 
> * Removed stdev_is_alive and moved pci deinit functions
>   into the device release function which only occurs after all
>   cdev instances are closed. (per Bjorn)
> * Reduced locking in read/write functions (per Bjorn)
> * Use pci_alloc_irq_vectors to vastly improve ISR initialization (Bjorn)
> * A few other minor nits and cleanup as noticed by Bjorn
> 
> Changes since v2:
> 
> * Collected reviewed and tested tags
> * Very minor fix to the error path in the create function
> 
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
> 
> --
> 
> Hi,
> 
> This is a continuation of the RFC we posted lasted month [1] which
> proposes a management driver for Microsemi's Switchtec line of PCI
> switches. This hardware is still looking to be used in the Open
> Compute Platform
> 
> To make this entirely clear: the Switchtec products are compliant
> with the PCI specifications and are supported today with the standard
> in-kernel driver. However, these devices also expose a management endpoint
> on a separate PCI function address which can be used to perform some
> advanced operations. This is a driver for that function. See the patch
> for more information.
> 
> Since the RFC, we've made the changes requested by Greg Kroah-Hartman
> and Keith Busch, and we've also fleshed out a number of features. We've
> added a couple of IOCTLs and sysfs attributes which are documented in
> the patch. Significant work has also been done on the userspace tool
> which is available under a GPL license at [2]. We've also had testing
> done by some of the interested parties.
> 
> We hope to see this work included in either 4.11 or 4.12 assuming a
> smooth review process.
> 
> The patch is based off of the v4.10-rc6 release.
> 
> Thanks for your review,
> 
> Logan
> 
> [1] https://www.spinics.net/lists/linux-pci/msg56897.html
> [2] https://github.com/sbates130272/switchtec-user
> 
> Logan Gunthorpe (4):
>   MicroSemi Switchtec management interface driver
>   switchtec: Add user interface documentation
>   switchtec: Add sysfs attributes to the Switchtec driver
>   switchtec: Add IOCTLs to the Switchtec driver
> 
>  Documentation/ABI/testing/sysfs-class-switchtec |   96 ++
>  Documentation/ioctl/ioctl-number.txt            |    1 +
>  Documentation/switchtec.txt                     |   80 ++
>  MAINTAINERS                                     |   11 +
>  drivers/pci/Kconfig                             |    1 +
>  drivers/pci/Makefile                            |    1 +
>  drivers/pci/switch/Kconfig                      |   13 +
>  drivers/pci/switch/Makefile                     |    1 +
>  drivers/pci/switch/switchtec.c                  | 1600 +++++++++++++++++++++++
>  include/uapi/linux/switchtec_ioctl.h            |  132 ++
>  10 files changed, 1936 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
>  create mode 100644 Documentation/switchtec.txt
>  create mode 100644 drivers/pci/switch/Kconfig
>  create mode 100644 drivers/pci/switch/Makefile
>  create mode 100644 drivers/pci/switch/switchtec.c
>  create mode 100644 include/uapi/linux/switchtec_ioctl.h

Applied to pci/switchtec for v4.12, thanks!
