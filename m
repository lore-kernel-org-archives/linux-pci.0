Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:54815 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab3GTUy1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Jul 2013 16:54:27 -0400
Received: by mail-vb0-f43.google.com with SMTP id e12so3920399vbg.2
        for <linux-pci@vger.kernel.org>; Sat, 20 Jul 2013 13:54:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374353080-15837-1-git-send-email-teg@jklm.no>
References: <1374353080-15837-1-git-send-email-teg@jklm.no>
Date: Sat, 20 Jul 2013 22:54:26 +0200
Message-ID: <CAGWsdOgb1J-fVzYsrasnDVALeECXgwF=bA1iiokqgoA+MMGT_A@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH][pciutils] lspci: pci_id_lookup - add
 udev/hwdb support
From: Michael Biebl <mbiebl@gmail.com>
To: Tom Gundersen <teg@jklm.no>
Cc: linux-pci@vger.kernel.org,
	systemd Mailing List <systemd-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/7/20 Tom Gundersen <teg@jklm.no>:
> Ideally Linux distros using systemd would like to not ship pci.ids, but use hwdb as the only source
> of this information, which this patch allows.

I don't think you strictly need to run systemd to make use of hwdb.
You just need to run a recent enough version of udev [1].

Michael

[1]  udev 196 or later
