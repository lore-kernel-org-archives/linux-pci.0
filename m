Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:55575 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab3EJRrw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 May 2013 13:47:52 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so757594obq.9
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2013 10:47:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <513E002C.40805@fold.natur.cuni.cz>
References: <513E002C.40805@fold.natur.cuni.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 May 2013 11:47:31 -0600
Message-ID: <CAErSpo5594KNtZz9Gpdw_j5NZX_sGpzKB9CT2-SCB2bCASfrSQ@mail.gmail.com>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express card
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Sarah, Alan]

On Mon, Mar 11, 2013 at 10:02 AM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> [re-sending to you all three directly, looks the original email did not make it into linux-pci
> through some filters]
>
>   I use for my daily work acpiphp to manage express cards in Dell Vostro 3550.
> I have never seen something like this before and believe this is some new regression
> in 3.8 series. I had in teh a USB3 card and ejected it. Then I inserted a
> SATA Sil3132 card but it is not detected and dmesg still ends with last lines
> added when the USB card was being removed. The funny thing is that lspci reports
> a mixture of USB-card properties with NEC chips along with Silicon Image eSATA card.

I don't know anything about the kmemleaks mentioned elsewhere in this
thread, but the idea of "stale PCI device info" seems possibly related
to some acpiphp issues we've been working on recently.

Starting with v3.9, we don't handle ACPI Bus Check notifications to
host bridges correctly, and the result is that when we're using
acpiphp, we don't notice when PCI devices are added or removed. There
are more details in https://bugzilla.kernel.org/show_bug.cgi?id=57961

It looks like your Vostro 3550 uses acpiphp, so maybe there's a
connection.  Can you try a current Linus upstream kernel (v3.10-rc1
should be released in the next day or two) and apply the v3.10 patch
from the bugzilla, and collect a complete dmesg log after you try a
couple hotplug events?

Bjorn
