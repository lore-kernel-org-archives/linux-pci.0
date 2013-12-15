Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47841 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab3LOEBR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Dec 2013 23:01:17 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so821905wid.17
        for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2013 20:01:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAG-2HqXsEBB_nxUF4gza-eTsUjmysYR7iPEjJPUFyR1rC2KGMg@mail.gmail.com>
References: <1378302428-19758-1-git-send-email-teg@jklm.no>
 <mj+md-20130904.134928.12262.nikam@ucw.cz> <CAG-2HqWcnZ-z7EbDd0aAj6y_Ho6szfRZUiK0psEnmoz17Kw-xA@mail.gmail.com>
 <mj+md-20131110.114139.9646.albireo@ucw.cz> <CAG-2HqXsEBB_nxUF4gza-eTsUjmysYR7iPEjJPUFyR1rC2KGMg@mail.gmail.com>
From: Kay Sievers <kay@vrfy.org>
Date: Sun, 15 Dec 2013 05:00:56 +0100
Message-ID: <CAPXgP12MLL_Z5gyrCndQLRT6SR_TJi9xHp1HkHMX1ahwnxx3yw@mail.gmail.com>
Subject: Re: [PATCH RESEND][pciutils] libpci: pci_id_lookup - add udev/hwdb support
To: Tom Gundersen <teg@jklm.no>
Cc: Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 15, 2013 at 1:23 AM, Tom Gundersen <teg@jklm.no> wrote:
>> Also, did you consider the opposite, that is making hwdb call libpci
>> to resolve PCI IDs? What are the downsides?
>
> Well, part of the reason for introducing the hwdb was to avoid libpci for
> performance reasons (I added Kay in cc who can correct me if I'm wrong):
> Firstly we don't want to parse the ids file at runtime, and secondly we want
> the constant time lookup time that hwdb gives. Due to the increased
> performance we are now able to tag (in the udev database) all devices with
> the pciids info, before we could only do this for selected devices. A result
> of this is that this info is available 'for free' for any app that uses
> libudev.

Hwdb is an indexed database which can be queried without any
measurable cost. It also carries more information than the textual
strings, and this data is needed during early boot, so we need hwdb
anyway.

Libpci and its linear search through megabytes of text files for evey
new query is too inefficient, that we cannot afford to use it during
early bootup. It was the largest hit left in bootup profiling on
machines booting userspace in the sub-1-second range on common
machines. It was probably never meant to provide efficient queries,
but it's the reason we can never use it during early boot.

Kay
