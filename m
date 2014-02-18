Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62586 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbaBRTMO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 14:12:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 20:11:25 +0100
Message-ID: <16012311.obgTYIWsOC@wuerfel>
In-Reply-To: <20140218185150.GE2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com> <10244486.cKXs90tdz5@wuerfel> <20140218185150.GE2010@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 18:51:50 Will Deacon wrote:
> 
> kvmtool provides an i8042, pci-shmem, an rtc, 8250 and vesa at the usual PC
> offsets. On ARM, I regularly use the 8250 (there are even DT bindings for
> it) and MarcZ got the rtc working for fun. Not tried the others though.

Ah, interesting. But which ones are between 0x1000-0x6200? The ones
you list should all be in the ISA range between 0x0-0xfff as far
as I can tell, which we keep clear of by setting PCIBIOS_MIN_IO
to 0x1000.

	Arnd
