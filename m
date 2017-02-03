Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdBCPJj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 10:09:39 -0500
Date: Fri, 3 Feb 2017 09:09:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170203150934.GB15080@bhelgaas-glaptop.roam.corp.google.com>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mika, linux-kernel]

On Thu, Feb 02, 2017 at 08:11:48PM -0800, Yinghai Lu wrote:
> 4.9 is  working,
> ...

> After reverting
> 
> From 68db9bc814362e7f24371c27d12a4f34477d9356 Mon Sep 17 00:00:00 2001
> From: Lukas Wunner <lukas@wunner.de>
> Date: Fri, 28 Oct 2016 10:52:06 +0200
> Subject: PCI: pciehp: Add runtime PM support for PCIe hotplug ports
> 
> the hotplug work again.

I provisionally reverted 68db9bc81436 ("PCI: pciehp: Add runtime PM
support for PCIe hotplug ports") on my for-linus branch while this is
being debugged.

To be clear, this revert is only a last resort to avoid releasing
v4.10 with a regression.  I hope and assume we'll have a real fix
before v4.10 and we'll be able to drop the revert in favor of the fix.

Can someone please open a kernel.org bugzilla, mark it as a
regression, and attach the complete dmesg log and "lspci -vv" output?
Please mention that bugzilla in the changelog of the fix.

Bjorn
