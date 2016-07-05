Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 5 Jul 2016 09:53:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: AceLan Kao <acelan@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	USB <linux-usb@vger.kernel.org>
Subject: Re: kmem_cache_alloc fail with unable to handle paging request after
 pci hotplug remove.
Message-ID: <20160705075346.GA2918@wunner.de>
References: <577A7203.9010305@linux.intel.com>
 <CAJZ5v0ji9pVgAZZJT+RG83RNE4-GgJAp88Mw2ddVt3H6eHG72g@mail.gmail.com>
 <577A7B0A.4090107@linux.intel.com>
 <20160704152131.GA2766@wunner.de>
 <577A84B4.8020505@linux.intel.com>
 <CAMz9Wg9wEhjH9izB_11xoNe954urJcRhrjbbyk9b45+42Vx6bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMz9Wg9wEhjH9izB_11xoNe954urJcRhrjbbyk9b45+42Vx6bg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 05, 2016 at 11:00:21AM +0800, AceLan Kao wrote:
> These are logs from my machine.
> 
> *** Before plug-in the USB key
> 
> u@u-XPS-13-9xxx:~$ sudo lspci -vvvv -s 00:1c.0
> 00:1c.0 PCI bridge: Intel Corporation Device 9d10 (rev f1) (prog-if 00
> [Normal decode])
[...]
>                 LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+

The link is down (DLActive-), but the root port is a hotplug port,
so apparently with Alpine Ridge the controller is powered down if
nothing is plugged in and this results in the controller being
"unplugged" from the root port.

This looks less fishy than I originally thought, it's just very
different from the power management of pre Alpine Ridge controllers
on Macs (which is the only thing I'm really familiar with), where
the root port is not a hotplug port and the controller does not
disappear from the system when powered down. (It's config space
just becomes inaccessible.)

Best regards,

Lukas
