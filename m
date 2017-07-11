Return-Path: <SRS0=qvcf=6O=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=qvcf=6O=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V2] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, wim.ten.have@oracle.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
 <20170710230911.GH5610@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5f5119fd-64d5-5e7c-fa50-54ac6e6a36b6@codeaurora.org>
Date: Mon, 10 Jul 2017 20:20:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170710230911.GH5610@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 7/10/2017 7:09 PM, Bjorn Helgaas wrote:
> The PCI_EXP_DEVCTL_EXT_TAG bit controls the behavior of the function as a
> Requester.  As far as I can see, it has nothing to do with whether the
> function supports 8-bit tags as a *Completer*, so the implicit assumption
> of the spec is that all Completers always support 8-bit tags.  My guess is
> that's why the ECN thought it would be safe to enable extended tags by
> default.
> 
> If that's the case, this is just a defect in the device (the Completer),
> and we should blacklist it.  Looking at the PCIe Capability version might
> happen to correlate with Completer support for 8-bit tags, but that looks
> like just a coincidence to me.

Sure, I can change to blacklist. I'll not enable it unless the device is blacklisted
via quirks.

Sinan
-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
