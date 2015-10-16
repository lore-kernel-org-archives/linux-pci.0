Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v7 0/7] Consolidate ACPI PCI root common code into ACPI
 core
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <20151015204829.GH10442@localhost> <18082551.ZgPkP00eQT@vostro.rjw.lan>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <56205945.4000606@linux.intel.com>
Date: Fri, 16 Oct 2015 09:56:21 +0800
MIME-Version: 1.0
In-Reply-To: <18082551.ZgPkP00eQT@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/16 5:49, Rafael J. Wysocki wrote:
> On Thursday, October 15, 2015 03:48:29 PM Bjorn Helgaas wrote:
>> On Wed, Oct 14, 2015 at 02:29:35PM +0800, Jiang Liu wrote:
>>> From: Liu Jiang <jiang.liu@linux.intel.com>
>>>
>>> This patch set consolidates common code to support ACPI PCI root on x86
>>> and IA64 platforms into ACPI core, to reproduce duplicated code and
>>> simplify maintenance. And a patch set based on previous version to support
>>> ACPI based PCIe host bridge on ARM64 has been posted at:
>>> https://lkml.org/lkml/2015/5/26/207
>>>
>>> It's based on latest mainstream kernel. It passes Fengguang's 0day test
>>> suite and has been tested on two IA64 platforms and one x86 platform.
>>>
>>> V6->V7:
>>> 1) Improve commit message according to Bjorn's suggestion.
>>> 2) Move arch specific logic(code) from ACPI core into arch code
>>>    according to Bjorn's review comments.
>>
>> Thanks for cleaning this up; I think it looks much better.
>>
>> As far as I'm concerned, this series is ready to go.  I assume Rafael
>> will merge it.
> 
> Yes, I'm going to do that.
> 
> Thanks a lot for your help with the review!
Thanks Bjorn and Rafael for review!

