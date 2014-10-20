Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [157.56.111.141] ([157.56.111.141]:13026 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751792AbaJTGC2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 02:02:28 -0400
Date: Mon, 20 Oct 2014 14:02:17 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul Zimmerman" <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/16] usb: dwc3: add quirks support to be compatible
 for kinds of SoCs
Message-ID: <20141020060217.GA24357@hr-slim.amd.com>
References: <1413536021-4886-1-git-send-email-ray.huang@amd.com>
 <1413536021-4886-6-git-send-email-ray.huang@amd.com>
 <20141017144144.GA26260@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141017144144.GA26260@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 17, 2014 at 09:41:44AM -0500, Felipe Balbi wrote:
> HI,
> 
> On Fri, Oct 17, 2014 at 04:53:30PM +0800, Huang Rui wrote:
> > This patch adds a quirks flag at dwc3 structure, and SoCs platform vendor is
> > able to define this flag in platform data at bus glue layer. Then do some
> > independent behaviors at dwc3 core level.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/usb/dwc3/core.c          | 2 ++
> >  drivers/usb/dwc3/core.h          | 3 +++
> >  drivers/usb/dwc3/dwc3-pci.c      | 9 +++++++++
> >  drivers/usb/dwc3/platform_data.h | 2 ++
> >  4 files changed, 16 insertions(+)
> > 

<snip>

> > diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
> > index 7db34f0..1d3d65f 100644
> > --- a/drivers/usb/dwc3/platform_data.h
> > +++ b/drivers/usb/dwc3/platform_data.h
> > @@ -24,4 +24,6 @@ struct dwc3_platform_data {
> >  	enum usb_device_speed maximum_speed;
> >  	enum usb_dr_mode dr_mode;
> >  	bool tx_fifo_resize;
> > +
> > +	u32     quirks;
> 
> I prefer to have one-bit fields like we already have for delayed_status,
> ep0_bounced, ep0_expect_in, and so on. That makes it easier to support
> the same quirks through devicetree as well.
> 

So it should define like below:

struct dwc3_platform_data {
        ...
        unsigned one_quirk:1;
}

Then also defined it in dwc3 structure. And when dwc3 probed, put this
value from glue layer to dwc3, right?

Thanks,
Rui
