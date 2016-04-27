Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbcD0Fgh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Apr 2016 01:36:37 -0400
Subject: Re: [PATCH V6 05/13] acpi, pci: Support IO resources when parsing PCI
 host bridge resources.
To: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-6-git-send-email-tn@semihalf.com>
 <20160427023916.GF6789@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
From: Jon Masters <jcm@redhat.com>
Message-ID: <57204FDB.6010202@redhat.com>
Date: Wed, 27 Apr 2016 01:36:27 -0400
MIME-Version: 1.0
In-Reply-To: <20160427023916.GF6789@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/26/2016 10:39 PM, Bjorn Helgaas wrote:
> On Fri, Apr 15, 2016 at 07:06:40PM +0200, Tomasz Nowicki wrote:
>> Platforms that have memory mapped IO port (such as ARM64) need special
>> handling for PCI I/O resources. For host bridge's resource probing case
>> these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.
> 
> ia64 also has memory-mapped I/O port space.

The specific references of interest to anyone here are:

*). Volume 2, Part 1: Itanium® Architecture-based Operating System
Interaction Model with IA-32 Applications 2:267 section "10.7 I/O Port
Space Model" which describes how they can map 4 "legacy" IO ports on a
virtual page when operating in a "sparse" mode.

*). Page 378 of the ACPI6.1 specification Table 6-213 I/O Resource Flag
(Resource Type = 1) Definitions describes how a "sparse" translation can
exist depending upon bit _TRS. This seems to be implemented in Linux
using the ACPI_SPARSE_TRANSLATION types.

> It would be ideal to find
> some way to handle ia64 and ARM64 similarly.  At the very least, we
> have to make sure that this doesn't break ia64.  The ia64 dense/sparse
> I/O spaces complicate things; I don't know if ARM64 has something
> similar or not.

There's nothing directly similar - it's just regular MMIO.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

