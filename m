Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33951 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbIAVp7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Sep 2015 17:45:59 -0400
Received: by iofb144 with SMTP id b144so17708769iof.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2015 14:45:59 -0700 (PDT)
Date: Tue, 1 Sep 2015 16:45:54 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/AER: Cleanup AER error status registers on probing
 devices
Message-ID: <20150901214554.GA829@google.com>
References: <1438706533-22547-1-git-send-email-izumi.taku@jp.fujitsu.com>
 <20150828213145.GB27890@google.com>
 <E86EADE93E2D054CBCD4E708C38D364A54276116@G01JPEXMBYT01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E86EADE93E2D054CBCD4E708C38D364A54276116@G01JPEXMBYT01>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 01, 2015 at 08:14:41AM +0000, Izumi, Taku wrote:
> Dear Bjorn,
> 
>  Thanks for reviewing.
>  
> > Hello Taku-san,
> > 
> > On Wed, Aug 05, 2015 at 01:42:13AM +0900, Taku Izumi wrote:
> > > AER uncorrectable or correctable error might be recorded
> > > when power on devices. These errors can be ignored, so
> > > BIOS usually clean up these registers ahead of OS's scanning
> > > devices.
> > > However, in case of hot-plug PCIe devices, BIOS can't care.
> > 
> > What happens when we power down a device for suspend or because it's idle?
> > Can we get spurious AER errors when we power the device back up?  This
> > patch only covers the enumeration path, so we'd need to do more if it can
> > happen during suspend/resume.
> 
>   Our server only supports "suspend to disk". In that case,
>   BIOS cleans up those registers like boot-time.
>   So It seems that no troubles are previously reported other 
>   than hot-plug case.
> 
>   However, if box supports suspend-to-RAM, similar problem may happen.
>   It is true that that register clean-up should be done during suspend/resume
>   case. Should we cover during-suspend/resume case ?

Yes, I think so.  pci_restore_state() restores a lot of other
configuration; maybe it should do something with AER also.

There is a disturbing lack of symmetry between the boot/hot-add paths and
the resume-from-D3 path.  We're doing similar things, at least from the
hardware point of view, but the code is not similar at all.  It would be
nice if we could unify those somehow.

Bjorn
