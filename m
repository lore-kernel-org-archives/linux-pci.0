Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:55484 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeIKAxR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Sep 2018 20:53:17 -0400
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
To: Daniel Drake <drake@endlessm.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, mika.westerberg@linux.intel.com,
        jonathan.derrick@intel.com, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com
References: <20180907053614.6540-1-drake@endlessm.com>
From: Thomas Martitz <kugel@rockbox.org>
Message-ID: <46fe10f6-e778-1808-2a58-663901ed7748@rockbox.org>
Date: Mon, 10 Sep 2018 21:57:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180907053614.6540-1-drake@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Daniel,

Am 07.09.18 um 07:36 schrieb Daniel Drake:
> On 38+ Intel-based Asus products, the nvidia GPU becomes unusable
> after S3 suspend/resume. The affected products include multiple
> generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
> many errors such as:
> 
>      fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04 [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
>      DRM: failed to idle channel 0 [DRM]
> 
> Similarly, the nvidia proprietary driver also fails after resume
> (black screen, 100% CPU usage in Xorg process). We shipped a sample
> to Nvidia for diagnosis, and their response indicated that it's a
> problem with the parent PCI bridge (on the Intel SoC), not the GPU.
> 
> Runtime suspend/resume works fine, only S3 suspend is affected.
> 
> We found a workaround: on resume, rewrite the Intel PCI bridge
> 'Prefetchable Base Upper 32 Bits' register (PCI_PREF_BASE_UPPER32). In
> the cases that I checked, this register has value 0 and we just have to
> rewrite that value.
> 
> It's very strange that rewriting the exact same register value
> makes a difference, but it definitely makes the issue go away.
> It's not just acting as some kind of memory barrier, because rewriting
> other bridge registers does not work around the issue. There's something
> magic in this particular register. We have confirmed this on all
> the affected models we have in-hands (X542UQ, UX533FD, X530UN, V272UN).
> 
> Additionally, this workaround solves an issue where r8169 MSI-X
> interrupts were broken after S3 suspend/resume on Asus X441UAR. This
> issue was recently worked around in commit 7bb05b85bc2d ("r8169:
> don't use MSI-X on RTL8106e"). It also fixes the same issue on
> RTL6186evl/8111evl on an Aimfor-tech laptop that we had not yet
> patched. I suspect it will also fix the issue that was worked around in
> commit 7c53a722459c ("r8169: don't use MSI-X on RTL8168g").
> 
> Thomas Martitz reports that this workaround also solves an issue where
> the AMD Radeon Polaris 10 GPU on the HP Zbook 14u G5 is unresponsive
> after S3 suspend/resume.


I can confirm that this exact patch also helps on my HP Zbook. Thanks 
for your work on this, resume has been a real pain until now.



> 
>   drivers/pci/pci-driver.c | 14 ++++++++++++++
>   drivers/pci/setup-bus.c  |  2 +-
>   include/linux/pci.h      |  1 +
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..034f816570ad 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -524,6 +524,20 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>   	pci_power_up(pci_dev);
>   	pci_restore_state(pci_dev);
>   	pci_pme_restore(pci_dev);
> +
> +	/*
> +	 * Redo the PCI bridge prefetch register setup.
> +	 *
> +	 * This works around an Intel PCI bridge issue seen on Asus and HP
> +	 * laptops, where the GPU is not usable after S3 resume.
> +	 * Even though PCI bridge register contents appear to be intact
> +	 * at resume time, rewriting the value of PREF_BASE_UPPER32 is
> +	 * required to make the GPU work.
> +	 * Windows 10 also reprograms these registers during S3 resume.
> +	 */
> +	if (pci_dev->class == PCI_CLASS_BRIDGE_PCI << 8)
> +		pci_setup_bridge_mmio_pref(pci_dev);
> +
>   	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>   }
>   
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824e83b4..cb88288d2a69 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -630,7 +630,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
>   	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
>   }
>   
> -static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
> +void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
>   {
>   	struct resource *res;
>   	struct pci_bus_region region;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8dd6241..b15828fc26a4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -934,6 +934,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>   void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>   unsigned int pci_scan_child_bus(struct pci_bus *bus);
>   void pci_bus_add_device(struct pci_dev *dev);
> +void pci_setup_bridge_mmio_pref(struct pci_dev *bridge);
>   void pci_read_bridge_bases(struct pci_bus *child);
>   struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>   					  struct resource *res);
> 
