Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Dec 2017 14:11:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kelvin Cao <kelvin.cao@microsemi.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Switchtec Updates
Message-ID: <20171205201124.GH23510@bhelgaas-glaptop.roam.corp.google.com>
References: <20171129172844.21468-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129172844.21468-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 29, 2017 at 10:28:42AM -0700, Logan Gunthorpe wrote:
> Hi Bjorn,
> 
> Blease accept the following two patches. The first adds a couple more
> device IDs for the Switchtec driver. The second adds a new event type
> for it to report.
> 
> Thanks,
> 
> Logan
> 
> Kelvin Cao (1):
>   switchtec: Add device IDs for PSX 24xG3 and PSX 48xG3
> 
> Logan Gunthorpe (1):
>   switchtec: Added Global Fabric Manager Server (GFMS) event
> 
>  drivers/pci/switch/switchtec.c       | 3 +++
>  include/linux/switchtec.h            | 3 +++
>  include/uapi/linux/switchtec_ioctl.h | 3 ++-
>  3 files changed, 8 insertions(+), 1 deletion(-)

Applied to pci/switchtec for v4.16, thanks!
