Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0092.outbound.protection.outlook.com ([207.46.100.92]:41664
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752741AbbIWSs0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 14:48:26 -0400
Message-ID: <5602F3F2.2050100@caviumnetworks.com>
Date: Wed, 23 Sep 2015 11:48:18 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] arm64/pci: Add quirks for Cavium Thunder PCI bridges.
References: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com> <20150923184005.GX7356@arm.com>
In-Reply-To: <20150923184005.GX7356@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/23/2015 11:40 AM, Will Deacon wrote:
> On Wed, Sep 23, 2015 at 01:09:56AM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The Cavium ThunderX SoC needs a PCI quirk for its on-chip bridges.
>> Since it is arm64, create a new quirks.c file there to contain arm64
>> related quirks.  Add the ThunderX bridge quirk, gated by a new config
>> variable, so that it can be disabled for kernels that aren't expected
>> to be used on ThunderX.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/arm64/Kconfig         | 11 +++++++++++
>>   arch/arm64/kernel/Makefile |  2 +-
>>   arch/arm64/kernel/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/kernel/quirks.c
>
> Why does this have to live in the arch/arm64/ directory? The quirks have
> nothing to do with the architecture code.
>

It doesn't have to live there.  It is something that will never be used 
for any other architecture.  So I thought we could do like 
arch/x86/kernel/quirks.c

I could move it to drivers/pci/quirks.c if people think that is a much 
better place for it.

David Daney
