Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:36740 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbaDPUzo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 16:55:44 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so9195757eek.37
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2014 13:55:43 -0700 (PDT)
Received: from [137.226.29.51] (ip29-051.kullen.rwth-aachen.de. [137.226.29.51])
        by mx.google.com with ESMTPSA id s46sm61165472ees.3.2014.04.16.13.55.42
        for <linux-pci@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 13:55:42 -0700 (PDT)
Message-ID: <534EEE4D.7070203@gmail.com>
Date: Wed, 16 Apr 2014 22:55:41 +0200
From: Faerbit <faerbit@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Hibernation problem with 3.14 kernel
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

I hope I am posting in the right section.
Since the upgrade to kernel 3.14 I am unable to hibernate.
I am using Archlinux.
I am hibernating with "systemctl hibernate".
It always fails to freeze device 00:08:

journalctl tells me:
kernel: serial 00:08: disable failed
kernel: dpm_run_callback(): pnp_bus_freeze+0x0/0x20 returns -5
kernel: PM: Device 00:08 failed to freeze: error -5

lspci -v tells me:

0:08.0 PCI bridge: NVIDIA Corporation MCP78S [GeForce 8200] PCI Bridge
(rev a1) (prog-if 01 [Subtractive decode])
    Flags: bus master, 66MHz, fast devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
    Capabilities: [b8] Subsystem: ASUSTeK Computer Inc. Device 82e7
    Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-

My mainboard is a ASUS M4N98TD EVO.

What does error code -5 mean? How do I debug this further? Should I file
a bug?

Cheers,

Faerbit


