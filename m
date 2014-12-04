Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:40773 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaLDCBe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Dec 2014 21:01:34 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so17882553igb.17
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2014 18:01:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
Date: Wed, 3 Dec 2014 18:01:33 -0800
Message-ID: <CAE9FiQXqqg-KYi3aEVvCm=hfjN3mx_7J8uQ61hVJFVLNe+U=Zg@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 3, 2014 at 2:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> In v3.16 (which does contain 5b28541552ef), when pbus_size_mem() sizes
> the 64-bit prefetchable window, it only looks for downstream 64-bit
> resources.  Since the radeon at 01:00.0 has none, we size the window
> to 0 + 0x200000 (the 0x200000 part is pci_hotplug_mem_size, to
> accommodate future hot-added devices).
>
> But that's not big enough to hold the radeon BAR 0 [mem
> 0xc0000000-0xcfffffff pref], so BAR 0 remains unassigned, so
> pci_enable_device() should fail, and radeon doesn't work.
>
> I don't know what the best fix is, but I think it's probably too
> aggressive to *never* use a 64-bit prefetchable window for downstream
> 32-bit prefetchable resources.  This configuration from BIOS should
> just work without us changing anything (although we probably should
> trim the window to start at 0xc0000000, which would still work).

pci=realloc should workaround the problem, as it would take control of
the bridge mmio BAR, and allocate more range for mmio pref under it.

Yinghai
