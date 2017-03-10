Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:36611 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934227AbdCJMHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2017 07:07:33 -0500
Date: Fri, 10 Mar 2017 13:07:25 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Vetter <daniel@ffwll.ch>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: dri-devel@lists.freedesktop.org,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 0/5] Thunderbolt GPU fixes
Message-ID: <20170310120725.GA24595@h08.hostsharing.net>
References: <cover.1487938188.git.lukas@wunner.de>
 <20170309150347.a4k4w2sclox2365t@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170309150347.a4k4w2sclox2365t@phenom.ffwll.local>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 09, 2017 at 04:03:47PM +0100, Daniel Vetter wrote:
> On Fri, Feb 24, 2017 at 08:19:45PM +0100, Lukas Wunner wrote:
> > Fix Thunderbolt-related issues in apple-gmux and vga_switcheroo:
> > 
> > Patch [1/5] ("Recognize Thunderbolt devices") has already been subjected
> > to a fair amount of scrutiny over at linux-pci@, I've submitted it 5 times
> > total since May 2016.  With luck it may be in ack-able shape now.
> > 
> > Patch [2/5] amends apple-gmux to handle combined DP/Thunderbolt ports
> > properly on newer MacBook Pros.
> > 
> > Patches [3/5] to [5/5] avoid registering external Thunderbolt GPUs with
> > vga_switcheroo:  Dave Airlie designed vga_switcheroo to register GPUs
> > unconditionally.  So if a desktop box has multiple GPUs, vga_switcheroo
> > will see more than one discrete GPU but that's not a problem because on
> > desktop boxes no handler is registered and thus vga_switcheroo_enable()
> > is never called.  Hybrid graphics laptops on the other hand do register
> > a handler, but are assumed to never register more than one discrete GPU.
> > However once a Thunderbolt eGPU is attached to a hybrid graphics laptop,
> > that assumption is no longer true and things go south when vga_switcheroo
> > runtime suspends the external discrete GPU and then calls the handler to
> > cut power to the internal discrete GPU.  The driver for the internal GPU
> > will sit there puzzled and typically cause a lockup.
[snip]
> > I've pushed the present series to GitHub in case anyone prefers reviewing
> > it in a GUI:
> > https://github.com/l1k/linux/commits/thunderbolt_gpu_v1
> 
> For merging, should I smash this all into drm-misc? The only thing outside
> is the apple-gmux driver ...

Merging through drm-misc would be lovely.  However I've prepared a v2 of
patch [1/5] to address Bjorn's comments (amended the commit message and a
code comment).  I'll respin the series this evening and include the acks
I've collected so far.

@Darren & Andy:
Please ack patch [5/5] of this series, barring any objections.

I'll move the apple-gmux patch to the end of the series, so merging that
one can be postponed until Darren and Andy find the time to look at it.

Thanks!

Lukas
