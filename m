Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Jun 2015 20:37:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150603203217-mutt-send-email-mst@redhat.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
 <1431431730-25164-2-git-send-email-mst@redhat.com>
 <871tilmwiq.fsf@x220.int.ebiederm.org>
 <20150513081101-mutt-send-email-mst@redhat.com>
 <20150514075957-mutt-send-email-mst@redhat.com>
 <46708A26-16CB-4417-BCFA-12F4C78FC2F7@xmission.com>
 <20150514113732-mutt-send-email-mst@redhat.com>
 <20150528182645-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528182645-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 06:36:22PM +0200, Michael S. Tsirkin wrote:
> On Thu, May 14, 2015 at 11:53:34AM +0200, Michael S. Tsirkin wrote:
> > > you are almost certainly going to subject it to a
> > > screaming MSI interrupt and there almost certainly will
> > > not be code to disable MSIs as they are disabled by at
> > > boot up by default.
> > > 
> > > Eric
> > 
> > OTOH if you do disable MSI but leave device functioning you will just
> > get screaming INT#x which is even worse because it will end up disabling
> > INT#x which is shared, and so breaking multiple devices and not just
> > this one.
> 
> Eric, can you comment on this please?
> To list the points again:
> 	1- if device is properly shut down there's no need to disable MSIs
> 	2- if device is not properly shut down disabling MSIs will cause
> 	   screaming INT#x interrupts
> 	3- in both cases if we leave MSI on then we can be sure we won't
> 	   get screaming interrupts since we now disable bus mastering
>            which suppresses MSIs (but not INT#x)
> 
> Looking at the commit that added the disable, that is d52877c7b1af, you
> will see that historically it preceded b566a22c23. So the screaming MSI
> problem that d52877c7b1af tried to address is now gone, addressed by
> b566a22c23.
> 
> What do you think?

Eric, Bjor, could you comment?
I'm sorry if these repeating questions are annoying to you, but the
comment that not disabling msi can cause screaming interrupts seems to
be based on state of the kernel before 2012.

Ever since
commit b566a22c23327f18ce941ffad0ca907e50a53d41
    PCI: disable Bus Master on PCI device shutdown
even broken devices that don't disable msi on shutdown can
not cause screaming interrupts even if core leaves msi alone.

So I don't see how can removing that code cause regressions, and it
might improve the situation since it reduces the chance of
getting screaming INT#x.

> > -- 
> > MST
