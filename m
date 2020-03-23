Return-Path: <SRS0=7zJh=5I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6ACC4332B
	for <linux-pci@archiver.kernel.org>; Mon, 23 Mar 2020 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7807320753
	for <linux-pci@archiver.kernel.org>; Mon, 23 Mar 2020 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585002487;
	bh=5jbRyzIrpZi5AB3gcfUvLN33piIdLeAYX6GbVsr40TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=XEyidHbFFnwsjD0C9TDqc2lZj1TiTDw8qe55Rtn0wtJYtYht3vUAEUpEknpJdI01+
	 eCXOrPK8ZRoigmWeb7OCMJHEk1NeBSMe0BajZwa9f/fr5qU6RDktHCuEQfKzCowil5
	 vTmJDl8y6Lbv69EKIqbVEARqGny8i8BlelI8WgLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCWW2G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWW2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 18:28:06 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD592073E;
        Mon, 23 Mar 2020 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585002486;
        bh=5jbRyzIrpZi5AB3gcfUvLN33piIdLeAYX6GbVsr40TM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oolZXOmmHqEDJUqAQdCNL7T/WEoOIdpOjepOSCgEqOdPJBdACpQ1sRmYV80Wj/zFH
         TmeEYwsznJUItzzjd+EDUScIxkTiIvd0DiNna8TDZsidboJmmXDmhSIlDL4OFmftdz
         +8AUKIkb80r6efHcmI7u6QpDI3VuTgAdf5XVntuo=
Date:   Mon, 23 Mar 2020 17:28:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: Add device links from fwnode only for
 the primary device
Message-ID: <20200323222803.GA21243@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju-rOU6TF9HDScXvV9N02wuJT9d3cLkoyEdd1xL6Kfbw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 21, 2020 at 11:20:07AM +0100, Rafael J. Wysocki wrote:
> On Sat, Mar 21, 2020 at 5:55 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Sometimes, more than one (generally two) device can point to the same
> > fwnode.  However, only one device is set as the fwnode's device
> > (fwnode->dev) and can be looked up from the fwnode.
> >
> > Typically, only one of these devices actually have a driver and actually
> > probe. If we create device links for all these devices, then the
> > suppliers' of these devices (with the same fwnode) will never get a
> > sync_state() call because one of their consumer devices will never probe
> > (because they don't have a driver).
> >
> > So, create device links only for the device that is considered as the
> > fwnode's device.
> >
> > One such example of this is the PCI bridge platform_device and the
> > corresponding pci_bus device. Both these devices will have the same
> > fwnode. It's the platform_device that is registered first and is set as
> > the fwnode's device. Also the platform_device is the one that actually
> > probes. Without this patch none of the suppliers of a PCI bridge
> > platform_device would get a sync_state() callback.
> 
> For the record, I think that this is a PCI subsystem problem, but I
> agree with the patch here.

I don't understand the issue here.  Can somebody educate me?  I'm
guessing this is related to pci_set_bus_of_node(), which does (for
PCI-to-PCI bridges):

  bus->dev.of_node = of_node_get(bus->self->dev.of_node);
  bus->dev.fwnode = &bus->dev.of_node->fwnode;

where "bus" points to a struct pci_bus and "bus->self" points to the
struct pci_dev for the bridge leading to the bus?

Is this related to the fact that we have a struct device for both a
PCI-to-PCI bridge and for its downstream bus?

Any suggestions for how could we fix this problem in the PCI
subsystem?
