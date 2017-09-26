Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Workaround wrong flags completions for IDT switch
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <59C02719.5050103@oracle.com>
 <9741d204-1dd6-2cc2-c133-2ef49c8a404b@codeaurora.org>
 <59CAB001.10207@oracle.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7084085b-89e7-80fa-d10b-06f121eb57be@codeaurora.org>
Date: Tue, 26 Sep 2017 16:03:13 -0400
MIME-Version: 1.0
In-Reply-To: <59CAB001.10207@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/26/2017 3:52 PM, James Puthukattukaran wrote:
>> I think you want to do the part above as part of a quirk that runs before
>> the probe.
> 
> I don't think there's a way to run this early enough?

Bjorn?

I have seen multiple quirk types in quirks.c some prefixed with EARLY and other
LATE.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
