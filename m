Return-Path: <SRS0=RduH=EM=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=RduH=EM=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Maik Broemme <mbroemme@libmpq.org>, Pawandeep Oza <poza@codeaurora.org>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-4-keith.busch@intel.com>
 <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
 <20171221051256.GA15276@localhost.localdomain>
 <ea609f8a-1d79-c2fe-e9e5-5993e418f9cc@codeaurora.org>
 <20180116024740.GA32639@localhost.localdomain>
 <20180117005559.GF10860@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8b5c30c2-b770-131e-d56d-8b435600889b@codeaurora.org>
Date: Wed, 17 Jan 2018 08:36:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180117005559.GF10860@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/16/2018 7:56 PM, Bjorn Helgaas wrote:
> I think Sinan is saying that if a DPC Port observes its own unmasked
> uncorrectable error (i.e., not something it learned about by receiving
> an ERR_* message), it will set a bit in an AER status register.
> 
> Since we do not set DPC ERR_COR Enable, the DPC Port does not generate
> an ERR_COR Message, so the AER driver never learns about the error and
> never clears the AER status register.  So we'll decode the AER status
> (with your current patch), but we don't clear it, so if another error
> occurs, the AER logging won't work correctly.

Yes, this is what I was meaning. I see that Keith took care of this in
the new series.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
