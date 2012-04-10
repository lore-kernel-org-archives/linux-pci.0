Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:57844 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab2DJSka (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 14:40:30 -0400
Received: by dake40 with SMTP id e40so112122dak.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 11:40:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F8467AA.90305@snewbury.org.uk>
References: <1333968563.5678.19.camel@infinity>
	<CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	<4F84110E.3000400@snewbury.org.uk>
	<CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	<4F8467AA.90305@snewbury.org.uk>
Date: Tue, 10 Apr 2012 11:40:30 -0700
Message-ID: <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2012 at 10:02 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
>
>>
>> Can you please try attached patches with pci=nocrs?
>>
>> for pci=use_crs, we need find safe place beyond _CRS, because your
>> _CRS limit under 4g.
>>
..
> So far it has changed behaviour:
>
> Many devices now assigned above 4g.
>
> When booted while docked i915 fails to initialise, along with radeon as
> before.
>
> When undocked i915 initialises, but radeon still fails when hot-docked.
>
> I've attached output of 'lspci -vvv', 'cat /proc/iomem', and "dmesg.log"
> for the docked case.
>
> Also, "dmesg-hotplug.out" for hot docking after boot.

looks good,  please only apply

allocate_high_at_first.patch

     Yinghai
