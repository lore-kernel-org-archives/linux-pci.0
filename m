Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <570C429A.6090006@caviumnetworks.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-4-git-send-email-jchandra@broadcom.com> <570C429A.6090006@caviumnetworks.com>
From: Jayachandran C <jchandra@broadcom.com>
Date: Thu, 14 Apr 2016 19:45:43 +0530
Message-ID: <CAKc_7PXdVYmm5LEUzCttagf9b4O9R--3OO1+u1CXTjGgi-K_rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PCI: generic, thunder: update to use generic ECAM API
To: David Daney <ddaney@caviumnetworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, Wangyijing <wangyijing@huawei.com>,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Tue, Apr 12, 2016 at 6:04 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 04/11/2016 03:45 PM, Jayachandran C wrote:
>>
>> Use functions provided by drivers/pci/ecam.h for mapping the config
>> space in drivers/pci/host/pci-host-common.c, and update its users to
>> use 'struct pci_config_window' and 'struct pci_generic_ecam_ops'
>>
>> The changes are mostly to use 'struct pci_config_window' in place of
>> 'struct gen_pci'. Some of the fields of gen_pci were only used
>> temporarily and can be eliminated by using local variables or function
>> arguments, these are not carried over to struct pci_config_window.
>>
>> pci-thunder-ecam.c and pci-thunder-pem.c are the only users of the
>> pci_host_common_probe function and the gen_pci structure, these have
>> been updated to use the new API as well.
>>
>> The patch does not introduce any functional changes other than a very
>> minor one: with the new code, on 64-bit platforms, we do just a single
>> ioremap for the whole config space.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>
>
> Tested-by: David Daney <david.daney@cavium.com>

Thanks.

> However, ...
>
>> ---
>>   drivers/pci/ecam.h                  |   5 ++
>>   drivers/pci/host/Kconfig            |   1 +
>>   drivers/pci/host/pci-host-common.c  | 121
>> ++++++++++++++++--------------------
>>   drivers/pci/host/pci-host-common.h  |  47 --------------
>>   drivers/pci/host/pci-host-generic.c |  50 +++------------
>>   drivers/pci/host/pci-thunder-ecam.c |  37 +++--------
>>   drivers/pci/host/pci-thunder-pem.c  |  53 +++++-----------
>
>
> ... The patch conflicts with a bug-fix patch I just sent to
> pci-thunder-pem.c, so there will be a race to see who gets in first.

I would expect this patchset to take more time than the bugfix.
I will update the patches when the fix is queued to -next.

> Also, I don't know if it would make sense to split out the pci-thunder-*
> changes to a separate patch.

In this case, I think splitting the pci-thunder-* will make it more
complex than just switching everything to ecam.h in one go.

If the patch needs to be split, I can move some of the simplification
that was done to gen_pci structure and pci-host-common to a separate
patch.

JC.
