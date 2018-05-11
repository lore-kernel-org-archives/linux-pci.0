Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbeEKTjZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 May 2018 15:39:25 -0400
Date: Fri, 11 May 2018 14:39:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Aron Griffis <aron@arongriffis.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: PCIe unsupported request with Intel 760p
Message-ID: <20180511193923.GJ190385@bhelgaas-glaptop.roam.corp.google.com>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
 <20180507134354.GF18116@bombadil.infradead.org>
 <20180507151246.GB20686@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180507151246.GB20686@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 07, 2018 at 09:12:47AM -0600, Keith Busch wrote:
> On Mon, May 07, 2018 at 06:43:54AM -0700, Matthew Wilcox wrote:
> > On Mon, May 07, 2018 at 08:30:35AM -0400, Aron Griffis wrote:
> > > I'm getting this error continuously with an Intel 760p on 4.16.5 (Fedora 28)
> > > 
> > > pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: id=00e8
> > > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=00e8(Requester ID)
> > > pcieport 0000:00:1d.0:   device [8086:a298] error status/mask=00100000/00010000
> > > pcieport 0000:00:1d.0:    [20] Unsupported Request    (First)
> > > pcieport 0000:00:1d.0:   TLP Header: 34000000 70000010 00000000 88468846
> > > pcieport 0000:00:1d.0: broadcast error_detected message
> > > pcieport 0000:00:1d.0: broadcast mmio_enabled message
> > > pcieport 0000:00:1d.0: broadcast resume message
> > > pcieport 0000:00:1d.0: AER: Device recovery successful
> > > 
> > > Willy graciously decoded this for me to a "Latency Tolerance Reporting
> > > Message," and suggested I send email to this list to check whether it's a
> > > problem with the device or driver.
> > 
> > Decoding this further, the Requester ID is 70:00.0 (ie the NVMe device is
> > sending the LTR message) so the Root Port is the one saying "Unsupported
> > Request".  Which is fair enough, because ...
> > 
> > > 00:1d.0 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #9 (rev f0) (prog-if 00 [Normal decode])
> > > 	Bus: primary=00, secondary=70, subordinate=70, sec-latency=0
> > > 		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
> > > 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> > > 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
> > > 			 AtomicOpsCtl: ReqEn- EgressBlck-
> > 
> > the Root Port doesn't know what LTR is.
> > 
> > > 70:00.0 Non-Volatile memory controller: Intel Corporation Device f1a6 (rev 03) (prog-if 02 [NVM Express])
> > > 	Capabilities: [70] Express (v2) Endpoint, MSI 00
> > > 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
> > > 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> > > 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
> > > 			 AtomicOpsCtl: ReqEn-
> > 
> > The device *does* know what LTR is, but it's supposed to be disabled.
> > 
> > Is there more recent firmware for this device?
> 
> Hi Willy,
> 
> Thank you for the detailed analysis. :)
> 
> I'm not familiar with this device, but I'll check internally to see if
> this a later firmware release address this.

Any update on this?  I'm pretty concerned about this issue because it
*looks* like we're not doing anything that should cause this problem,
and I don't know what we *could* do to avoid it.

The theory is that the Intel 760p NVMe is sending LTR messages even
though it's configured to *not* send them.  It happens that Aron's
system has a root port that doesn't support LTR, and it complains when
it sees the messages.

Anybody who has the Intel 760p NVMe should be able to reproduce this.
If the root port leading to the NVMe doesn't support LTR (its DevCap2
would say "LTR-"), the same problem should occur.

If your root port *does* support LTR, you might be able to force this
to happen by booting with "pcie_aspm=off" and then running this
command where "bb:dd.f" is the bus/domain/function of the root port:

  # setpci -sbb:dd.f CAP_EXP+0x28.W=0:0x400

But I tried this on a root port leading to a different (non-NVMe)
device with LTR enabled, and I didn't see any AER complaints about
unexpected LTR messages, so maybe there's something I'm missing.

(BTW, thanks for the really cool setpci syntax, Keith!  I didn't know
it could do the masked read/modify/write thing.)
