Return-Path: <SRS0=XC36=66=huawei.com=dingtianhong@kernel.org>
Return-Path: <SRS0=XC36=66=huawei.com=dingtianhong@kernel.org>
Subject: Re: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
To: Casey Leedom <leedom@chelsio.com>,
        Alex Williamson
	<alex.williamson@redhat.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
CC: Sinan Kaya <okaya@codeaurora.org>,
        "ashok.raj@intel.com"
	<ashok.raj@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        Michael Werner
	<werner@chelsio.com>, Ganesh GR <ganeshgr@chelsio.com>,
        "asit.k.mallick@intel.com" <asit.k.mallick@intel.com>,
        "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
        "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>,
        "amira@mellanox.com" <amira@mellanox.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com"
	<will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "alexander.duyck@gmail.com"
	<alexander.duyck@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
From: Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <75213fca-4522-2297-3cb8-338e643d3552@huawei.com>
Date: Thu, 27 Jul 2017 09:08:20 +0800
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>



On 2017/7/27 2:26, Casey Leedom wrote:
>   By the way Ding, two issues:
> 
>  1. Did we ever get any acknowledgement from either Intel or AMD
>     on this patch?  I know that we can't ensure that, but it sure would
>     be nice since the PCI Quirks that we're putting in affect their
>     products.
> 

Still no Intel and AMD guys has ack this, this is what I am worried about, should I
ping some man again ?

Thanks
Ding
> 
> Casey
> .
> 
