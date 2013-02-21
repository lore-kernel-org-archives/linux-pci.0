Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:53637 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab3BUXqL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2013 18:46:11 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so39808bkc.6
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2013 15:46:09 -0800 (PST)
MIME-Version: 1.0
From: Cole Mickens <cole.mickens@gmail.com>
Date: Thu, 21 Feb 2013 17:45:29 -0600
Message-ID: <CAJ9Gbf1o0JHTWRvx=5x51q-wpZctkjFQuufR4fdNja_kV56dqw@mail.gmail.com>
Subject: Hot (un)plugging a Thunderbolt Ethernet adapter causes kernel panic
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, I was instructed to send this issue to this mailing list:
https://bugzilla.kernel.org/show_bug.cgi?id=54131

--

I have a Macbook Air 2012 running Ubuntu 13.04 with the 3.8.0 kernel
(not an RC).

My Thunderbolt Ethernet adapter is usable but only if it is inserted at boot.

If it is removed after being available, the kernel will panic. Generally it
takes a minute or two or I have to fire up Chrome or something to stir it.

I assume the crash isn't written out on a Mac EFI system but I can easily
reproduce it and retype whatever bits are important. I did take a
snapshot with my camera: http://i.imgur.com/q2iuHWZ.jpg

Apologies if this is the wrong format or place for this; I'm reporting my first
kernel bug. Cheers.
