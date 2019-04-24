Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E01C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F5821904
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556115118;
	bh=dWXGXDJVAFXWhSTX8F7NXIck+tEjXNfmi/+23cDcY0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f11tR4ij5AJpRkhGnpqCQ9Sql/KZzS80CO22kjEP3V3LtWQ94sytyrusiIRYAspDH
	 bn/xF1NgFYGYvmSrz/gWDz0VpkQxZ1nKBh0Xfd+rrp+XPyXeJFRAglId66urC4Ttft
	 gy/iILE17ojCoz3Z+CoycJhormyP5t4uKieEx+Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfDXOL6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfDXOL6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 10:11:58 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B13121900;
        Wed, 24 Apr 2019 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556115117;
        bh=dWXGXDJVAFXWhSTX8F7NXIck+tEjXNfmi/+23cDcY0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIGEggcX5xTRWcwLupAalhXq4Pon+rhrJ/Et3bcv/KkTvfhQc9ZevQzGF1fLkXm6+
         axc5lTHHQlkSGSvdarx71oC4QfKViSMTsG2ihU/nRd6B5vjirrKlZaT2kOD7lv7nun
         dfR577+80usEmi26LFDeaRAg3mKthutmbf0C56KI=
Date:   Wed, 24 Apr 2019 09:11:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190424141148.GA244134@google.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com>
 <20190424100102.iyxogbsa4l7dyusb@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424100102.iyxogbsa4l7dyusb@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika for runtime PM of bridges, Logan for switchtec question]

On Wed, Apr 24, 2019 at 01:01:02PM +0300, Alexander Fomichev wrote:
> On Tue, Apr 23, 2019 at 04:53:40PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 15, 2019 at 09:15:54AM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 15, 2019 at 04:59:03PM +0300, Alexander Fomichev wrote:
> > > > PLX switches have an issue that their internal registers
> > > > become inaccessible when runtime PM is enabled. Therefore PLX
> > > > service tools can't communicate with the hardware. A kernel
> > > > option "pcie_port_pm=off" can be used as a workaround. But it
> > > > affects all the devices.
> > > >
> > > > So this solution is to add PLX switch devices to the quirk
> > > > list for disabling runtime PM only for them.
> > >
> > > I assume the problem is actually that the config space registers
> > > are inaccessible when the device is in D3hot?
> >
> > Reading this again, I realize you said "internal registers".  I
> > don't know whether that actually means config space registers
> > (which *should* work even when the device is in D3hot (see the
> > PCIe reference below and PCI Power Management Spec r1.2, sec
> > 5.4.1)), or MMIO registers (which are not expected to work while
> > in D3hot).
> > 
> > If the service tools read MMIO registers, presumably that goes
> > through some driver that should be able to manage runtime PM.  Or,
> > if there's no driver, I think your service tool could prevent
> > runtime power management by changing
> > /sys/devices/.../power/control to "on" (see
> > Documentation/power/runtime_pm.txt).
>
> You're right. Config space registers are accessible. The driver
> can't read/write MMIO registers (Device-Specific Registers as
> they're called by Broadcom).

Ah, perfect.  That's exactly what's supposed to happen from a PCI
hardware point of view.  Unfortunately I don't know much about how
Linux power management works, but Rafael and Mika do.

How do your service tools access these MMIO registers?

  - via a PLX driver that provides read/write/ioctl on a char dev?
  - read/write on /sys/devices/pci*/.../resource<x> ?
  - mmap on /sys/devices/pci*/.../resource<x> ?
  - read/write on /dev/mem?
  - mmap on /dev/mem?
  - something else?

I think there are several ways we might be able to fix this:

  - Write a driver along the lines of drivers/pci/switch/switchtec.c.
    I don't see any runtime PM stuff in that driver, so maybe it's
    magically taken care of by the PM/PCI core?  There might also be
    an issue if both portdrv and your driver want to claim the same
    device.  I don't know how switchtec deals with that.

  - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
    turn off runtime PM?  If we allow mmap of a BAR and then put the
    device in D3hot, that seems like a bug that could affect lots of
    things.  But maybe that's already done magically elsewhere?

Bjorn
