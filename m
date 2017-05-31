Return-Path: <SRS0=jrP7=5F=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=jrP7=5F=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <david.laight@aculab.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
References: <ef36137c-f0d1-23b9-8b91-a6ed87239578@arm.com>
 <aec89b9a-8377-ff39-547c-9e6eaf254fab@free.fr>
 <f1a57255-be75-e8c4-6b8d-0254f4365d61@arm.com>
 <c78b1e79-59e5-0097-989e-1f1e8cd93fc4@arm.com>
 <b10a211d-1f4a-1cc1-7139-9b48a90dd1c6@free.fr>
 <20170531173414.GB4496@bhelgaas-glaptop.roam.corp.google.com>
 <4885137f-7c1c-5742-4f66-f48c32ce7abb@free.fr>
 <20170531190037.GA18084@bhelgaas-glaptop.roam.corp.google.com>
 <20170531191258.GA18454@bhelgaas-glaptop.roam.corp.google.com>
 <74d6d867-313a-2304-9753-9739ad4703a8@free.fr>
 <20170531200424.GA23171@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <8bbdc8a4-98a5-ae13-ff0f-d644307986d5@free.fr>
Date: Wed, 31 May 2017 23:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170531200424.GA23171@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 31/05/2017 22:04, Bjorn Helgaas wrote:

> Cscope only sees 94 definitions of irq_set_affinity.  I know *I* could
> never write a script faster than looking at them manually.

for F in $(find -name '*.c'); do
  if grep -q pci_msi_create_irq_domain $F; then
    grep 'irq_set_affinity\s*=' $F | cut -f2 -d= | tr -d ',;' | while read CALLBACK
    do
      Y=$(grep -A4 "$CALLBACK(struct" $F)
      echo $Y | grep static
    done
  fi
done

static int ls_scfg_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force) { return -EINVAL; }
static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force) { return -EINVAL; }
static int armada_xp_set_affinity(struct irq_data *d, const struct cpumask *mask_val, bool force) { irq_hw_number_t hwirq = irqd_to_hwirq(d);
static int nwl_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force) { return -EINVAL; }
static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force) { struct irq_data *parent = data->parent_data;
static int xgene_msi_set_affinity(struct irq_data *irqdata, const struct cpumask *mask, bool force) { int target_cpu = cpumask_first(mask); int curr_cpu;
static int vmd_irq_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force) { return -EINVAL; }
static int altera_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force) { return -EINVAL; }
static int advk_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force) { return -EINVAL; }
static int iproc_msi_irq_set_affinity(struct irq_data *data, const struct cpumask *mask, bool force) { struct iproc_msi *msi = irq_data_get_irq_chip_data(data);

> While doing that, I noticed irq_chip_set_affinity_parent(), which is
> used in 14 cases and appears similar to your patch.

Indeed. I suppose msi_domain_set_affinity() could look like below,
if we don't mind changing EINVAL to ENOSYS. What do you think?

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ddc2f5427f75..d37d2ba790df 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -87,11 +87,10 @@ static inline void irq_chip_write_msi_msg(struct irq_data *data,
 int msi_domain_set_affinity(struct irq_data *irq_data,
                            const struct cpumask *mask, bool force)
 {
-       struct irq_data *parent = irq_data->parent_data;
        struct msi_msg msg;
        int ret;
 
-       ret = parent->chip->irq_set_affinity(parent, mask, force);
+       ret = irq_chip_set_affinity_parent(irq_data, mask, force);
        if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
                BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
                irq_chip_write_msi_msg(irq_data, &msg);
