Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:57687 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdBCFvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 00:51:04 -0500
Date: Fri, 3 Feb 2017 06:52:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170203055200.GA29413@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc += Mika]

On Thu, Feb 02, 2017 at 08:11:48PM -0800, Yinghai Lu wrote:
> 4.9 is  working,
[...]
> sca05-0a81e0db:~ # echo 1 > /sys/bus/pci/slots/8/power
> [  175.771846] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
> [  175.777898] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
> ignored; already powering on
> [  175.956632] pci 0000:65:00.0: [15b3:1003] type 00 class 0x0c0600
[...]
> sca05-0a81e0db:~ # echo 1 > /sys/bus/pci/slots/8/power
> [  221.041664] pciehp 0000:60:03.2:pcie004: Slot(8): Already enabled

Could you check if the port above 0000:60:03.2 is runtime suspended
when you're trying this, i.e. does its power/runtime_status entry in
sysfs say "suspended"?

Normally the hotplug slot should keep its parents awake so that config
space accesses work.  And the hotplug port's config space should be
accessible in D3 per the spec.

If you add pm_runtime_get_sync(&ctrl->pcie->port->dev) in
drivers/pci/pciehp_ctrl.c:pciehp_enable_slot() before the call to
pciehp_get_power_status(), and a corresponding pm_runtime_put()
afterwards, does the issue go away?

Thanks,

Lukas
