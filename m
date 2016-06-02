Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Wenrui Li <wenrui.li@rock-chips.com>, Doug Anderson <dianders@chromium.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>, Hannes Reinecke <hare@suse.de>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Date: Thu, 02 Jun 2016 17:06:55 +0200
Message-ID: <3585926.N1C2xx3GaB@wuerfel>
In-Reply-To: <20160602140001.GB8262@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de> <4967020.J4dsRYGugq@wuerfel> <20160602140001.GB8262@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 9:00:01 AM CEST Bjorn Helgaas wrote:
> > I just did a count of the implementations of pci_ops: I found 107
> > instances of 'struct pci_ops', and 67 of them treat type0 and type1
> > access differently in some form.
> > 
> > I'd estimate that about half of them, or roughly a third of the total
> > instances would benefit from my change, if we were to do them again.
> > Clearly there is no need to change the existing code here when it works,
> > unless the benefit is very clear and the code is actively maintained.
> > 
> > In some cases, the difference is only that the root bus has a limited
> > set of devices that are allowed to be accessed, so there would
> > likely be no benefit of this, compared to e.g. yet another callback
> > that checks the validity.
> > Some other instances have type0 registers at a different memory location
> > from type1, some use different layout inside of that space, and some
> > are completely different.
> 
> The type0/type1 distinction still seems out of place to me at the call
> site.  Is there any other reason a caller would care about the
> difference between type0 and type1?

The callers really shouldn't care, but they also shouldn't call the
pci_ops function pointer (and as we found earlier, there are only
three such callers).

The distinction between type0 and type1 in my mind is an implementation
detail of the pci_{read,write}_config_{byte,word,dword} functions
that call the low-level operations here.

	Arnd
