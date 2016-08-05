Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36666 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759353AbcHEBvE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2016 21:51:04 -0400
MIME-Version: 1.0
In-Reply-To: <1715354.XJRkSZIhcu@vostro.rjw.lan>
References: <5356594.Wd8M8VygiD@vostro.rjw.lan> <CA+55aFxV68Bp0xCfDBzvUYZiLHiRW4FAUQ07ft_2SBuCF01bSw@mail.gmail.com>
 <1715354.XJRkSZIhcu@vostro.rjw.lan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Aug 2016 21:32:10 -0400
Message-ID: <CA+55aFz27Bxde9iU2ZBMVgSzVHE8Qqo1SZKEDbYxtjO6TMw0Fw@mail.gmail.com>
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

On Thu, Aug 4, 2016 at 9:05 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Please apply it directly if that's not a problem.

Ok, NP.

           Linus
