Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Feb 2017 13:14:06 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jess Frazelle <me@jessfraz.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:Hyper-V CORE AND DRIVERS" <devel@linuxdriverproject.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 3/5] pci: set msi_domain_ops as __ro_after_init
Message-ID: <20170213181406.GD24425@localhost.localdomain>
References: <20170211013758.3288-1-me@jessfraz.com>
 <20170211013758.3288-3-me@jessfraz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170211013758.3288-3-me@jessfraz.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 05:37:56PM -0800, Jess Frazelle wrote:
> Marked msi_domain_ops structs as __ro_after_init when called only during init.
> This protects the data structure from accidental corruption.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jess Frazelle <me@jessfraz.com>
>
>  drivers/pci/host/pci-hyperv.c | 2 +-
>  drivers/pci/host/vmd.c        | 2 +-

Ok for vmd driver.

Acked-by: Keith Busch <keith.busch@intel.com>

>  drivers/pci/msi.c             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
