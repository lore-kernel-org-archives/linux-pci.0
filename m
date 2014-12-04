Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:45326 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbaLDQhp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 11:37:45 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so18427259pad.10
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 08:37:45 -0800 (PST)
Date: Thu, 4 Dec 2014 09:37:41 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141204163741.GD3168@google.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAE9FiQXqqg-KYi3aEVvCm=hfjN3mx_7J8uQ61hVJFVLNe+U=Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXqqg-KYi3aEVvCm=hfjN3mx_7J8uQ61hVJFVLNe+U=Zg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 03, 2014 at 06:01:33PM -0800, Yinghai Lu wrote:
> On Wed, Dec 3, 2014 at 2:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > In v3.16 (which does contain 5b28541552ef), when pbus_size_mem() sizes
> > the 64-bit prefetchable window, it only looks for downstream 64-bit
> > resources.  Since the radeon at 01:00.0 has none, we size the window
> > to 0 + 0x200000 (the 0x200000 part is pci_hotplug_mem_size, to
> > accommodate future hot-added devices).
> >
> > But that's not big enough to hold the radeon BAR 0 [mem
> > 0xc0000000-0xcfffffff pref], so BAR 0 remains unassigned, so
> > pci_enable_device() should fail, and radeon doesn't work.
> >
> > I don't know what the best fix is, but I think it's probably too
> > aggressive to *never* use a 64-bit prefetchable window for downstream
> > 32-bit prefetchable resources.  This configuration from BIOS should
> > just work without us changing anything (although we probably should
> > trim the window to start at 0xc0000000, which would still work).
> 
> pci=realloc should workaround the problem, as it would take control of
> the bridge mmio BAR, and allocate more range for mmio pref under it.

I don't think pci=realloc is the answer because

  1) It's a poor user experience.  We should be able to handle this
     automatically, without asking the user to do anything.

  2) It puts the radeon framebuffer in the non-prefetchable window, and we
     should be able to keep it in the prefetchable window.

Bjorn
