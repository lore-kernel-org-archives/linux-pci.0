Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:62665 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114Ab3DQQsN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2013 12:48:13 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so1604056obc.4
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2013 09:48:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1825980.1C7UKqDGj6@vostro.rjw.lan>
References: <20130416171732.GA6356@google.com> <1825980.1C7UKqDGj6@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 17 Apr 2013 10:47:51 -0600
Message-ID: <CAErSpo44LzWjne=0G+4tMiFmHd0x=b6Rfd7K_PWZo+yZmFihsg@mail.gmail.com>
Subject: Re: Changes for v3.10 merge window
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 17, 2013 at 10:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, April 16, 2013 11:17:32 AM Bjorn Helgaas wrote:
>> Below are the patches currently in my "next" branch, planned for
>> release in v3.10.  If I'm missing something important, let me know.
>
> Well, you said you took the "PCI / PM: Make pci_pme_active() ignore devices
> without PME support" patch for v3.10, but it is not listed below.

Yep, I just merged it 30 seconds ago :)  I was waiting to make sure
you didn't want the "Fix fallback to PCI_D0"  patch in v3.9.  Thanks
for the reminder.

Bjorn
