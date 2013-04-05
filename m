Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:50394 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163063Ab3DEXxJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2013 19:53:09 -0400
Received: by mail-da0-f48.google.com with SMTP id p8so1777423dan.21
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2013 16:53:09 -0700 (PDT)
Date: Fri, 5 Apr 2013 16:53:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Vijay Chauhan <kernel.vijay@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [OT] LDD3 Query
Message-ID: <20130405235307.GA13235@kroah.com>
References: <CAJ61zBAP3E6bSaKSm=qwxnMyY_BBkA9W=kOMg-QSv90wJc=iTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJ61zBAP3E6bSaKSm=qwxnMyY_BBkA9W=kOMg-QSv90wJc=iTw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 05, 2013 at 12:17:54PM +0530, Vijay Chauhan wrote:
> Hi,
> 
> I am new to Linux Device Driver and reading LDD3.
> 
> It mentions that the disadvantage of dynamic major number allocation
> is that you can’t create the device nodes in
> advance, because the major number assigned to your module will vary.

That's extremely out of date, all distros now use udev (or mdev) and as
such, dynamic major/minor are fine to use, and recommended.

> To solve this problem, it says that create a script to invoke insmod
> and after calling insmod, reads /proc/devices in order to create the
> special file(s).

Not needed anymore, udev handles this for you.

Hope this helps,

greg k-h
