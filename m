Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965209AbdIZUC5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Sep 2017 16:02:57 -0400
Date: Tue, 26 Sep 2017 15:02:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: don't use snprintf() in driver_override_show()
Message-ID: <20170926200254.GP15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170911074542.16777-1-nstange@suse.de>
 <20170911074542.16777-3-nstange@suse.de>
 <20170911115511.GB16198@kroah.com>
 <20170925234819.GH15970@bhelgaas-glaptop.roam.corp.google.com>
 <87zi9ivuec.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zi9ivuec.fsf@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 26, 2017 at 08:36:11AM +0200, Nicolai Stange wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Mon, Sep 11, 2017 at 04:55:11AM -0700, Greg Kroah-Hartman wrote:
> >> On Mon, Sep 11, 2017 at 09:45:41AM +0200, Nicolai Stange wrote:
> >> > Quote from Documentation/filesystems/sysfs.txt:
> >> > 
> >> >   show() must not use snprintf() when formatting the value to be
> >> >   returned to user space. If you can guarantee that an overflow
> >> >   will never happen you can use sprintf() otherwise you must use
> >> >   scnprintf().
> >> > 
> >> > Commit 4efe874aace5 ("PCI: Don't read past the end of sysfs
> >> > "driver_override" buffer") introduced such a snprintf() usage from
> >> > driver_override_show() while at the same time tweaking
> >> > driver_override_store() such that the write buffer can't ever get
> >> > overflowed.
> >> > 
> >> > Reasoning:
> >> > Since aforementioned commit, driver_override_store() only accepts to be
> >> > written buffers less than PAGE_SIZE - 1 in size.
> >> > 
> >> > The then kstrndup()'ed driver_override string will be at most PAGE_SIZE - 1
> >> > in length, including the trailing '\0'.
> >> > 
> >> > After the addition of a '\n' in driver_override_show(), the result won't
> >> > exceed PAGE_SIZE characters in length, again including the trailing '\0'.
> >> > 
> >> > Hence, snprintf(buf, PAGE_SIZE, ...) and sprintf(buf, ...) are equivalent
> >> > at this point.
> >> > 
> >> > Replace the former by the latter in order to adhere to the rules in
> >> > Documentation/filesystems/sysfs.txt.
> >> > 
> >> > This is a style fix only and there's no change in functionality.
> >> > 
> >> > Signed-off-by: Nicolai Stange <nstange@suse.de>
> >> > ---
> >> >  drivers/pci/pci-sysfs.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > 
> >> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> > index 8e075ea2743e..43f7fbede448 100644
> >> > --- a/drivers/pci/pci-sysfs.c
> >> > +++ b/drivers/pci/pci-sysfs.c
> >> > @@ -722,7 +722,7 @@ static ssize_t driver_override_show(struct device *dev,
> >> >  	ssize_t len;
> >> >  
> >> >  	device_lock(dev);
> >> > -	len = snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
> >> > +	len = sprintf(buf, "%s\n", pdev->driver_override);
> >> 
> >> While I'm all for changes like this, it's an uphill battle to change
> >> them, usually it's best to just catch them before they go into the tree.
> 
> I did this patch mostly for demonstrating why the exclusion of the
> sprintf() -> snprintf() change from the port of
> 
>   3d713e0e382e ("driver core: platform: add device binding path 'driver_override'")
> 
> to platform in [3/3] is safe. Because I'm pretty sure that [3/3] would
> have been rejected if it had included that chunk -- due to the
> non-conformity to Documentation/.
> 
> 
> >> Anyway, nice summary, very good job with that.
> >> 
> >> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Why use snprintf() instead of scnprintf()?  
> 
> s/snprintf/sprintf/, right?

Yep, sorry!  I meant "why use sprintf() instead of scnprintf()?"

> > It looks like snprintf() is probably safe, but requires a bunch of
> > analysis to prove that, while scnprintf() would be obviously safe.
> 
> Personal preference, I guess. Something like "using sprintf() would
> implicitly document that the buffer is always large enough", i.e. that
> the size check in driver_override_store() is already strict enough / correct.
> 
> Anyway, I don't have a strong opinion on that. So if you want me to
> change this, I'll do, of course. Just note that Greg K-H. has queued up
> [3/3] somewhere already and thus, it would probably require two patches
> rather than only this one to make PCI and platform look the same again,
> provided that's what is wanted.
> 
> So, given that this patch has fulfilled its purpose already, I'm fine
> with either of
> - dropping it
> - taking it
> - s/sprintf/scnprintf/ and do the same for platform.

OK, I think I'll drop it.

I think the documentation is misleading.  The problem with
snprintf() is not that it might overflow the buffer; the problem is
that it might return more characters than it actually put in the
buffer.

I would be happy to see patches that change driver_override_show()
(there are three of them) to use scnprintf() instead of sprintf() or
snprintf().

Is the third case (the amba driver_override store/show functions)
susceptible to the same issues you're fixing for platform and PCI?

Bjorn
