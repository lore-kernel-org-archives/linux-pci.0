Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Mar 2017 19:15:25 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] WIP: PCI: rockchip: add remove() support
Message-ID: <20170309031523.GA123115@google.com>
References: <20170308233748.54706-1-briannorris@chromium.org>
 <20170308233748.54706-3-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308233748.54706-3-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 08, 2017 at 03:37:48PM -0800, Brian Norris wrote:
> I haven't quite figured out the right way to invert pci_remap_iospace().
> I guess no one supports this yet?

Jeffy Chen pointed out to me that there's a pci_unmap_iospace() as of
4.8. Looks like that should probably do the job. I'll rework this and
send it out sometime. The first 2 patches are still relevant though, and
the first one is a bugfix.

Brian
