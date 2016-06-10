Return-Path: <jcm@jonmasters.org>
Return-Path: <jcm@jonmasters.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <20160610234107.GC7671@localhost>
Cc: rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
 catalin.marinas@arm.com, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 cov@codeaurora.org, mw@semihalf.com, linux-arm-kernel@lists.infradead.org,
 jchandra@broadcom.com, dhdang@apm.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <2e8ae0dc-d04e-3264-86d4-e2640060750c@jonmasters.org>
Date: Fri, 10 Jun 2016 19:58:38 -0400
MIME-Version: 1.0
In-Reply-To: <20160610234107.GC7671@localhost>
Content-Type: text/plain; charset=utf-8
Subject: Re: [Linaro-acpi] [PATCH V9 00/11] Support for ARM64 ACPI based PCI
 host controller
List-ID: <linux-pci.vger.kernel.org>

On 06/10/2016 07:41 PM, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2016 at 09:55:08PM +0200, Tomasz Nowicki wrote:
>> From the functionality point of view this series may be split into the
>> following logic parts:
>> 1. Export ECAM API and add parent device to pci_config_window
>> 2. Add IO resources handling to PCI core code
>> 3. New MCFG driver
>> 4. Cleanups and support for generic domain assignment based on ACPI
>> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/
> 
> This is beautiful!  It really turned out well.
> 
> I applied all these to pci/arm64-acpi for v4.8.

Quick followup - I've forwarded your mail to the Linaro Enterprise Group
members and started nudging the vendors to prep any remaining pieces for
post-merge. That includes quirks, and then any drivers that anyone has
been sitting on until this was upstream.

Looking forward to F25 Server booting out of the box, and finally
getting to a point where Fedora is once again upstream of RHEL(SA).

Jon.
