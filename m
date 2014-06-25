Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0187.outbound.protection.outlook.com ([207.46.163.187]:9260
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752771AbaFYATt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 20:19:49 -0400
Message-ID: <53AA158E.1040700@amd.com>
Date: Tue, 24 Jun 2014 19:19:26 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
CC: <marc.zyngier@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Liviu.Dudau@arm.com>
Subject: Re: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140624122639.GL10202@titan.lakedaemon.net>
In-Reply-To: <20140624122639.GL10202@titan.lakedaemon.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/24/2014 7:26 AM, Jason Cooper wrote:
> On Mon, Jun 23, 2014 at 07:32:58PM -0500, suravee.suthikulpanit@amd.com wrote:
>> This patch set introduces support for MSI(-X) in GICv2m specification,
>> which is implemented in some variation of GIC400.
>>
>> This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
>> (https://lkml.org/lkml/2014/3/14/320).
>
> Is this a build, boot, or runtime dependency?
>
> thx,
>
> Jason.
>

For all of the above.

Suravee

