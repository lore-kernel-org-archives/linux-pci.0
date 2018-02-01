Return-Path: <SRS0=Qzba=E3=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Qzba=E3=codeaurora.org=okaya@kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Myron Stowe <myron.stowe@gmail.com>, Ron Yuan <ron.yuan@memblaze.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Bo Chen <bo.chen@memblaze.com>,
 William Huang <william.huang@memblaze.com>,
 Fengming Wu <fengming.wu@memblaze.com>,
 Jason Jiang <jason.jiang@microsemi.com>,
 Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
 William Cheng <william.cheng@microsemi.com>,
 "Kim Helper (khelper)" <khelper@micron.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
 <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
 <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org>
 <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com>
 <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com>
 <20180124180118.GJ5317@bhelgaas-glaptop.roam.corp.google.com>
 <SHAPR01MB173F9910CA9B2651104E319FEFB0@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <CAL-B5D3rbY57UNANUcuguHy1X4CzhCSpGk0i9i-13RHEo9NQ6Q@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0c036431-ff08-693b-e406-34e42582c2f3@codeaurora.org>
Date: Wed, 31 Jan 2018 19:13:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAL-B5D3rbY57UNANUcuguHy1X4CzhCSpGk0i9i-13RHEo9NQ6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/31/2018 7:01 PM, Myron Stowe wrote:
>> I think from above examples:
>> 1. perf mode is moving devices to 256 MPS as it can.
>> 2. safe mode is setting to 128 MPS
>> 3. perf mode set MRRS=MPS is a CORRECT call for device with MPSC lower than its parents.
>> 4. perf mode set MRRS=MPS is not necessary for a device with SAME MPSC as its parents?
>> 5. it is an interested point to me that slot/switch/root MRRS are always set to 128B, I have not found out why.
> In Sinan's original posting, a reference to
> https://www.xilinx.com/support/documentation/white_papers/wp350.pdf
> was provided.  When I read that paper and got to the "Read Completion
> Boundary" section I thought to myself: "If RCB can only be 64 or 128
> bytes then what's the point of MPS (or MRRS) as all TLP completions
> would be limited to 64 or 128 bytes? (see also the paper's 'Read
> Completions with the RCB Set to 64 Bytes' figure)".  I brought this up
> to a colleague and they surmised that possibly only _lower end_
> (a.k.a. lazy) chipset implementations would truly have RCB limited
> sized completions; higher end chipsets would of course have to comply
> with RCB when communicating with the memory controller but could then
> aggregate data into larger MPS (or MRRS) sized TLP completion packets.
> Perhaps this might explain why you always saw slot/switch/root values
> set at 128B?
> 

I have looked at that paper before. It is plain wrong. Read Completion
Boundary is about the alignment of addresses that an endpoint is sending
in memory read packets according to the spec. It has nothing to do with
the packet size.

The limitation on MRRS could be that device (switch) doesn't support it.
A device is allowed to reject an MRRS set value.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
