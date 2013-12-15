Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:63922 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab3LOMVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 07:21:07 -0500
Received: by mail-we0-f175.google.com with SMTP id t60so3526229wes.6
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2013 04:21:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <mj+md-20131215.110132.29802.nikam@ucw.cz>
References: <1378302428-19758-1-git-send-email-teg@jklm.no>
 <mj+md-20130904.134928.12262.nikam@ucw.cz> <CAG-2HqWcnZ-z7EbDd0aAj6y_Ho6szfRZUiK0psEnmoz17Kw-xA@mail.gmail.com>
 <mj+md-20131110.114139.9646.albireo@ucw.cz> <CAG-2HqXsEBB_nxUF4gza-eTsUjmysYR7iPEjJPUFyR1rC2KGMg@mail.gmail.com>
 <CAPXgP12MLL_Z5gyrCndQLRT6SR_TJi9xHp1HkHMX1ahwnxx3yw@mail.gmail.com>
 <mj+md-20131215.091609.28546.nikam@ucw.cz> <CAPXgP10+1WtX8_xN+QSHvKws01hbKhP3FN95sXk9EtezdSPtqg@mail.gmail.com>
 <mj+md-20131215.110132.29802.nikam@ucw.cz>
From: Kay Sievers <kay@vrfy.org>
Date: Sun, 15 Dec 2013 13:20:45 +0100
Message-ID: <CAPXgP127fBUBPqtsOCiqE2cy2JX+JabWn2Trmhk69GRUmUb57g@mail.gmail.com>
Subject: Re: [PATCH RESEND][pciutils] libpci: pci_id_lookup - add udev/hwdb support
To: Martin Mares <mj@ucw.cz>
Cc: Tom Gundersen <teg@jklm.no>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 15, 2013 at 12:33 PM, Martin Mares <mj@ucw.cz> wrote:
>> It does that per process doing that, and that's the problem for how
>> udev works/worked. The binary hwdb is on-disk and can be mmaped, and
>> there is no difference between initialization, first, or subsequent
>> queries.
>
> OK, point taken.
>
> I see that a mechanism for fast lookup of hardware identification data
> is needed. However, why should such a mechanism depend on udev, systemd,
> or Linux in general?
>
> What I would really like to have is a universal library for HW lookup,
> independent of anything else and widely portable. All the hardware data
> would be provided by other packages -- pci.ids, usb.ids, kernel modules,
> etc. -- and compiled to a binary format available for instant queries.

Yeah, that's what udev's hwdb is for us now.

For the textual strings, it seems relatively easy to commit to a
reasonable stable format, but I doubt that text strings alone would
justify supporting a binary format to compile to.

I wouldn't want to commit to cross-platform stability for other device
properties we use, or things which will end up in the hwdb. It's hard
enough already to coordinate the development across Linux
distributions, and generic cross-platform device-management metadata
maintenance doesn't sound too promising or an easy goal to me.

Some data of hwdb is entirely Linux and Linux kernel device specific.
The hwdb query string to lookup the binary radix tree in the hwdb file
is just the Linux kernel modalias strings, and they are directly
passed as queries to hwdb. Other platforms could do the same thing,
sure, but I'm not sure this really makes too much sense.

> Do I miss anything?

No, you didn't. It's just that we develop for and work with Linux
only, and this is really hard enough already. :)

I personally never think about other platforms because I don't really
know/care about or use them; and hwdb was just a tiny and not
important enough piece of the problem we need to solve, so it became
part of udev.

Kay
