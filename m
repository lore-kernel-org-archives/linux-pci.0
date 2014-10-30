Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52481 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759789AbaJ3OPB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 10:15:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: balbi@ti.com
Cc: Huang Rui <ray.huang@amd.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Jason Chang <jason.chang@amd.com>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/20] usb: dwc3: enable hibernation if to be supported
Date: Thu, 30 Oct 2014 15:14:17 +0100
Message-ID: <2025342.7A7Ashtuyx@wuerfel>
In-Reply-To: <20141030140832.GH6482@saruman>
References: <1414663725-2195-1-git-send-email-ray.huang@amd.com> <4077930.b7qzaS4pBb@wuerfel> <20141030140832.GH6482@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 October 2014 09:08:32 Felipe Balbi wrote:
> On Thu, Oct 30, 2014 at 12:35:56PM +0100, Arnd Bergmann wrote:
> > On Thursday 30 October 2014 18:08:26 Huang Rui wrote:
> > > It enables hibernation if the function is set in coreConsultant.
> > > 
> > > Suggested-by: Felipe Balbi <balbi@ti.com>
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > 
> > 
> > Something went wrong with the Signed-off-by lines here. 
> > You should never add someone else's Signed-off-by below yours.
> > 
> > I took a brief look at the entire series and the patches all look good
> > to me, but you have made the same mistake with the Signed-off-by
> > multiple times.
> 
> there are no mistakes, I just asked Huang to resend what I had on my
> testing/next because it had not been sent to devicetree mailing list.
> 

It's definitely a tricky question what the right Signed-off-by
chain is in this case, I guess strictly speaking it could have
been 

Suggested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>

which could correctly track where the patches went, but it's also
somewhat silly.

I would probably just have dropped the second Signed-off-by,
so that the last S-o-b in the patch matches the "From", as we expect.

It's definitely good to know that Huang Rui was not faking your
Signed-off-by but that you had actually provided it yourself.

	Arnd
