Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34492 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbcAUW61 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2016 17:58:27 -0500
MIME-Version: 1.0
In-Reply-To: <56A0EE00.80709@cn.fujitsu.com>
References: <1453167913-16248-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
	<6239489.QX2A2kAHWp@vostro.rjw.lan>
	<20160120002431.GA7973@localhost>
	<56A0EE00.80709@cn.fujitsu.com>
Date: Thu, 21 Jan 2016 23:58:26 +0100
Message-ID: <CAJZ5v0iq29mq_sFzk=mEbjPGJV9vPL9MCgU4WamrGV_fWcpEMA@mail.gmail.com>
Subject: Re: [PATCH] pci: fix unavailable irq number 255 reported by BIOS
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 21, 2016 at 3:41 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> Hi,
>
>     IMHO, I think maybe modification on i801_smbus driver is easier.
>
>     Because when i801_smbus request_irq using pci_dev->irq, this
> pci_dev->irq seems still holds the value read from register(
> pci_setup_device->pci_read_irq), if the value is 255, it is invalid in
> register,

Right.

Which is why the PCI core should not leak it into the driver's ->probe callback.

Thanks,
Rafael
