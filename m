Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50655 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbeCKPzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Mar 2018 11:55:51 -0400
Date: Sun, 11 Mar 2018 16:55:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, Daniel Drake <dan@reactivated.net>,
        Denis Lisov <dennis.lissov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Martin Lopatar <lopin@dataplex.cz>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        Takashi Iwai <tiwai@suse.com>, Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, Mike Lothian <mike@fireburn.co.uk>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 0/7] Modernize vga_switcheroo by using device link for
 HDA
Message-ID: <20180311155549.GA11806@wunner.de>
References: <cover.1520068884.git.lukas@wunner.de>
 <20180306102940.GG22212@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180306102940.GG22212@phenom.ffwll.local>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 06, 2018 at 11:29:40AM +0100, Daniel Vetter wrote:
> On Sat, Mar 03, 2018 at 10:53:24AM +0100, Lukas Wunner wrote:
> > Modernize vga_switcheroo by using a device link to enforce a runtime PM
> > dependency from an HDA controller to the GPU it's integrated into, v2.
> > 
> > https://github.com/l1k/linux/commits/switcheroo_devlink_v2
> 
> This all looks really reasonable and like a good cleanup, but it's a bit
> too much detail so I'll punt review to someone else with more clue.

Patches [3/7] to [7/7] were reviewed by Peter Wu, the HDA bits in
patch [5/7] additionally by Takashi.

Patch [2/7] was acked by Bjorn.  There was no ack for patch [1/7]
(authored by Rafael), but it adressed the objection Bjorn raised
against my original patch, so I'm assuming Bjorn is okay with it.
(Bjorn, please let me know if that isn't the case.)

The series has been tested on 5 systems, which raises the confidence:
2x AMD PowerXpress (Mike Lothian, Kai Heng Feng)
2x Nvidia Optimus (Denis Lisov, Peter Wu)
1x MacBook Pro

The issues found during Peter Wu's thorough testing appear to all
be unrelated to this series, as per my e-mail yesterday.

If there are no objections, I plan to push the series to
drm-misc-next by the middle of the coming week so that it
would still catch the last train to 4.17.

Thanks,

Lukas
