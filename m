Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34838 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcDSEPM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 00:15:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id a140so1529679wma.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2016 21:15:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160419001453.GA4597@localhost>
References: <20160419001453.GA4597@localhost>
Date: Tue, 19 Apr 2016 12:15:10 +0800
Message-ID: <CADjb_WSAo4Wa8xy1sBwOg+5=Ez8jQYsc=mmbedokY1N9=A0aMA@mail.gmail.com>
Subject: Re: [BUG?] Thunderbolt BAR 8: no space / failed to assign
From: yu chen <yu.chen.surf@gmail.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: andreas.noever@gmail.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 8:14 AM, Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
> Not sure if this is an actual bug since I don't have any Thunderbolt
> devices to test with, but on every boot:
>
> [    0.418473] pci 0000:05:05.0: res[8]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
> [    0.418474] pci 0000:05:05.0: res[8]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
> [    0.418476] pci 0000:05:05.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
> [    0.418478] pci 0000:05:05.0: res[9]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
> [    0.418479] pci 0000:05:06.0: res[8]=[mem 0x00100000-0x000fffff] res_to_dev_res add_size 200000 min_align 100000
> [    0.418481] pci 0000:05:06.0: res[8]=[mem 0x00100000-0x002fffff] res_to_dev_res add_size 200000 min_align 100000
> [    0.418483] pci 0000:05:06.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
> [    0.418484] pci 0000:05:06.0: res[9]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
> [    0.418486] pci 0000:05:05.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
> [    0.418487] pci 0000:05:05.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
> [    0.418489] pci 0000:05:06.0: res[7]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000 min_align 1000
> [    0.418490] pci 0000:05:06.0: res[7]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000 min_align 1000
> [    0.418492] pci 0000:05:05.0: BAR 8: no space for [mem size 0x00200000]
> [    0.418496] pci 0000:05:05.0: BAR 8: failed to assign [mem size 0x00200000]
> [    0.418502] pci 0000:05:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
> [    0.418507] pci 0000:05:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
> [    0.418513] pci 0000:05:06.0: BAR 8: no space for [mem size 0x00200000]
> [    0.418516] pci 0000:05:06.0: BAR 8: failed to assign [mem size 0x00200000]
> [    0.418521] pci 0000:05:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
> [    0.418526] pci 0000:05:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
> [    0.418532] pci 0000:05:05.0: BAR 7: no space for [io  size 0x1000]
> [    0.418536] pci 0000:05:05.0: BAR 7: failed to assign [io  size 0x1000]
> [    0.418539] pci 0000:05:06.0: BAR 7: no space for [io  size 0x1000]
> [    0.418543] pci 0000:05:06.0: BAR 7: failed to assign [io  size 0x1000]
> [    0.418547] pci 0000:05:06.0: BAR 8: no space for [mem size 0x00200000]
> [    0.418551] pci 0000:05:06.0: BAR 8: failed to assign [mem size 0x00200000]
> [    0.418555] pci 0000:05:06.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
> [    0.418561] pci 0000:05:06.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
> [    0.418566] pci 0000:05:06.0: BAR 7: no space for [io  size 0x1000]
> [    0.418570] pci 0000:05:06.0: BAR 7: failed to assign [io  size 0x1000]
> [    0.418574] pci 0000:05:05.0: BAR 8: no space for [mem size 0x00200000]
> [    0.418577] pci 0000:05:05.0: BAR 8: failed to assign [mem size 0x00200000]
> [    0.418582] pci 0000:05:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
> [    0.418587] pci 0000:05:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
> [    0.418593] pci 0000:05:05.0: BAR 7: no space for [io  size 0x1000]
> [    0.418596] pci 0000:05:05.0: BAR 7: failed to assign [io  size 0x1000]
> [    0.418600] pci 0000:05:00.0: PCI bridge to [bus 06]
> [    0.418606] pci 0000:05:00.0:   bridge window [mem 0xa0700000-0xa07fffff]
> [    0.418615] pci 0000:05:03.0: PCI bridge to [bus 07-37]
> [    0.418619] pci 0000:05:03.0:   bridge window [io  0x3000-0x3fff]
> [    0.418625] pci 0000:05:03.0:   bridge window [mem 0xa0800000-0xa47fffff]
> [    0.418630] pci 0000:05:03.0:   bridge window [mem 0xac800000-0xb07fffff 64bit pref]
> [    0.418638] pci 0000:05:04.0: PCI bridge to [bus 38-68]
> [    0.418642] pci 0000:05:04.0:   bridge window [io  0x4000-0x4fff]
> [    0.418648] pci 0000:05:04.0:   bridge window [mem 0xa4800000-0xa87fffff]
> [    0.418653] pci 0000:05:04.0:   bridge window [mem 0xb0800000-0xb47fffff 64bit pref]
> [    0.418662] pci 0000:05:05.0: PCI bridge to [bus 69]
> [    0.418672] pci 0000:05:06.0: PCI bridge to [bus 6a]
>
> Hardware is 2012 Macbook Ivybridge.
> Error occurs on kernels from 7bc5a2bad0b8 (which enabled Thunderbolt on
> Apple hardware) onwards.

I also saw this error on Macbook Pro 12 . Looks like there
is no space left  in the pci bridge.


-- 
Regards,
Yu
