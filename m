Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33570 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2EKPoQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2012 11:44:16 -0400
Received: by pbbrp8 with SMTP id rp8so3458247pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 11 May 2012 08:44:16 -0700 (PDT)
Message-ID: <4FAD33C2.6050109@gmail.com>
Date: Fri, 11 May 2012 23:44:02 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Gleb Natapov <gleb@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, rjw@sisk.pl, alex.williamson@redhat.com,
	Amos Kong <akong@redhat.com>
Subject: Re: [SeaBIOS] [RESEND PATCH v3] hotplug: add device per func in ACPI
 DSDT tables
References: <20111214010645.GA2044@morn.localdomain> <20120509072452.14872.92530.stgit@t> <4FABF832.1060708@gmail.com> <20120510174257.GD14647@redhat.com> <4FABFEE9.9060501@gmail.com> <20120511101415.GD15230@redhat.com>
In-Reply-To: <20120511101415.GD15230@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2012 06:14 PM, Gleb Natapov wrote:
>> I'm not familiar with qemu:(
>> On native OS, admin could trigger PCI device hotplug operations through
>> /sys/bus/pci/slot/xx/power. Not sure whether that's needed for guest OS too. 
>>
> Why is it needed on physical HW? May be it is needed in a VM for the
> same reason?
As Amos has mentioned, it's used power on/off a PCI device instead of physical
hotplug. Not sure whether it's needed in guest OS.
--gerry
