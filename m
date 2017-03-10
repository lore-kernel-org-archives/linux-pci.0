Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36744 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936812AbdCJMQC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2017 07:16:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170310120725.GA24595@h08.hostsharing.net>
References: <cover.1487938188.git.lukas@wunner.de> <20170309150347.a4k4w2sclox2365t@phenom.ffwll.local>
 <20170310120725.GA24595@h08.hostsharing.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Mar 2017 14:15:45 +0200
Message-ID: <CAHp75Vcg_1EjtVLeLSpoadAcFa_+1fkzHyU4m_rY9O1taQOAmA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Thunderbolt GPU fixes
To: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        dri-devel@lists.freedesktop.org,
        Michael Jamet <michael.jamet@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Peter Wu <peter@lekensteyn.nl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 10, 2017 at 2:07 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Mar 09, 2017 at 04:03:47PM +0100, Daniel Vetter wrote:
>> On Fri, Feb 24, 2017 at 08:19:45PM +0100, Lukas Wunner wrote:
>> > Fix Thunderbolt-related issues in apple-gmux and vga_switcheroo:
>> >
>> > Patch [1/5] ("Recognize Thunderbolt devices") has already been subjected
>> > to a fair amount of scrutiny over at linux-pci@, I've submitted it 5 times
>> > total since May 2016.  With luck it may be in ack-able shape now.
>> >
>> > Patch [2/5] amends apple-gmux to handle combined DP/Thunderbolt ports
>> > properly on newer MacBook Pros.
>> >
>> > Patches [3/5] to [5/5] avoid registering external Thunderbolt GPUs with
>> > vga_switcheroo:  Dave Airlie designed vga_switcheroo to register GPUs
>> > unconditionally.  So if a desktop box has multiple GPUs, vga_switcheroo
>> > will see more than one discrete GPU but that's not a problem because on
>> > desktop boxes no handler is registered and thus vga_switcheroo_enable()
>> > is never called.  Hybrid graphics laptops on the other hand do register
>> > a handler, but are assumed to never register more than one discrete GPU.
>> > However once a Thunderbolt eGPU is attached to a hybrid graphics laptop,
>> > that assumption is no longer true and things go south when vga_switcheroo
>> > runtime suspends the external discrete GPU and then calls the handler to
>> > cut power to the internal discrete GPU.  The driver for the internal GPU
>> > will sit there puzzled and typically cause a lockup.
> [snip]
>> > I've pushed the present series to GitHub in case anyone prefers reviewing
>> > it in a GUI:
>> > https://github.com/l1k/linux/commits/thunderbolt_gpu_v1
>>
>> For merging, should I smash this all into drm-misc? The only thing outside
>> is the apple-gmux driver ...
>
> Merging through drm-misc would be lovely.  However I've prepared a v2 of
> patch [1/5] to address Bjorn's comments (amended the commit message and a
> code comment).  I'll respin the series this evening and include the acks
> I've collected so far.
>
> @Darren & Andy:
> Please ack patch [5/5] of this series, barring any objections.
>
> I'll move the apple-gmux patch to the end of the series, so merging that
> one can be postponed until Darren and Andy find the time to look at it.

Yeah, please resend. It's probably buried in the pile of deleted mails.
Though I have still patchwork ticket.

Okay, I have looked at it and I'm fine with the code. Hope this
doesn't break anything.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
