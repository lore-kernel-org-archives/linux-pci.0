Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0135.outbound.protection.outlook.com ([157.56.110.135]:45635
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161426AbaJaBmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 21:42:31 -0400
Date: Fri, 31 Oct 2014 09:34:59 +0800
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
Subject: Re: [PATCH v4 16/20] usb: dwc3: add disable usb2 suspend phy quirk
Message-ID: <20141031013459.GB20367@hr-slim.amd.com>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com>
 <1414663725-2195-17-git-send-email-ray.huang@amd.com>
 <20141030163943.GL10130@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141030163943.GL10130@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 11:39:43AM -0500, Felipe Balbi wrote:
> On Thu, Oct 30, 2014 at 06:08:41PM +0800, Huang Rui wrote:
> > This patch adds disable usb2 suspend phy quirk, and some special platforms
> > can configure that if it is needed.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  Documentation/devicetree/bindings/usb/dwc3.txt | 1 +
> >  drivers/usb/dwc3/core.c                        | 7 +++++++
> >  drivers/usb/dwc3/core.h                        | 2 ++
> >  drivers/usb/dwc3/platform_data.h               | 1 +
> >  4 files changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> > index 3720fca..feaf2c8 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> > @@ -33,6 +33,7 @@ Optional properties:
> >   - snps,tx_de_emphasis: the value driven to the PHY is controlled by the
> >  			LTSSM during USB3 Compliance mode.
> >   - snps,dis_u3_susphy_quirk: when set core will disable USB3 suspend phy.
> > + - snps,dis_u2_susphy_quirk: when set core will disable USB2 suspend phy.
> >  
> >  This is usually a subnode to DWC3 glue to which it is connected.
> >  
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index fdc715a..a28ed1c 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -423,6 +423,10 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
> >  	if (dwc->revision > DWC3_REVISION_194A)
> >  		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> >  
> > +	/* FIXME will move FPGA flag when AMD NL taps out */
> 
> no need to mention AMD NL here. We still want to have is_fpga flag, just
> dwc3-pci will be patches once AMD NL tapes out.
> 

OK, will move it.

Thanks,
Rui
