Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:19808
	"EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750757AbcGEWxj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jul 2016 18:53:39 -0400
Message-ID: <577C1661.5000106@caviumnetworks.com>
Date: Tue, 5 Jul 2016 13:19:45 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	<linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <arnd@arndb.de>,
	<david.daney@cavium.com>, <jchandra@broadcom.com>
Subject: Re: [PATCH 04/14] PCI: generic: make it explicitly non-modular
References: <20160702231334.26684-1-paul.gortmaker@windriver.com> <20160702231334.26684-5-paul.gortmaker@windriver.com> <20160704173752.GR1639@arm.com>
In-Reply-To: <20160704173752.GR1639@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/04/2016 10:37 AM, Will Deacon wrote:
> On Sat, Jul 02, 2016 at 07:13:24PM -0400, Paul Gortmaker wrote:
>> The Kconfig currently controlling compilation of this code is:
>>
>> drivers/pci/host/Kconfig:config PCI_HOST_GENERIC
>> drivers/pci/host/Kconfig:       bool "Generic PCI host controller"
>>
>> ...meaning that it currently is not being built as a module by anyone.
>>
>> Lets remove the few trace uses of modular code and macros, so that
>> when reading the driver there is no doubt it is builtin-only.
>>
>> Since module_platform_driver() uses the same init level priority as
>> builtin_platform_driver() the init ordering remains unchanged with
>> this commit.
>>
>> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>>
>> We also delete the MODULE_LICENSE tag etc. since all that information
>> is already contained at the top of the file in the comments.
>
> Ideally, we'd simply fix this to build as a module, but it's not clear
> how to do that now that the ecam accessors have been split out into
> their own file. A liberal sprinkling of EXPORT_SYMBOL might work, but
> it's a bit grotty.
>
> David, Jayachandran -- do you have any desire to build your PCI host
> controller drivers as modules?

I can only speak to the Cavium case.

The system is not usable without PCI, so there is no advantage to making 
the PCI host drivers modular.  At this point I don't see any reason to 
expend effort making it work as a module.

David.


>
> Will
>

