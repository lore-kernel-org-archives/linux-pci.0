Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0091.outbound.protection.outlook.com ([157.56.110.91]:10198
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751277AbbLURaX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Dec 2015 12:30:23 -0500
Message-ID: <5678370B.1030102@caviumnetworks.com>
Date: Mon, 21 Dec 2015 09:29:47 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>,
	"robert.richter@caviumnetworks.com"
	<robert.richter@caviumnetworks.com>,
	"mw@semihalf.com" <mw@semihalf.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Wangyijing <wangyijing@huawei.com>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"jcm@redhat.com" <jcm@redhat.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <1450278993-12664-23-git-send-email-tn@semihalf.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb> <201512211510.32029.arnd@arndb.de>
In-Reply-To: <201512211510.32029.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/21/2015 06:10 AM, Arnd Bergmann wrote:
> On Monday 21 December 2015, Gabriele Paoloni wrote:
>>> -----Original Message-----
>>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>>> owner@vger.kernel.org] On Behalf Of Tomasz Nowicki
>
>>> Some platforms may not be fully compliant with generic set of PCI
>>> config accessors. For these cases we implement the way to overwrite
>>> accessors set before PCI buses enumeration. Algorithm that overwrite
>>> accessors matches against platform ID (DMI), domain and bus number,
>>> hopefully enough for all cases. All quirks can be defined using:
>>> DECLARE_ACPI_MCFG_FIXUP() and keep self contained.
>>
>> I've got a couple of comments/questions about this patch..
>>
>> 1) So according to this mechanism quirks would be supported only by
>>     vendors whose BIOS are SMBIOS compliant. Now personally I am ok
>>     with this but I don't know if this is OK in general as it would
>>     narrow down the number of platforms that would be able to define
>>     the quirks...
>>     Lorenzo, Arnd what is your opinion here?
>
> I'd rather not see the quirks in mainline at all, and only support
> SBSA compliant machines,

There seems to exist a class of systems that were intended to be SBSA 
compliant, but after they were manufactured turn out to not be fully 
complaint.  It would be nice to have Linux kernel support for some of 
these systems

There also seems to be historical precedent for quirk frameworks in 
various kernel subsystems to handle systems and devices that are not 
fully "Spec. Compliant".

> or require the BIOS to work around the hardware
> quirks differently (e.g. by trapping config space access through secure
> firmware, or going through an AML method to be defined).

Some systems don't seem to have this capability.  For example, in ARMv8 
(A.K.A. arm64), I haven't been able to figure out how to trap these 
accesses to EL3 for emulation.  The specification is 5700 pages long 
though, so perhaps I missed that bit.

> I'm certainly
> ok with making it depend on SMBIOS if we are going to use something like this.
>
> 	Arnd
>

