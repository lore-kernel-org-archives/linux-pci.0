Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33259 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2DZRu3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 13:50:29 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1204261304020.1530-100000@iolanthe.rowland.org>
References: <CAD52pS--R8Ob14doabyqU7JBd96VQ-TqL5cdy4GW0k+gmFgpzg@mail.gmail.com>
	<Pine.LNX.4.44L0.1204261304020.1530-100000@iolanthe.rowland.org>
Date: Thu, 26 Apr 2012 20:50:28 +0300
Message-ID: <CAD52pS9v4K7HDF9z3sWib=qV1EfwN9K+tX=0CWXLznBd2Pd=vw@mail.gmail.com>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
From: Calin Demian <c.demian20@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ok, then. In my case it solves the problem.
Thank you again.

Calin Demian

2012/4/26 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 26 Apr 2012, Calin Demian wrote:
>
>> Yes, it's ok. Thank you.
>> Nevertheless, I think I will try to find out exactly what's happening.
>
> Okay.  It may be that your hardware never turns on the HCR bit in the
> first place.
>
> Remember, there will be no problem merging that patch, if it helps your
> system.
>
> Alan Stern
>
