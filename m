Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52387 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2EWRQG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 13:16:06 -0400
Received: by dady13 with SMTP id y13so10013941dad.19
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 10:16:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120523155346.GA23940@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
	<CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
	<20120523024313.GA2888@redhat.com>
	<CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
	<CAE9FiQVPyjsB=oWp80sgqzkWw8KqX0GHg+csM39juo2N67P2Tg@mail.gmail.com>
	<20120523155346.GA23940@redhat.com>
Date: Wed, 23 May 2012 10:16:06 -0700
Message-ID: <CAE9FiQWPpKE5vmzZqw-E_L_0Lt1QpqV=xk=Hu6Stzva5vXk1_g@mail.gmail.com>
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Jason Baron <jbaron@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 8:53 AM, Jason Baron <jbaron@redhat.com> wrote:
>> > but still would prefer you to make qemu to support pciehp.
>>
>> another solution could be:
>>
>> in qemu acpi dsdt, you could set bridge size for new added bridge.
>>
>> current pbus_size_mem() will not shrink the old bridge resource size.
>
> ok, I also tried hard-wiring the bridge io/mem base and limit registers on the
> qemu side. That seems to work without any guest-side hotplug code changes. And
> would seem to be more flexible than putting the limits in acpi.

that should be acpi asl code or SMI work. and should make sure that
range is not overlapped with resources that are used by other bridges
and pci devices.

Thanks

Yinghai
