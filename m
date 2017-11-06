Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbdKFUwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Nov 2017 15:52:36 -0500
Date: Mon, 6 Nov 2017 13:52:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Devices behind a non-ACS switch are assigned different
 iommu-groups
Message-ID: <20171106135235.643ca4ec@t450s.home>
In-Reply-To: <AM4PR0501MB2723EC01DCA37976AE4EABA4D4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <AM4PR0501MB2723EC01DCA37976AE4EABA4D4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 29 Oct 2017 07:56:52 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Hi,
> I was testing devices assignment behind a non-ACS switch and to my surprise,
> Devices connected to different ports were assigned different iommu-groups.
> 
> The reason for this behavior is that pci_acs_enabled(...) considers the switch 
> Upstream port to have ACS enabled.
> http://elixir.free-electrons.com/linux/v4.13.1/source/drivers/pci/pci.c#L2914
> (the upstream port is not a multifunction device).
> 
> I'm not sure what the correct solution is but I believe, the upstream port
> Shouldn't be considered in pci_acs_path_enable(...).

Yes, this seems like a bug.  We should fix it, but we're likely to make
some people unhappy by doing so :-\  My guess it that this works
correctly if the switch enumerates downstream ports as separate
functions within the same slot, but fails if the downstream ports are
exposed as separate slots.  We like to assume that separate slots are
isolated, but of course they're all within the internal implementation
of the switch here.  Patches welcome, otherwise I'll try to look at it
soon.  Thanks,

Alex
