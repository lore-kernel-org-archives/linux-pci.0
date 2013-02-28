Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:44286 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab3B1QGd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2013 11:06:33 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so3816068oag.40
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2013 08:06:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <512F2C9E02000078000C1D07@nat28.tlf.novell.com>
References: <512F2C9E02000078000C1D07@nat28.tlf.novell.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 28 Feb 2013 09:06:12 -0700
Message-ID: <CAErSpo6+bHeNkP9rc6NUGweGfLa0CRw6H=Nny9cV-FL2xOGKeA@mail.gmail.com>
Subject: Re: time periods of no resource re-assignment
To: Jan Beulich <JBeulich@suse.com>
Cc: xen-devel <xen-devel@lists.xen.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 28, 2013 at 2:08 AM, Jan Beulich <JBeulich@suse.com> wrote:
> Bjorn,
>
> in the context of dealing with the final part of a long known security
> issue on Xen, I'd appreciate if you could help me understand
> under what conditions (or at which times) MMIO resources for PCI
> devices can get re-assigned in Linux. Or really I'm in need to know
> under what conditions there won't be any resource re-assignment
> (i.e. we particularly need the BARs to be stable that cover the
> MSI-X table and the Pending Bit Array).
>
> Right now I'm intending to send the hypervisor a respective
> notification in the context of xen-pciback's probe function, after
> having called pci_enable_device(). Can you confirm that at this
> point, and until the driver lets go of the device again, resources
> won't get re-assigned? Or if not, can you suggest a better point
> in time for sending such a notification, or additional steps we
> may need to take in order to ensure resource stability?

Hi Jan,

There is currently no mechanism for the PCI core to tell a driver that
we're changing any device resources (IRQ, MMIO, I/O).  Since there's
no way to tell a driver to refresh its idea of device resources, the
core can not change anything after we call a driver's .probe()
method.

This could change in the future if we support dynamic resource
reassignment, but I think that would require adding some sort of
notification infrastructure so we could essentially suspend a driver,
reassign device resources, and tell the driver "things might have
changed" when we resume it.

Bjorn
