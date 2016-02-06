Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: Problems since commit Recognize that Interrupt Line 255 means
 "not connected"
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <56B52990.3030103@gmail.com> <1676062.Zh6hUgWIix@vostro.rjw.lan>
Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <56B5AA4B.5040705@gmail.com>
Date: Sat, 6 Feb 2016 09:09:47 +0100
MIME-Version: 1.0
In-Reply-To: <1676062.Zh6hUgWIix@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 06.02.2016 um 00:37 schrieb Rafael J. Wysocki:
> On Saturday, February 06, 2016 12:00:32 AM Heiner Kallweit wrote:
>> Since commit a44c386a361e "x86/PCI/ACPI: Recognize that Interrupt Line 255
>> means "not connected"" I get several "PCI INT not connected" warnings on
>> a Zotac CI321 and EHCI failes to load:
> 
> That doesn't follow clearly from your report, but I'm assuming that it works
> correctly without that commit, right?
> 
Right, w/o this commit it looks like this:

dmesg
ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d1b000

/proc/interrupts
IO-APIC  23-fasteoi   ehci_hcd:usb3

>> ehci-pci 0000:00:1d.0: PCI INT not connected
>> ehci-pci 0000:00:1d.0: EHCI Host Controller
>> ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 3
>> ehci-pci 0000:00:1d.0: debug port 2
>> ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
>> ehci-pci 0000:00:1d.0: request interrupt -2147483648 failed
>> ehci-pci 0000:00:1d.0: USB bus 3 deregistered
>> ehci-pci 0000:00:1d.0: init 0000:00:1d.0 fail, -107
>> ehci-pci: probe of 0000:00:1d.0 failed with error -107
>>
>> XHCI brings the "PCI INT not connected" warning too but loads properly
>> (most likely because it uses a MSI interrupt).
>>
>> Not sure whether this commit is to blame or a broken BIOS.
>> Just let me know in case you need additional information.
> 
> Well, even if the BIOS is "broken" and the kernel without the above commit
> is able to work with it, we cannot break that.
> 
> Thanks,
> Rafael
> 
> 

