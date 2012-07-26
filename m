Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52608 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2GZCi4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jul 2012 22:38:56 -0400
Message-ID: <1343270334.3874.4.camel@yhuang-dev>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Huang Ying <ying.huang@intel.com>
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 26 Jul 2012 10:38:54 +0800
In-Reply-To: <87pq7j79j6.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	 <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	 <874now7xi8.fsf@nemi.mork.no> <201207252202.22302.rjw@sisk.pl>
	 <87pq7j79j6.fsf@nemi.mork.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-07-26 at 00:36 +0200, Bjørn Mork wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > This is not really necessary.  The problem is the change of behavior I was
> > worried about some time ago.
> >
> > Namely, the device in question apparently doesn't support ACPI D3_hot,
> > so acpi_pm_device_sleep_state() returns D2 as the target state, where it
> > would return D3(cold) before the commit in question.
> >
> > To fix the regression, we'd need to reverse the current initial value of
> > the d3cold_allowed flag so that it is set to "true" by default and only
> > set to "false" for devices where we suspect there may be problems with
> > D3_cold (like PCI Express ports).
> 
> Good.  May I also request a few lines describing d3cold_allowed in e.g
> Documentation/ABI/testing/sysfs-bus-pci?  I must admit that I thought
> that was the policy for any new sysfs file, but it seems that is only
> in the USB subsystem?
> 
> Anyway, I believe it ought to be a requirement.  If we are meant to
> tweak some knob, then we must known how and when to do so.  If not, then
> why add it in the first place?

Yes.  I should have added the ABI document.  Will write a patch for
that.

Best Regards,
Huang Ying


