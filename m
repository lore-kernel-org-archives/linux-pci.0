Return-Path: <SRS0=wG18=ER=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=wG18=ER=codeaurora.org=okaya@kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ron Yuan <ron.yuan@memblaze.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Bo Chen <bo.chen@memblaze.com>, William Huang <william.huang@memblaze.com>,
 Fengming Wu <fengming.wu@memblaze.com>,
 Jason Jiang <jason.jiang@microsemi.com>,
 Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
 Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
 William Cheng <william.cheng@microsemi.com>,
 "Kim Helper (khelper)" <khelper@micron.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <SH2PR01MB106A1E21DEB5FE3FFB3D61C83E90@SH2PR01MB106.CHNPR01.prod.partner.outlook.cn>
 <ef16a3cc-b641-a30d-644a-7940e340eb3e@codeaurora.org>
 <SHAPR01MB173A5EA1677C2138CB528F2FEE90@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <5727b0b1-f0d5-7c78-373e-fc9d1bd662d2@codeaurora.org>
 <CABhMZUU0643U-qVc9ymA+1PMZToSLFm2dg8-cu=iQ2LGw2Pi8Q@mail.gmail.com>
 <SHAPR01MB173A36104635A8BFF9A83E1FEE80@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
 <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
Date: Mon, 22 Jan 2018 17:04:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/22/2018 4:36 PM, Bjorn Helgaas wrote:
>>> That leaves Completions.  We limit the size of Completions by limiting
>>> MRRS.  If we set the endpoint's MRRS to its MPS (128 in this case), it
>>> will never request more than MPS bytes at a time, so it will never
>>> receive a Completion with more than MPS bytes.
>>>
>>> Therefore, we may be able to configure other devices in the fabric
>>> with MPS larger than 128, which may benefit those devices.

> Help me understand exactly what is problematic.  No matter what your
> read/write mix is, a single device in isolation should get the best
> performance with both MPS and MRRS at the highest possible settings.

The performance approach is trying to maximize MPS while reducing MRRS
value to MPS value. Meaning improving write performance while trading
off read performance.

> 
> Reducing MPS may be necessary if there are several devices in the
> hierarchy and one requires a smaller MPS than the others.  That
> obviously reduces the maximum read and write performance.
> 
> Reducing the MRRS may be useful to prevent one device from hogging a
> link, but of course, it reduces read performance for that device
> because we need more read requests.
> 

Maybe, a picture could help.

			root (MPS=256)
			 |
		 ------------------
		/		   \
	   bridge0 (MPS=256)      bridge1 (MPS=128)
	    /				\
	   EP0 (MPS=256)		EP1 (MPS=128)

If I understood this right, code allows the configuration above with
the performance mode so that MPS doesn't have to be uniform across
the tree. 

It just needs to be consistent between the root port and endpoints.

Why are we reducing MRRS in this case?

Are we assuming that root bus cannot handle more than 256 bytes and bridge1
would be starved while root bus is passing the completions to bridge0?

If yes, the answer to the assumption depends on the architecture. One silicon
could serve any completions in any speed. 

It depends on how root bus was implemented. If it is a real one or an emulated one.
I think most silicon emulate root bus.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
