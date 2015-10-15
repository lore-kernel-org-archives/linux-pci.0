Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35250 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbJOSvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 14:51:23 -0400
Received: by lbwr8 with SMTP id r8so80660549lbw.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2015 11:51:22 -0700 (PDT)
Subject: Re: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
To: Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20150604102253.GA31773@red-moon> <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org> <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org> <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon> <55F0388B.1090607@linaro.org>
 <20150911112018.GA13033@red-moon> <55F6DFF6.4010807@linaro.org>
 <20151015132200.GA7621@red-moon> <561FB985.8070509@linaro.org>
 <561FD3BB.70501@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"msalter@redhat.com" <msalter@redhat.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <561FF5A5.1040305@semihalf.com>
Date: Thu, 15 Oct 2015 20:51:17 +0200
MIME-Version: 1.0
In-Reply-To: <561FD3BB.70501@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/15/2015 06:26 PM, Marc Zyngier wrote:
> On 15/10/15 15:34, Tomasz Nowicki wrote:
>
>> Of course your help in testing is welcomed. Also please have a look at
>> my GICv3/ITS patches, they are important for ACPI PCI.
>
> Where is the dependency? ACPI/PCI should really be standalone.
>
There are no dependencies in code. Just wanted to say that ARM64 
machines with GICv3/ITS and PCI on board need both series to use MSI 
with ACPI kernel. Sorry for confusion.

Regards,
Tomasz
