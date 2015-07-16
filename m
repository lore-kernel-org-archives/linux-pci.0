Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0059.outbound.protection.outlook.com ([65.55.169.59]:21536
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751461AbbGPQxG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jul 2015 12:53:06 -0400
Message-ID: <55A7E167.6040000@caviumnetworks.com>
Date: Thu, 16 Jul 2015 09:52:55 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	<linux-kernel@vger.kernel.org>,
	Robert Richter <rrichter@cavium.com>,
	"David Daney" <david.daney@cavium.com>
Subject: Re: [PATCH 5/5] PCI: Add host drivers for Cavium ThunderX processors.
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>  <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com> <1437035476.27428.24.camel@tiscali.nl>
In-Reply-To: <1437035476.27428.24.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/16/2015 01:31 AM, Paul Bolle wrote:
> On wo, 2015-07-15 at 09:54 -0700, David Daney wrote:
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>
>> +config PCI_THUNDER_PEM
>> +	bool
>
> Do you expect other symbols to select this symbol in the future?

No, ...

> Because
> at this moment PCI_THUNDER_PEM is merely an alias for PCI_THUNDER.
>

... the next version of the patch will uncouple them.  They are separate 
drivers and should be selectable independently.

Thanks,
David Daney



