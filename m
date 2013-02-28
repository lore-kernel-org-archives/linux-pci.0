Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52341 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3B1EmD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2013 23:42:03 -0500
Date: Wed, 27 Feb 2013 20:42:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linux-pci@vger.kernel.org
Subject: ACPI based PCI/PCIe bridge hotplug
Message-ID: <20130228044205.GA30949@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

we had a discussion about ACPI hotplug today at work. Someone claimed that ACPI
would not support PCI/PCIe bridge hotplug.

I don't know much about ACPI, but that seemed like a surprising limitation
to me. After a little research, I found that the ACPI hotplug code seems to
support it, and Microsoft was talking about adding it to Vista back in 2003.

So ... just for my education, I have a couple of questions: Does ACPI support
PCI/PCIe bridge hotplug or not ? And if it does, are there any limitations ?

Thanks,
Guenter
