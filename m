Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 May 2017 08:52:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, linux-pci@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170525082215.4736027d@xeon-e3>
In-Reply-To: <20170525141955.6cee8fbb@alans-desktop>
References: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
 <BLUPR03MB1412AD9B6C5B4575F354EC4CCAFE0@BLUPR03MB1412.namprd03.prod.outlook.com>
 <20170525141955.6cee8fbb@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 25 May 2017 14:19:55 +0100
Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:

> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---    
> > 
> > According to Stephen Hemminger <sthemmin@microsoft.com>, there are
> > additional programs, like X.org, DPDK, are also using 16-bit only
> > PCI domain numbers. So, I'm submitting this patch for re-consideration.  
> 
> The correct way to handle this is to send the needed patches to DPDK and
> to X.org both of whom will I am sure be delighted to get it fixed in
> their codebase.

Both projects have stable ABI requirements. And the lead time to get
the change propagated out to applications is long (>5yrs) even longer
with the Enterprise distro's. As developers we can all just pass the
buck but this doesn't help users in any reasonable time fram. It is not
as simple as just making a patch or pull request for their upstream
code bases.
