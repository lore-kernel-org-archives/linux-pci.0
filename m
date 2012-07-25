Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:59023 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2GYWhF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 18:37:05 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Huang Ying <ying.huang@intel.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	<874now7xi8.fsf@nemi.mork.no> <201207252202.22302.rjw@sisk.pl>
Date: Thu, 26 Jul 2012 00:36:45 +0200
In-Reply-To: <201207252202.22302.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 25 Jul 2012 22:02:22 +0200")
Message-ID: <87pq7j79j6.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> This is not really necessary.  The problem is the change of behavior I was
> worried about some time ago.
>
> Namely, the device in question apparently doesn't support ACPI D3_hot,
> so acpi_pm_device_sleep_state() returns D2 as the target state, where it
> would return D3(cold) before the commit in question.
>
> To fix the regression, we'd need to reverse the current initial value of
> the d3cold_allowed flag so that it is set to "true" by default and only
> set to "false" for devices where we suspect there may be problems with
> D3_cold (like PCI Express ports).

Good.  May I also request a few lines describing d3cold_allowed in e.g
Documentation/ABI/testing/sysfs-bus-pci?  I must admit that I thought
that was the policy for any new sysfs file, but it seems that is only
in the USB subsystem?

Anyway, I believe it ought to be a requirement.  If we are meant to
tweak some knob, then we must known how and when to do so.  If not, then
why add it in the first place?


Bjørn
