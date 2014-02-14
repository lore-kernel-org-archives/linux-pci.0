Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60986 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751926AbaBNNYt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 08:24:49 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 1/6] PCI,acpiphp: Use list_for_each_entry() for bus traversal
Date: Fri, 14 Feb 2014 14:39:32 +0100
Message-ID: <2512180.zyEb2tzySd@vostro.rjw.lan>
In-Reply-To: <52FD7D3D.4030409@huawei.com>
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com> <2601738.3Ek05F9oo5@vostro.rjw.lan> <52FD7D3D.4030409@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 14, 2014 10:19:41 AM Yijing Wang wrote:
> On 2014/2/14 7:54, Rafael J. Wysocki wrote:
> > On Thursday, February 13, 2014 09:13:58 PM Yijing Wang wrote:
> >> Replace list_for_each() + pci_bus_b() with the simpler
> >> list_for_each_entry().
> >>
> >> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> > 
> > Looks reasonable to me.
> > 
> > Does it conflict with anything currently in linux-next (the linux-next branch
> > of linux-pm.git in particular)?
> 
> Hi Rafael,
>    I applied this to your linux-next branch successfully . No conflicts found.

Good. :-)

Please feel free to add my ACK to it.

Rafael


> >> ---
> >>  drivers/pci/hotplug/acpiphp_glue.c |    6 +++---
> >>  1 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> >> index cd929ae..aee6a0a 100644
> >> --- a/drivers/pci/hotplug/acpiphp_glue.c
> >> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> >> @@ -450,7 +450,7 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
> >>   */
> >>  static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
> >>  {
> >> -	struct list_head *tmp;
> >> +	struct pci_bus *tmp;
> >>  	unsigned char max, n;
> >>  
> >>  	/*
> >> @@ -463,8 +463,8 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
> >>  	 */
> >>  	max = bus->busn_res.start;
> >>  
> >> -	list_for_each(tmp, &bus->children) {
> >> -		n = pci_bus_max_busnr(pci_bus_b(tmp));
> >> +	list_for_each_entry(tmp, &bus->children, node) {
> >> +		n = pci_bus_max_busnr(tmp);
> >>  		if (n > max)
> >>  			max = n;
> >>  	}
> >>
> > 
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
