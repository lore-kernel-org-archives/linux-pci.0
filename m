Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:38827 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478AbcAHOnE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 09:43:04 -0500
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Mark Salter <msalter@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
	<bhelgaas@google.com>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <rjw@rjwysocki.net>,
	<hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
	<okaya@codeaurora.org>, <jiang.liu@linux.intel.com>,
	<Stefano.Stabellini@eu.citrix.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <1452262581.31901.26.camel@redhat.com>
CC: <jchandra@broadcom.com>, <linaro-acpi@lists.linaro.org>,
	<linux-pci@vger.kernel.org>, <Liviu.Dudau@arm.com>,
	<ddaney@caviumnetworks.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <robert.richter@caviumnetworks.com>,
	<Suravee.Suthikulpanit@amd.com>, <jcm@redhat.com>,
	<wangyijing@huawei.com>, <tglx@linutronix.de>, <mw@semihalf.com>,
	<linux-arm-kernel@lists.infradead.org>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <568FCAD7.70700@arm.com>
Date: Fri, 8 Jan 2016 08:42:31 -0600
MIME-Version: 1.0
In-Reply-To: <1452262581.31901.26.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/08/2016 08:16 AM, Mark Salter wrote:
> On Wed, 2015-12-16 at 16:16 +0100, Tomasz Nowicki wrote:
>> Some platforms may not be fully compliant with generic set of PCI config
>> accessors. For these cases we implement the way to overwrite accessors
>> set before PCI buses enumeration. Algorithm that overwrite accessors
>> matches against platform ID (DMI), domain and bus number, hopefully
>> enough for all cases. All quirks can be defined using:
>> DECLARE_ACPI_MCFG_FIXUP() and keep self contained.

...

> This seems awkward to me in the case where the quirk is SoC-based and there
> may be multiple platforms affected. Needing a DECLARE_ACPI_MCFG_FIXUP for
> each platform using such a SoC (i.e. Mustang and Moonshot) doesn't seem
> right. In that case, I think it'd be better to check CPUID and possibly
> some SoC register to cover all platforms affected.
>
> Also, there doesn't seem to be a way to connect a given quirk check to the
> MCFG/device requesting the ops. So if there is a platform with multiple PCIE
> roots and not all of them have quirks, how does one no whether to override the
> default ecam ops?

That was the thinking that lead me to quirk the xgene based m400 using
the root bridge VID/DID and DECLARE_PCI_FIXUP_EARLY(). A solution which
works because the default config space accessors work sufficiently to
read the VID/DID.

I think that solution might work for at least one other vendor as well,
and IMHO is better than using DMI for the reasons you list.

I will rebase/post those patches RSN...
















(please ignore the message below, i'm working getting that taken care of
as well)



IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

