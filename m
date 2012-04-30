Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1332135781-13695-6-git-send-email-yinghai@kernel.org>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org> <1332135781-13695-6-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Apr 2012 17:29:01 -0600
Message-ID: <CAErSpo5AnsmfQs4oa3P7AQyPTJ+YqCVVh5p2L=bmDY=A+BO9PQ@mail.gmail.com>
Subject: Re: [PATCH -v11 05/30] PCI: Add busn_res operation functions
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Will use them insert/update busn res in pci_bus struct.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/probe.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 53 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d30948d..9235b16 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1679,6 +1679,56 @@ err_out:
>        return NULL;
>  }
>
> +void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
> +{
> +       struct resource *res = &b->busn_res;
> +       struct resource *parent_res;
> +       int ret;
> +
> +       res->start = bus;
> +       res->end = bus_max;
> +       res->flags = IORESOURCE_BUS;
> +
> +       /* no parent for root bus' busn_res */
> +       if (!pci_is_root_bus(b)) {
> +               parent_res = &b->parent->busn_res;
> +
> +               ret = insert_resource(parent_res, res);
> +
> +               dev_printk(KERN_DEBUG, &b->dev,
> +                       "busn_res: %pR %s inserted under %pR\n",
> +                       res, ret ? "can not be" : "is", parent_res);
> +       } else
> +               dev_printk(KERN_DEBUG, &b->dev,
> +                       "busn_res: %pR for root bus\n",
> +                       res);
> +}
> +
> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
> +{
> +       struct resource *res = &b->busn_res;
> +       struct resource old_res = *res;
> +
> +       res->end = bus_max;

I've mentioned before that I'm not comfortable with updating the
struct resource after it's been inserted into the tree.  If you want
to do an in-place update, I think you need to add a new interface in
kernel/resource.c so it can make sure the resource tree remains
consistent.
