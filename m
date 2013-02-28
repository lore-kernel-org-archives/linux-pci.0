Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59645 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab3B1LNR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2013 06:13:17 -0500
Date: Thu, 28 Feb 2013 03:13:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: ACPI based PCI/PCIe bridge hotplug
Message-ID: <20130228111319.GA8739@roeck-us.net>
References: <20130228044205.GA30949@roeck-us.net>
 <CAE9FiQX3Q+2ycXpR=Bn=tqW94F6e8cDZjiiE8vxO7wmJn_kUCg@mail.gmail.com>
 <20130228050857.GA31066@roeck-us.net>
 <512F2F32.40001@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <512F2F32.40001@fold.natur.cuni.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 28, 2013 at 11:19:30AM +0100, Martin Mokrejs wrote:
> Guenter Roeck wrote:
> 
> > [ Bjorn, sorry I dropped you from the Cc:, but my e-mail provider and Google
> >   still don't like each other ]
> 
> I also observe that emails from Bjorn often end up in gmail's SPAM folder while
> lots of other emails coming also from linux-pci, lkml, etc. do get through into
> Inbox. Don't know why. Just to let you know. Moving them out of SPAM folder into
> Inbox does not seem to teach gmail.
> 
That isn't the problem here. Goole's e-mail server either considers my e-mail
address to be a spam source, or it considers my e-mail provider's IP address to
be a spam source, and rejects acceptance of e-mails immediately with a 550 error.
I can not even send it and get

msmtp: recipient address bhelgaas@google.com not accepted by the server
msmtp: server message: 550 sorry, no mailbox here by that name (#5.1.1)
msmtp: could not send mail (account default from /etc/msmtprc)

immediately when I try. That happens with all e-mail I send to google.com.

Guenter
