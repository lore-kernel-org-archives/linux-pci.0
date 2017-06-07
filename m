Return-Path: <SRS0=2Rdb=5M=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=2Rdb=5M=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v6 3/6] irqdomain: Add irq_domain_{push,pop}_irq()
 functions.
To: Tim Harvey <tharvey@gateworks.com>,
 Linus Walleij <linus.walleij@linaro.org>
References: <1491931269-15650-1-git-send-email-david.daney@cavium.com>
 <1491931269-15650-4-git-send-email-david.daney@cavium.com>
 <CACRpkdZ8byO6=rWS-TJDJ21-duvyau_EQpN2hWj27DF8ur6fnQ@mail.gmail.com>
 <CAJ+vNU2ejbQUTBGnJsLr+pYdJsUc=yHZvbrKNm0bo5nZL=DhBw@mail.gmail.com>
Cc: David Daney <david.daney@cavium.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <d755037b-f909-ea0c-a8a5-617cac09fc15@arm.com>
Date: Wed, 7 Jun 2017 17:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU2ejbQUTBGnJsLr+pYdJsUc=yHZvbrKNm0bo5nZL=DhBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 07/06/17 17:09, Tim Harvey wrote:
> On Mon, Apr 24, 2017 at 6:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Sorry for top posting but we need to loop in Bjorn Helgass and the
>> linux-pci mailing list on this patch, at least so they see it, and can
>> recognize similar cases in the future.
>>
>> (The patch set if very nice.)
>>
>> Yours,
>> Linus Walleij
>>
>> On Tue, Apr 11, 2017 at 7:21 PM, David Daney <david.daney@cavium.com> wrote:
>>> For an already existing irqdomain hierarchy, as might be obtained via
>>> a call to pci_enable_msix_range(), a PCI driver wishing to add an
>>> additional irqdomain to the hierarchy needs to be able to insert the
>>> irqdomain to that already initialized hierarchy.  Calling
>>> irq_domain_create_hierarchy() allows the new irqdomain to be created,
>>> but no existing code allows for initializing the associated irq_data.
>>>
>>> Add a couple of helper functions (irq_domain_push_irq() and
>>> irq_domain_pop_irq()) to initialize the irq_data for the new
>>> irqdomain added to an existing hierarchy.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> ---
>>>  include/linux/irqdomain.h |   3 +
>>>  kernel/irq/irqdomain.c    | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 181 insertions(+)
>>>
>>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>>> index 9f36160..0316846 100644
>>> --- a/include/linux/irqdomain.h
>>> +++ b/include/linux/irqdomain.h
>>> @@ -425,6 +425,9 @@ extern void irq_domain_free_irqs_common(struct irq_domain *domain,
>>>  extern void irq_domain_free_irqs_top(struct irq_domain *domain,
>>>                                      unsigned int virq, unsigned int nr_irqs);
>>>
>>> +extern int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg);
>>> +extern int irq_domain_pop_irq(struct irq_domain *domain, int virq);
>>> +
>>>  extern int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
>>>                                         unsigned int irq_base,
>>>                                         unsigned int nr_irqs, void *arg);
>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>> index 31805f2..ea9d30d 100644
>>> --- a/kernel/irq/irqdomain.c
>>> +++ b/kernel/irq/irqdomain.c
>>> @@ -1304,6 +1304,184 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>>>         return ret;
>>>  }
>>>
>>> +/* The irq_data was moved, fix the revmap to refer to the new location */
>>> +static void irq_domain_fix_revmap(struct irq_data *d)
>>> +{
>>> +       void **slot;
>>> +
>>> +       if (d->hwirq < d->domain->revmap_size)
>>> +               return; /* Not using radix tree. */
>>> +
>>> +       /* Fix up the revmap. */
>>> +       mutex_lock(&revmap_trees_mutex);
>>> +       slot = radix_tree_lookup_slot(&d->domain->revmap_tree, d->hwirq);
>>> +       if (slot)
>>> +               radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
>>> +       mutex_unlock(&revmap_trees_mutex);
>>> +}
>>> +
>>> +/**
>>> + * irq_domain_push_irq() - Push a domain in to the top of a hierarchy.
>>> + * @domain:    Domain to push.
>>> + * @virq:      Irq to push the domain in to.
>>> + * @arg:       Passed to the irq_domain_ops alloc() function.
>>> + *
>>> + * For an already existing irqdomain hierarchy, as might be obtained
>>> + * via a call to pci_enable_msix(), add an additional domain to the
>>> + * head of the processing chain.  Must be called before request_irq()
>>> + * has been called.
>>> + */
>>> +int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
>>> +{
>>> +       struct irq_data *child_irq_data;
>>> +       struct irq_data *root_irq_data = irq_get_irq_data(virq);
>>> +       struct irq_desc *desc;
>>> +       int rv = 0;
>>> +
>>> +       /*
>>> +        * Check that no action has been set, which indicates the virq
>>> +        * is in a state where this function doesn't have to deal with
>>> +        * races between interrupt handling and maintaining the
>>> +        * hierarchy.  This will catch gross misuse.  Attempting to
>>> +        * make the check race free would require holding locks across
>>> +        * calls to struct irq_domain_ops->alloc(), which could lead
>>> +        * to deadlock, so we just do a simple check before starting.
>>> +        */
>>> +       desc = irq_to_desc(virq);
>>> +       if (!desc)
>>> +               return -EINVAL;
>>> +       if (WARN_ON(desc->action))
>>> +               return -EBUSY;
>>> +
>>> +       if (domain == NULL)
>>> +               return -EINVAL;
>>> +
>>> +       if (WARN_ON(!domain->ops->alloc))
>>> +               return -EINVAL;
>>> +
>>> +       if (!root_irq_data)
>>> +               return -EINVAL;
>>> +
>>> +       child_irq_data = kzalloc_node(sizeof(*child_irq_data), GFP_KERNEL,
>>> +                                     irq_data_get_node(root_irq_data));
>>> +       if (!child_irq_data)
>>> +               return -ENOMEM;
>>> +
>>> +       mutex_lock(&irq_domain_mutex);
>>> +
>>> +       /* Copy the original irq_data. */
>>> +       *child_irq_data = *root_irq_data;
>>> +
>>> +       irq_domain_fix_revmap(child_irq_data);
>>> +
>>> +       /*
>>> +        * Overwrite the root_irq_data, which is embedded in struct
>>> +        * irq_desc, with values for this domain.
>>> +        */
>>> +       root_irq_data->parent_data = child_irq_data;
>>> +       root_irq_data->domain = domain;
>>> +       root_irq_data->mask = 0;
>>> +       root_irq_data->hwirq = 0;
>>> +       root_irq_data->chip = NULL;
>>> +       root_irq_data->chip_data = NULL;
>>> +       rv = domain->ops->alloc(domain, virq, 1, arg);
>>> +       if (rv) {
>>> +               /* Restore the original irq_data. */
>>> +               *root_irq_data = *child_irq_data;
>>> +               irq_domain_fix_revmap(root_irq_data);
>>> +               goto error;
>>> +       }
>>> +
>>> +       if (root_irq_data->hwirq < domain->revmap_size) {
>>> +               domain->linear_revmap[root_irq_data->hwirq] = virq;
>>> +       } else {
>>> +               mutex_lock(&revmap_trees_mutex);
>>> +               radix_tree_insert(&domain->revmap_tree,
>>> +                                 root_irq_data->hwirq, root_irq_data);
>>> +               mutex_unlock(&revmap_trees_mutex);
>>> +       }
>>> +error:
>>> +       mutex_unlock(&irq_domain_mutex);
>>> +
>>> +       return rv;
>>> +}
>>> +EXPORT_SYMBOL_GPL(irq_domain_push_irq);
>>> +
>>> +/**
>>> + * irq_domain_pop_irq() - Remove a domain from the top of a hierarchy.
>>> + * @domain:    Domain to remove.
>>> + * @virq:      Irq to remove the domain from.
>>> + *
>>> + * Undo the effects of a call to irq_domain_push_irq().  Must be
>>> + * called either before request_irq() or after free_irq().
>>> + */
>>> +int irq_domain_pop_irq(struct irq_domain *domain, int virq)
>>> +{
>>> +       struct irq_data *root_irq_data = irq_get_irq_data(virq);
>>> +       struct irq_data *child_irq_data;
>>> +       struct irq_data *tmp_irq_data;
>>> +       struct irq_desc *desc;
>>> +
>>> +       /*
>>> +        * Check that no action is set, which indicates the virq is in
>>> +        * a state where this function doesn't have to deal with races
>>> +        * between interrupt handling and maintaining the hierarchy.
>>> +        * This will catch gross misuse.  Attempting to make the check
>>> +        * race free would require holding locks across calls to
>>> +        * struct irq_domain_ops->free(), which could lead to
>>> +        * deadlock, so we just do a simple check before starting.
>>> +        */
>>> +       desc = irq_to_desc(virq);
>>> +       if (!desc)
>>> +               return -EINVAL;
>>> +       if (WARN_ON(desc->action))
>>> +               return -EBUSY;
>>> +
>>> +       if (domain == NULL)
>>> +               return -EINVAL;
>>> +
>>> +       if (!root_irq_data)
>>> +               return -EINVAL;
>>> +
>>> +       tmp_irq_data = irq_domain_get_irq_data(domain, virq);
>>> +
>>> +       /* We can only "pop" if this domain is at the top of the list */
>>> +       if (WARN_ON(root_irq_data != tmp_irq_data))
>>> +               return -EINVAL;
>>> +
>>> +       if (WARN_ON(root_irq_data->domain != domain))
>>> +               return -EINVAL;
>>> +
>>> +       child_irq_data = root_irq_data->parent_data;
>>> +       if (WARN_ON(!child_irq_data))
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&irq_domain_mutex);
>>> +
>>> +       root_irq_data->parent_data = NULL;
>>> +
>>> +       if (root_irq_data->hwirq >= domain->revmap_size) {
>>> +               mutex_lock(&revmap_trees_mutex);
>>> +               radix_tree_delete(&domain->revmap_tree, root_irq_data->hwirq);
>>> +               mutex_unlock(&revmap_trees_mutex);
>>> +       }
>>> +
>>> +       if (domain->ops->free)
>>> +               domain->ops->free(domain, virq, 1);
>>> +
>>> +       /* Restore the original irq_data. */
>>> +       *root_irq_data = *child_irq_data;
>>> +
>>> +       irq_domain_fix_revmap(root_irq_data);
>>> +
>>> +       mutex_unlock(&irq_domain_mutex);
>>> +
>>> +       kfree(child_irq_data);
>>> +
>>> +       return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(irq_domain_pop_irq);
>>> +
>>>  /**
>>>   * irq_domain_free_irqs - Free IRQ number and associated data structures
>>>   * @virq:      base IRQ number
>>> --
>>> 1.8.3.1
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Linus,
> 
> It looks like we are still waiting on ACK's for this from the IRQ
> folk. Are the right people cc'd? Seem's like there's been an adequate
> review period with no response.

Yup, I've been fairly busy with some other Cavium related stuff. I'll
get on it shortly...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
