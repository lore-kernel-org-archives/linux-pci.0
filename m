Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48064 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbcGVPPu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jul 2016 11:15:50 -0400
Date: Fri, 22 Jul 2016 10:15:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>, nofooter <nofooter@xilinx.com>,
	nofooter2 <nofooter2@xilinx.com>
Subject: Re: Why does BIOS assign memory to 16 byte BAR
Message-ID: <20160722151546.GA20646@localhost>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

On Fri, Jul 22, 2016 at 09:24:22AM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> I'm observing that on x86 BIOS successfully assigns memory if an End point requests
> BAR of size 16byte.
> 
> But as per Spec:
> The minimum memory address range requested by a BAR is 128 bytes.

Can you provide the spec reference for this?  I don't see it in PCI
r3.0.

PCI r3.0, sec 6.2.5.1, shows bits 4-31 of a memory BAR as writable,
which would correspond to a minimum size of 16 bytes.

> Why BIOS is successfully allocating region to 16 byte BAR requests?

If you want to know why the BIOS does this, you'd have to ask the BIOS
writer.

If you were to ask about *Linux*, I'd say we should not gratuitously
enforce things in the spec merely for the sake of being compliant with
the letter of the spec.  We should enforce things that are logically
required or that are required for compatibility, security, etc.  But
if the spec contained an arbitrary restriction  for no good reason,
and real-world hardware violated that restriction, I'd say Linux
should accommodate the hardware.

Bjorn

