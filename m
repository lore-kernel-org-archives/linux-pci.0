Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Apr 2016 17:36:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, kbuild-all@01.org, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, robert.richter@caviumnetworks.com,
	mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge
 device companion assignment to core code.
Message-ID: <20160426223618.GB6789@localhost>
References: <1460740008-19489-2-git-send-email-tn@semihalf.com>
 <201604160430.P8zNe8Vl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604160430.P8zNe8Vl%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 16, 2016 at 04:41:45AM +0800, kbuild test robot wrote:
> Hi Tomasz,
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.6-rc3 next-20160415]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Support-for-generic-ACPI-based-PCI-host-controller/20160416-011935
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: ia64-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/hotplug/sgi_hotplug.c: In function 'enable_slot':
> >> drivers/pci/hotplug/sgi_hotplug.c:412:61: error: 'struct pci_controller' has no member named 'companion'
>       phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
>                                                                 ^
>    drivers/pci/hotplug/sgi_hotplug.c: In function 'disable_slot':
>    drivers/pci/hotplug/sgi_hotplug.c:491:32: error: 'struct pci_controller' has no member named 'companion'
>       PCI_CONTROLLER(slot->pci_bus)->companion) {
>                                    ^
>    drivers/pci/hotplug/sgi_hotplug.c:500:61: error: 'struct pci_controller' has no member named 'companion'
>       phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
>                                                                 ^

I assume somebody is fixing this?

> 
> vim +412 drivers/pci/hotplug/sgi_hotplug.c
> 
> 3e643e77 John Keller       2007-01-30  406  		struct acpi_device *pdevice;
> 3e643e77 John Keller       2007-01-30  407  		acpi_handle phandle;
> 3e643e77 John Keller       2007-01-30  408  		acpi_handle chandle = NULL;
> 3e643e77 John Keller       2007-01-30  409  		acpi_handle rethandle;
> 3e643e77 John Keller       2007-01-30  410  		acpi_status ret;
> 3e643e77 John Keller       2007-01-30  411  
> 7b199811 Rafael J. Wysocki 2013-11-11 @412  		phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
> 3e643e77 John Keller       2007-01-30  413  
> 3e643e77 John Keller       2007-01-30  414  		if (acpi_bus_get_device(phandle, &pdevice)) {
> 227f0647 Ryan Desfosses    2014-04-18  415  			dev_dbg(&slot->pci_bus->self->dev, "no parent device, assuming NULL\n");
> 
> :::::: The code at line 412 was first introduced by commit
> :::::: 7b1998116bbb2f3e5dd6cb9a8ee6db479b0b50a9 ACPI / driver core: Store an ACPI device pointer in struct acpi_dev_node
> 
> :::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


