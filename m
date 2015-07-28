Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Dall, Elizabeth J" <betty.dall@hp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Tanmay Inamdar <tinamdar@apm.com>
CC: Duc Dang <dhdang@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
Date: Tue, 28 Jul 2015 14:37:46 +0000
Message-ID: <45B5D2ED2CA81049B5F9826D4DFA5BA756F589A4@G9W0707.americas.hpqcorp.net>
References: <20150724224258.GA23990@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/24/2015 04:43 PM, Bjorn Helgaas wrote:
> I regularly see faults like this on an APM X-Gene:
> 
>   U-Boot 2013.04-mustang_sw_1.14.14 (Dec 16 2014 - 15:59:33)
>   CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
>        32 KB ICACHE, 32 KB DCACHE
>        SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
>   ...
>   Unhandled fault: synchronous external abort (0x96000010) at 0xffffff8000110034

The 0x96000010 is the value of the ESR register and decodes to "Stack
Pointer Alignment exception". The ISS field for this exception code is
reserved, so no additional info.

-Betty Dall

