Return-Path: <SRS0=JYXB=6Q=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=JYXB=6Q=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, alex.williamson@redhat.com, vikrams@codeaurora.org,
 Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
 <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
 <20170713162915.GA14716@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <78020acc-c2b6-423c-38a0-251f86ffa8a9@codeaurora.org>
Date: Thu, 13 Jul 2017 12:42:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170713162915.GA14716@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 7/13/2017 12:29 PM, Keith Busch wrote:
>> When used, DRS and FRS allow an improved behavior over the CRS mechanism, and eliminate
>> its associated periodic polling time of up to 1 second following a reset."
> That wording is just confusing. It looks to me the 1 second polling is
> to be used following a reset if CRS is not implemented.
> 
>   https://pcisig.com/sites/default/files/specification_documents/ECN_RN_29_Aug_2013.pdf
> 
> "
>   Through the mechanisms defined by this ECR, we can avoid the long,
>   architected, fixed delays following various forms of reset before
>   software is permitted to perform its first Configuration Request. These
>   delays are very large:
> 
>   1 second if Configuration Retry Status (CRS) is not used
> "
> 
> It goes on to say CRS is usually much lower, but doesn't specify an
> upper bound either.
> 

I see, we got caught on spec language where we don't know what 'its' is. 

Bjorn,

Since there is no upper cap on how long, what is your preference (stick to 60),
give incremental warning updates every 5 seconds?

I can certainly rewrite the commit message.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
