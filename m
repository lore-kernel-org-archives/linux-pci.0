Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Aug 2015 15:52:05 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jingoohan1@gmail.com, nsekhar@ti.com
Subject: Re: [PATCH v5 0/3] dra7xx: Add PM support to PCIe
Message-ID: <20150811205205.GJ13982@google.com>
References: <1438345512-28973-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438345512-28973-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 31, 2015 at 05:55:09PM +0530, Kishon Vijay Abraham I wrote:
> This series adds PM support to pci-dra7xx so that PCI clocks can be disabled
> during suspend and enabled back during resume without affecting
> PCI functionality.
> 
> Changes from v4:
> *) Fixed a bug caused by sending incomplete patch.
> 
> Changes from v3:
> *) Fix compilation errors when individual patches are applied
> 
> Changes from v2:
> *) Used SET_SYSTEM_SLEEP_PM_OPS and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for
>    populating PM ops.
> 
> Changes from v1:
> *) Moved resetting and setting of MSE bit to pci-dra7xx.
> 
> The comment to reset and set ISE is not done now since I don't have a card
> with IO space. Once I get to test that, I'll post a separate patch for
> handling that.
> 
> Kishon Vijay Abraham I (3):
>   PCI: host: pci-dra7xx: Disable pm_runtime on get_sync failure
>   PCI: host: pci-dra7xx: add pm support to pci dra7xx
>   PCI: host: pci-dra7xx: Idle the module by disabling MSE bit
> 
>  drivers/pci/host/pci-dra7xx.c |   95 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)

Applied with Jingoo's Reviewed-by to pci/host-dra7xx for v4.3, thanks!

I tweaked the changelogs as follows:


commit 0e2bdb0e7abf4b5170874e415ec42df547916dd3
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Fri Jul 31 17:55:10 2015 +0530

    PCI: dra7xx: Disable pm_runtime on get_sync failure
    
    Fix the error handling when pm_runtime_get_sync() fails.
    
    If pm_runtime_get_sync() fails, call pm_runtime_disable() so there are no
    unbalanced pm_runtime_enable() calls.
    
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

commit e52eb445ea1d97bf7fb92d2297e487a305392136
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Fri Jul 31 17:55:11 2015 +0530

    PCI: dra7xx: Add PM support
    
    Add PM support to pci-dra7xx so PCI clocks can be disabled during suspend
    and enabled during resume without affecting PCI functionality.
    
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

commit 389c7094ec241ee8ebe358ba10fe392018692c8c
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Fri Jul 31 17:55:12 2015 +0530

    PCI: dra7xx: Clear MSE bit during suspend so clocks will idle
    
    DRA7xx requires the MSE bit to be cleared to set the master in standby
    mode.  (In DRA7xx TRM_vE, section 24.9.4.5.2.2.1 PCIe Controller Master
    Standby Behavior advises to use the clearing of the local MSE bit to set
    the master in standby.  Without this some of the clocks do not idle).
    
    Clear the MSE bit on suspend and enable it on resume.  Clearing MSE bit is
    required to get clocks to be idled after suspend.
    
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
