Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36340 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbFXW2J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 18:28:09 -0400
Received: by igbiq7 with SMTP id iq7so107190474igb.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2015 15:28:08 -0700 (PDT)
Date: Wed, 24 Jun 2015 17:28:02 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: get correct bridge mmio size with old size checking
Message-ID: <20150624222802.GP7710@google.com>
References: <1434235142-2751-1-git-send-email-yinghai@kernel.org>
 <20150619022612.GI7710@google.com>
 <CAE9FiQVZngaPYvxi1DcXDLvDnDvx6qb2md1xbhMBc0uCPyLisw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVZngaPYvxi1DcXDLvDnDvx6qb2md1xbhMBc0uCPyLisw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 08:02:57PM -0700, Yinghai Lu wrote:
> On Thu, Jun 18, 2015 at 7:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Sat, Jun 13, 2015 at 03:39:02PM -0700, Yinghai Lu wrote:
> >> Found allocation request too big size for must+optional during pci
> >> bus rescan via /sys/bus/pci/rescan, and fail with that size.

Is this a hotplug thing?  I assume you wouldn't normally use
/sys/bus/pci/rescan unless there's some kind of hotplug and
notification is broken.

> >> [ 1217.699800] pci 0000:85:02.0: bridge window [mem 0x00100000-0x001fffff] to [bus 86] add_size 100000 add_align 100000
> >> [ 1217.699821] pci 0000:85:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 87] add_size 100000 add_align 100000
> >> [ 1217.699907] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
> >> [ 1217.699909] pci 0000:85:03.0: res[14]=[mem 0x00100000-0x001fffff] res_to_dev_res add_size 100000 min_align 100000
> >> [ 1217.699933] pci 0000:85:02.0: BAR 14: assigned [mem 0xedf00000-0xee0fffff]
> >> [ 1217.699936] pci 0000:85:03.0: BAR 14: no space for [mem size 0x00200000]
> >> [ 1217.699939] pci 0000:85:03.0: BAR 14: failed to assign [mem size 0x00200000]
> >>
> >> After close look, for 85:02.0 only need 1M for must+optional.
> >
> > I'm pretty sure this is fixing a bug, but I haven't figured out how it
> > works yet.  (Is there a bugzilla or URL for an email problem report?)
> 
> No bugzilla, and it is with internal test with current upstream +
> pci/next ... + my local
> patches.
> 
> > Please strip out timestamps unless they help understand the problem.
> 
> ok.
> 
> > Are both 85:02.0 and 85:03.0 relevant to the problem?  If not, strip out
> > the one that doesn't matter.
> 
> kind of. please check more detail printout:
> 
> [ 1217.699800] pci 0000:85:02.0: bridge window [mem
> 0x00100000-0x001fffff] to [bus 86] add_size 100000 add_align 100000
> [ 1217.699821] pci 0000:85:03.0: bridge window [mem
> 0x00100000-0x001fffff] to [bus 87] add_size 100000 add_align 100000
> [ 1217.699904] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
> res_to_dev_res add_size 100000 min_align 100000
> [ 1217.699907] pci 0000:85:02.0: res[14]=[mem 0x00100000-0x001fffff]
> res_to_dev_res add_size 100000 min_align 100000
> ...

This is slipping down my priority list because I have more interesting
things to work on than trying to decipher what's going on here.

And immediately after I suggested that you remove irrelevant
information like timestamps, you send a bunch more logs WITH the
distracting timestamps :)

85:02.0 is a bridge to bus 86.  85:03.0 is a bridge to bus 87.
Apparently we assigned too much space for the 85:02.0 mem window.
So I'm expecting a list of the devices on bus 86 along with their
resource requirements.  And I'm looking for some discussion about
which are required, which are optional, what size we actually computed,
and what size we *should* have computed.  In English, not C.

You say 85:03.0 is also relevant, but your only explanation is "kind of."
That doesn't really help me.  Is the problem that the window leading
to bus 85 is limited, 85:03.0 takes some, and what's left isn't enough
for 85:02.0?  I don't see any information about the windows leading to
bus 85.

I'm dropping this for now; please post an update with an improved
changelog.

Bjorn
