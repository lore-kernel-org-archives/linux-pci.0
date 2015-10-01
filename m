Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1443653222-24924-3-git-send-email-ddaney.cavm@gmail.com>
References: <1443653222-24924-1-git-send-email-ddaney.cavm@gmail.com> <1443653222-24924-3-git-send-email-ddaney.cavm@gmail.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 1 Oct 2015 08:08:35 -0500
Message-ID: <CAL_JsqJA6UskrxU2Gpo3vtAyfPzT=d-9Z+CSpT__mR+7FRmhrQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] of/irq: Add new function of_msi_map_rid()
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 30, 2015 at 5:47 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> The device tree property "msi-map" specifies how to create the PCI
> requester id used in some MSI controllers.  Add a new function
> of_msi_map_rid() that finds the msi-map property and applies its
> translation to a given requester id.
>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Rob Herring <robh@kernel.org>

I'm assuming this will go thru irqchip or PCI trees? It helps if To is
who you want to merge this.

Rob

> ---
>  drivers/of/irq.c       | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_irq.h |  7 +++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 55317fa..c90bd4e 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -598,3 +598,87 @@ void of_msi_configure(struct device *dev, struct device_node *np)
>                 d = irq_find_host(msi_np);
>         dev_set_msi_domain(dev, d);
>  }
> +
> +/**
> + * of_msi_map_rid - Map a MSI requester ID for a device.
> + * @dev: device for which the mapping is to be done.
> + * @msi_np: device node of the expected msi controller.
> + * @rid_in: unmapped MSI requester ID for the device.
> + *
> + * Walk up the device hierarchy looking for devices with a "msi-map"
> + * property.  If found, apply the mapping to @rid_in.
> + *
> + * Returns the mapped MSI requester ID.
> + */
> +u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
> +{
> +       struct device *parent_dev;
> +       struct device_node *msi_controller_node;
> +       u32 map_mask, masked_rid, rid_base, msi_base, rid_len, phandle;
> +       int msi_map_len;
> +       bool matched;
> +       u32 rid_out = rid_in;
> +       const __be32 *msi_map = NULL;
> +
> +       /*
> +        * Walk up the device parent links looking for one with a
> +        * "msi-map" property.
> +        */
> +       for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> +               if (!parent_dev->of_node)
> +                       continue;
> +
> +               msi_map = of_get_property(parent_dev->of_node,
> +                                         "msi-map", &msi_map_len);
> +               if (!msi_map)
> +                       continue;
> +
> +               if (msi_map_len % (4 * sizeof(__be32))) {
> +                       dev_err(parent_dev, "Error: Bad msi-map length: %d\n",
> +                               msi_map_len);
> +                       return rid_out;
> +               }
> +               /* We have a good parent_dev and msi_map, let's use them. */
> +               break;
> +       }
> +       if (!msi_map)
> +               return rid_out;
> +
> +       /* The default is to select all bits. */
> +       map_mask = 0xffffffff;
> +
> +       /*
> +        * Can be overridden by "msi-map-mask" property.  If
> +        * of_property_read_u32() fails, the default is used.
> +        */
> +       of_property_read_u32(parent_dev->of_node, "msi-map-mask", &map_mask);
> +
> +       masked_rid = map_mask & rid_in;
> +       matched = false;
> +       while (!matched && msi_map_len >= 4 * sizeof(__be32)) {
> +               rid_base = be32_to_cpup(msi_map + 0);
> +               phandle = be32_to_cpup(msi_map + 1);
> +               msi_base = be32_to_cpup(msi_map + 2);
> +               rid_len = be32_to_cpup(msi_map + 3);
> +
> +               msi_controller_node = of_find_node_by_phandle(phandle);
> +
> +               matched = masked_rid >= rid_base &&
> +                       masked_rid < rid_base + rid_len &&
> +                       msi_np == msi_controller_node;
> +
> +               of_node_put(msi_controller_node);
> +               msi_map_len -= 4 * sizeof(__be32);
> +               msi_map += 4;
> +       }
> +       if (!matched)
> +               return rid_out;
> +
> +       rid_out = masked_rid + msi_base;
> +       dev_dbg(dev,
> +               "msi-map at: %s, using mask %08x, rid-base: %08x, msi-base: %08x, length: %08x, rid: %08x -> %08x\n",
> +               dev_name(parent_dev), map_mask, rid_base, msi_base,
> +               rid_len, rid_in, rid_out);
> +
> +       return rid_out;
> +}
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 4bcbd58..8cd9334 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -75,6 +75,7 @@ static inline int of_irq_to_resource_table(struct device_node *dev,
>  extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);
>  extern struct device_node *of_irq_find_parent(struct device_node *child);
>  extern void of_msi_configure(struct device *dev, struct device_node *np);
> +u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
>
>  #else /* !CONFIG_OF */
>  static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
> @@ -87,6 +88,12 @@ static inline void *of_irq_find_parent(struct device_node *child)
>  {
>         return NULL;
>  }
> +
> +static inline u32 of_msi_map_rid(struct device *dev,
> +                                struct device_node *msi_np, u32 rid_in)
> +{
> +       return rid_in;
> +}
>  #endif /* !CONFIG_OF */
>
>  #endif /* __OF_IRQ_H */
> --
> 1.9.1
>
