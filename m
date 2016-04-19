Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33865 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbcDSAO6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 20:14:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id n3so722712wmn.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2016 17:14:57 -0700 (PDT)
Date: Tue, 19 Apr 2016 01:14:53 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: andreas.noever@gmail.com
Cc: linux-pci@vger.kernel.org
Subject: [BUG?] Thunderbolt BAR 8: no space / failed to assign
Message-ID: <20160419001453.GA4597@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Not sure if this is an actual bug since I don't have any Thunderbolt
devices to test with, but on every boot:

[    0.418473] pci 0000:05:05.0: res[8]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.418474] pci 0000:05:05.0: res[8]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.418476] pci 0000:05:05.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.418478] pci 0000:05:05.0: res[9]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.418479] pci 0000:05:06.0: res[8]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.418481] pci 0000:05:06.0: res[8]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
[    0.418483] pci 0000:05:06.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.418484] pci 0000:05:06.0: res[9]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.418486] pci 0000:05:05.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.418487] pci 0000:05:05.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.418489] pci 0000:05:06.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
[    0.418490] pci 0000:05:06.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
[    0.418492] pci 0000:05:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.418496] pci 0000:05:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.418502] pci 0000:05:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.418507] pci 0000:05:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.418513] pci 0000:05:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.418516] pci 0000:05:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.418521] pci 0000:05:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.418526] pci 0000:05:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.418532] pci 0000:05:05.0: BAR 7: no space for [io  size 0x1000]
[    0.418536] pci 0000:05:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.418539] pci 0000:05:06.0: BAR 7: no space for [io  size 0x1000]
[    0.418543] pci 0000:05:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.418547] pci 0000:05:06.0: BAR 8: no space for [mem size 0x00200000]
[    0.418551] pci 0000:05:06.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.418555] pci 0000:05:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.418561] pci 0000:05:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.418566] pci 0000:05:06.0: BAR 7: no space for [io  size 0x1000]
[    0.418570] pci 0000:05:06.0: BAR 7: failed to assign [io  size 0x1000]
[    0.418574] pci 0000:05:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.418577] pci 0000:05:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.418582] pci 0000:05:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.418587] pci 0000:05:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.418593] pci 0000:05:05.0: BAR 7: no space for [io  size 0x1000]
[    0.418596] pci 0000:05:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.418600] pci 0000:05:00.0: PCI bridge to [bus 06]
[    0.418606] pci 0000:05:00.0:   bridge window [mem 0xa0700000-0xa07fffff]
[    0.418615] pci 0000:05:03.0: PCI bridge to [bus 07-37]
[    0.418619] pci 0000:05:03.0:   bridge window [io  0x3000-0x3fff]
[    0.418625] pci 0000:05:03.0:   bridge window [mem 0xa0800000-0xa47fffff]
[    0.418630] pci 0000:05:03.0:   bridge window [mem 0xac800000-0xb07fffff 64bit pref]
[    0.418638] pci 0000:05:04.0: PCI bridge to [bus 38-68]
[    0.418642] pci 0000:05:04.0:   bridge window [io  0x4000-0x4fff]
[    0.418648] pci 0000:05:04.0:   bridge window [mem 0xa4800000-0xa87fffff]
[    0.418653] pci 0000:05:04.0:   bridge window [mem 0xb0800000-0xb47fffff 64bit pref]
[    0.418662] pci 0000:05:05.0: PCI bridge to [bus 69]
[    0.418672] pci 0000:05:06.0: PCI bridge to [bus 6a]

Hardware is 2012 Macbook Ivybridge.
Error occurs on kernels from 7bc5a2bad0b8 (which enabled Thunderbolt on
Apple hardware) onwards.
