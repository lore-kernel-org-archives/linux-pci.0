Return-Path: <SRS0=KvoV=6P=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=KvoV=6P=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V3 1/2] PCI: Add Extended Tags quirk for Broadcom HT2100
 Root Port
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, wim.ten.have@oracle.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
 <20170711195853.GA14614@bhelgaas-glaptop.roam.corp.google.com>
 <ae4dca5b-30cf-3a14-1707-380a3660badf@codeaurora.org>
 <20170711203957.GB14614@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <25b6bbf6-20b5-dfc8-c92a-268c07fa1f98@codeaurora.org>
Date: Wed, 12 Jul 2017 09:07:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170711203957.GB14614@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 7/11/2017 4:39 PM, Bjorn Helgaas wrote:
> My proposal handles endpoints, too.  The pci_walk_bus() in the quirk
> handles all devices we've already enumerated, and all devices we'll
> enumerate in the future are handled in pci_configure_device().

Code clears the endpoint's extended tag capability only if a quirky host
bridge is found. 

The question here was 

"what if you have an endpoint, it may declare extended tags capability
and has a bug even though the host bridge is just fine"

Code will enable extended tags on both the host bridge and endpoint
if it is supported.

The host bridge will start generating 256 tags towards the endpoint
but endpoint is unable to catch up with it. 

Same thing is possible with two endpoints that try to do peer-to-peer
communication. The first endpoint may generate 256 requests, second
endpoint may not handle it.

Again, this is a hypothetical condition with no known endpoints. I
suggest we deal with this when time comes.

Sinan 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
