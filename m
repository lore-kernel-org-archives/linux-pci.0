Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54838 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab2JYBYM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Oct 2012 21:24:12 -0400
MIME-Version: 1.0
In-Reply-To: <17130842.qTSs14eT8a@vostro.rjw.lan>
References: <50841CCC.9030809@uli-eckhardt.de>
	<6817642.hqndXjdIQA@vostro.rjw.lan>
	<CAErSpo5cN5w=E8GYyKE=bX0=67Qk0g0wAW4vVFe0QfPGxo=+MA@mail.gmail.com>
	<17130842.qTSs14eT8a@vostro.rjw.lan>
Date: Thu, 25 Oct 2012 09:24:10 +0800
Message-ID: <CACVXFVNnrCLo76rh8-hxTdf3C=kvw3ejY6Jg1==COqFC+UHMBg@mail.gmail.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
From: Ming Lei <ming.lei@canonical.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 25, 2012 at 5:31 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

>> I don't know how to use those.  Is there a doc somewhere?
>
> I'm not sure, but let's ask the developer who added them.
>
> Lei, do you have any doc describing how to use those tracepoints?

Hi Bjorn Helgaas,

Firstly, please enable these tracepoints via below

          echo 1 > /sys/kernel/debug/tracing/events/rpm/enable

then store the trace event result by below once you make sure your interested
events are completed:

          echo 0 > /sys/kernel/debug/tracing/events/rpm/enable
          cp /sys/kernel/debug/tracing/trace /media/ram/rpm-trace

For the format of the captured trace log(rpm-trace), please see

                include/trace/events/rpm.h

which is just a replacement of previous printk and add some extra fields
into that.  If you still don't understand the format, please post the
result onto list, and I think many guys here may help you out.

Hope the above can help you.


Thanks,
--
Ming Lei
