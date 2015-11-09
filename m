Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] PCI: pcie-rcar: Convert to DT resource parsing API
Date: Mon, 9 Nov 2015 09:31:17 +0000
Message-ID: <PS1PR06MB11807CD89B1DE501665BB9FCF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
 <1446482175-26507-2-git-send-email-phil.edworthy@renesas.com>
 <20151107132902.GA21726@katana>
In-Reply-To: <20151107132902.GA21726@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 07 November 2015 13:29, Wolfram wrote:
> On Mon, Nov 02, 2015 at 04:36:13PM +0000, Phil Edworthy wrote:
> > The main purpose of this change is to avoid calling pci_ioremap_io() as
> > this is not available on arm64. However, instead of doing the range passing
> > in this driver we can utilise of_pci_get_host_bridge_resources().
> >
> > This is similar to changes made to the generic PCI host driver in commit
> > dbf9826d "PCI: generic: Convert to DT resource parsing API".
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Works for me and my USB3 card. I also like going the global io_offset
> variable away and the code readability improved, too, IMO.
> 
> One question:
> 
> 
> > +		case IORESOURCE_MEM:
> > +			parent = &iomem_resource;
> > +			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > +			break;
> 
> res_valid doesn't seem to be actually used?
Ah, you are right. I'll remove this & send a v2

Thanks
Phil
