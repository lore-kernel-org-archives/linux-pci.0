Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61623 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752622AbcEDVAO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 17:00:14 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI: Add support for suspending (including runtime) of PCIe ports
Date: Wed, 04 May 2016 23:03:26 +0200
Message-ID: <2024673.GFc4p1cAz0@vostro.rjw.lan>
In-Reply-To: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 29, 2016 11:51:55 AM Mika Westerberg wrote:
> Current Linux PCI core does not do any kind of power management to PCIe
> ports. This means that we waste energy and consume laptop battery even if
> the port has nothing connected to. These patches aim to change that to the
> right direction.
> 
> Previous versions of the patches can be found below:
> 
>   v1: http://www.spinics.net/lists/linux-pci/msg49313.html
>   v2: http://www.spinics.net/lists/linux-pci/msg50167.html
>   v3: http://www.spinics.net/lists/linux-pci/msg50345.html
>   v4: http://www.spinics.net/lists/linux-pci/msg50665.html
> 
> This assumes that recent (starting from 2015) PCIe ports are capable of
> transition to D3hot/D3cold. We add a new flag to struct pci_dev 'bridge_d3'
> that is set whenever the PCI core thinks the port can be put to D3. The
> check in pci_pm_suspend_noirq() is then extended to cover devices where
> 'bridge_d3' is set.
> 
> We then add two new functions pci_bridge_d3_device_changed/removed(). These
> are used to set and clear 'bridge_d3' whenever there is a change in device
> power management policy (or if the device is removed). For example when
> userspace forbids the device to enter D3cold pci_bridge_d3_device_changed()
> will clear 'bridge_d3' of the upstream bridge.
> 
> For all PCI ports where 'bridge_d3' is set we also enable and unblock
> runtime PM automatically. Only exception is when the PCIe port claims to
> support hotplug. More information about that is in the changelog of
> patch [4/4].
> 
> Since this also touches xhci, I'm adding Mathias and Greg to check if the
> change looks reasonable.
> 
> Changes to v4:
> 
>   - Use "Put PCIe ports into D3" instead of "move" in subject and comments.
> 
>   - Add new helper function pci_power_manageable() and use it to check if
>     the port can be suspended instead of open-coding it everytime.
> 
>   - Changed pci_dev_check_d3cold() to follow what Rafael suggested.
> 
>   - Dropped call to pm_runtime_mark_last_busy() in pcie_port_runtime_resume()
>     as PM core does that automatically when the function returns 0.
> 
>   - Added ACKs from Rafael.
> 
> Changes to v3:
> 
>   - Make 'no_d3cold' persist for pci_dev. Once this is set through
>     pci_d3cold_enable/disable(), it will persist unless changed again using
>     the same functions. Those also handle setting and clearing 'bridge_d3'
>     as necessary.
> 
>   - Add kernel command line parameter "pcie_port_pm=off|force" that can
>     be used to forcibly disable/enable the feature.
> 
>   - Use runtime PM autosuspend instead of scheduling runtime suspend
>     manually
> 
>   - Allow runtime PM always except when we are dealing with a hotplug
>     bridge. Actual checking whether the port can be suspended is done in
>     ->idle() and ->runtime_suspend() hooks based on 'bridge_d3'.
> 
> Changes to v2:
> 
>   - Renamed and split pci_enable_d3cold() into two functions
>     pci_d3cold_enable()/disable().
> 
>   - Renamed pci_bridge_pm_update() into two functions
>     pci_bridge_d3_device_changed() and pci_bridge_d3_device_removed() that
>     should match better what they are doing.
> 
>   - Propagate ->bridge_d3 change to upstream bridges in
>     pci_bridge_d3_update().
> 
>   - Removed pci_can_suspend() in favor of doing ->bridge_d3 check directly
>     in pci_pm_suspend_noirq().
> 
>   - Extend runtime PM enabling for ports that are using native PCIe
>     hotplug.
> 
>   - Call pm_runtime_no_callbacks() for PCIe port service devices (the are
>     handled by the parent device).
> 
> Changes to v1:
> 
>   - Dropped patch [2/6] as there is no need to use that function from other
>     files anymore.
> 
>   - Dropped patches [5-6/6] in favor of using cut-off date.
> 
>   - Updated changelog of [1/4] to mention where in the PCI core PCI bridge
>     and PCIe ports are skipped from being power managed.
> 
>   - Instead of checking at suspend time if it is possible to transition the
>     port to D3, do it whenever power management status of a device (below a
>     port) is changed or when it is added or removed to the bus.
> 
>   - Added patch [3/4] to runtime resume a bridge when ACPI hotplug event is
>     received.
> 
> Mika Westerberg (4):
>   PCI: No need to set d3cold_allowed to PCIe ports
>   PCI: Put PCIe ports into D3 during suspend
>   ACPI / hotplug / PCI: Runtime resume bridge before rescan
>   PCI: Add runtime PM support for PCIe ports
> 
>  Documentation/kernel-parameters.txt |   4 +
>  drivers/pci/bus.c                   |   1 +
>  drivers/pci/hotplug/acpiphp_glue.c  |   8 +-
>  drivers/pci/pci-driver.c            |   5 +-
>  drivers/pci/pci-sysfs.c             |   5 ++
>  drivers/pci/pci.c                   | 175 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h                   |  11 +++
>  drivers/pci/pcie/portdrv_core.c     |   2 +
>  drivers/pci/pcie/portdrv_pci.c      |  51 ++++++++++-
>  drivers/pci/remove.c                |   2 +
>  drivers/usb/host/xhci-pci.c         |   2 +-
>  include/linux/pci.h                 |   3 +
>  12 files changed, 259 insertions(+), 10 deletions(-)

OK, I've just ACKed [2/4] and the other patches in this series were ACKed by me
before.

Bjorn, if you want me to take this series, please let me know.

Thanks,
Rafael

