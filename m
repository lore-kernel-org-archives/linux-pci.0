Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:58840 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeIFSLA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 14:11:00 -0400
Subject: Re: [Nouveau] [PATCH] PCI: add prefetch quirk to work around
 Asus/Nvidia suspend issues
To: Daniel Drake <drake@endlessm.com>, bhelgaas@google.com,
        peter@lekensteyn.nl, alexdeucher@gmail.com
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux@endlessm.com
References: <20180831073057.14626-1-drake@endlessm.com>
From: Thomas Martitz <kugel@rockbox.org>
Message-ID: <2848f50b-d0c6-12ec-8f24-8461209c13b4@rockbox.org>
Date: Thu, 6 Sep 2018 15:35:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180831073057.14626-1-drake@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 31.08.2018 um 09:30 schrieb Daniel Drake:
> On over 40 Intel-based Asus products, the nvidia GPU becomes unusable
> after S3 suspend/resume. The affected products include multiple
> generations of nvidia GPUs and Intel SoCs. After resume, nouveau logs
> many errors such as:
>
>      fifo: fault 00 [READ] at 0000005555555000 engine 00 [GR] client 04 [HUB/FE] reason 4a [] on channel -1 [007fa91000 unknown]
>      DRM: failed to idle channel 0 [DRM]
>
> Similarly, the nvidia proprietary driver also fails after resume
> (black screen, 100% CPU usage in Xorg process). We shipped a sample
> to Nvidia for diagnosis, and their response indicated that it's a
> problem with the parent PCI bridge (on the Intel SoC), not the GPU.
>
> We found a workaround: on resume, rewrite the Intel PCI bridge
> 'Prefetchable Base Upper 32 Bits' register. In the cases that I checked,
> this register has value 0 and we just have to rewrite that value.
>
> It's very strange that rewriting the exact same register value
> makes a difference, but it definitely makes the issue go away.
> It's not just acting as some kind of memory barrier, because rewriting
> other bridge registers does not work around the issue. There's something
> magic in this particular register.
>
> We examined our database of Asus hardware and identified 43 products
> that we believe are affected. Checking the nvidia GPU parent PCI bridge
> on each one, in total 5 Intel PCI bridges need quirking as below.
> The quirk will run on bridges even where no nvidia GPU is connected,
> but it should be harmless, and we at least limit it to only running
> on Asus products.
>
> This fix was tested on all the affected models that we have in hands
> (X542UQ, UX533FD, X530UN, V272UN).

Hello,

this patch helps on my HP Zbook 14u G5 which otherwise fails to resume 
the dGPU after suspend. In this case it's a radeon gpu (polaris 10). Of 
course I had to remove the check for ASUS, but made no other changes.

With this patch I can successfully run "DRI_PRIME=1 glxinfo | grep -i 
renderer" and see the radeon, as well as "DRI_PRIME=1 glxgears", after 
resuming from suspend. Attemting that without the patch makes the system 
hang for a few seconds followed by lots of powerplay errors in dmesg. 
glxinfo/gears sometimes use the Intel graphics or show a blank window.

FWIW, this problem was discussed a lot in bug 
https://bugs.freedesktop.org/show_bug.cgi?id=105760 (it's closed only 
because the original bug crash is solved but the root problem is still 
unfixed). Therefore I add Peter Wu and Alex Deucher who attempted to 
help me out already.

I think this supports your other mail where you suggest it should be 
done unconditionally.

Thanks for the patch!

Best regards
