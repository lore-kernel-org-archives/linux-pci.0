Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0145.outbound.protection.outlook.com ([207.46.100.145]:3169
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932834AbaJ2Ogi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Oct 2014 10:36:38 -0400
Date: Wed, 29 Oct 2014 22:33:19 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul Zimmerman" <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	"Vincent Wan" <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 19/19] usb: dwc3: add support for AMD NL platform
Message-ID: <20141029143319.GD10840@hr-slim.amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
 <1414497280-3126-20-git-send-email-ray.huang@amd.com>
 <20141028133856.GB8123@saruman> <20141028143536.GA4519@hr-slim.amd.com>
 <20141029091342.GC10840@hr-slim.amd.com> <20141029141146.GF11572@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141029141146.GF11572@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 29, 2014 at 09:11:46AM -0500, Felipe Balbi wrote:
> On Wed, Oct 29, 2014 at 05:13:43PM +0800, Huang Rui wrote:
> > Hi Felipe, Paul,
> > 
> > On Tue, Oct 28, 2014 at 10:35:37PM +0800, Huang Rui wrote:
> > > On Tue, Oct 28, 2014 at 08:38:56AM -0500, Felipe Balbi wrote:
> > 
> > <snip>
> > 
> > > > 
> > > > however, as I mentioned before, the core shouldn't have to know that
> > > > it's running on an AMD platform. We already support several different
> > > > platforms (OMAP5, AM437x, DRA7xx, Exynos5, Exynos7, Qcom, Merrifield,
> > > > Baytrail, Braswell, HAPS PCIe, and STiH407) and none of them get their
> > > > $my_awesome_platform flag in dwc3, why should AMD be any different ?
> > > > 
> > > > This is the only part of $subject that I cannot accept because it would
> > > > mean we would be giving AMD a special treatment when there shouldn't be
> > > > any, for anybody.
> > > > 
> > > 
> > > That's because I used this flag to enable below quirks on AMD NL FPGA
> > > board, and FPGA flag only can be detected on core. Can I set
> > > disable_scramble_quirk, dis_u3_susphy_quirk, and dis_u2_susphy_quirk
> > > for all the FPGA platforms?
> > > 
> > > if (dwc->amd_nl_plat && dwc->is_fpga) {
> > >         dwc->disable_scramble_quirk = true;
> > >         dwc->dis_u3_susphy_quirk = true;
> > >         dwc->dis_u2_susphy_quirk = true;
> > > }
> > > 
> > 
> > I confirmed with HW designer, these three quirks only will be needed
> > on FPGA board. And these should *not* be used on non-FPGA board, as you
> > known.
> > 
> > So I would like to use below conditions on dwc3 core. When I set these
> > quirk flags in pci glue layer, then core can filter them by is_fpga
> > flag to support both on FPGA and SoC. Is there any concern? If that, I
> > should remove WARN_ONCE at disable_scramble flag.
> > 
> > if (dwc->disable_scramble_quirk && dwc->is_fpga) {..}
> > 
> > if (dwc->dis_u2_susphy_quirk && dwc->is_fpga) {..}
> > 
> > if (dwc->dis_u3_susphy_quirk && dwc->is_fpga) {..}
> 
> the problem is that somebody might need this on non-FPGA. Currently,
> only AMD needs these and only on FPGA, but you never know.
> 
> I guess we can add it like this for now and once we have a real AMD
> product, we drop FPGA support from AMD.
> 

OK, agree.

Then I comments below WARN_ONCE, OK?

/* FIXME it should be used after AMD NL product taps out */
#if 0
WARN_ONCE(dwc->disable_scramble_quirk && !dwc->is_fpga,
"disable_scramble cannot be used on non-FPGA builds\n");
#endif

Thanks,
Rui
