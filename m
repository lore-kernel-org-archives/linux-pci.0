Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35898 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbJHXay (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 19:30:54 -0400
Received: by wicgb1 with SMTP id gb1so45978067wic.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2015 16:30:53 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 8 Oct 2015 16:30:53 -0700
Message-ID: <CAKAYmMKumZTG9e_PzBtW1Jbo+0EvHVtY_XyFiZ=jnBVstkA-dw@mail.gmail.com>
Subject: what code generates this message?
From: Chuck Tuffli <ctuffli@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As part of trying to understand a hardware issue, I'm trying to track
down the kernel code which prints:

[ 1077.119096] pcieport 0000:00:02.0: PCI bridge to [bus 02-02]
[ 1077.119098] pcieport 0000:00:02.0:   bridge window [io  disabled]
[ 1077.119101] pcieport 0000:00:02.0:   bridge window [mem disabled]
[ 1077.119104] pcieport 0000:00:02.0:   bridge window [mem pref disabled]

to the system log / dmesg. Grep'ing the kernel source for strings such
as "PCI bridge to" or "bridge window" hasn't turned up any candidates.
Can someone point me in the right direction? TIA.

--chuck
