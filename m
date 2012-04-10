Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:63129 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab2DJUHC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 16:07:02 -0400
Received: by dake40 with SMTP id e40so194230dak.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 13:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F848E10.1090703@snewbury.org.uk>
References: <1333968563.5678.19.camel@infinity>
	<CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	<4F84110E.3000400@snewbury.org.uk>
	<CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	<4F8467AA.90305@snewbury.org.uk>
	<CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	<4F848357.3060007@snewbury.org.uk>
	<CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	<4F848E10.1090703@snewbury.org.uk>
Date: Tue, 10 Apr 2012 13:07:02 -0700
Message-ID: <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2012 at 12:46 PM, Steven Newbury <steve@snewbury.org.uk> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>> the suitable range for that is 0xe0000000-0xefffffff. that is not
>> bigger enough, because need to preallocate 64M optional for 03:01.0
>> the cardbus. but that is optional.
>
> Maybe this is a stupid question, but is there any way of enlarging the
> PCI hole?

Sane BIOS should have one option to increase that.

or it should probe MMIO range it need to allocate for pci devices and
hotplug. then set TOP_OF_LOW_MEM.

Yinghai
