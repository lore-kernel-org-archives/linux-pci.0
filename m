Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33886 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775AbbKXUF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 15:05:58 -0500
Date: Tue, 24 Nov 2015 14:05:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mathias Krause <minipli@googlemail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Sasha Levin <sasha.levin@oracle.com>,
	Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2] PCI: Prevent out of bounds access in numa_node
 override - part 2
Message-ID: <20151124200551.GA17377@localhost>
References: <1447095627-12798-1-git-send-email-minipli@googlemail.com>
 <20151124184957.GB27957@localhost>
 <CA+rthh_hmYqpyu-cREMtFBevPJjpUG3LE28htrtSGr3ipdzD_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+rthh_hmYqpyu-cREMtFBevPJjpUG3LE28htrtSGr3ipdzD_w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 24, 2015 at 08:27:04PM +0100, Mathias Krause wrote:
> On 24 November 2015 at 19:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Applied as tweaked below to for-linus for v4.4, thanks!  As written,
> > if NUMA_NO_NODE were defined as -2, we would incorrectly accept -1.
> > Let me know if you disagree with my fix.
> 
> I don't think the value of NUMA_NO_NODE will (or even has to) ever
> change, as we're already exporting that value to userland via sysfs.
> But you're right, the code shouldn't make any assumptions about the
> concrete value of NUMA_NO_NODE and just handle it as a special
> symbolic value.
> 
> > commit 2a35194c5a45fbb9ca1d88bc56804dfb51a75233
> > Author: Mathias Krause <minipli@googlemail.com>
> > Date:   Mon Nov 9 20:00:27 2015 +0100
> >
> >     PCI: Prevent out of bounds access in numa_node override
> >
> >     Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
> >     override") missed that the user-provided node could also be negative.
> >     Handle this case as well to avoid out-of-bounds accesses to the
> >     node_states[] array.  However, allow the special value -1, i.e.
> >     NUMA_NO_NODE, to be able to set the 'no specific node' configuration.
> >
> >     [bhelgaas: remove assumption that NUMA_NO_NODE == -1]
> >     Fixes: 1266963170f5 ("PCI: Prevent out of bounds access in numa_node override")
> >     Fixes: 63692df103e9 ("PCI: Allow numa_node override via sysfs")
> >     Signed-off-by: Mathias Krause <minipli@googlemail.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     CC: Sasha Levin <sasha.levin@oracle.com>
> >     CC: Prarit Bhargava <prarit@redhat.com>
> >     CC: stable@vger.kernel.org  # v3.19+
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 9261868..50f4747 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -216,7 +216,12 @@ static ssize_t numa_node_store(struct device *dev,
> >         if (ret)
> >                 return ret;
> >
> > -       if (node >= MAX_NUMNODES || !node_online(node))
> > +       if (node < 0 || node >= MAX_NUMNODES) {
> > +               if (node != NUMA_NO_NODE)
> > +                       return -EINVAL;
> > +       }
> 
> I would have written something like this:
> 
>     if ((node < 0 && node != NUMA_NO_NODE) || node >= MAX_NUMNODES)
>         return -EINVAL;

I adopted that, thanks!
