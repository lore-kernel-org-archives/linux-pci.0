Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbdHDOjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Aug 2017 10:39:10 -0400
Date: Fri, 4 Aug 2017 09:39:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Oza <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: iproc: Retry request when CRS returned from
 EP
Message-ID: <20170804143905.GG16580@bhelgaas-glaptop.roam.corp.google.com>
References: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
 <1499310582-21193-2-git-send-email-oza.oza@broadcom.com>
 <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcfUFmjg471qmzqQmayNYzfq8Wo7yfHeiEKrj7hkWF=zg@mail.gmail.com>
 <20170803185713.GV20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcbnVefeVVh3HJd1M+8co+4VMj8HU2zmXMv4K5VGcdjVg@mail.gmail.com>
 <20170804133753.GD16580@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPdxiqwZoUmpL3eyD=SJin8_Wa=4Q0ncXJpsf7kbwqZNsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMSpPPdxiqwZoUmpL3eyD=SJin8_Wa=4Q0ncXJpsf7kbwqZNsQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 08:04:20PM +0530, Oza Oza wrote:
> On Fri, Aug 4, 2017 at 7:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Aug 04, 2017 at 11:29:29AM +0530, Oza Oza wrote:
> >> On Fri, Aug 4, 2017 at 12:27 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Thu, Aug 03, 2017 at 01:50:29PM +0530, Oza Oza wrote:
> >> >> On Thu, Aug 3, 2017 at 2:34 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> >> > On Thu, Jul 06, 2017 at 08:39:41AM +0530, Oza Pawandeep wrote:
> >
> >> >> this is documented in our PCIe core hw manual.
> >> >> >>
> >> >> 4.7.3.3. Retry Status On Configuration Cycle
> >> >> Endpoints are allowed to generate retry status on configuration
> >> >> cycles.  In this case, the RC needs to re-issue the request.  The IP
> >> >> does not handle this because the number of configuration cycles needed
> >> >> will probably be less
> >> >> than the total number of non-posted operations needed.   When a retry status
> >> >> is received on the User RX interface for a configuration request that
> >> >> was sent on the User TX interface, it will be indicated with a
> >> >> completion with the CMPL_STATUS field set to 2=CRS, and the user will
> >> >> have to find the address and data values and send a new transaction on
> >> >> the User TX interface.
> >> >> When the internal configuration space returns a retry status during a
> >> >> configuration cycle (user_cscfg = 1) on the Command/Status interface,
> >> >> the pcie_cscrs will assert with the pcie_csack signal to indicate the
> >> >> CRS status.
> >> >> When the CRS Software Visibility Enable register in the Root Control
> >> >> register is enabled, the IP will return the data value to 0x0001 for
> >> >> the Vendor ID value and 0xffff  (all 1’s) for the rest of the data in
> >> >> the request for reads of offset 0 that return with CRS status.  This
> >> >> is true for both the User RX Interface and for the Command/Status
> >> >> interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
> >> >> field of the completion on the User RX Interface will not be 2=CRS and
> >> >> the pcie_cscrs signal will not assert on the Command/Status interface.
> >> >> >>
> >> >> Broadcom does not sell PCIe core IP, so above information is not
> >> >> publicly available in terms of hardware erratum or any similar note.
> >> >>
> >> >>
> >> >> >
> >> >> >> As a result of the fact, PCIe RC driver (sw) should take care of CRS.
> >> >> >> This patch fixes the problem, and attempts to read config space again in
> >> >> >> case of PCIe code forwarding the CRS back to CPU.
> >> >> >> It implements iproc_pcie_config_read which gets called for Stingray,
> >> >> >> Otherwise it falls back to PCI generic APIs.
> > ...
> >
> >> >> >> +static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> >> >> >> +{
> >> >> >> +     int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
> >> >> >> +     unsigned int ret;
> >> >> >> +
> >> >> >> +     /*
> >> >> >> +      * As per PCI spec, CRS Software Visibility only
> >> >> >> +      * affects config read of the Vendor ID.
> >> >> >> +      * For config write or any other config read the Root must
> >> >> >> +      * automatically re-issue configuration request again as a
> >> >> >> +      * new request. Iproc based PCIe RC (hw) does not retry
> >> >> >> +      * request on its own, so handle it here.
> >> >> >> +      */
> >> >> >> +     do {
> >> >> >> +             ret = readl(cfg_data_p);
> >> >> >> +             if (ret == CFG_RETRY_STATUS)
> >> >> >> +                     udelay(1);
> >> >> >> +             else
> >> >> >> +                     return PCIBIOS_SUCCESSFUL;
> >> >> >> +     } while (timeout--);
> >> >> >
> >> >> > Shouldn't this check *where* in config space we're reading?
> >> >> >
> >> >> No, we do not require, because with SPDK it was reading BAR space
> >> >> which points to MSI-x table.
> >> >> what I mean is, it could be anywhere.
> >> >
> >> > The documentation above says the IP returns data of 0x0001 for *reads
> >> > of offset 0*.  Your current code reissues the read if *any* read
> >> > anywhere returns data that happens to match CFG_RETRY_STATUS.  That
> >> > may be a perfectly valid register value for some device's config
> >> > space.  In that case, you do not want to reissue the read and you do
> >> > not want to timeout.
> >>
> >> ok, so the documentation is about PCIe core IP,
> >> It is not about the host bridge. (PCI to AXI bridge)
> >>
> >> PCIe core forwards 0x0001 return code to host bridge, and converts it
> >> into 0xffff0001.
> >> which is hard wired.
> >> we have another HW layer on top of PCIe core which implements lots of
> >> logic. (host bridge)
> >>
> >> I agree with you that, it could be valid data, but our ASIC conveyed
> >> that they have chosen the code
> >> such that this data is unlikely to be valid.
> >
> > Hehe.  I think it's more likely that they chose this value because
> > it's mentioned in the spec for CRS.  I doubt it has anything to do
> > with it being "unlikely".  Or maybe it really is just a coincidence :)
> >
> > In any event, your documentation says this data is only fabricated for
> > reads at offset 0.  So why do you check for it for *all* reads?
> 
> sorry, missed to clarify your question:
> 
> the Documentation mentioned offset 0, but that is not the case.
> it is true for every single configuration access.
> so yes, the iproc PCIe core, will not re-issue any request for any offset
> in configuration space.

OK.  In your changelog, please quote the documentation as-is, and
append a note about this error in the documentation.
