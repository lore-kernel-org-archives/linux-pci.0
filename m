Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:43884 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbaGJQZv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 12:25:51 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so7846254qgf.40
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 09:25:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
References: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Jul 2014 10:25:29 -0600
Message-ID: <CAErSpo4wbqPTYa-0Ot2vdfnnRE3iQbPoUsaXca8kr7SkjqSJQg@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] xen-pciback: allow device reset to work more often
To: David Vrabel <david.vrabel@citrix.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex]

On Thu, Jul 10, 2014 at 7:03 AM, David Vrabel <david.vrabel@citrix.com> wrote:
> When a PCI device is passed through to a different domain, it must be
> reset to ensure it works correctly in the new domain.  Usually the
> toolstack will request a device reset via the "reset" sysfs file.  But
> this file is not present if a function reset is not available.
>
> A common use case is a GPU device and its associated audio function.
> In the case where these two devices are simultaneously co-assigned to
> the same domain, it is safe to reset them with an SBR.
>
> Patch #1 export pci_probe_reset_function() so pciback can know if an
> alternate reset mechanism needs to be proved.
>
> Patch #2 adds a "reset" file to devices bound to pciback that performs
> the SBR if it is safe to do so.

I haven't looked at your patches yet, but I added Alex because he did
a lot of similar work for vfio.

Bjorn
