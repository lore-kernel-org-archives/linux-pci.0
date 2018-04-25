Return-Path: <SRS0=Gxz6=HO=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Gxz6=HO=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 sulrich@codeaurora.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Doug Ledford <dledford@redhat.com>,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Rajat Jain <rajatja@google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
 <290e9530-dcde-9c10-7ae0-59ac4c509db4@codeaurora.org>
 <20180420140049.GP28657@bhelgaas-glaptop.roam.corp.google.com>
 <20180420090420.03fb1e6c@w520.home>
 <10d9cf68-29ed-d205-a25f-b8dade53cdd8@codeaurora.org>
 <20180423131044.53471670@w520.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <988448bc-a5be-2beb-cbe8-b5a8ec4b8cfa@codeaurora.org>
Date: Wed, 25 Apr 2018 10:13:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180423131044.53471670@w520.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/23/2018 3:10 PM, Alex Williamson wrote:
>> Do we need a retrain API with the speed that driver wants to reach to?
>> API can return what was actually accomplished. The quirk from Alex can
>> run inside this API to make a decision on what speed do we actually want
>> to reach to for a given PCI topology by reprogramming the target link speed
>> field.
> Yes, I think the core should provide a retraining API, that would also
> make the Pericom quirk easier to implement.  We'd want a field/flag on
> the pcidev that could be set by quirks to limit the highest target
> rate, but it makes sense that this should be an interface provided by
> and control point for the PCI core.  Thanks,

Maybe, we could live with the existing secondary bus reset API. The speed that
driver wants to reach to is in the target speed field. Quirk can hook up
to the secondary bus reset call, read the target speed field to see what speed
we are trying to negotiate to and override the target speed register based on
upstream and downstream speeds.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
