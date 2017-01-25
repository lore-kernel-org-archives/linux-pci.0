Return-Path: <SRS0=/1wB=ZH=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=/1wB=ZH=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH] PCI: enable extended tags support for PCIe endpoints
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1474769434-5756-1-git-send-email-okaya@codeaurora.org>
 <420a9a23-79f8-41d8-c44f-b53f5000c957@codeaurora.org>
 <20161111205801.GC9868@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 vikrams@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <34f2e149-3bb1-6af2-a9f5-fbe5a050fe31@codeaurora.org>
Date: Wed, 25 Jan 2017 12:49:17 -0500
MIME-Version: 1.0
In-Reply-To: <20161111205801.GC9868@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/11/2016 3:58 PM, Bjorn Helgaas wrote:
>> Is there any other feedback?
> If this were completely safe to enable for every device that supported
> it, why would there be an enable bit in Device Control?
> 
> I don't know anything about extended tags, but it worries me a little
> when there's a "go-fast" switch and no explanation about when and why
> we might need to go slow.
> 

I have v2 posted. Do you feel like applying to linux-next to get some testing
exposure or do you want to tie it to some DMI so that we enable it only on
recent HW?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
