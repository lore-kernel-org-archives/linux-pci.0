Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:58504 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab3GTU7H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Jul 2013 16:59:07 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik8so1993163bkc.23
        for <linux-pci@vger.kernel.org>; Sat, 20 Jul 2013 13:59:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGWsdOgb1J-fVzYsrasnDVALeECXgwF=bA1iiokqgoA+MMGT_A@mail.gmail.com>
References: <1374353080-15837-1-git-send-email-teg@jklm.no> <CAGWsdOgb1J-fVzYsrasnDVALeECXgwF=bA1iiokqgoA+MMGT_A@mail.gmail.com>
From: Tom Gundersen <teg@jklm.no>
Date: Sat, 20 Jul 2013 22:58:45 +0200
Message-ID: <CAG-2HqW3pg1bkZdaV0XnbBFmRaBagp+MiRc2mL6y9S3o5HuFcA@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH][pciutils] lspci: pci_id_lookup - add
 udev/hwdb support
To: Michael Biebl <mbiebl@gmail.com>
Cc: linux-pci@vger.kernel.org,
	systemd Mailing List <systemd-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 20, 2013 at 10:54 PM, Michael Biebl <mbiebl@gmail.com> wrote:
> 2013/7/20 Tom Gundersen <teg@jklm.no>:
>> Ideally Linux distros using systemd would like to not ship pci.ids, but use hwdb as the only source
>> of this information, which this patch allows.
>
> I don't think you strictly need to run systemd to make use of hwdb.
> You just need to run a recent enough version of udev [1].

Yes, that is true, my mistake.

-t
