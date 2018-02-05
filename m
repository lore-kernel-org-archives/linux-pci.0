Return-Path: <SRS0=Fog0=E7=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Fog0=E7=codeaurora.org=okaya@kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Myron Stowe <myron.stowe@gmail.com>, Ron Yuan <ron.yuan@memblaze.com>,
 Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Bo Chen <bo.chen@memblaze.com>,
 William Huang <william.huang@memblaze.com>,
 Fengming Wu <fengming.wu@memblaze.com>,
 Jason Jiang <jason.jiang@microsemi.com>,
 Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
 William Cheng <william.cheng@microsemi.com>,
 "Kim Helper (khelper)" <khelper@micron.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
 <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org>
 <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com>
 <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com>
 <20180124180118.GJ5317@bhelgaas-glaptop.roam.corp.google.com>
 <SHAPR01MB173F9910CA9B2651104E319FEFB0@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <CAL-B5D3rbY57UNANUcuguHy1X4CzhCSpGk0i9i-13RHEo9NQ6Q@mail.gmail.com>
 <0c036431-ff08-693b-e406-34e42582c2f3@codeaurora.org>
 <20180201033753.GA98500@bhelgaas-glaptop.roam.corp.google.com>
 <31eecdff-68e7-4891-5034-9a387e79a97b@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <7ae35971-1e85-c3ca-9fbf-6c2ab5883313@codeaurora.org>
Date: Sun, 4 Feb 2018 20:02:03 -0500
MIME-Version: 1.0
In-Reply-To: <31eecdff-68e7-4891-5034-9a387e79a97b@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 2/1/2018 10:14 AM, Sinan Kaya wrote:
> I think from above examples:
> 1. perf mode is moving devices to 256 MPS as it can.
> 2. safe mode is setting to 128 MPS
> 3. perf mode set MRRS=MPS is a CORRECT call for device with MPSC lower than its parents.

Thinking more about this...

The only way for a transaction of size that's greater than MRRS can happen if there
is a device specific driver attached that sends commands to the device and device issues
a large sized memory read transaction.

Let's say that we find the slow device in tree.

If no driver is attached to a slow device in the tree and assume it is safe and do not
reduce MRRS?

> 4. perf mode set MRRS=MPS is not necessary for a device with SAME MPSC as its parents?
> 5. it is an interested point to me that slot/switch/root MRRS are always set to 128B, I have not found out why.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
