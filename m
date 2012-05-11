Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60517 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422636Ab2EKSJX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 May 2012 14:09:23 -0400
Date: Fri, 11 May 2012 20:04:12 +0300
From: Gleb Natapov <gleb@redhat.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, rjw@sisk.pl, alex.williamson@redhat.com,
	Amos Kong <akong@redhat.com>
Subject: Re: [SeaBIOS] [RESEND PATCH v3] hotplug: add device per func in ACPI
 DSDT tables
Message-ID: <20120511170412.GE15230@redhat.com>
References: <20111214010645.GA2044@morn.localdomain>
 <20120509072452.14872.92530.stgit@t>
 <4FABF832.1060708@gmail.com>
 <20120510174257.GD14647@redhat.com>
 <4FABFEE9.9060501@gmail.com>
 <20120511101415.GD15230@redhat.com>
 <4FAD33C2.6050109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FAD33C2.6050109@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2012 at 11:44:02PM +0800, Jiang Liu wrote:
> On 05/11/2012 06:14 PM, Gleb Natapov wrote:
> >> I'm not familiar with qemu:(
> >> On native OS, admin could trigger PCI device hotplug operations through
> >> /sys/bus/pci/slot/xx/power. Not sure whether that's needed for guest OS too. 
> >>
> > Why is it needed on physical HW? May be it is needed in a VM for the
> > same reason?
> As Amos has mentioned, it's used power on/off a PCI device instead of physical
> hotplug. Not sure whether it's needed in guest OS.
Probably for assigned devices.

--
			Gleb.
