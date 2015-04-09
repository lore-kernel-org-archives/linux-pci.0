Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Apr 2015 17:12:56 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read ID & Pointer from PCI Capabilities List in 1 call
Message-ID: <20150409221256.GO30967@google.com>
References: <1428009019-19563-1-git-send-email-sean.stalley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428009019-19563-1-git-send-email-sean.stalley@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 02, 2015 at 02:10:19PM -0700, Sean O. Stalley wrote:
> Reading both fields at the same time lets us parse the
> list with half the number of configspace reads.
> 
> Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>

Applied to pci/misc for v4.1, thanks Sean!

> ---
>  drivers/pci/pci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5e3c8e9..db7f3d6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -145,19 +145,22 @@ static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>  				   u8 pos, int cap, int *ttl)
>  {
>  	u8 id;
> +	u16 ent;
> +
> +	pci_bus_read_config_byte(bus, devfn, pos, &pos);
>  
>  	while ((*ttl)--) {
> -		pci_bus_read_config_byte(bus, devfn, pos, &pos);
>  		if (pos < 0x40)
>  			break;
>  		pos &= ~3;
> -		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID,
> -					 &id);
> +		pci_bus_read_config_word(bus, devfn, pos, &ent);
> +
> +		id = ent & 0xff;
>  		if (id == 0xff)
>  			break;
>  		if (id == cap)
>  			return pos;
> -		pos += PCI_CAP_LIST_NEXT;
> +		pos = (ent >> 8);
>  	}
>  	return 0;
>  }
> -- 
> 1.9.1
> 
