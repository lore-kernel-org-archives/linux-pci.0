Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: enable extended tags support for PCIe endpoints
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1474769434-5756-1-git-send-email-okaya@codeaurora.org>
 <420a9a23-79f8-41d8-c44f-b53f5000c957@codeaurora.org>
 <20161111205801.GC9868@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 vikrams@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <99d136d7-6bce-5faf-c4a9-ba55808c167d@codeaurora.org>
Date: Fri, 11 Nov 2016 20:11:19 -0500
MIME-Version: 1.0
In-Reply-To: <20161111205801.GC9868@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2016 3:58 PM, Bjorn Helgaas wrote:
>> I should have checked the capability here before trying to enable it. 
>> > I'll post a follow up patch on this. 
>> > 
>> > Is there any other feedback?
> If this were completely safe to enable for every device that supported
> it, why would there be an enable bit in Device Control?

reading from the ECN here.

https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf

The initial value is implementation specific and functions are allowed
to set it to 1 by default.

> 
> I don't know anything about extended tags, but it worries me a little
> when there's a "go-fast" switch and no explanation about when and why
> we might need to go slo

Based on my observation, extended tags increase the number of reads that
can be queued up back to back downstream. Otherwise, the requests will not
make progress until 1 tag out of 32 gets available.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
