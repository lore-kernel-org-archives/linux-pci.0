Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:49424 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdAWVu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2017 16:50:57 -0500
Date: Mon, 23 Jan 2017 16:49:56 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, rbezut@gmail.com,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI/MSI: Export all remapped MSIs to sysfs attributes
Message-ID: <20170123214956.GA28723@hmswarspite.think-freely.org>
References: <1443051076-27716-1-git-send-email-rbezut@gmail.com>
 <20151015172305.GC17702@localhost>
 <CAL-B5D2zfKg2pzc0M2udS3=tNQ-=RzG8qLdBWAQC3KVh4PRQ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL-B5D2zfKg2pzc0M2udS3=tNQ-=RzG8qLdBWAQC3KVh4PRQ0g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 01:57:28PM -0700, Myron Stowe wrote:
> On Thu, Oct 15, 2015 at 11:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Sep 24, 2015 at 01:31:16AM +0200, Romain Bezut wrote:
> >> irqbalance uses these attributes to populate its internal database, which is
> >> then used to bind the irq on the appropriate NUMA node.
> >>
> >> On a device accepting multiple MSIs and with interrupt remapping enabled,
> >> only the first irq entry is exported to msi_irqs directory.
> >> This results in irqbalance having no clue of the NUMA affinity for the extra
> >> irqs and starting to bind them on random nodes.
> >>
> >> This patch exports all MSI interrupts as sysfs attributes when relevant.
> >>
> >> Signed-off-by: Romain Bezut <rbezut@gmail.com>
> >
> > Applied with Thomas' ack to pci/msi for v4.4, thanks, Romain!
> 
> Internal testing with netperf - network performance between two
> machines with 10Gb Intel NICs running 24 instances of the netperf tool
> in parallel (to utilize all CPU cores) - shows a roughly 20%
> performance degradation.  Bi-section showed the offending commit to be
> this patch: commit a86760664f4 ("PCI/MSI: Export all remapped MSIs to
> sysfs attributes").
> 
>   Prior: 9.62 +-0.00 gbits/sec
>   After: 7.77 +-0.17 gbits/sec
> 


Hmm, any idea whats leading to the performance degradation?  Seems odd that
exposing that info should lead to reduced performance.  is irqbalance placing
the interrupts on a node that is inappropriate (i.e. making the wrong decision
based on the info exposed)?

Neil
 
> >> ---
> >>  drivers/pci/msi.c | 31 +++++++++++++++++--------------
> >>  1 file changed, 17 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> >> index d449714..324a164 100644
> >> --- a/drivers/pci/msi.c
> >> +++ b/drivers/pci/msi.c
> >> @@ -475,10 +475,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
> >>       int ret = -ENOMEM;
> >>       int num_msi = 0;
> >>       int count = 0;
> >> +     int i;
> >>
> >>       /* Determine how many msi entries we have */
> >>       for_each_pci_msi_entry(entry, pdev)
> >> -             ++num_msi;
> >> +             num_msi += entry->nvec_used;
> >>       if (!num_msi)
> >>               return 0;
> >>
> >> @@ -487,19 +488,21 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
> >>       if (!msi_attrs)
> >>               return -ENOMEM;
> >>       for_each_pci_msi_entry(entry, pdev) {
> >> -             msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
> >> -             if (!msi_dev_attr)
> >> -                     goto error_attrs;
> >> -             msi_attrs[count] = &msi_dev_attr->attr;
> >> -
> >> -             sysfs_attr_init(&msi_dev_attr->attr);
> >> -             msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
> >> -                                                 entry->irq);
> >> -             if (!msi_dev_attr->attr.name)
> >> -                     goto error_attrs;
> >> -             msi_dev_attr->attr.mode = S_IRUGO;
> >> -             msi_dev_attr->show = msi_mode_show;
> >> -             ++count;
> >> +             for (i = 0; i < entry->nvec_used; i++) {
> >> +                     msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
> >> +                     if (!msi_dev_attr)
> >> +                             goto error_attrs;
> >> +                     msi_attrs[count] = &msi_dev_attr->attr;
> >> +
> >> +                     sysfs_attr_init(&msi_dev_attr->attr);
> >> +                     msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
> >> +                                                         entry->irq + i);
> >> +                     if (!msi_dev_attr->attr.name)
> >> +                             goto error_attrs;
> >> +                     msi_dev_attr->attr.mode = S_IRUGO;
> >> +                     msi_dev_attr->show = msi_mode_show;
> >> +                     ++count;
> >> +             }
> >>       }
> >>
> >>       msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
> >> --
> >> 2.4.9
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
