Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:58245 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab3DYG2m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2013 02:28:42 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so2494192oag.39
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 23:28:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXwM_Jd_fbB7fKUAxuQJNXEbPA0yfWN_xFnYFUNxE8URg@mail.gmail.com>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
	<CAAh6nkmkbKh7FjEZea4GmEbZvH4qvnfOJ2Og8xHYm5othsWLwQ@mail.gmail.com>
	<CAErSpo6zf34MOLNh5t_PifYhA87vFLRRx-g0WG5N=8+oUcWukQ@mail.gmail.com>
	<3400627.YcEmgrxv5I@vostro.rjw.lan>
	<CAE9FiQX7zyaZVm7QsZnOXtRD9qcCGCFpi2DLve863juL1ZxcWQ@mail.gmail.com>
	<CAE9FiQXwM_Jd_fbB7fKUAxuQJNXEbPA0yfWN_xFnYFUNxE8URg@mail.gmail.com>
Date: Thu, 25 Apr 2013 14:28:42 +0800
Message-ID: <CAAh6nkmV3QYGuB1q8zZh94QdWUjx=1cxDycx92w3xhLV8RvkRg@mail.gmail.com>
Subject: Re: About dynamically loading the acpiphp.ko
From: Gavin Guo <tuffkidtt@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/4/25 Yinghai Lu <yinghai@kernel.org>
>
> On Wed, Apr 24, 2013 at 6:20 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Wed, Apr 24, 2013 at 3:55 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> On Wednesday, April 24, 2013 02:03:04 PM Bjorn Helgaas wrote:
> >>>
> >>> We install a notify handler on PCI0 in find_root_bridges(), and that
> >>> notify handler leads to _handle_hotplug_event_root(), which assumes
> >>> this is a host bridge hotplug event.  But I would expect the notify
> >>> for a host bridge hot-add would go to the *parent* of the host bridge,
> >>> not to the host bridge itself, so something seems wrong here.
> >>>
> >>> Maybe the ACPI & hotplug experts can comment on this.
> >>
> >> I think it may (ie. won't be against the spec) go both ways, so it may go
> >> to the parent or the host bridge object itself.  We should be handling both
> >> cases IMO.
> >
> > Yes, we missed that path.
> >
> > Attached patch should fix the problem.
> >
> > Gavin,
> >
> > Can you please check that on top of pci/next?
>
> updated -v2.

Hi Yinghai,

I tested the first version of your patch and it can't work. Now, I'm
testing the v2 of your patch. Please wait a minute.

Gavin Guo
