Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNLcj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jun 2017 07:32:39 -0400
Date: Wed, 14 Jun 2017 06:32:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: Workaround wrong flags completions for IDT switch
Message-ID: <20170614113235.GA13481@bhelgaas-glaptop.roam.corp.google.com>
References: <20170609231617.20243-1-yinghai@kernel.org>
 <20170612214848.GC28578@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQU_Hfsn-_tJSQ2NbqMV-rtaiFsX1FWfe_fADbd8TnKhBA@mail.gmail.com>
 <8e04aa73-8fe0-d1ac-208b-3f8fa4b04c4b@oracle.com>
 <20170613221451.GC7012@bhelgaas-glaptop.roam.corp.google.com>
 <4E27D271-80C3-4EED-860C-936AC1CCCD2F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4E27D271-80C3-4EED-860C-936AC1CCCD2F@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 07:19:57PM -0400, James Puthukattukaran wrote:
> > On Jun 13, 2017, at 6:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> On Tue, Jun 13, 2017 at 02:30:55PM -0400, james puthukattukaran wrote:
> >>> On 6/13/2017 1:00 PM, Yinghai Lu wrote:
> >>>> On Mon, Jun 12, 2017 at 2:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>> On Fri, Jun 09, 2017 at 04:16:17PM -0700, Yinghai Lu wrote:
> >>>>> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
> >>>>> 
> >>>>> The IDT switch incorrectly flags an ACS source violation on a read config
> >>>>> request to an end point device on the completion (IDT 89H32H8G3-YC,
> >>>>> errata #36) even though the PCI Express spec states that completions are
> >>>>> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).
> >>>> Can you include a URL where this erratum is published?  If not, can
> >>>> you include the actual erratum text here?
> >> 
> >> Here's the errata text
> >> ------------------------------------
> >> Item #36 - Downstream port applies ACS Source Validation to
> >> Completions “Section 6.12.1.1" of the PCI Express Base
> >> Specification 3.1 states that completions are never affected by
> >> ACS Source Validation. However, completions received by a
> >> downstream port of the PCIe switch from a device that has not yet
> >> captured a PCIe bus number are incorrectly dropped by ACS source
> >> validation by the switch downstream port.
> >> 
> >> Workaround: Issue a CfgWr1 to the downstream device before
> >> issuing the first CfgRd1 to the device.  This allows the
> >> downstream device to capture its bus number; ACS source
> >> validation no longer stops completions from being forwarded by
> >> the downstream port. It has been observed that Microsoft Windows
> >> implements this workaround already; however, some versions of
> >> Linux and other operating systems may not.
> > 
> > This doesn't mention anything about disabling ACS.  Issuing a
> > config write to devices downstream of an IDT bridge sounds simpler
> > than what this patch does.  Why don't you do that?
> 
> The issue is how will we know is the config write succeeds if the
> device is not ready? I thought it was simpler to disable acs for the
> sake of the read and when we know that the device is ready ( returns
> vendor id from read), it's ready for subsequent config write. 

If that's a problem, it sounds like the errata text is wrong or at
least incomplete.  If disabling ACS SV is required, the errata text
should mention it.

But I don't think it is a problem.  Per PCIe r3.1, sec 2.3.2, if a
Root Complex receives a CRS completion for a Configuration Write, it
must re-issue the request.

Or did you actually try that and find that it didn't work?

Bjorn
