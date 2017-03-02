Return-Path: <SRS0=6SUC=2L=codeaurora.org=vivek.gautam@kernel.org>
Return-Path: <SRS0=6SUC=2L=codeaurora.org=vivek.gautam@kernel.org>
Subject: Re: [PATCH] pci: dwc: Fix NULL pointer dereference due to missing
 assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1488269298-23056-1-git-send-email-vivek.gautam@codeaurora.org>
 <20170228210231.GB29859@bhelgaas-glaptop.roam.corp.google.com>
Cc: bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>,
 Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <73fb02d5-093b-626f-b284-3c01aaebae39@codeaurora.org>
Date: Thu, 2 Mar 2017 09:32:05 +0530
MIME-Version: 1.0
In-Reply-To: <20170228210231.GB29859@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 03/01/2017 02:32 AM, Bjorn Helgaas wrote:
> On Tue, Feb 28, 2017 at 01:38:18PM +0530, Vivek Gautam wrote:
>> Add missing assignment of dw_pci core structure for
>> designware-plat.
>>
>> Commit 8b130f815a6b ("PCI: dwc: Fix crashes seen due to missing
>> assignments") fixed all other platforms, but missed
>> designware-plat file.
>>
>> Fixes: 442ec4c04d12 ("PCI: dwc: all: Split struct pcie_port into host-only and core structures")
>>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Thanks, Vivek!  I folded this into Guenter's patch and added your
> Signed-off-by for this designware-plat fix.  I'll ask Linus to pull this
> before v4.11-rc1.

Thanks Bjorn.


BRs
Vivek

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
