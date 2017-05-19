Return-Path: <SRS0=0SQO=4Z=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=0SQO=4Z=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170517171154.GF31462@bhelgaas-glaptop.roam.corp.google.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
 <1494912127-12890-3-git-send-email-oza.oza@broadcom.com> <20170517171154.GF31462@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Fri, 19 May 2017 06:51:28 +0530
Message-ID: <CAMSpPPfnhSb3w4te=k5aHGoC6wgn0iu7EAvc5gxwxGnNe4JehQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] iommu/pci: reserve IOVA for PCI masters
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 17, 2017 at 10:41 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, May 16, 2017 at 10:52:06AM +0530, Oza Pawandeep wrote:
>> this patch reserves the IOVA for PCI masters.
>> ARM64 based SOCs may have scattered memory banks.
>> such as iproc based SOC has
>>
>> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
>> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
>> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
>>
>> but incoming PCI transcation addressing capability is limited
>
> s/transcation/transaction/
>
>> by host bridge, for example if max incoming window capability
>> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
>>
>> to address this problem, iommu has to avoid allocating IOVA which
>
> s/iommu/IOMMU/
>
>> are reserved. which inturn does not allocate IOVA if it falls into hole.
>
> s/inturn/in turn/

Hi Bjorn,

Thank you for the comments.
Will take care of all your comments.

Regards,
Oza.
