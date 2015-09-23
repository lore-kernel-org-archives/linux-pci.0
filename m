Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0063.outbound.protection.outlook.com ([157.56.110.63]:64432
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753284AbbIWQAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 12:00:45 -0400
Message-ID: <5602CCA4.8070606@caviumnetworks.com>
Date: Wed, 23 Sep 2015 09:00:36 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>,
	David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] arm64/pci: Add quirks for Cavium Thunder PCI bridges.
References: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com> <1675889.xYIhzenZEC@wuerfel>
In-Reply-To: <1675889.xYIhzenZEC@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/23/2015 12:51 AM, Arnd Bergmann wrote:
> On Tuesday 22 September 2015 17:09:56 David Daney wrote:
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
>>
>
> Looks reasonable to me. Just one question: Is the same bridge used
> on MIPS machines?

No.  The MIPS64 based OCTEON family of SoCs does not contain 
PCI-buses/config-space/bridges for on-chip hardware blocks.  The on-chip 
blocks in OCTEON are all platform devices.  So, ...

> If so, maybe it should be moved to drivers/pci/quirks.c
> instead for better reuse.

The quirk is specific to some arm64 based SoCs, thus my idea to have 
arch specific quirks.

David Daney


