Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752705AbeAXAqK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 19:46:10 -0500
Date: Tue, 23 Jan 2018 18:46:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [GIT PULL] PCI fixes for v4.15
Message-ID: <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 12:49:22PM -0800, Linus Torvalds wrote:
> On Tue, Jan 23, 2018 at 11:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - fix AMD regression due to not re-enabling the big window on resume
> >     (Christian König)
> 
> Bjorn, I think you need to look at your email habits.
> 
> I suspect you're editing your mailbox, or you're using some broken
> mailer setup, or something (using some broken "export" function?),
> because you're corrupting Christian's name all the time:
> 
> > =?UTF-8?q?Christian=20K=C3=B6nig?= (1):
> >       x86/PCI: Enable AMD 64-bit window on resume
> 
> and I'm pretty sure git gets this right if actually fed a real mbox,
> but I suspect that you have some other workflow going on..

I'm not editing my mailbox, but I am using stgit.  The "From:" header
uses encoded-word syntax for Christian's name, and I think stgit is
not decoding that when applying the patch.

When I save the patch email message from mutt (or gmail, for that
matter), I see:

  From: "=?UTF-8?q?Christian=20K=C3=B6nig?="  ...

Applying that patch with "git am" results in the correct

  Author: Christian König <ckoenig.leichtzumerken@gmail.com

Applying the identical patch with "stg import -M" results in

  Author: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>

Some of Christian's PCI patches came out OK (8bb705e3e79d,
276b738deb5b, cb21bc9469c4).  I don't remember specifically, but I
suspect I fixed those manually.

I don't know if there's some stg configuration I could do to fix this.
I looked a little bit but haven't found anything yet.

Thanks for pointing this out.  I'll try to fix this one way or another
in the future.

Bjorn
