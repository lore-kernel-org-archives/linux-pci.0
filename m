Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V12 4/5] PCI: Handle CRS ("device not ready") returned by
 device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
 <1503464171-6471-4-git-send-email-okaya@codeaurora.org>
 <20170823213838.GG8498@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0ef4c01d-75bc-17dc-8926-2f9647cfeec8@codeaurora.org>
Date: Wed, 23 Aug 2017 17:51:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170823213838.GG8498@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/23/2017 5:38 PM, Bjorn Helgaas wrote:
> If we increase the timeout, is there still value in adding the
> pci_bus_wait_crs() stuff?  I'm not sure there is.

I agree increasing the timeout is more than enough for FLR case. 

However, I was considering the wait and pending functions as a utility
that I can reuse towards fixing CRS in other conditions like secondary
bus reset and potentially PM.

I'm planning to have a CRS session in the Linux Plumbers Conference 
to talk about CRS use cases. 

I was going to follow up this series with secondary bus reset next once
this goes in. 

I'm unable to test PM. I can't promise how I fix/test it.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
