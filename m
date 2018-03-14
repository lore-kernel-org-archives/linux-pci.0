Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:35759 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeCNGHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 02:07:22 -0400
Date: Wed, 14 Mar 2018 07:07:20 +0100
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
Message-ID: <20180314060720.GA24283@wunner.de>
References: <cover.1520068884.git.lukas@wunner.de>
 <20180306102940.GG22212@phenom.ffwll.local>
 <20180311155549.GA11806@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180311155549.GA11806@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 11, 2018 at 04:55:49PM +0100, Lukas Wunner wrote:
> > On Sat, Mar 03, 2018 at 10:53:24AM +0100, Lukas Wunner wrote:
> > > Modernize vga_switcheroo by using a device link to enforce a runtime PM
> > > dependency from an HDA controller to the GPU it's integrated into, v2.
> > > 
> > > https://github.com/l1k/linux/commits/switcheroo_devlink_v2
> 
> If there are no objections, I plan to push the series to
> drm-misc-next by the middle of the coming week so that it
> would still catch the last train to 4.17.

Pushed to drm-misc-next now with Bjorn's changelog tweak and ack for
patch [1/1].

Thanks a lot everyone for the reviews, acks, testing & comments.

Lukas
