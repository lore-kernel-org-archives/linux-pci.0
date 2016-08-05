Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32796 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964849AbcHEAxP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2016 20:53:15 -0400
MIME-Version: 1.0
In-Reply-To: <5356594.Wd8M8VygiD@vostro.rjw.lan>
References: <5356594.Wd8M8VygiD@vostro.rjw.lan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Aug 2016 20:53:14 -0400
Message-ID: <CA+55aFxV68Bp0xCfDBzvUYZiLHiRW4FAUQ07ft_2SBuCF01bSw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Runtime resume bridges before bus rescans
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 4, 2016 at 8:38 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If a PCI bridge (or PCIe port) that is runtime-suspended gets an
> ACPI hotplug notification, such as a bus check, it has to be resumed
> before re-scanning the devices below it, or those devices will not
> be accessible and will be treated as hot-removed.

Just checking: do you want me to apply this as a patch, or are you
adding it to your git tree and just cc'ing me as a FYI?

           Linus
