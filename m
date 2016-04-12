Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Provide common functions for ECAM mapping
To: David Daney <ddaney@caviumnetworks.com>,
	Jayachandran C <jchandra@broadcom.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
 <570C4034.20105@caviumnetworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <570C78F1.4090701@jonmasters.org>
Date: Tue, 12 Apr 2016 00:26:25 -0400
MIME-Version: 1.0
In-Reply-To: <570C4034.20105@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David, JC,

On 04/11/2016 08:24 PM, David Daney wrote:

> Tested-by: David Daney <david.daney@cavium.com>

On ThunderX (please let me know the silicon pass specifics off-list)?
I'm planning to give this series a test run also on some other ARMv8
hardware and will prod a few of the other vendors to do so.

>>   drivers/pci/ecam.c   | 130
>>   drivers/pci/ecam.h   |  58 +++++++++++++++++++++++
> 
> I wonder if these files should go in drivers/pci/host ...  I understand
> that you still have to use them from drivers/pci/acpi though.
> 
> I will let others opine on this, but could you put the contents of
> ecam.h into include/linux/pci.h along with the  pci_generic_config_*()
> declarations?
> 
> If you did that, the contents of ecam.c could  go into
> drivers/pci/access.c...

Quoting Bjorn's original reply to the previous series:

> Some of the code that moved to drivers/acpi/pci_mcfg.c is not
> really ACPI-specific, and could potentially be used for non-ACPI
> bridges that support ECAM.  I'd like to see that sort of code
> moved to a new file like drivers/pci/ecam.c.

So my guess is that this is the reasoning behind JC's file layout.

I'm curious what Lorenzo's take on things is currently. I assume this
series is now to be the official coordinated version of this effort for
upstream, following the advice of Bjorn previously, but I would like to
know if everyone is behind this plan. I've (previously) requested a
Linaro LEG meeting this week (part of our bootarch working group) to
specifically discuss the status of PCI upstreaming in order to get the
different vendors together to ensure every single one of them is
tracking the correct latest effort and doing what is needed to test/aid,
hence my ask. If this is now plan A, I'll make sure everyone is aligned
behind it and start pinging people individually for testing.

Jon.

-- 
Computer Architect

