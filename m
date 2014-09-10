Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:45800 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbaIJXuH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 19:50:07 -0400
Received: by mail-oa0-f50.google.com with SMTP id o6so13596280oag.23
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2014 16:50:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4g6GXwWLvh4qGLvXH-1bCrWKf-Pjf4pAWsoB05NYSmFw@mail.gmail.com>
References: <CAG-92OOEkNOPmmyHP0=UGcT+qusPkWp7vy_qZCe6YEwKG27B6g@mail.gmail.com>
	<CAErSpo4g6GXwWLvh4qGLvXH-1bCrWKf-Pjf4pAWsoB05NYSmFw@mail.gmail.com>
Date: Wed, 10 Sep 2014 19:50:07 -0400
Message-ID: <CAG-92OO_DeZDr8j=p1m69uWsxSqwXsjCjbhZHoMawsaL5h1OcA@mail.gmail.com>
Subject: Re: Running Adobe Flash triggers PCI bus failure
From: aw ful <awfl.awfl@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Josh Boyer <jwboyer@redhat.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello;

When I mention taking down the PCI bus, what I imply is that when I
compare the before and after status of devices on the PCI buses using
"lspci -vv",  I saw many 0xffffffffs and device memory and ports
marked as "disabled". I (naively and likely wrongly) understood that
if the PCI bus (or devices on them) detects a bus fault, or suffer
failure, the devices on it become disabled as a result? Either way,
that is where I got the idea that a bus is down, not just a single
specific device.

During troubleshooting I removed the ata7 and ata8 devices you
mentioned from the machine (as well as all other ata devices except
for the main disk), and all extraneous pci cards. Still crashed as
evidenced by the onboard ethernet failing. I then disabled the onboard
ethernet and installed a separate PCI ethernet card and the network
still failed (i'll look at my notes, but that is what I recall).
Another reason I was looking at the PCI bus as the failure point.

And all these devices work flawlessly, heavily loaded, by themselves
or in tandem. As well when running heavy graphics and steam games
under fglrx. But only when an impending flash fault hasn't yet created
a failure.

It is outside my experience level, but I will try to git an
appropriate kernel, compile it, and get it to run on my system if
possible - it is my sole working machine.

If I am successful, I will attempt to open a bug report with the
information you have requested.

And yes, on my Fedora 19 3.14.17-100 config the default is
CONFIG_PCIEAER=y so the dmesg you see is complete. I did try a debug
kernels, but the output was always as sparse.

Thank You for your time.
