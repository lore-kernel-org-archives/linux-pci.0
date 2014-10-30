Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge2.emulex.com ([138.239.224.100]:52919 "EHLO
	CMEXEDGE2.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759470AbaJ3Niy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 09:38:54 -0400
From: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v1] pci: Limit VPD length of Emulex adapters to the
 actual length supported.
Date: Thu, 30 Oct 2014 13:38:28 +0000
Message-ID: <BF3270C86E8B1349A26C34E4EC1C44CB3E860095@CMEXMB1.ad.emulex.com>
References: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
 <20141023154054.GA7137@google.com>
In-Reply-To: <20141023154054.GA7137@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
Please find my comments inline.

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, October 23, 2014 9:11 PM
> To: Venkat Duvvuru
> Cc: linux-pci@vger.kernel.org
> Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the actual
> length supported.
> 
> On Thu, Oct 16, 2014 at 02:16:42PM +0530, Venkat Duvvuru wrote:
> > By default pci utilities/subsystem tries to read 32k bytes of vpd data no
> matter
> > what the device supports. This can lead to unexpected behavior depending
> > on how each of the devices handle this condition. This patch fixes the
> > problem for Emulex adapter family.
> >
> > v1:
> > Addressed Bjorn's comments
> > 1. Removed Vendor id and Device id macros from pci_ids.h and
> >    using the Vendor and Device id values directly in
> DECLARE_PCI_FIXUP_FINAL() lines.
> >
> > Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
> 
> Hi Venkat,
> 
> I'll merge this (in some form), but I'd like the changelog to include more
> details about what unexpected behavior occurs when reading too much data.
> This is to help people who trip over this problem find this patch as the
> solution.
[Venkat] "Timeout" happens on excessive VPD reads and  Kernel keeps logging the following message 
"vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update"
> 
> In my opinion, this is a hardware defect, and I'd like to know what your
> hardware folks think, because I don't want to have to merge similar quirks
> for future devices.  Here's my reasoning:
> 
> If a device doesn't implement the entire 32K of possible VPD space, I would
> expect the device to just return zeros or 0xff, or maybe alias the space by
> dropping the high-order unused address bits.
[Venkat] We do return 0xffs beyond the supported size but excessive VPD reads are causing timeouts when the adapter is handling some high priority work.

> 
> The only thing I see in the spec related to this is (PCI r3.0, Appendix I,
> "VPD Data" description): "Reading or writing data outside of the VPD space
> in the storage component is not allowed."  The only way I see for software
> to determine the size of the storage is to parse the data looking for an
> End Tag.
> 
> I don't think it's reasonable to make correct hardware operation depend on
> the contents of the storage, so if something bad happens when software
> reads past the end, that looks like a hardware defect to me.
