Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32963 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbIBWBO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 18:01:14 -0400
Received: by pacex6 with SMTP id ex6so18954124pac.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 15:01:14 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Sep 2015 16:01:13 -0600
Message-ID: <CAD8Lp44cpj0Z3aadOzW=Lc=m88AbQpaW3g=GCgtpvbpGATT7uw@mail.gmail.com>
Subject: pcieport AER error spam on Intel Skylake
From: Daniel Drake <drake@endlessm.com>
To: linux-pci@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Working with a sample for a new laptop based on Intel Skylake, the
kernel logs are full of these messages:

 pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
 pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected,
type=Physical Layer, id=00e5(Receiver ID)
 pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
 pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
 pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
 pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected,
type=Physical Layer, id=00e5(Receiver ID)
 pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
 pcieport 0000:00:1c.5:    [ 0] Receiver Error         (First)
 pcieport 0000:00:1c.5: AER: Corrected error received: id=00e5
 pcieport 0000:00:1c.5: can't find device of ID00e5

Reproduced on 4.2 and on linus master as of today, using x86_64_defconfig.

Apart from the log spam, there is no user-visible effect that I'm
aware of. Booting with pci=nomsi makes the messages go away.

Any thoughts, is this something worth looking into in more detail?

full dmesg: https://gist.github.com/dsd/1d7f738e917465edf2ae
lspci dump: https://gist.github.com/dsd/dc2481d64aadd520b0b3

Thanks,
Daniel
