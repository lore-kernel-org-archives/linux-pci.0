Return-Path: <ashutosh.dixit@intel.com>
Return-Path: <ashutosh.dixit@intel.com>
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Marciniszyn\, Mike" <mike.marciniszyn@intel.com>,  "Dalessandro\, Dennis" <dennis.dalessandro@intel.com>,  Doug Ledford <dledford@redhat.com>,  "Hefty\, Sean" <sean.hefty@intel.com>,  Hal Rosenstock <hal.rosenstock@gmail.com>,  "linux-rdma\@vger.kernel.org" <linux-rdma@vger.kernel.org>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: hfi1 use of PCI internals
References: <20160616162052.GA2144@localhost>
Date: Thu, 16 Jun 2016 14:48:30 -0400
In-Reply-To: <20160616162052.GA2144@localhost> (Bjorn Helgaas's message of
	"Thu, 16 Jun 2016 10:20:52 -0600")
Message-ID: <tnm1toa71hsw1.fsf@phwtpriv05.ph.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 16 2016 at 12:20:52 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> I noticed drivers/infiniband/hw/hfi1 got moved from staging to
> drivers/ for v4.7.  It does a bunch of grubbing around in PCIe ASPM
> configuration, e.g., see drivers/infiniband/hw/hfi1/aspm.h.
>
> I know there have been lots of ASPM issues, both hardware problems and
> Linux kernel problems, but it is *supposed* to be manageable by the
> core, without special driver support.  What's the justification for
> having to do this in the hfi1 driver?

The description for commit affa48de84 "staging/rdma/hfi1: Add support
for enabling/disabling PCIe ASPM" anticipates this question and
describes why this was done in the hfi1 driver:

    Finally, the kernel ASPM API is not used in this patch. This is
    because this patch does several non-standard things as SW
    workarounds for HW issues. As mentioned above, it enables ASPM even
    when advertised actual latencies are greater than acceptable
    latencies. Also, whereas the kernel API only allows drivers to
    disable ASPM from driver probe, this patch enables/disables ASPM
    directly from interrupt context. Due to these reasons the kernel
    ASPM API was not used.
