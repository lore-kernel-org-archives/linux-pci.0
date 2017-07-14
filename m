Return-Path: <SRS0=UZLv=6R=huawei.com=dingtianhong@kernel.org>
Return-Path: <SRS0=UZLv=6R=huawei.com=dingtianhong@kernel.org>
Subject: Re: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
To: Casey Leedom <leedom@chelsio.com>,
        Alexander Duyck
	<alexander.duyck@gmail.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>
 <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
 <MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
CC: Ashok Raj <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michael Werner <werner@chelsio.com>, Ganesh GR <ganeshgr@chelsio.com>,
        Asit K Mallick <asit.k.mallick@intel.com>,
        Patrick J Cramer <patrick.j.cramer@intel.com>,
        Suravee Suthikulpanit
	<Suravee.Suthikulpanit@amd.com>,
        Bob Shaw <Bob.Shaw@amd.com>, h
	<l.stach@pengutronix.de>,
        Amir Ancel <amira@mellanox.com>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        David Laight <David.Laight@aculab.com>,
        "Jeff
 Kirsher" <jeffrey.t.kirsher@intel.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Miller
	<davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LinuxArm
	<linuxarm@huawei.com>
From: Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <d36574a1-2853-6989-25ae-5fd1b0d811ba@huawei.com>
Date: Fri, 14 Jul 2017 18:23:51 +0800
MIME-Version: 1.0
In-Reply-To: <MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Casey, Alexander:

Thanks for the great efforts from both of you, It looks like we have reached a consensus finally,
could you please add a confirmation message just like Reviewed-by or something else, thanks. :)

Ding

On 2017/7/14 2:44, Casey Leedom wrote:
>   Yeah, I think this works for now.  We'll stumble over what to do when we want to mix upstream TLPs without Relaxed Ordering Attributes directed at problematic Root Complexes, and Peer-to-Peer TLPs with Relaxed Ordering Attributes ... or vice versa depending on which target PCIe Device has issues with Relaxed Ordering.
> 
> 
>   Thanks for all the work!
> 
> 
> Casey
> 
> 
