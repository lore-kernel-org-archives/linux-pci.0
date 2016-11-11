Return-Path: <hanjun.guo@linaro.org>
Return-Path: <hanjun.guo@linaro.org>
Message-ID: <5825D967.5050505@linaro.org>
Date: Fri, 11 Nov 2016 22:44:55 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Al Stone <al.stone@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Al Stone <ahs@redhat.com>,
 Robert Richter <rrichter@cavium.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jon Masters <jcm@redhat.com>,
 linaro-acpi@lists.linaro.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Don Dutile <ddutile@redhat.com>,
 Christopher Covington <cov@codeaurora.org>,
 Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [Linaro-acpi] ACPI namespace details for ARM64
References: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com> <a0829be4-6324-758b-2fe6-a274f715a3a9@linaro.org> <20161111093226.GA13333@red-moon>
In-Reply-To: <20161111093226.GA13333@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2016 05:32 PM, Lorenzo Pieralisi wrote:
> On Thu, Nov 10, 2016 at 04:18:54PM -0700, Al Stone wrote:
>> On 11/09/2016 03:05 PM, Bjorn Helgaas wrote:
>>> Hi all,
>>>
>>> We've been working through the details of getting ACPI to work on
>>> arm64, and there have been lots of questions about what this means for
>>> PCI.  I've outlined this for several people individually, but I'm
>>> going to send this separately, apart from a specific patch series, to
>>> make sure we're all on the same page.  Please correct my errors and
>>> misunderstandings.
>>>
>>> Bjorn
>>>
>>> [snip....]
>>
>> A big +1 to all of this.  This also looks like something that should
>> be added to either PCI, ACPI or arm64 documentation (or even all three).
>
> And to arm64 platforms FW :)
>
>> What do you think?
>
> I do not think there is anything ARM64 specific in Bjorn's description,
> but I do think it is very useful to have it in documentation, these
> bits of information are scattered around ACPI specs and PCI FW specs,
> having a single source would help and would have prevented asking
> Bjorn the same questions 100 times.
>
>> Thank you for putting this together, Bjorn.
>
> +1, Thank you very much for this nice summary Bjorn.

+1, thanks a lot :)

Hanjun
