Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35805 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbbLWJjo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2015 04:39:44 -0500
Received: by mail-pa0-f50.google.com with SMTP id jx14so103494453pad.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Dec 2015 01:39:43 -0800 (PST)
From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
 <567923D2.2010202@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC183BD@lhreml503-mbb>
Cc: "robert.richter@caviumnetworks.com"
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
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"jcm@redhat.com" <jcm@redhat.com>
Message-ID: <567A6BA5.1030408@linaro.org>
Date: Wed, 23 Dec 2015 17:38:45 +0800
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC183BD@lhreml503-mbb>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/22/2015 10:48 PM, Gabriele Paoloni wrote:
> Hi Tomasz
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Tomasz Nowicki
>> Sent: 22 December 2015 10:20
>> To: Gabriele Paoloni; bhelgaas@google.com; arnd@arndb.de;
>> will.deacon@arm.com; catalin.marinas@arm.com; rjw@rjwysocki.net;
>> hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
>> jiang.liu@linux.intel.com; Stefano.Stabellini@eu.citrix.com
>> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
>> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; tglx@linutronix.de;
>> Wangyijing; Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
>> acpi@lists.linaro.org; jchandra@broadcom.com; jcm@redhat.com
>> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
>> accessors against platfrom specific quirks.
>>
>> On 21.12.2015 12:47, Gabriele Paoloni wrote:
>>> 2) In the quirk mechanism you proposed, I see that the callback
>> function
>>>      allows to do some preparation work for the host bridge. For
>> example in
>>>      Hisilicon hip05 case we would need to read some values from the
>> ACPI
>>>      table (see acpi_pci_root_hisi_add() function in
>>>      https://lkml.org/lkml/2015/12/3/426).
>>>      I am quite new to ACPI and I wonder if it is OK to add such
>> "Packages"
>>>      to the  PCI host bridge ACPI device...or maybe we need to declare
>> a new
>>>      one...?
>>
>> I may miss sth so please correct me in that case.
>>
>> https://lkml.org/lkml/2015/12/3/426 shows that you need special
>> handling for root->secondary.start bus number only, right? So how about
>> creating special MCFG region <rc-base:rc-base+rc-size> only for
>> <segment,bus>.
>> Like that:
>>
>> [0008]                       Base Address : <rc-base>
>> [0002]               Segment Group Number : <segment>
>> [0001]                   Start Bus Number : <root->secondary.start>
>> [0001]                     End Bus Number : <root->secondary.start>
>> [0004]                           Reserved : 00000000
>>
>>
>> static const struct dmi_system_id hisi_quirk[] = {
>> 	{
>> 		.ident = "HiSi...",
>> 		.matches = {
>> 			DMI_MATCH(<whatever you need to match your platform>),
>> 		},
>> 	},
>> 	{ }
>> };
>>
>> static struct pci_ops hisi_ecam_pci_ops = {
>> 	.map_bus = pci_mcfg_dev_base,
>> 	.read = hisi_pcie_cfg_read,
>> 	.write = hisi_pcie_cfg_write,
>> };
>>
>> DECLARE_ACPI_MCFG_FIXUP(hisi_quirk, &hisi_ecam_pci_ops,
>> 			<segment>, <bus>);
>>
>> With above code you can use your custom PCI config accessor only for
>> that region.
>>
>> Let me know if that is not enough for you.
>
> In principle I think it can work...
>
> Liudongdong, Guo Hanjun what is your opinion about?

Let me and Dongdong prepare a patch for Hip05 and then will
back to this discussion to see if we met some problems.

Thanks
Hanjun
