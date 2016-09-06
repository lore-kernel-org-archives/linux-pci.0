Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 2/5] PCI/ACPI: Move ACPI ECAM mapping to generic
 MCFG driver
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-3-git-send-email-tn@semihalf.com>
 <20160905022247.GC30488@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
 rafael@kernel.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org,
 okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org,
 dhdang@apm.com, ard.biesheuvel@linaro.org,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
 jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <6ed71efa-e1fc-32bc-925d-454f93711e37@semihalf.com>
Date: Tue, 6 Sep 2016 20:04:05 +0200
MIME-Version: 1.0
In-Reply-To: <20160905022247.GC30488@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 05.09.2016 04:22, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 03:05:38PM +0200, Tomasz Nowicki wrote:
>> pci_acpi_setup_ecam_mapping() is not really ARM64 specific so move it out
>> of arch/arm64/ directory. In preparation for adding MCFG quirk handling
>> extend pci_acpi_setup_ecam_mapping() functionality to accept custom
>> PCI config accessors (function's argument).
>>
>> For ARM64 ACPI based PCI host controller we still use pci_generic_ecam_ops.
>
> I'm not sure we gain much by moving pci_acpi_setup_ecam_mapping() from
> arm64 code to generic code, since nobody else uses it yet.  But if you
> do want to move it, can you do the move (with no other change at all)
> in one patch, and add the new "ops" argument in a second patch?  I
> just don't want the "ops" change to get lost in the noise of the move.

Yes, will do.

Tomasz
