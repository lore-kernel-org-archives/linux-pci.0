Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:53423 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758443Ab2DJMYy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 08:24:54 -0400
Message-ID: <4F84110E.3000400@snewbury.org.uk>
Date: Tue, 10 Apr 2012 11:53:02 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
In-Reply-To: <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/04/12 01:51, Bjorn Helgaas wrote:
> On Mon, Apr 9, 2012 at 4:49 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
>> Hi Bjorn,
>>
>> like many users here:
>>
>> https://bugs.launchpad.net/ubuntu/+source/nvidia-graphics-drivers-180/+bug/342926
>>
>> I've hit this bug:
>> https://bugzilla.kernel.org/show_bug.cgi?id=10461
>>
>> I was wondering whether an option to enable an algorithm which
>> allocated all 64bit capable devices above 4GB would at least allow
>> systems where the BIOS has not provided a sufficient PCI hole to
>> initialise all PCI devices?  I've been digging into the code, but I'm
>> not yet comfortable to seriously attempt this myself, certainly not
>> without guidance.
>>
>> It's a shame TJ seems to have disappeared, it would have been great to
>> have had a look at his code, I'm sure many of these problems would have
>> been resolved.
>>
>> Any help, workarounds, guidance or patches welcome! :)
> Please attach complete dmesg logs with and without "pci=use_crs" to
> the bugzilla.
>
>
dmesg logs attached to bug, for both pci=use_crs and pci=nocrs.  In both
cases assignment fails.
