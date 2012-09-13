Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35305 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab2IMJVA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2012 05:21:00 -0400
Received: by lbbgj3 with SMTP id gj3so1800537lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 13 Sep 2012 02:20:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
Date: Thu, 13 Sep 2012 11:20:59 +0200
Message-ID: <CA+icZUWQtYB2yJYKh9MRqA40Qu5v7V=SOqpu5jvdqDhR_teiFg@mail.gmail.com>
Subject: [pci-next] Include patches from mmotm and drm-opt-pwr GIT trees?
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

those two patches would IMHO be nice to have also in pci.git#next?
The 1st could have given me more infos when I had some troubles with
drm in Linux-Next some days ago.
The 2nd one was sent already by Dave to linux-pci ML.

[1] pci: test for unexpectedly disabled bridges
[2] pci: don't touch card regs after runtime suspend D3

Regards,
- Sedat -


[1] http://git.cmpxchg.org/?p=linux-mmotm.git;a=patch;h=173546b1e91460b550247b3303164797949dc5a3
[2] http://cgit.freedesktop.org/~airlied/linux/patch/?id=005fdf5c184f9b857cbd8cb7195898d776f68670
