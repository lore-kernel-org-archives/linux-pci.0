Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965626Ab2ERRR5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 13:17:57 -0400
Message-ID: <4FB68442.1010506@redhat.com>
Date: Fri, 18 May 2012 13:17:54 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shyam Iyer <Shyam_Iyer@Dell.com>, ddutile@redhat.com
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
References: <20120518045130.GA3281@kroah.com> <1337350606-32648-1-git-send-email-prarit@redhat.com> <20120518154715.GA21043@kroah.com>
In-Reply-To: <20120518154715.GA21043@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> 
> Please define "unhardened".  Why aren't all drivers "hardened"?

Most drivers _currently_ do not handle reading all f's (or -1) from hardware.
Some drivers do handle some situations but definitely not all of them.
Hardening a driver involves making the driver "-1" safe.

Some companies do ship hardened drivers, but the ones in the tree are not hardened.

[The above comment is in no way an approval of shipping drivers outside of the
kernel.  I'm just stating a fact.]

The effort involved in hardening this drivers is significant.  It will be a long
time before anyone considers the in-tree drivers hardened.  We should start with
a baby-step of acknowledging the problem and giving current users a way of
protecting their data.

> 
>> In these cases, the system should not do a bus reset, but rather the
>> system should panic to avoid any further possible data corruption.
> 
> Really?  You really want to panic the whole system and shut down and
> potentially loose everything?  That does not sound like a good idea at
> all to me, is there really no way to recover from this?

Yes, that's _exactly_ what I want to do.  Having a driver that is capable of
writing corrupted data to a disk or corrupting memory is much worse than
panicking and stopping the system for a short period of time.

The default is to handle an AER through a bus reset so a user must actively
request the panic.

P.
