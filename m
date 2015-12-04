Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, Liviu.Dudau@arm.com, tn@semihalf.com
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
Cc: linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
	linux-acpi@vger.kernel.org, wangzhou1@hisilicon.com,
	liudongdong3@huawei.com, wangyijing@huawei.com, tglx@linutronix.de,
	liguozhu@hisilicon.com, jiang.liu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5661F9DD.7060303@arm.com>
Date: Fri, 4 Dec 2015 14:38:53 -0600
MIME-Version: 1.0
In-Reply-To: <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/03/2015 09:19 AM, Gabriele Paoloni wrote:
> This patch modifies the ARM64 architecure specific PCI framework to
> support Host Bridge specific quirks. these quirks are need for
> host bridge controllers that are not fully ECAM compliant.
> The quirks array allows each vendor to define his own
> acpi_scan_handler where its own pci_ops can be defined
> and the global pointer "vendor_specific_ops" should be
> set to them accordingly.

I have a similar set of changes working for a APM based platform. That 
platform has the same problem, that the default config space access 
methods don't work.

The one comment I have is that I've tried hard to set it up as a generic 
quirk system for which the ACPI/PCI subsystem makes the decision about 
which hardware quirk is being enabled. But its hard because the platform 
in question claims PNP0A08 too, which IMHO is completely wrong if your 
not actually compliant. OTOH, I don't want to base it off the DMI data 
because I don't want it to be tied to a particular implementation.

Lucky, the host bridge VID/PID _CAN_ be read with the default ECAM 
accessor. The only gocha is that the rescan needs to be restarted once 
the ops are replaced.

So my question, is does that work for this device as well?





