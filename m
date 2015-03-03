Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:39359 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920AbbCCVpY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 16:45:24 -0500
Received: by mail-qa0-f44.google.com with SMTP id n8so30406258qaq.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2015 13:45:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6Hw2GhtbmjBdTiLnvW_4vZPno9cpCXk+wTTAviB6F7vg@mail.gmail.com>
References: <bug-92321-41252@https.bugzilla.kernel.org/> <CAErSpo6Hw2GhtbmjBdTiLnvW_4vZPno9cpCXk+wTTAviB6F7vg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Mar 2015 15:45:03 -0600
Message-ID: <CAErSpo71Ksp3YEXh-OfM3aTSPK9NE7180UJ24QVD1n3xMBTaVg@mail.gmail.com>
Subject: Re: [Bug 92321] New: Mapping CompactPCI device through sysfs-pci driver
To: Georgiy <jediknight.93@mail.ru>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Georgiy attached dmesg log, lspci output, a user program with output,
and a kernel module with output to
https://bugzilla.kernel.org/show_bug.cgi?id=92321]

The kernel module, which uses ioremap(), works as expected.  The user
program, which uses mmap(), fails.  The user-space mmap() path uses
pci_mmap_resource().  Can you add some instrumentation to that path?
We might be able to figure out where things are going wrong.

Bjorn
