Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeBADiA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jan 2018 22:38:00 -0500
Date: Wed, 31 Jan 2018 21:37:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Myron Stowe <myron.stowe@gmail.com>,
        Ron Yuan <ron.yuan@memblaze.com>,
        Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bo Chen <bo.chen@memblaze.com>,
        William Huang <william.huang@memblaze.com>,
        Fengming Wu <fengming.wu@memblaze.com>,
        Jason Jiang <jason.jiang@microsemi.com>,
        Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
        William Cheng <william.cheng@microsemi.com>,
        "Kim Helper (khelper)" <khelper@micron.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
Message-ID: <20180201033753.GA98500@bhelgaas-glaptop.roam.corp.google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0c036431-ff08-693b-e406-34e42582c2f3@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 07:13:56PM -0500, Sinan Kaya wrote:
> On 1/31/2018 7:01 PM, Myron Stowe wrote:
> >> I think from above examples:
> >> 1. perf mode is moving devices to 256 MPS as it can.
> >> 2. safe mode is setting to 128 MPS
> >> 3. perf mode set MRRS=MPS is a CORRECT call for device with MPSC lower than its parents.
> >> 4. perf mode set MRRS=MPS is not necessary for a device with SAME MPSC as its parents?
> >> 5. it is an interested point to me that slot/switch/root MRRS are always set to 128B, I have not found out why.

> > In Sinan's original posting, a reference to
> > https://www.xilinx.com/support/documentation/white_papers/wp350.pdf
> > was provided.  When I read that paper and got to the "Read
> > Completion Boundary" section I thought to myself: "If RCB can only
> > be 64 or 128 bytes then what's the point of MPS (or MRRS) as all
> > TLP completions would be limited to 64 or 128 bytes? (see also the
> > paper's 'Read Completions with the RCB Set to 64 Bytes' figure)".
> > I brought this up to a colleague and they surmised that possibly
> > only _lower end_ (a.k.a. lazy) chipset implementations would truly
> > have RCB limited sized completions; higher end chipsets would of
> > course have to comply with RCB when communicating with the memory
> > controller but could then aggregate data into larger MPS (or MRRS)
> > sized TLP completion packets.  Perhaps this might explain why you
> > always saw slot/switch/root values set at 128B?
> 
> I have looked at that paper before. It is plain wrong. Read
> Completion Boundary is about the alignment of addresses that an
> endpoint is sending in memory read packets according to the spec. It
> has nothing to do with the packet size.

I hope this isn't being too pedantic, but I think RCB applies to the
*completer*, not the requester.  Typically an endpoint generates a
memory read and a root port supplies data to complete it.

I didn't see anything in the "Read Completion Boundary" section of the
paper that I thought *contradicted* the spec.  I did think this was
speculation:

  Typically, most root complexes set the RCB at 64 bytes and return
  data in 64-byte completions instead of what might be allowed by the
  MPS.

That would be legal per spec, but I don't have direct knowledge of
whether root complexes actually do that.  I tend to doubt it because
it seems like people do observe performance differences based on the
MPS setting.

I agree that the "Read Transaction Throughput" section is inaccurate
when it says:

  The size of the completion is determined by a completer's read
  completion boundary.

RCB may limit the size of the first completion to less than MPS, but
subsequent completions (except the final one) only need to be a
multiple of RCB.

RCB determines the boundaries at which a completer is allowed to end a
TLP (PCIe r4.0, sec 2.3.1.1 has the rules).  Let's work through an
example:

  MPS=128
  RCB=64

  Endpoint generates a 256-byte read request for addresses 0x2-0x101

In the absence of RCB, a root port could satisfy this request with two
completions:

  completion 0: bytes   0x2- 0x81  (128 bytes)  <-- illegal
  completion 0: bytes  0x82-0x101  (128 bytes)

But with RCB, the first completion is illegal because it doesn't
satisfy the entire request and it doesn't end on a multiple of RCB.
Because of RCB the completer must respond with at least three
completions.  The best it can do is this:

  completion 0: bytes   0x2- 0x7f  (126 bytes)
  completion 1: bytes  0x80- 0xff  (128 bytes)
  completion 2: bytes 0x100-0x101  (2 bytes)

It is *allowed* but not required to respond with more completions,
e.g.,

  completion 0: bytes   0x2- 0x3f  (62 bytes)
  completion 1: bytes  0x40- 0x7f  (64 bytes)
  completion 2: bytes  0x80- 0xbf  (64 bytes)
  completion 3: bytes  0xc0- 0xff  (64 bytes)
  completion 4: bytes 0x100-0x101  (2 bytes)
