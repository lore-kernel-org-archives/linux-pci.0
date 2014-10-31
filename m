Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:30976
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161552AbaJaBnW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 21:43:22 -0400
Date: Fri, 31 Oct 2014 09:35:51 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul Zimmerman" <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 19/20] usb: dwc3: add support for AMD Nolan platform
Message-ID: <20141031013550.GC20367@hr-slim.amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
 <1414663725-2195-20-git-send-email-ray.huang@amd.com>
 <20141030163840.GK10130@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141030163840.GK10130@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 11:38:40AM -0500, Felipe Balbi wrote:
> On Thu, Oct 30, 2014 at 06:08:44PM +0800, Huang Rui wrote:
> > This patch adds support for AMD Nolan (NL) FPGA and SoC platform.
> > 
> > Cc: Jason Chang <jason.chang@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/usb/dwc3/dwc3-pci.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> > index ada975f..257fb3f9e 100644
> > --- a/drivers/usb/dwc3/dwc3-pci.c
> > +++ b/drivers/usb/dwc3/dwc3-pci.c
> > @@ -145,6 +145,28 @@ static int dwc3_pci_probe(struct pci_dev *pci,
> >  	res[1].name	= "dwc_usb3";
> >  	res[1].flags	= IORESOURCE_IRQ;
> >  
> > +	if (pci->vendor == PCI_VENDOR_ID_AMD &&
> > +			pci->device == PCI_DEVICE_ID_AMD_NL_USB) {
> > +		dwc3_pdata.has_lpm_erratum = true;
> > +		dwc3_pdata.lpm_nyet_threshold = 0xf;
> > +
> > +		dwc3_pdata.u2exit_lfps_quirk = true;
> > +		dwc3_pdata.u2ss_inp3_quirk = true;
> > +		dwc3_pdata.req_p1p2p3_quirk = true;
> > +		dwc3_pdata.del_p1p2p3_quirk = true;
> > +		dwc3_pdata.del_phy_power_chg_quirk = true;
> > +		dwc3_pdata.lfps_filter_quirk = true;
> > +		dwc3_pdata.rx_detect_poll_quirk = true;
> > +
> > +		dwc3_pdata.tx_de_emphasis_quirk = true;
> > +		dwc3_pdata.tx_de_emphasis = 1;
> > +
> > +		/* FIXME these quirks should move when AMD NL taps out */
> 
> do you mean ?
> 
> 		/*
> 		 * FIXME these quirks should be removed when AMD NL
> 		 * tapes out
> 		 */
> 

That's right, will update.

Thanks,
Rui
