Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:57263 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760571Ab3DDMzb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 08:55:31 -0400
Received: from arm.com (e106165-lin.cambridge.arm.com [10.1.197.23])
	by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id r34CtTIT029215
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 13:55:29 +0100
Date: Thu, 4 Apr 2013 13:55:29 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: linux-pci@vger.kernel.org
Subject: PCI IO and IO_COND
Message-ID: <20130404125529.GA21798@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I have a question regarding the IO_COND macro in lib/iomap.c...

If you have a system which uses GENERIC_IOMAP and you use default values for
PIO_OFFSET, PIO_MASK and PIO_RESERVED - it doesn't seem possible to use the
ioreadX functions to access the first address of the IO port, i.e.
addr=PIO_OFFSET (assuming that you would want to).

/*
 * Ugly macros are a way of life.
 */
#define IO_COND(addr, is_pio, is_mmio) do {			\
	unsigned long port = (unsigned long __force)addr;	\
	if (port >= PIO_RESERVED) {				\
		is_mmio;					\
	} else if (port > PIO_OFFSET) {				\
		port &= PIO_MASK;				\
		is_pio;						\
	} else							\
		bad_io_access(port, #is_pio );			\
} while (0)

Should the first else be '} else if (port >= PIO_OFFSET)' or am I missing
something here?

I can see that on ARM where IO is used for PCI, the pcibios_min_io variable
probably prevents accesses to addr=PIO_OFFSET as it introduces an additional
offset.

Thanks,

Andrew Murray
