Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50668 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab2CPRtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Mar 2012 13:49:41 -0400
Date: Fri, 16 Mar 2012 10:49:34 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Tom Goetz <tom.goetz@virtualcomputer.com>
Cc: linux-usb@vger.kernel.org, xen-devel@lists.xen.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: xHCI not waking up from D3 after S3 Resume on Ivybridge
Message-ID: <20120316174934.GC6077@xanatos>
References: <loom.20120312T142127-400@post.gmane.org>
 <20120313211859.GA16020@xanatos>
 <567DD8FC-9951-4EE3-BA65-51736CD141F8@virtualcomputer.com>
 <20120314165715.GA19308@xanatos>
 <0477B653-4ECF-4D24-A87E-7A2786F4A34B@virtualcomputer.com>
 <C5DCD920-A72C-40B4-B616-DA952FB5B00F@virtualcomputer.com>
 <6A33BBC0-83E3-4D4E-94C5-9594DF32AF97@virtualcomputer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6A33BBC0-83E3-4D4E-94C5-9594DF32AF97@virtualcomputer.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cross posting to the linux-acpi and linux-pci list for help.

Summary:  After an Ivy Bridge laptop is resumed from S3 and the USB 3.0
host controller is in D3, under Xen, the host controller will never come
out of D3 to report a USB device connection.  The same laptop with a
standard Ubuntu install with the same 3.2.11 kernel works fine.

I'm not sure what to make of the ACPI details about wakeup events being
routed to e1000e instead of the xHCI host.  Can someone help out here?

On Thu, Mar 15, 2012 at 04:25:45PM -0400, Tom Goetz wrote:
> On Mar 15, 2012, at 10:35 AM, Tom Goetz wrote:
> > On Mar 14, 2012, at 1:46 PM, Tom Goetz wrote:
> >> On Mar 14, 2012, at 12:57 PM, Sarah Sharp wrote:
> >>> On Wed, Mar 14, 2012 at 09:52:28AM -0400, Tom Goetz wrote:
> >>>>> Why were you posting there in particular?  You're much more
> >>>>> likely to get your USB questions answered on this mailing list.
> >>>>> :)
> >>>> 
> >>>> I'm concerned that this may be a bug in the Xen PVOPs MSI code.
> >>>> To that end I've posted updates on xen-devel here:
> >>>> 
> >>>> http://lists.xen.org/archives/html/xen-devel/2012-03/msg00904.html
> >>>> http://lists.xen.org/archives/html/xen-devel/2012-03/msg00727.html
> >>>> http://lists.xen.org/archives/html/xen-devel/2012-03/msg00978.html
> >>> 
> >>> Does the xHCI host work fine without Xen?  I.e. running Linux
> >>> directly as the host OS, suspending, resuming, and then plugging
> >>> in a device?
> >> 
> >> It works in Ubuntu 12.04 Beta 1 with Linux 3.2.0. So it's either
> >> broken between 3.2.0 and 3.2.5 or it's broken in Xen. I haven't
> >> made a direct comparison yet. I'm putting Ubuntu on my SDP now to
> >> test that.
> > 
> > xHCI wakes up from D3 on the SDP with Ubuntu 12.04 Beta 1 and
> > 3.2.11. This fails with the same 3.2.11 kernel and Xen. So the
> > problem is Xen related.
> 
> Another update.
> 
> On the Ivybridge laptop, xHCI is not waking up because when I plug a
> device into a xHCI port the ACPI wakeup events are going to the
> e1000e. Pre S3, it eventually gets a interrupt from the device that
> wakes it up. Post S3 it never gets an interrupt from the device.
> 
> On the SDP, I get ACPI wake up calls for the xHCI before S3, but not
> after. Both cases work with out Xen. I'm assuming Xen/PVOPs is leaving
> the device in a state the causes the ACPI wake up events to be masked.
> Can you tell me what what state that could be? I can look at
> decompiling the ASL to find out, but that's not my first choice.
> Toggling the power policy (auto->on->auto) does not fix delivery of
> ACPI wake up events for this device. I am still getting ACPI wake ups
> for the e1000e, so it's not all wake ups that are blocked.
> 
> Thanks for any help.
> 
> -Tom-- To unsubscribe from this list: send the line "unsubscribe
> linux-usb" in the body of a message to majordomo@vger.kernel.org More
> majordomo info at  http://vger.kernel.org/majordomo-info.html
