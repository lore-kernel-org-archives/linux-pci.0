Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:62197 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbbALLmi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jan 2015 06:42:38 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so23605406lab.4
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 03:42:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: pricardofc@gmail.com
Date: Mon, 12 Jan 2015 11:42:37 +0000
Message-ID: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
Subject: Hot add a PCIe device driver upon hotplug event
From: Paulo Fortuna Carvalho <pricardofc@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
I want to automatically load/unload a PCIe device driver when a card
is inserted/removed from the system. I can see in the system logger
with dmesg that the interrupt event is captured and acknowledged by
the pciehp hotplug service driver.
What I want to do next is that the operating system load/unload the
corresponding PCIe device driver for that card.
Can anyone give me some information if possible?
Thx,
Paulo.
