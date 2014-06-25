Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0203.outbound.protection.outlook.com ([207.46.163.203]:19847
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752599AbaFYDEi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 23:04:38 -0400
Message-ID: <53AA3C28.4080200@amd.com>
Date: Tue, 24 Jun 2014 22:04:08 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm/gic: Add supports for GICv2m MSI(-X)
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1403569980-12913-3-git-send-email-suravee.suthikulpanit@amd.com>
 <53A94A46.1010801@arm.com>
In-Reply-To: <53A94A46.1010801@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/24/2014 4:52 AM, Marc Zyngier wrote:
> Overall, this requires to be re-architected. If you want to have a look
> at the way I did the GICv3 ITS support:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> gicv3/its
>
> Thanks,

Thanks for the review comments. I'll take a look at the GICv3 and 
re-architect for the V2 patch set.

Suravee

