Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 May 2015 08:06:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150514075957-mutt-send-email-mst@redhat.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
 <1431431730-25164-2-git-send-email-mst@redhat.com>
 <871tilmwiq.fsf@x220.int.ebiederm.org>
 <20150513081101-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513081101-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 13, 2015 at 08:41:55AM +0200, Michael S. Tsirkin wrote:
> > This also sounds like a case for implementing a shutdown callback and
> > disabling things properly.  A properly shutdown driver should have
> > already disabled MSI's.  A driver is responsible for enabling MSIs so it
> > should be responsible for disabling it.  The core disabling MSIs is
> > mostly to catch the handful of lazy drivers that forget.
> 
> 
> Okay! And I am saying that if the driver did forget,
> we are better off not disabling it - leave it enabled
> until kexec starts and disables it.
> 
> 
> > The bottom line is that there are a few things that are standard
> > behavior that we can do in the generic code, but at the end of the day
> > it is the responsibility of the driver to shut things down and whatever
> > driver you are dealing with clearly has a bunch of bugs and you aren't
> > fixing it. 
> 
> So please let us get on with fixing it in driver and stop
> playing with device in core.

Eric, does this argument make sense?  Drivers should do the right thing
in their shutdown callback, let's not try to work around their bugs in
core.

-- 
MST
