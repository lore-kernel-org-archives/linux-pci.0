Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbeF3UlC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 30 Jun 2018 16:41:02 -0400
Date: Sat, 30 Jun 2018 15:41:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH 0/4] Expose PCIe AER stats via sysfs
Message-ID: <20180630204100.GF9547@bhelgaas-glaptop.roam.corp.google.com>
References: <20180621234829.224566-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2018 at 04:48:25PM -0700, Rajat Jain wrote:
> This is a follow up to:
> https://lkml.org/lkml/2018/5/22/1057
> 
> Respinning as a new patchset because the old one has been refactored
> to include new patches (that were not part of original), and dropping
> some patches. The major changes are:
> 
> * Provide breakdown of Fatal / non fatal errors separately
> * Include the "total" in the same file
> * do some PCI cleanup before the actual aer_stats stuff
> * Include documentation in the main patch
> * Rename variables / attributes to better match the newer reality.
> 
> Rajat Jain (4):
>   PCI: Move pci_aer_init() and pci_no_aer() declarations to
>     drivers/pci/pci.h
>   PCI/AER: Define and allocate aer_stats structure for AER capable
>     devices
>   PCI/AER: Add sysfs attributes to provide AER stats and breakdown
>   PCI/AER: Add sysfs attributes for rootport cumulative stats
> 
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 122 +++++++++++
>  Documentation/PCI/pcieaer-howto.txt           |   5 +
>  drivers/pci/pci-sysfs.c                       |   3 +
>  drivers/pci/pci.h                             |  11 +
>  drivers/pci/pcie/aer.c                        | 198 +++++++++++++++++-
>  drivers/pci/probe.c                           |   1 +
>  include/linux/pci.h                           |   5 +-
>  7 files changed, 337 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

Applied to pci/aer for v4.19, thanks!
