Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 21 May 2015 14:21:33 +0800
From: Fam Zheng <famz@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150521062133.GA19684@fam-t430.nay.redhat.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
 <1431431730-25164-2-git-send-email-mst@redhat.com>
 <20150519145853.GP31666@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150519145853.GP31666@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 05/19 09:58, Bjorn Helgaas wrote:
> On Tue, May 12, 2015 at 03:03:32PM +0200, Michael S. Tsirkin wrote:
> > d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
> > v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.
> > ... 

Hi Bjorn,
> 
> I know you're trying to put all the justification in the changelog, and
> that's great if it can be done.  But would you please just add the single
> link here to https://bugzilla.kernel.org/show_bug.cgi?id=96571 ?
> 
> And please attach the dmesg log and instructions for reproducing the
> problem to the bugzilla.  I've asked for this before, and it seems like a
> simple request, but maybe there's a reason it's more complicated than it
> seems to me.  It's obvious to you how all this fits together, but I'd like
> it to be more concrete to the rest of us, too.

I've updated what I could see with current master build as much as I can, the
softlockup is not observed in my tests, but the dmesg log already shows the
spurious IRQ.

> 
> The bugzilla says Ulrich Obergfell noticed this in RHEL7.  If there's a
> RHEL bugzilla, it'd be nice to have a link to it in the kernel.org
> bugzilla.  Informal hints are great right now, but they'll be useless after
> six months.

The original bug is not public accessible, so I didn't include the link.

Fam
