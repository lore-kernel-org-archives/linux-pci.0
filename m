Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 May 2015 11:53:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150514113732-mutt-send-email-mst@redhat.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
 <1431431730-25164-2-git-send-email-mst@redhat.com>
 <871tilmwiq.fsf@x220.int.ebiederm.org>
 <20150513081101-mutt-send-email-mst@redhat.com>
 <20150514075957-mutt-send-email-mst@redhat.com>
 <46708A26-16CB-4417-BCFA-12F4C78FC2F7@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46708A26-16CB-4417-BCFA-12F4C78FC2F7@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 14, 2015 at 02:58:59AM -0500, Eric W. Biederman wrote:
> 
> 
> On May 14, 2015 1:06:00 AM CDT, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Wed, May 13, 2015 at 08:41:55AM +0200, Michael S. Tsirkin wrote:
> >> > This also sounds like a case for implementing a shutdown callback
> >and
> >> > disabling things properly.  A properly shutdown driver should have
> >> > already disabled MSI's.  A driver is responsible for enabling MSIs
> >so it
> >> > should be responsible for disabling it.  The core disabling MSIs is
> >> > mostly to catch the handful of lazy drivers that forget.
> >> 
> >> 
> >> Okay! And I am saying that if the driver did forget,
> >> we are better off not disabling it - leave it enabled
> >> until kexec starts and disables it.
> >> 
> >> 
> >> > The bottom line is that there are a few things that are standard
> >> > behavior that we can do in the generic code, but at the end of the
> >day
> >> > it is the responsibility of the driver to shut things down and
> >whatever
> >> > driver you are dealing with clearly has a bunch of bugs and you
> >aren't
> >> > fixing it. 
> >> 
> >> So please let us get on with fixing it in driver and stop
> >> playing with device in core.
> >
> >Eric, does this argument make sense?  Drivers should do the right thing
> >in their shutdown callback, let's not try to work around their bugs in
> >core.
> 
> Not in context of this patch, as this change appears to
> be to avoid fixing the driver.

Not really. I do intend to work on adding shutdown to virtio: e.g. we
really must change avoid running config change interrupts.
but I would like the core to do the right thing, so I argue
about what's best for general core to do, and what has the least
chance to cause hangs.

> Further this behavior in the core has existed for the
> better part of a decade.
>  Who knows what weird
> behavior (called regressions) this will trigger with
> other drivers in other situations.

That is also part of the argument. It used to be so, but
now it really can not trigger any regressions because we
have since added a bigger hammer: disabling bus mastering.

Do you disagree with this? How can leaving msi on cause harm?

> I do not see any reason to change the existing behavior here.
> 
> Especially as if you try and boot a non-linux kernel with
> kexec

First time I hear about this requirement. Does anyone do this? I find
it hard to believe it works ...

> you are almost certainly going to subject it to a
> screaming MSI interrupt and there almost certainly will
> not be code to disable MSIs as they are disabled by at
> boot up by default.
> 
> Eric

OTOH if you do disable MSI but leave device functioning you will just
get screaming INT#x which is even worse because it will end up disabling
INT#x which is shared, and so breaking multiple devices and not just
this one.

-- 
MST
