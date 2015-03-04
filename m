Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1425512923.5200.318.camel@redhat.com>
Subject: Re: [Patch v4 21/23] x86/PCI: Refine the way to release PCI IRQ
 resources
From: Alex Williamson <alex.williamson@redhat.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Date: Wed, 04 Mar 2015 16:48:43 -0700
In-Reply-To: <1425485213.5200.230.camel@redhat.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
	 <1423115089-12904-22-git-send-email-jiang.liu@linux.intel.com>
	 <1425485213.5200.230.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-03-04 at 09:06 -0700, Alex Williamson wrote:
> Hi,
> 
> I'm getting a regression from this patch when using VFIO for device
> assignment to a QEMU VM.  I have a device initially bound to the nouveau
> driver, which is unbound from that driver and bound to vfio-pci for use
> by userspace.  vfio-pci calls pci_enable_device, but when userspace
> attempts to setup the legacy INTx interrupt, pci_dev->irq is zero and
> vfio-pci errors with -ENODEV.
> 
> Where is pci_dev->irq supposed to be getting re-initialized in this
> case?  Am I missing an important initialization step in vfio-pci?  I
> certainly don't think I should be calling request_irq(pci_dev->irq, ...
> when pci_dev->irq is zero.  Thanks,

It looks like the imbalance is in pci_dev->enable_cnt.  Any call to
pci_disable_device() will clear pci_dev->irq, but pci_enable_device()
does effectively nothing unless it's called with enable_cnt == zero.  So
I'm at the mercy of the previous driver behaving relatively sanely in
order to re-enable legacy interrupts for a device :-\  Maybe the unbound
notifier needs to do some sanitizing of the device?  Thanks,

Alex

