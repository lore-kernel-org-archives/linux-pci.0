Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 05/13] acpi, pci: Support IO resources when parsing PCI
 host bridge resources.
To: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-6-git-send-email-tn@semihalf.com>
 <20160427023916.GF6789@localhost> <57204FDB.6010202@redhat.com>
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
Message-ID: <57228671.7060606@redhat.com>
Date: Thu, 28 Apr 2016 17:53:53 -0400
MIME-Version: 1.0
In-Reply-To: <57204FDB.6010202@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/27/2016 01:36 AM, Jon Masters wrote:
> On 04/26/2016 10:39 PM, Bjorn Helgaas wrote:

>> It would be ideal to find
>> some way to handle ia64 and ARM64 similarly.  At the very least, we
>> have to make sure that this doesn't break ia64.  The ia64 dense/sparse
>> I/O spaces complicate things; I don't know if ARM64 has something
>> similar or not.
> 
> There's nothing directly similar - it's just regular MMIO.

Just a footnote on the IA64 thing. I'm working on getting access to a
few Itanium systems and running V6 on these (even bought my first
Itanium system today so I can run this at home also). I'm also chatting
with the internal RH QE folks about testing on a few dozen x86 systems.
Will followup when we've any results on that testing.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

