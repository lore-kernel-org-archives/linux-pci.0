Return-Path: <SRS0=1PPZ=HA=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=1PPZ=HA=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 11 Apr 2018 16:08:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	sulrich@codeaurora.org, timur@codeaurora.org,
	linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
Message-ID: <20180411140849.GA12557@kroah.com>
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
 <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
 <20180410195008.GE54986@bhelgaas-glaptop.roam.corp.google.com>
 <1c94361d-7a8d-ad18-12e5-1612326a54db@codeaurora.org>
 <20180411135151.GB91792@bhelgaas-glaptop.roam.corp.google.com>
 <ecdad8f4-6996-cfe0-d005-fbc67ba3cd79@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ecdad8f4-6996-cfe0-d005-fbc67ba3cd79@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:02:07AM -0400, Sinan Kaya wrote:
> +GregKH

Why?

> On 4/11/2018 9:51 AM, Bjorn Helgaas wrote:
> > On Tue, Apr 10, 2018 at 04:18:01PM -0400, Sinan Kaya wrote:
> >> On 4/10/2018 3:50 PM, Bjorn Helgaas wrote:
> >>> On Tue, Apr 10, 2018 at 02:41:44PM -0500, Bjorn Helgaas wrote:
> >>>> On Wed, Apr 04, 2018 at 06:50:09PM -0400, Sinan Kaya wrote:
> >>>>> Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
> >>>>> unless its Extended Tag Field Enable is set, but all Receivers/Completers
> >>>>> must handle 8-bit Tags correctly regardless of their Extended Tag Field
> >>>>> Enable.
> >>>>>
> >>>>> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
> >>>>> them.  If we find such a device, we disable Extended Tags for the entire
> >>>>> hierarchy to make peer-to-peer DMA possible.
> >>>>>
> >>>>> The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
> >>>>> tags.  Mark it as broken.
> >>>>>
> >>>>> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> >>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
> >>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >>>> Applied to pci/enumeration for v4.18, thanks!
> >>> Actually, this is a really annoying issue and I think the fix is
> >>> appropriate for v4.17, so I moved it to my for-linus branch.
> >>>
> >>
> >> I agree. It causes boot issues on some AMD Opteron machines. It should
> >> probably be back-ported too. 
> > 
> > We started enabling extended tags with 60db3a4d8cc9 ("PCI: Enable PCIe
> > Extended Tags if supported"), which appeared in v4.11.
> > 
> > So I added these stable tags:
> > 
> >   CC: stable@vger.kernel.org      # v4.11: 62ce94a7a5a5 PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
> >   CC: stable@vger.kernel.org      # v4.11
> > 
> > I'm not sure I'm using the stable request correctly, but my intent is:
> > 
> >   - 62ce94a7a5a5 appeared in v4.14, so cherry-pick 62ce94a7a5a5 to
> >     v4.11 through v4.13
> >   - cherry-pick *this* patch on top of 62ce94a7a5a5 to v4.11 and later

Bjorn is correct here, why are you dragging me into this?

greg k-h
