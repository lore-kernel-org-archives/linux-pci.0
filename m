Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:19612 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbCJVCn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 17:02:43 -0400
Message-ID: <54FF5BED.9090302@broadcom.com>
Date: Tue, 10 Mar 2015 14:02:37 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	"Paul Bolle" <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] PCI: Export symbols of PCI functions
References: <1425947886-23705-1-git-send-email-rjui@broadcom.com> <1425947886-23705-2-git-send-email-rjui@broadcom.com> <20150310205651.GA32204@google.com>
In-Reply-To: <20150310205651.GA32204@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 3/10/2015 1:56 PM, Bjorn Helgaas wrote:
> On Mon, Mar 09, 2015 at 05:38:03PM -0700, Ray Jui wrote:
>> Export symbols of the following PCI functions so they can be referenced
>> by a PCI driver compiled as a kernel loadable module:
>>
>> pci_common_swizzle
>> pci_create_root_bus
>> pci_stop_root_bus
>> pci_remove_root_bus
>> pci_assign_unassigned_bus_resources
>> pci_fixup_irqs
> 
> Have you tested your driver as a loadable module?
> 
> If it works to load/unload/reload/etc., I'm OK with exporting these
> symbols.  I would prefer EXPORT_SYMBOL_GPL, though, because these don't
> constitute a very coherent interface right now, and they will likely be
> reworked.  For example, see Yijing Wang's work to sort out the
> pci_bus_add_devices() / resource assignment mess.
> 
> Bjorn

Yes, I tested the driver with load/unload/reload on Cygnus. Console logs
are included in my reply to Arnd's email from another email thread.

I'll wait for more feedback from you on the iProc PCIe driver itself.
But if you have reviewed them and think they are okay then I can go
ahead and submit v6 with changes to use EXPORT_SYMBOL_GPL.

Let me know.

Thanks,

Ray
