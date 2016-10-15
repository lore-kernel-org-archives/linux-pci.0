Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V2 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size
 to 16"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
 <20161012221357.GB15116@localhost>
 <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 wim@djo.tudelft.nl, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <44177a0c-d608-d6b8-232a-ebe244d932ee@codeaurora.org>
Date: Fri, 14 Oct 2016 23:50:30 -0400
MIME-Version: 1.0
In-Reply-To: <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/12/2016 6:46 PM, Sinan Kaya wrote:
>> Which API are you thinking about here?  pcibios_penalize_isa_irq() is
>> > called by ACPI and PNP, which should both be after ACPI is started.
> Correct, I was talking about acpi_penalize_sci_irq function here.
> 

Now that I'm looking at the code. There are two more functions that get
called before ACPI start. 

These are acpi_isa_irq_available and acpi_penalize_isa_irq functions. 
We can't rely on iterating the link list.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
