Return-Path: <SRS0=qDb1=CR=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=qDb1=CR=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
 <20171116201745.GB7266@bhelgaas-glaptop.roam.corp.google.com>
 <16b9ac67-042d-1010-0c8c-205b2fa40a7f@codeaurora.org>
 <20171118000243.GC16907@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <dddb6c7a-5bf9-8c26-f753-6223b35f4842@codeaurora.org>
Date: Sun, 19 Nov 2017 11:41:01 -0500
MIME-Version: 1.0
In-Reply-To: <20171118000243.GC16907@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2017 7:02 PM, Bjorn Helgaas wrote:
>> What do you think about the rescan following link up? The only entity
>> that does rescan today is hotplug after DPC recovery. There could be
>> a platform with DPC support but no hotplug support. 
>>
>> How should we handle it?
> Good question.  If your system does support both DPC and hotplug, I
> assume the link comes back up after you clear DPC Trigger Status.
> Does pciehp notice that "link up" event and add the device back?

that's correct. we see a link up indication from hotplug driver followed
by a rescan.

> 
> So I think your question is whether the DPC code should explicitly do
> a rescan so that if we don't have pciehp, we'll still automatically
> rediscover the device.  I dunno, maybe.  Seems like a plausible idea
> anyway.

OK, will add it to DPC driver for completeness.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
