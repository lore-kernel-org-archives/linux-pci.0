Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:32884 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbEGPEQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 11:04:16 -0400
Received: by iepj10 with SMTP id j10so38283770iep.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2015 08:04:15 -0700 (PDT)
Date: Thu, 7 May 2015 10:04:12 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Michael S. Tsirkin" <mst@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 00/10] PCI: Fix unhandled interrupt on shutdown
Message-ID: <20150507150412.GI24643@google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150426084739-mutt-send-email-mst@kernel.org>
 <20150506210327.GG24643@google.com>
 <871titfbs3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871titfbs3.fsf@x220.int.ebiederm.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 07:53:48PM -0500, Eric W. Biederman wrote:
> Bjorn Helgaas <bhelgaas@google.com> writes:
> 
> > On Sun, Apr 26, 2015 at 08:50:06AM +0200, Michael S. Tsirkin wrote:
> >> On Fri, Apr 10, 2015 at 05:54:19PM -0500, Bjorn Helgaas wrote:
> >> > Hi Michael,
> >> > 
> >> > I put your patches on my pci/msi branch and I hope to merge them for v4.1.
> >> > I didn't apply the acks from Fam and Eric because I made changes to those
> >> > patches that weren't completely trivial.  I think the end result is
> >> > equivalent, though.  The diff attached to this cover letter is the
> >> > difference between your v5 series and this v6 series.
> >> > 
> >> > As far as I'm concerned, this is ready to go except that I would like a
> >> > little more info about the virtio kernel hang to include in the changelog
> >> > for "PCI/MSI: Don't disable MSI/MSI-X at shutdown".
> >> 
> >> 
> >> Hi Bjorn,
> >> do you have eveything you need to merge this?
> >
> > No.  I made the minor changelog edits you suggested and the result is on
> > my pci/msi-v7 branch.  But I still have these open issues:
> >
> >   - The last thing I heard from Eric was that "not disabling MSI/MSI-X at
> >     shutdown is the wrong fix, and someone needs to fix a buggy driver."
> >     I want to hear Eric say "OK, we need to leave MSI/MSI-X enabled at
> >     shutdown for this case."
> 
> So far this just sounds like a device that needs a shutdown method.
> 
> >   - One changelog says "Stop disabling MSIs at shutdown to avoid
> >     conflicting with drivers."  But I don't know what the conflict is.
> >
> >   - The bugzilla has no dmesg log or detailed analysis.  Fam said the
> >     scenario I came up with
> >     (http://lkml.kernel.org/r/20150416194245.GB20701@google.com)
> >     was fairly close, but it took me a lot of work to derive that.  Fixing
> >     any errors in it and putting it in the bugzilla would be a big step.
> >     The bugzilla should have the raw data and the analysis, so someone else
> >     can validate the analysis and conclude that this patch is a reasonable
> >     fix for it.  That's currently impossible because the bugzilla really
> >     only contains the fix as a fait accompli.
> 
> What I saw in the bugzilla was:
> 
> An interrupt was stuck on, and being reasserted as quickly as we could
> call iret for that interrupt.
> 
> We did not disable that interrupt because irq debugging was explicitly
> disabled on the kernel command line.
> 
> The irq was asserted because the the device did not have a shutdown
> method to stop the device doing things.
> 
> There is an argument that disabling bus mastering should have disabled
> whatever the interrupting condition was (and thus there may also be a
> bug in the qemu device emulation).
> 
> So I read this as the driver and maybe the "hardware" is buggy not that
> the linux pci layer is buggy.

OK, it sounds like we don't have consensus on this issue yet.

The rest of the series, which disable MSIs at boot-time even without
CONFIG_PCI_MSI=y in the new kernel and does some cleanup, seems worthwhile
and non-controversial, so I reordered it and applied the following patches
to pci/msi for v4.2:

  PCI/MSI: Rename msi_set_enable(), msix_clear_and_set_ctrl()
  PCI/MSI: Export pci_msi_set_enable(), pci_msix_clear_and_set_ctrl()
  PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI
  virtio_pci: drop pci_msi_off() call during probe
  ntb: Drop pci_msi_off() call during probe
  PCI/MSI: Drop pci_msi_off() calls from quirks
  PCI/MSI: Remove unused pci_msi_off()

I removed the "stable" annotations because I don't have a clear report of
a bug that this fixes.  If it does fix a bug, please point me to a
bugzilla, and I can add the stable annotations back.

That leaves these two:

  PCI/MSI: Don't disable MSI/MSI-X at shutdown
  PCI/MSI: Make pci_msi_shutdown(), pci_msix_shutdown() static

I'm going to ignore them until you guys figure out what to do.

Bjorn
