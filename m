Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 09/13] pci, acpi: Support for ACPI based generic PCI
 host controller
To: Tomasz Nowicki <tn@semihalf.com>,
	Jayachandran C <jchandra@broadcom.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-10-git-send-email-tn@semihalf.com>
 <CAKc_7PXLbX+wxesGVKni7tkKPUbfo7AgfPNxA+Uc25ctOWRk=Q@mail.gmail.com>
 <57189824.7080908@semihalf.com>
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
Message-ID: <571A37DD.4070003@redhat.com>
Date: Fri, 22 Apr 2016 10:40:29 -0400
MIME-Version: 1.0
In-Reply-To: <57189824.7080908@semihalf.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/21/2016 05:06 AM, Tomasz Nowicki wrote:
> On 20.04.2016 21:12, Jayachandran C wrote:
>> On Fri, Apr 15, 2016 at 10:36 PM, Tomasz Nowicki <tn@semihalf.com> wrote:

>>> This patch is heavily based on the updated version from Jayachandran C:
>>> https://lkml.org/lkml/2016/4/11/908
>>> git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
>>
>> This is a little bit unusual because I had not posted the v3 patch
>> to the mailing list yet, but you posted a variant of it The git
>> repository
>> should not be in the commit comment because it is a temporary location.
> 
> We all agree this too important for everybody to delay this series. So
> main motivation is to keep all discussion&patches within one unified
> series. I would like to finally find direction we need to go. Stating
> another discussion based on my previous patch set v5 confused people,
> they do no know who is driving this. Again, lets cooperate to move it
> forward within one patch set.

We need one person in the driver's seat here for this patch series. I
believe the intention is that this is Tomasz, with others cooperating
and assisting. The previous alternative patch series did serve to cause
confusion, and worse, they made it look like the ARM vendors can't work
together. That ends. Right now. I've raised this individually with each
of you (and with all of the other vendors), as well as inside Linaro.
There will be one person driving this, and everyone else will help.

> I agree with you we need maintainers to join this discussion.

Please. I really want to lend support to the sense of urgency of getting
something merged that provides the basic ACPI based ECAM functionality
on ARMv8 systems. Until that happens, there are vendors who are going to
have to delay various other activities around ARM server until it is
done (because of the lack of an upstream patch is a critical blocker -
this isn't embedded, and we don't work that way).

This is incredibly critical and central to the successful adoption of
larger ARMv8 servers over the next year or so, all of which will rely
upon PCIe, using ACPI. We therefore need all hands on deck, and all
vendors getting overwhelmingly excited about making this patch series a
success. As an aside, to help the engineering orgs within these vendors
understand how much I need motion on this thread, I'm buzzing in their
ears multiple times per week specifically on engagement on this thread.
We need this done. If Bjorn or anyone else needs something, tell us.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

