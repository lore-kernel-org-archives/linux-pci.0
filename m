Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56C47E9A.5010901@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-8-git-send-email-tn@semihalf.com> <CAKc_7PU+i2AwOVCyW2VNt4BZCWw=KBMAbV8v9DVQ2Ess3WE=kw@mail.gmail.com>
 <56C47E9A.5010901@semihalf.com>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Wed, 17 Feb 2016 19:51:48 +0530
Message-ID: <CAKc_7PUiLQhUuJjR8wcuRm7KJdxBYjb+ZBd_cLTtjNPbEro6wA@mail.gmail.com>
Subject: Re: [PATCH V5 07/15] pci, acpi: Provide generic way to assign bus
 domain number.
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 17, 2016 at 7:37 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> On 17.02.2016 14:44, Jayachandran Chandrashekaran Nair wrote:
>>
>> Tomasz, Lorenzo,
>>
>> On Tue, Feb 16, 2016 at 7:23 PM, Tomasz Nowicki<tn@semihalf.com>  wrote:
>>>
>>> >As we now have valid PCI host bridge device reference we can
>>> >introduce code that is going to find its bus domain number using
>>> >ACPI _SEG method.
>>> >
>>> >Note that _SEG method is optional, therefore _SEG absence means
>>> >that all PCI buses belong to domain 0.
>>> >
>>> >While at it, for the sake of code clarity we put ACPI and DT domain
>>> >assign methods into the corresponding helpers.
>>
>> In my patchset, I had a slightly different and I think better approach for
>> this without calling the _SEG method again. Please see
>> http://www.spinics.net/lists/arm-kernel/msg478167.html
>> at the last part ofhttp://www.spinics.net/lists/arm-kernel/msg478169.html
>
> Relying on NULL parent device to make decision on boot method is really ugly
> way. This may hit us again once we want to obtain another firmware specific
> info e.g. numa node. IMO we need to fix it this way.

I am not relying on NULL there, in the current code parent is NULL
in case of ACPI, and the check is needed not to crash (unless that
has changed).

The main part was the macro acpi_pci_get_segment() and the use
of acpi_pci_root_info from sysdata to do this.

JC.
