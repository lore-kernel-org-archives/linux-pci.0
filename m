Return-Path: <SRS0=0995=HG=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=0995=HG=codeaurora.org=okaya@kernel.org>
Subject: Re: RFC on MCFG Table Support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <bd3f4d3a-f641-7385-4ce2-d62a28bc9cd3@codeaurora.org>
 <20180417200441.GL28657@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <22609a39-d701-9b36-f99f-0334aee88c6a@codeaurora.org>
Date: Tue, 17 Apr 2018 16:09:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180417200441.GL28657@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/17/2018 4:04 PM, Bjorn Helgaas wrote:
>> We are trying to remove this restriction in the spec and have
>> multiple entries per segment as long as <segment, bus start number,
>> bus end number> tuple is unique. 
> I hope you mean the <start, end> tuples are more than just unique;
> they shouldn't overlap, i.e., a given <segment, bus number> should
> match at most one MCFG entry.

Agreed, I'm talking about no overlap. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
