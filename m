Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B034EC64EBC
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA82087D
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzVckIbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEA82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJEDkw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbeJEDkw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 23:40:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FDC2083F;
        Thu,  4 Oct 2018 20:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538685951;
        bh=zBx1GMyIX0MtAw7hjW3EbbabSYdg572zWaTRlMTFX+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzVckIblDAGOPrZD5JlE0IbyH86AbZrX/mZ/5kvl7twsrgbQlCcZDUE2BO+U6fwpy
         IzZ/FF3Gn2QY5Zax45vNMfpWspFNFWUOLxeRYwVGli7baitRmf3h5Yal8MGV8+d4Vy
         NH4nwaOZMFKbxvgrg3bScMBNjS3fabTwDM0xFAH4=
Date:   Thu, 4 Oct 2018 15:45:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex_Gagniuc@Dellteam.com
Cc:     mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, keith.busch@intel.com, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com, ariel.elior@cavium.com,
        everest-linux-l2@cavium.com, davem@davemloft.net,
        michael.chan@broadcom.com, ganeshgr@chelsio.com,
        jeffrey.t.kirsher@intel.com, tariqt@mellanox.com,
        saeedm@mellanox.com, leon@kernel.org, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, oss-drivers@netronome.com,
        stephen@networkplumber.org, mj@ucw.cz,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/9] PCI: sysfs: Export available PCIe bandwidth
Message-ID: <20181004204549.GI120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-2-mr.nuke.me@gmail.com>
 <20181003213054.GH120535@bhelgaas-glaptop.roam.corp.google.com>
 <f9fbc8babbb344eca593a3f8b0d096d9@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9fbc8babbb344eca593a3f8b0d096d9@ausx13mps321.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex (VC mentioned below)]

On Wed, Oct 03, 2018 at 10:00:19PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 10/03/2018 04:31 PM, Bjorn Helgaas wrote:
> > On Mon, Sep 03, 2018 at 01:02:28PM -0500, Alexandru Gagniuc wrote:
> >> For certain bandwidth-critical devices (e.g. multi-port network cards)
> >> it is useful to know the available bandwidth to the root complex. This
> >> information is only available via the system log, which doesn't
> >> account for link degradation after probing.
> >>
> >> With a sysfs attribute, we can computes the bandwidth on-demand, and
> >> will detect degraded links.
> >>
> >> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> ---
> >>   drivers/pci/pci-sysfs.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index 9ecfe13157c0..6658e927b1f5 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -218,6 +218,18 @@ static ssize_t current_link_width_show(struct device *dev,
> >>   }
> >>   static DEVICE_ATTR_RO(current_link_width);
> >>   
> >> +static ssize_t available_bandwidth_show(struct device *dev,
> >> +				       struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> >> +	u32 bw_avail;
> >> +
> >> +	bw_avail = pcie_bandwidth_available(pci_dev, NULL, NULL, NULL);
> >> +
> >> +	return sprintf(buf, "%u.%03u Gb/s\n", bw_avail / 1000, bw_avail % 1000);
> >> +}
> >> +static DEVICE_ATTR_RO(available_bandwidth);
> > 
> > Help me understand this.  We already have these sysfs attributes:
> > 
> >    max_link_speed          # eg, 16 GT/s
> >    max_link_width          # eg, 8
> >    current_link_speed      # eg, 16 GT/s
> >    current_link_width      # eg, 8
> > 
> > so I think the raw materials are already exposed.
> >
> > The benefits I see for this new file are that
> > 
> >    - pcie_bandwidth_available() does the work of traversing up the
> >      tree, doing the computations (link width * speed, reduced by
> >      encoding overhead), and finding the minimum, and
> > 
> >    - it re-traverses the path every time we look at it, while the
> >      boot-time check is a one-time event.
> > 
> > In principle this could all be done in user space with the attributes
> > that are already exported.  There's some precedent for things like
> > this in lspci, e.g., "NUMA node" [1], and lspci might even be a more
> > user-friendly place for users to look for this, as opposed to
> > searching through sysfs.
> 
> Parsing the endpoint to root port bandwidth is, in principle, possible 
> from userspace. It's just that in practice it's very clumsy to do, and, 
> as you pointed out, not that reliable.

I don't remember the reliability issue.  Was that in a previous
conversation?  AFAICT, using current_link_speed and current_link_width
should be as reliable as pcie_bandwidth_available() because they're
both based on reading PCI_EXP_LNKSTA.

This patch exposes only the available bandwidth, not the limiting
device, link speed, or link width.  Maybe that extra information isn't
important in this context.  Of course, it's easy to derive using
current_link_speed and current_link_width, but if we do that, there's
really no benefit to adding a new file.

Linux doesn't really support Virtual Channels (VC) yet, and I don't
know much about it, but it seems like Quality-of-Service features like
VC could affect this idea of available bandwidth.

Since we already expose the necessary information, and we might throw
additional things like VC into the mix, I'm a little hesitant about
adding things to sysfs because they're very difficult to change later.  

> I understand it's not information that all users would jump in the air 
> to know. However, it was important enough for certain use cases, that 
> the kernel already has a very reliable way to calculate it.
> 
> It seems to me that the most elegant way is to let the kernel tell us, 
> since the kernel already has this facility. To quote one of the texts 
> under Documentation/, it is an elegant way to "avoid reinventing kernel 
> wheels in userspace".
> 
> Alex
> 
> > [1] https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=90ec4a6d0ae8
> > 
> >>   static ssize_t secondary_bus_number_show(struct device *dev,
> >>   					 struct device_attribute *attr,
> >>   					 char *buf)
> >> @@ -786,6 +798,7 @@ static struct attribute *pcie_dev_attrs[] = {
> >>   	&dev_attr_current_link_width.attr,
> >>   	&dev_attr_max_link_width.attr,
> >>   	&dev_attr_max_link_speed.attr,
> >> +	&dev_attr_available_bandwidth.attr,
> >>   	NULL,
> >>   };
> >>   
> >> -- 
> >> 2.17.1
> >>
> > 
> 
