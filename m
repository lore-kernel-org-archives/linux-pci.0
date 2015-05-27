Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50477 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751207AbbE0AEh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 20:04:37 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
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
Date: Wed, 27 May 2015 02:30:06 +0200
Message-ID: <1951882.p8DdrcurkC@vostro.rjw.lan>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, May 26, 2015 08:49:13 PM Hanjun Guo wrote:
> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
> code into ACPI core":
> 
> https://lkml.org/lkml/2015/5/14/98

I'll be regarding this patchset as an RFC until the one from Jiang Liu goes in.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
