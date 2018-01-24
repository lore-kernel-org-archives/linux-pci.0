Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964826AbeAXSBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jan 2018 13:01:23 -0500
Date: Wed, 24 Jan 2018 12:01:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>
Cc: Ron Yuan <ron.yuan@memblaze.com>,
        Sinan Kaya <okaya@codeaurora.org>,
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
Message-ID: <20180124180118.GJ5317@bhelgaas-glaptop.roam.corp.google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 11:50:30PM +0000, Radjendirane Codandaramane wrote:
> Hi Bjorne,

s/Bjorne/Bjorn/

Also, the convention on Linux mailing lists is to use interleaved
reply style [1] because it makes it easier to follow the conversation.

> Ceiling the MRRS to the MPS value in order to guarantee the
> interoperability in pcie_bus_perf mode does not make sense.

I disagree with this part.  The Linux pcie_bus_perf mode isn't my
favorite approach, but given the assumptions it makes, it does make
sense.  I laid out the explanation in [2]; if you disagree with
something there, please be specific about what's wrong.

> A device can make a memrd request according to the MRRS setting
> (which can be higher than its MPS), but the completer has to respect
> the MPS and send completions accordingly. As an example, system can
> configure MPS=128B and MRRS=4K, where an endpoint can a make 4K
> MemRd request, but the completer has to send completions as 128B
> TLPs, by respecting the MPS setting. MRRS does not force a device to
> use higher MPS value than it is configured to.

This part is certainly true.  I used a very similar example in [2]:

  Consider the case where a function has MPS=256 and MRRS=1024: if the
  function generates a 1024-byte read request, it should receive 4
  completions, each with a 256-byte data payload.

> Another factor that need to be considered for storage devices is
> that support of T10 Protection Information (DIF). For every 512B or
> 4KB, a 8B PI is computed and inserted or verified, which require the
> 512B of data to arrive in sequence. 

MPS and MRRS are parts of the PCIe TLP protocol.  I'm not aware of any
connection between the PCIe protocol and the T10 Protection
Information/DIF stuff.  I assume the T10/DIF stuff is content being
carried by PCIe, and PCIe doesn't care at all about the content it
carries.  Can you clarify what the connection is here?

> If the MRRS is < 512B, this might pose out of order completions to
> the storage device, if the EP has to submit multiple outstanding
> read requests in order to achieve higher performance. 

If I understand correctly, this is exactly the situation described in
the implementation note in PCIe r4.0, sec 2.4.1: completions for a
single memory read request are always returned in order (Table 2-39,
entry D5b), but completions for multiple read requests may be returned
in any order because completions may pass each other (entry D5a).  The
note doesn't mention this, but I think even the multiple outstanding
read requests themselves can pass each other (entry B3).

So I agree that if the function generates multiple outstanding read
requests, the completions for those requests may come back out of
order.  For example, if the function generates req-A and req-B,
completions for req-A will be in order and completions for req-B will
be in order, but it might receive cmpl-B1, cmpl-A1, cmpl-B2, cmpl-B3,
cmpl-A2, cmpl-A3, cmpl-A4, cmpl-B4.

This reordering may happen no matter what the MRRS setting is.  The
only way to avoid it is to avoid multiple outstanding read requests.

> This would be a challenge for the storage endpoints that process the
> T10 PI inline with the transfer, now they have to store and process
> the 512B sectors once they receive all the TLPs for that sector.

Are you saying these endpoints depend on MRRS >= 512 for correct
operation?

I don't think think that would be legal, per sec 7.5.3.4, which says
"the Function must not generate Read Requests with a size exceeding
the set [MRRS] value."  That doesn't leave the function any wiggle
room -- if the OS programs MRRS=128, the function has to deal with it.
There's no provision for the function to say "I can only support
MRRS > X".

But you probably mean the endpoints will function correctly even with
MRRS=128, but performance will be poor.  That's certainly a concern
for all devices; reducing MRRS increases overhead, so we should use
the largest possible MRRS, subject to the constraints of any MPS/MRRS
design (like pcie_bus_perf) and concerns about bandwidth allocation
(see the implementation note in sec 7.5.3.4).

> So, it is better to decouple the MRRS and MPS in pcie_bus_perf mode.
> Like stated earlier in the thread, provide an option to configure
> MRRS separately in pcie_bus_perf mode.

If you read [2] again, it will be obvious why the Linux pcie_bus_perf
mode requires the use of MRRS in addition to MPS.  At the very end of
that email and in [3], I pointed out that the current Linux
implementation is unnecessarily conservative in some cases, and there
is room for fixing that, which should improve performance in some
cases.  But given the design of pcie_bus_perf, it's impossible to
completely decouple MRRS and MPS in that mode.

[1] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
[2] https://lkml.kernel.org/r/20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com
[3] https://lkml.kernel.org/r/20180123174821.GF5317@bhelgaas-glaptop.roam.corp.google.com
