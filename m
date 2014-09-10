Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:64394 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaIJQ2H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 12:28:07 -0400
Received: by mail-oi0-f66.google.com with SMTP id e131so1477035oig.9
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2014 09:28:06 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 10 Sep 2014 12:10:06 -0400
Message-ID: <CAG-92OOEkNOPmmyHP0=UGcT+qusPkWp7vy_qZCe6YEwKG27B6g@mail.gmail.com>
Subject: Running Adobe Flash triggers PCI bus failure
From: aw ful <awfl.awfl@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a hardware system that is otherwise extremely stable, however,
after 1 minute to 1 day of viewing Flash videos via Firefox a PCI bus
fails and manifests in several different ways, including massive
ethernet errors and frozen sata devices. This failure can also be
invoked using multiple Live distributions, where the only thing I add
is installing the Flash plugin from Adobe. Initially believed to be a
hardware problem, I now believe it is a long term obscure bug as I
have seen related symptoms in various bug reports which were never
clearly resolved, and never associated with the flash plugin.

I am writing to the kernel devs as I can easily make this occur on two
distinct Linux distributions - standard Fedora 19, 20 Live, and 21 TC6
Live, and Linux Mint 17 Live, experienced across many recent 3.14.17,
3.16.2 kernel versions. The failure occurs on a Asrock AM3+ system
with AMD NB and SB. I was not clear how and where to write a further
bug report because I can now demonstrate it on multiple distributions.
Any assistance is appreciated.

Detailed information can be found here:
https://bugzilla.redhat.com/show_bug.cgi?id=1135801
which includes dmesg and lspci -vv

Thank You for your time.
awfl
