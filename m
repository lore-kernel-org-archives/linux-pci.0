Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62990 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab2G2UMz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2012 16:12:55 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1207291051310.18141-100000@netrider.rowland.org>
References: <201207291555.52749.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1207291051310.18141-100000@netrider.rowland.org>
Date: Mon, 30 Jul 2012 01:42:55 +0530
Message-ID: <CABb+yY2G7VurriJEbo-5WXY0kpyBB0cEWeACDDv++AHcKFZ+hQ@mail.gmail.com>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Jassi Brar <jassisinghbrar@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>,
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2012 at 8:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> For me there's also an issue of style: If you do a synchronous get then it
> looks odd not to do a synchronous put.  My feeling has always been that
> the async routines are for use in non-process contexts, where the sync
> routines can't be used.  Using them just to return a little more
> quickly is a foreign idea.
>
Another way of looking at it is - I need h/w to be active in order to
proceed so I call get_sync but I don't care if the h/w is not put down
immediately after I am done using it. So the put could be
relaxed/async - At best, we could avoid an unnecessary suspend-resume
cycle which could be expensive power and time wise. At worst, we
return a bit quicker. Or so do I think.
