Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbLUXYU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Dec 2015 18:24:20 -0500
Message-ID: <56788A1F.6020305@redhat.com>
Date: Mon, 21 Dec 2015 18:24:15 -0500
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
CC: David Daney <ddaney@caviumnetworks.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	Wangyijing <wangyijing@huawei.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"robert.richter@caviumnetworks.com"
	<robert.richter@caviumnetworks.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	"Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mw@semihalf.com" <mw@semihalf.com>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <201512211510.32029.arnd@arndb.de> <5678370B.1030102@caviumnetworks.com> <201512212342.18960.arnd@arndb.de>
In-Reply-To: <201512212342.18960.arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/21/2015 05:42 PM, Arnd Bergmann wrote:
> On Monday 21 December 2015, David Daney wrote:
>> On 12/21/2015 06:10 AM, Arnd Bergmann wrote:
>>> On Monday 21 December 2015, Gabriele Paoloni wrote:
>>
>>> or require the BIOS to work around the hardware
>>> quirks differently (e.g. by trapping config space access through secure
>>> firmware, or going through an AML method to be defined).
>>
>> Some systems don't seem to have this capability.  For example, in ARMv8 
>> (A.K.A. arm64), I haven't been able to figure out how to trap these 
>> accesses to EL3 for emulation.  The specification is 5700 pages long 
>> though, so perhaps I missed that bit.

There isn't a way to directly trap to EL3 for emulation (caveat - there
might be some nasty hack with an SMMU that wouldn't be supportable). I
requested the implementation of a generic mechanism for LPC type
emulation (complete with "SMI" traps to EL3 for fixups) about 4 years
ago. That wouldn't have helped with this situation, but this was to be
on the radar afterward. However, on ARM, it is still early days with
respect to transparently trapping and emulating hardware workarounds.

> How about using AML then? This would be similar to what CHRP used with
> RTAS calls to do PCI config space access.

The best way to do it for now (IMO) is via a DMI quirk match and a
special method for the early SoCs that aren't implementing MMCONFIG
correctly. An effort is underway to correct that in third party IP, and
similar directly with the partners for future generations. So this
should not get "much" more out of hand than it sadly is so far. Once we
have a good upstream solution (which is vital) then it will be an error
and a pre-tapeout bug to not be able to boot an upstream kernel with
stock ACPI hostbridge working sans nasty quirks. Therefore, the sooner
this is upstream, the better it will be for everyone involved.

Jon.

