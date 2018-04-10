Return-Path: <SRS0=S5rd=G7=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=S5rd=G7=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, sulrich@codeaurora.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
 <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
 <20180410195008.GE54986@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1c94361d-7a8d-ad18-12e5-1612326a54db@codeaurora.org>
Date: Tue, 10 Apr 2018 16:18:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180410195008.GE54986@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/10/2018 3:50 PM, Bjorn Helgaas wrote:
> On Tue, Apr 10, 2018 at 02:41:44PM -0500, Bjorn Helgaas wrote:
>> On Wed, Apr 04, 2018 at 06:50:09PM -0400, Sinan Kaya wrote:
>>> Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
>>> unless its Extended Tag Field Enable is set, but all Receivers/Completers
>>> must handle 8-bit Tags correctly regardless of their Extended Tag Field
>>> Enable.
>>>
>>> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
>>> them.  If we find such a device, we disable Extended Tags for the entire
>>> hierarchy to make peer-to-peer DMA possible.
>>>
>>> The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
>>> tags.  Mark it as broken.
>>>
>>> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Applied to pci/enumeration for v4.18, thanks!
> Actually, this is a really annoying issue and I think the fix is
> appropriate for v4.17, so I moved it to my for-linus branch.
> 

I agree. It causes boot issues on some AMD Opteron machines. It should
probably be back-ported too. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
