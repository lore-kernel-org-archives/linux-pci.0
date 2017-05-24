Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941010AbdEXVd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 17:33:59 -0400
Date: Wed, 24 May 2017 16:33:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
Message-ID: <20170524213353.GB2794@bhelgaas-glaptop.roam.corp.google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523194443.GD7241@bhelgaas-glaptop.roam.corp.google.com>
 <c2331eef-b76d-720d-3750-6d754d53710a@rock-chips.com>
 <20170524011507.GA112603@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170524011507.GA112603@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 06:15:07PM -0700, Brian Norris wrote:
> (Since Shawn didn't quite answer this piece)
> 
> On Wed, May 24, 2017 at 09:04:33AM +0800, Shawn Lin wrote:
> > 在 2017/5/24 3:44, Bjorn Helgaas 写道:
> > >On Fri, May 19, 2017 at 02:58:27PM +0800, Shawn Lin wrote:
> > >>This patch checks the link status before reading and
> > >>writing configure space of devices attached to the RC.
> > >>If the link status is down, we shouldn't try to access
> > >>the devices.
> > >
> > >What bad things happen without this patch?
> 
> On this SoC, I've seen this sort of behavior (reading the config space
> when the device isn't responding) yield aborts, which panic the system. 

Trying to read config space of a device that doesn't exist is an
essential part of enumeration, and we expect whatever error occurs at
the hardware level to get turned into 0xffffffff data at the CPU (as
in pci_bus_read_dev_vendor_id()).

Shawn mentioned some issue with memory read/write as well.  I think we
need to sort out how to handle both the config space issue and the
memory issue.  This patch seems like it papers over part of it and
reduces the urgency of finding a real solution.

I'm going to drop this for now, pending a more detailed explanation.

Bjorn
