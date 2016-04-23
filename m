Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 09/13] pci, acpi: Support for ACPI based generic PCI
 host controller
To: Tomasz Nowicki <tn@semihalf.com>,
	Jayachandran C <jchandra@broadcom.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-10-git-send-email-tn@semihalf.com>
 <CAKc_7PXLbX+wxesGVKni7tkKPUbfo7AgfPNxA+Uc25ctOWRk=Q@mail.gmail.com>
 <57189824.7080908@semihalf.com> <571A37DD.4070003@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	Wangyijing <wangyijing@huawei.com>,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Jon Masters <jcm@redhat.com>
Message-ID: <571B937B.7050905@redhat.com>
Date: Sat, 23 Apr 2016 11:23:39 -0400
MIME-Version: 1.0
In-Reply-To: <571A37DD.4070003@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/22/2016 10:40 AM, Jon Masters wrote:
> On 04/21/2016 05:06 AM, Tomasz Nowicki wrote:
>> On 20.04.2016 21:12, Jayachandran C wrote:
>>> On Fri, Apr 15, 2016 at 10:36 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> 
>>>> This patch is heavily based on the updated version from Jayachandran C:
>>>> https://lkml.org/lkml/2016/4/11/908
>>>> git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
>>>
>>> This is a little bit unusual because I had not posted the v3 patch
>>> to the mailing list yet, but you posted a variant of it The git
>>> repository
>>> should not be in the commit comment because it is a temporary location.
>>
>> We all agree this too important for everybody to delay this series. So
>> main motivation is to keep all discussion&patches within one unified
>> series. I would like to finally find direction we need to go. Stating
>> another discussion based on my previous patch set v5 confused people,
>> they do no know who is driving this. Again, lets cooperate to move it
>> forward within one patch set.
> 
> We need one person in the driver's seat here for this patch series. I
> believe the intention is that this is Tomasz, with others cooperating
> and assisting. The previous alternative patch series did serve to cause
> confusion, and worse, they made it look like the ARM vendors can't work
> together. That ends. Right now. I've raised this individually with each
> of you (and with all of the other vendors), as well as inside Linaro.
> There will be one person driving this, and everyone else will help.

As a quick update, since yesterday I have confirmed that several
different microarchitecture implementations (different PCIe) have tested
and validated this patch series. Those minimally include:

* Cavium Networks ThunderX
* Qualcomm Technologies Inc QDF2XXX
* AMD A1100 ("Seattle")

Another is working on testing over the weekend. Still waiting for an ARM
tested-by on Juno I think. I will personally be testing this and future
releases on all of the above mentioned hw.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

