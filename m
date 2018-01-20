Return-Path: <SRS0=HSSc=EP=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=HSSc=EP=codeaurora.org=okaya@kernel.org>
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6f5ec91e-01db-5bd7-6d3f-0128604dc775@codeaurora.org>
Date: Sat, 20 Jan 2018 14:29:17 -0500
MIME-Version: 1.0
In-Reply-To: <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/20/2018 2:20 PM, Sinan Kaya wrote:
>> In this case, the function *could* receive a Memory Write Request with
>> a 1024-byte data payload.  CPUs normally write at most a cacheline,
>> which is probably smaller than 1024 bytes, so these large writes would
>> most likely be peer-to-peer DMA writes.
> Why do you think that CPU is involved in fetching a memory read response
> to a read request?

Never mind. I realized you started talking about Memory Writes after the
completions in the above paragraph now. Another source for memory write could
be an SOC internal DMA memcpy engine as well as a peer-to-peer access.

> 
> If an endpoint tries to read 4k from system memory, this would be typically
> done by SOC internal fabric not by the CPU. How fast a fabric can feed 1k
> to the endpoint depends on the capability of the fabric. Some fabric might
> do better with 1k, others could be better with 256 bytes.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
