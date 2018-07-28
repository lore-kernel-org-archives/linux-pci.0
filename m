Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbeG1RdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jul 2018 13:33:09 -0400
Date: Sat, 28 Jul 2018 11:06:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [net-next 10/16] net/mlx5: Support PCIe buffer congestion
 handling via Devlink
Message-ID: <20180728160608.GI173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180719010107.22363-1-saeedm@mellanox.com>
 <20180719010107.22363-11-saeedm@mellanox.com>
 <20180718184947.6e472ee4@cakuba.netronome.com>
 <575e4a3a-af6f-aac4-fed6-fd4dad387105@mellanox.com>
 <20180724125135.19121f1f@cakuba.netronome.com>
 <98071d31-bf99-d713-7fd1-4b1cc156377e@mellanox.com>
 <CAKgT0UfG-4zuKArCbSLkZoCKs2-t6r9U4qQPPUvBk-e_5_3FCg@mail.gmail.com>
 <20180725174359.6952c937@cakuba.netronome.com>
 <20180726071433.GA2222@nanopsycho>
 <CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgT0UeGOhjR756fMPx_k_o8Qq5x4waKMcdmtR3pLAT=xRHMgA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2018 at 07:00:20AM -0700, Alexander Duyck wrote:
> On Thu, Jul 26, 2018 at 12:14 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> > Thu, Jul 26, 2018 at 02:43:59AM CEST, jakub.kicinski@netronome.com wrote:
> >>On Wed, 25 Jul 2018 08:23:26 -0700, Alexander Duyck wrote:
> >>> On Wed, Jul 25, 2018 at 5:31 AM, Eran Ben Elisha wrote:
> >>> > On 7/24/2018 10:51 PM, Jakub Kicinski wrote:
> >>> >>>> The devlink params haven't been upstream even for a full cycle and
> >>> >>>> already you guys are starting to use them to configure standard
> >>> >>>> features like queuing.
> >>> >>>
> >>> >>> We developed the devlink params in order to support non-standard
> >>> >>> configuration only. And for non-standard, there are generic and vendor
> >>> >>> specific options.
> >>> >>
> >>> >> I thought it was developed for performing non-standard and possibly
> >>> >> vendor specific configuration.  Look at DEVLINK_PARAM_GENERIC_* for
> >>> >> examples of well justified generic options for which we have no
> >>> >> other API.  The vendor mlx4 options look fairly vendor specific if you
> >>> >> ask me, too.
> >>> >>
> >>> >> Configuring queuing has an API.  The question is it acceptable to enter
> >>> >> into the risky territory of controlling offloads via devlink parameters
> >>> >> or would we rather make vendors take the time and effort to model
> >>> >> things to (a subset) of existing APIs.  The HW never fits the APIs
> >>> >> perfectly.
> >>> >
> >>> > I understand what you meant here, I would like to highlight that this
> >>> > mechanism was not meant to handle SRIOV, Representors, etc.
> >>> > The vendor specific configuration suggested here is to handle a congestion
> >>> > state in Multi Host environment (which includes PF and multiple VFs per
> >>> > host), where one host is not aware to the other hosts, and each is running
> >>> > on its own pci/driver. It is a device working mode configuration.
> >>> >
> >>> > This  couldn't fit into any existing API, thus creating this vendor specific
> >>> > unique API is needed.
> >>>
> >>> If we are just going to start creating devlink interfaces in for every
> >>> one-off option a device wants to add why did we even bother with
> >>> trying to prevent drivers from using sysfs? This just feels like we
> >>> are back to the same arguments we had back in the day with it.
> >>>
> >>> I feel like the bigger question here is if devlink is how we are going
> >>> to deal with all PCIe related features going forward, or should we
> >>> start looking at creating a new interface/tool for PCI/PCIe related
> >>> features? My concern is that we have already had features such as DMA
> >>> Coalescing that didn't really fit into anything and now we are
> >>> starting to see other things related to DMA and PCIe bus credits. I'm
> >>> wondering if we shouldn't start looking at a tool/interface to
> >>> configure all the PCIe related features such as interrupts, error
> >>> reporting, DMA configuration, power management, etc. Maybe we could
> >>> even look at sharing it across subsystems and include things like
> >>> storage, graphics, and other subsystems in the conversation.
> >>
> >>Agreed, for actual PCIe configuration (i.e. not ECN marking) we do need
> >>to build up an API.  Sharing it across subsystems would be very cool!

I read the thread (starting at [1], for anybody else coming in late)
and I see this has something to do with "configuring outbound PCIe
buffers", but I haven't seen the connection to PCIe protocol or
features, i.e., I can't connect this to anything in the PCIe spec.

Can somebody help me understand how the PCI core is relevant?  If
there's some connection with a feature defined by PCIe, or if it
affects the PCIe transaction protocol somehow, I'm definitely
interested in this.  But if this only affects the data transferred
over PCIe, i.e., the data payloads of PCIe TLP packets, then I'm not
sure why the PCI core should care.

> > I wonder howcome there isn't such API in place already. Or is it?
> > If it is not, do you have any idea how should it look like? Should it be
> > an extension of the existing PCI uapi or something completely new?
> > It would be probably good to loop some PCI people in...
> 
> The closest thing I can think of in terms of answering your questions
> as to why we haven't seen anything like that would be setpci.
> Basically with that tool you can go through the PCI configuration
> space and update any piece you want. The problem is it can have
> effects on the driver and I don't recall there ever being any sort of
> notification mechanism added to make a driver aware of configuration
> updates.

setpci is a development and debugging tool, not something we should
use as the standard way of configuring things.  Use of setpci should
probably taint the kernel because the PCI core configures features
like MPS, ASPM, AER, etc., based on the assumption that nobody else is
changing things in PCI config space.

> As far as the interface I don't know if we would want to use something
> like netlink or look at something completely new.
> 
> I've gone ahead and added the linux-pci mailing list to the thread.
> 
> - Alex

[1] https://lkml.kernel.org/r/20180719010107.22363-11-saeedm@mellanox.com
