Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:42315 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbJOXts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 19:49:48 -0400
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
Message-Id: <A2E9B42F-21EE-4432-91E2-9142BE595825@redhat.com>
Date: Thu, 15 Oct 2015 19:49:03 -0400 (EDT)
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <561FFB4C.1000500@redhat.com> <562039FE.9050004@linaro.org>
To: Hanjun Guo <hanjun.guo@linaro.org>
In-Reply-To: <562039FE.9050004@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	linux-acpi@vger.kernel.org,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry for top posting. Can you summarize the OperationRegion issue? I am aware of a few early firmwares that effectively had the producer/consumer type for bridge resources the wrong way around but not of the specific issue. If ASWG confidential I can take it over there.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Oct 15, 2015, at 19:43, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> 
>> On 10/16/2015 03:15 AM, Jon Masters wrote:
>> Hi Hanjun,
>> 
>> Thanks for your hard work on ARM64 PCI host bridge/root complex so far!
>> 
>>> On 05/26/2015 08:49 AM, Hanjun Guo wrote:
>>> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
>>> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
>>> code into ACPI core":
>>> 
>>> https://lkml.org/lkml/2015/5/14/98
>> 
>> The latest version (v7) of the ACPI PCI root common code consolidation
>> series was posted by Gerry (Jiang Liu) yesterday:
>> 
>> https://lkml.kernel.org/g/1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com
>> 
>> This got me wondering what the status is of the ARM64 specific
>> hostbridge patch series that has a dependency upon the former. Are you
>> planning to wait for that series to be accepted or post a newer rebased
>> version for additional review, or something else?
> 
> Tomasz and Lorenzo are discussing about the PCI config based
> OperationRegions, which still have no conclusion yet, Lorenzo
> started a discussion on ASWG and hope can get some feedback.
> 
> Other than that, Tomasz volunteered to cleanup this patch set, I
> think we need to rebase on Jiang's v7 patchset which was accepted
> By Rafael, of course I will work with Tomasz to prepare those
> patches.
> 
> Thanks
> Hanjun
