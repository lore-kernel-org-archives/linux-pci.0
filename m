Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35708 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbE0D6H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 23:58:07 -0400
Received: by pdea3 with SMTP id a3so107200967pde.2
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 20:58:06 -0700 (PDT)
Message-ID: <556540C7.6080301@linaro.org>
Date: Wed, 27 May 2015 11:57:59 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
Subject: Re: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1951882.p8DdrcurkC@vostro.rjw.lan>
In-Reply-To: <1951882.p8DdrcurkC@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年05月27日 08:30, Rafael J. Wysocki wrote:
> On Tuesday, May 26, 2015 08:49:13 PM Hanjun Guo wrote:
>> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
>> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
>> code into ACPI core":
>>
>> https://lkml.org/lkml/2015/5/14/98
>
> I'll be regarding this patchset as an RFC until the one from Jiang Liu goes in.

Yes, please, Jiang Liu's patch set should go in first.

Thanks
Hanjun
