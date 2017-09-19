Return-Path: <SRS0=V6ft=AU=intel.com=alexander.shishkin@kernel.org>
Return-Path: <SRS0=V6ft=AU=intel.com=alexander.shishkin@kernel.org>
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
In-Reply-To: <20170919165842.GA22312@bhelgaas-glaptop.roam.corp.google.com>
References: <20170919145136.13527-1-alexander.shishkin@linux.intel.com> <20170919165842.GA22312@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 19 Sep 2017 20:27:08 +0300
Message-ID: <87vaketx8z.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> Hi Alexander,

Hi Bjorn,

> On Tue, Sep 19, 2017 at 05:51:36PM +0300, Alexander Shishkin wrote:
>> On some intergrations of the Intel TH the reported size of RTIT_BAR
>
> s/intergrations/integrations/

Oops.

> What is "TH"?  If there's a public spec for it, can you include a
> reference here?

Intel Trace Hub,
https://software.intel.com/sites/default/files/managed/d3/3c/intel-th-developer-manual.pdf

There's an overview at Documentation/trace/intel_th.txt.

> I guess this is an erratum, since the device responds to more MMIO
> space than it advertises via the BAR.  Can you include a reference to
> the published erratum?

There's no erratum at the moment, unfortunately.

>> doesn't match its actual size, which leads to overlaps with other
>> devices' resources.
>
> So I suppose the BIOS relies on the size advertised via the BAR,
> assigns it to be just below the XHCI space, and now both the TH and
> XHCI respond there?  I assume this causes some sort of "unexpected
> response" error?  Is there a bug report about this?  What does it look
> like when a user hits this?  I'm trying to make this fix discoverable
> to users who might trip over the problem.

When the intel_th pci device gets enabled (on modprobe, for example),
XHCI starts seeing 0xffffffff in its MMIO registers, which makes it go

xhci_hcd: xHCI host controller not responding, assume dead
xhci_hcd: xHC not responding in xhci_irq, assume controller is dead
xhci_hcd: HC died; cleaning up

followed by disappearance of keyboards and user's profound confusion.
I'll make sure to mention all this in the commit message.

>> For this reason, we need to resize the RTIT_BAR on Denverton where
>> it would overlap with XHCI MMIO space.
>> 
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Fixes: 5118ccd347 ("intel_th: pci: Add Denverton SOC support")
>
> Please use a 12-char SHA1.

Will do.

>> Cc: stable@vger.kernel.org
>
> I guess this is only applicable to v4.11+, since 5118ccd34780 appeared in
> v4.11-rc4?

Right, my git-send-email keeps trying to CC "# v4.11+" if I leave it in the
Cc: stable line.

Regards,
--
Alex
