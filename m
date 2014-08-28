Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:8116
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934783AbaH1JPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Aug 2014 05:15:30 -0400
Message-ID: <53FEF325.20505@amd.com>
Date: Thu, 28 Aug 2014 04:15:17 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>, <pawel.moll@arm.com>,
	<Catalin.Marinas@arm.com>, <Will.Deacon@arm.com>,
	<tglx@linutronix.de>, <Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2 V4] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
References: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1407942041-3291-2-git-send-email-suravee.suthikulpanit@amd.com>
 <003d01cfb76b$629b43c0$27d1cb40$%han@samsung.com>
In-Reply-To: <003d01cfb76b$629b43c0$27d1cb40$%han@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/13/2014 09:56 PM, Jingoo Han wrote:
> On Thursday, August 14, 2014 12:01 AM, Suravee Suthikulpanit wrote:
>>
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> ARM GICv2m specification extends GICv2 to support MSI(-X) with
>> a new set of register frame. This patch introduces support for
>> the non-secure GICv2m register frame. Currently, GICV2m is available
>> in certain version of GIC-400.
>>
>> The patch introduces a new property in ARM gic binding, the v2m subnode.
>> It is optional.
>
> Hi Suravee Suthikulpanit,
>
> I added some minor comments.

Thanks for the cleaning up comments.

Suravee
