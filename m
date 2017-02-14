Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Feb 2017 17:45:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: Re: [PATCH 0/6] PCI/ASPM: Add PCIe L1 PM substate support
Message-ID: <20170214234559.GC19040@bhelgaas-glaptop.roam.corp.google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 02, 2017 at 10:34:09PM -0800, Rajat Jain wrote:
> This patchset adds the PCIe L1 PM substate support to the kernel.
> The feature is described at:
> https://pcisig.com/sites/default/files/specification_documents/ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a.pdf
> 
> Its all logically one patch (and may be some of them should be
> squashed later) , but I've broken down into smaller patches for
> ease of review. 
> 
> This is currently rebased on top of Bjorn's master branch.
> 
> Rajat Jain (6):
>   PCI: Add L1 substate capability structure register definitions
>   PCI/ASPM: Introduce L1 substates and a Kconfig for it
>   PCI/ASPM: Read and setup L1 substate capabilities
>   PCI/ASPM: Calculate and save the L1.2 timing parameters
>   PCI/ASPM: Actually configure the L1 substate settings to the device
>   PCI/ASPM: Add comment about L1 substate latency
> 
>  drivers/pci/pcie/Kconfig      |   8 ++
>  drivers/pci/pcie/aspm.c       | 291 ++++++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/pci_regs.h |  16 +++
>  3 files changed, 302 insertions(+), 13 deletions(-)

Applied to pci/aspm for v4.11, thanks, Rajat!
