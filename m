Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:44910 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S966762Ab3DRP2C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2013 11:28:02 -0400
Date: Thu, 18 Apr 2013 16:27:48 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
Subject: I/O and multiple PCI buses
Message-ID: <20130418152747.GA19258@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm trying to understand PCI I/O addressing in the kernel... (again)

I understand that ideally you want to give PCI bus addresses to PCI devices in
the range of 0K to 64K. This seems to be achieved in pcibios_init_resources in
arm's kernel/bios32.c implementation.

What happens if you want to add another root bus? In this implementation the
start address of the io_res is now 64K and as sys->io_offset is set to 0 the
bus addresses under this second root bus will be 64K-128K - which I assume may
break some things.

Am I correct that for ARM there are no implementations where subsequent root
buses allocate I/O starting from 0?

And to allow subsequent busses to use I/O starting from 0, you'd have to set
sys->io_offset to 64K*nr and adapt functions such as pci_iomap to use the
offset?

Are there any other archiectures that do give I/O ranges starting from 0 in
subsequent root busses? Or am I missing something here?

Andrew Murray
