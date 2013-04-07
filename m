Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:65362 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933536Ab3DGNJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Apr 2013 09:09:06 -0400
MIME-Version: 1.0
In-Reply-To: <20130405235307.GA13235@kroah.com>
References: <CAJ61zBAP3E6bSaKSm=qwxnMyY_BBkA9W=kOMg-QSv90wJc=iTw@mail.gmail.com>
	<20130405235307.GA13235@kroah.com>
Date: Sun, 7 Apr 2013 18:39:04 +0530
Message-ID: <CAJ61zBCW_O6VJXjJui_ncnWgojLaZkz_ZaZQjdhQA6zUZNQg=w@mail.gmail.com>
Subject: Re: [OT] LDD3 Query
From: Vijay Chauhan <kernel.vijay@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,


On Sat, Apr 6, 2013 at 5:23 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 05, 2013 at 12:17:54PM +0530, Vijay Chauhan wrote:
> > Hi,
> >
> > I am new to Linux Device Driver and reading LDD3.
> >
> > It mentions that the disadvantage of dynamic major number allocation
> > is that you can’t create the device nodes in
> > advance, because the major number assigned to your module will vary.
>
> That's extremely out of date, all distros now use udev (or mdev) and as
> such, dynamic major/minor are fine to use, and recommended.
>
> > To solve this problem, it says that create a script to invoke insmod
> > and after calling insmod, reads /proc/devices in order to create the
> > special file(s).
>
> Not needed anymore, udev handles this for you.
>
> Hope this helps,

Thanks Greg. I realizes it later :)

Vijay

>
> greg k-h
