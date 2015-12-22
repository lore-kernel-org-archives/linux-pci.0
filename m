Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44818 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbbLVQp0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Dec 2015 11:45:26 -0500
Message-ID: <56797E20.2080107@redhat.com>
Date: Tue, 22 Dec 2015 11:45:20 -0500
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: Tomasz Nowicki <tn@semihalf.com>,
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
	"ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
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
	"jchandra@broadcom.com" <jchandra@broadcom.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <1450278993-12664-23-git-send-email-tn@semihalf.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb> <201512211510.32029.arnd@arndb.de> <335CDE2E-B588-43A8-8665-6023AFD0EA04@redhat.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EC17CAC@lhreml503-mbb> <56797C16.2020802@redhat.com>
In-Reply-To: <56797C16.2020802@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/22/2015 11:36 AM, Jon Masters wrote:
> On 12/22/2015 04:29 AM, Gabriele Paoloni wrote:
>> Hi Jon, thanks for replying
>>
>>> -----Original Message-----
>>> From: Jon Masters [mailto:jcm@redhat.com]
>>> Sent: 21 December 2015 23:11
>>> To: Arnd Bergmann
>>> Cc: Gabriele Paoloni; Tomasz Nowicki; bhelgaas@google.com;
>>> will.deacon@arm.com; catalin.marinas@arm.com; rjw@rjwysocki.net;
>>> hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
>>> jiang.liu@linux.intel.com; Stefano.Stabellini@eu.citrix.com;
>>> robert.richter@caviumnetworks.com; mw@semihalf.com; Liviu.Dudau@arm.com;
>>> ddaney@caviumnetworks.com; tglx@linutronix.de; Wangyijing;
>>> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
>>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
>>> acpi@lists.linaro.org; jchandra@broadcom.com
>>> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
>>> accessors against platfrom specific quirks.
>>>
>>> Sorry for top-posting. A quick note that SMBIOS3 is required by SBBR so
>>> it can be presumed that compliant platforms will provide quirks via DMI.
>>
>> Ok so you completely clarified my question 1). Many Thanks for this
> 
> No problem. One of the (many) reasons I pushed for requiring SMBIOS/DMI
> in SBBR (I was lead author of one of the early drafts of that document)
> was to make the experience ultimately equivalent across architectures.
> We already know how to do quirks and handle platform deviations, and the
> major Operating System vendors did not want to reinvent the wheel.

Additional: it is clear that more prescription is required to get the
vendors onto the bandwagon that we have with other architectures (e.g.
that other one). So there will be a Red Hat "ARM server whitepaper"
coming in the early new year that will include the kind of "server 101"
material we want to make sure people know. Things like making sure you
implement and test PCIe correctly, handle backward compatibility (you
will build hardware in the future that runs my existing OS release),
design the hardware to allow for workarounds later, etc. I expect some
other Operating System vendors to be involved in reviewing that.

Ultimately my objective is to make this whole thing dull and boring. You
will get RHEL(SA)/upstream kernels and it will either boot or it will
not. If it does not boot, vendor X screwed up their hardware. We know
this story, it's been this way for over a decade already, and that is
exactly how it is going to be with ARM servers shortly.

Jon.

