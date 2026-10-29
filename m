Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293611;
	b=dZQTsMJzSGbjRXBYW3pg2YruvvVaq5l2FmhS2ldVzP0EJf96awUrBfh6wx6BXwsRmdFm
	 fchi9Wx/GaFtGI3ws0Jsi7kUvU4URiPrlshtW6VpeZuzsOyRLWLsPnpGxej+nF3AxaQRk
	 rnk4y/pdoEwMnlZrz29dai82wVe6BhFI0ZEH6ze7lMgmg4JTBF5Xr2oSzrT0+W0dJ/W6X
	 b0z2eifV5h2xR4e8+jBO01WaKnzPcwnY7s38vWgE82tXnXgnvH1C/gKkbyM0bmaqRbTUO
	 rfi+Ctt7t7tfPavPdaoEq6sEWFyYIVBbwgG3+qYiNZaNN9qDqArmTEz8iL9ITRtitcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293611;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hqkcRhbg6p6G4OiMh1Urw9NTIjXWW9NK4+69SzpS4Qc=;
	b=GOsnnxtlkwXK3uJVbH6MwnvTV9i0t5+gbj5APzwgnSpbS16q6gpo2fvRRpYvf4ECER+8
	 G/0mAelauShpQ0umv/pgoNEMpmd39lGhPz07MGEULu3faZcnBUTe8HLcRRg9jUHT2faHB
	 MslpBQ8CRWnS1pjL5CcTSk4vjBMvs3zrXgY24zcyT+im8kKaLwJnfQZ49yyxsbEIXUX9S
	 jqNWhdnjcMXJhzFV5+CVrP7qJ8CUOI/hGUvAvewpPGo7yau3KgRvFocb+8Rn0+elPpc1U
	 LTYHjXFgFBJpZo7cR6NvOA9iCSZmci9nzYgfjkX66hfsDsFylPzP/EmeCO9Cwcs6ZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sk4EVqEB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040A606A322;
	Thu, 29 Oct 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sk4EVqEB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01061F01816;
	Thu, 29 Oct 2026 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293610;
	bh=hqkcRhbg6p6G4OiMh1Urw9NTIjXWW9NK4+69SzpS4Qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sk4EVqEBx2lOsW2goUkQRflKlJgnbMO7VwU5x25Ugz2sN+dF1H9jqXRJYn8s0Oux6
	 5PGG8TlltNQnDtWt8II2Oc6go/el/0Ga6377nUML7CBb1WjUfjMhcQw3HCBB+zeWWi
	 4YnsbXIBgceBHxUM5TS/CMITlPRBKA5Y6cLoTwLHgxpqDByy2m78sLi0BASWA5vCiV
	 PLZFV0LfHr5D0TKtTZKrU1I0rHDTFoCEjJVo51Bzcgj/yqZbud0A71Cwwz2ouhRis4
	 uWf0lLOqzIzFzTCd4uBJFlOSjQsRK1XjxW0DeV+SzfrTAoEctjrpnYS/i5K35yDZ18
	 amaKF2kvu9S2w==
Message-ID: <sashiko-outbox-189718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] PCI: add KVM MSI domain guest module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261029163713.1366077-4-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-4-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:06:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] PCI: kvm-msi: use-after-free on module unload in kvm_pci_msi_exit()
- [High] PCI: kvm-msi: broken IRQ affinity in kvm_pcie_init_dev_msi_info()
- [High] PCI: kvm-msi: host MSI message corrupts guest config in kvm_compos=
e_msi_msg()
- [High] PCI: kvm-msi: global kvm_msi_ctx clobbered in kvm_pcie_domain_allo=
c()
- [High] PCI: kvm-msi: init failure in kvm_pci_msi_init() breaks hotplug an=
d modprobe
- [High] PCI: kvm-msi: race and use-after-free on kvm_data in kvm_pcie_doma=
in_free()
- [Medium] PCI: kvm-msi: missing stubs in pci-kvm-msi.h break modular link
- [Medium] PCI: kvm-msi: kvm_pci_msi_wait_ready() polls until timeout on hy=
percall error
- [Medium] PCI: kvm-msi: missing device_lock() in kvm_msi_attach_device()
--

commit 56d70781d8bf9094f446115196e63d6a77876b7c
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: add KVM MSI domain guest module

This commit adds a guest-side PCI MSI IRQ domain driver for KVM virtual
machines that intercepts MSI composition and provides kvm_pci_msi_wait_read=
y()
and kvm_pci_msi_get_address() to obtain host physical MSI addresses via a K=
VM
hypercall for devices whose firmware programs MSI addresses into BAR regist=
ers.

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index d246bbe37948e..cdf65d1c26741 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -248,6 +248,18 @@ config PCI_HYPERV_INTERFACE
>  	  drivers to have a common interface with the Hyper-V PCI frontend
>  	  driver.
> =20
> +config PCI_KVM_MSI_DOMAIN
> +	tristate "KVM PCI passthrough MSI domain"
> +	depends on X86_64 && KVM_GUEST && PCI_MSI
> +	select IRQ_MSI_LIB

[ ... ]

> diff --git a/drivers/pci/controller/pci-kvm-msi.c b/drivers/pci/controlle=
r/pci-kvm-msi.c
> new file mode 100644
> index 0000000000000..e2b0a4114aa88
> --- /dev/null
> +++ b/drivers/pci/controller/pci-kvm-msi.c

[ ... ]

> +struct kvm_msi_ctx {
> +	struct pci_dev *pdev;
> +	struct irq_domain *domain;
> +	u32 devid;
> +	unsigned int first_virq;
> +	unsigned int nr_irqs;
> +};
> +
> +static struct kvm_msi_ctx kvm_msi_ctx;
> +
> +int kvm_pci_msi_wait_ready(struct pci_dev *pdev, unsigned long timeout_m=
s)
> +{
> +	struct kvm_msi_response resp =3D {};
> +	struct kvm_msi_irq_data *kvm_data;
> +	unsigned int max_retries;
> +	struct irq_data *irqd;
> +	struct msi_desc *desc;
> +	unsigned int retries;
> +	long hret;
> +	int i;
> +
> +	if (!kvm_para_available())
> +		return 0;
> +
> +	if (!kvm_msi_domain)
> +		return 0;
> +
> +	if (!pdev || !kvm_msi_ctx.pdev || kvm_msi_ctx.pdev !=3D pdev)
> +		return 0;
> +
> +	max_retries =3D timeout_ms / KVM_MSI_POLL_INTERVAL_MS;
> +	if (!max_retries)
> +		max_retries =3D 1;
> +
> +	for (retries =3D 0; retries < max_retries; retries++) {
> +		memset(&resp, 0, sizeof(resp));
> +		hret =3D kvm_hypercall3(KVM_HC_PCI_MSI_ALLOC,
> +				      kvm_msi_ctx.devid, 0,
> +				      slow_virt_to_phys(&resp));
> +
> +		if (hret =3D=3D 0 && resp.address_lo !=3D 0)
> +			goto ready;
> +
> +		msleep(KVM_MSI_POLL_INTERVAL_MS);
> +	}
> +
> +	pr_err("kvm-pci-msi: %s wait timed out after %lu ms\n",
> +	       pci_name(pdev), timeout_ms);
> +	return -ETIMEDOUT;

[Severity: Medium]
Should kvm_pci_msi_wait_ready() in drivers/pci/controller/pci-kvm-msi.c
check for negative hypercall return values before sleeping and retrying?

In ____kvm_emulate_hypercall() in arch/x86/kvm/x86.c, KVM_HC_PCI_MSI_ALLOC
returns negative error codes on permanent failures, such as -KVM_ENOSYS when
the host kernel does not implement the hypercall or has no kvm-vfio device
(vcpu->kvm->pci_msi_alloc =3D=3D NULL), and -KVM_EINVAL when the PCI device=
 is not
found in kvm-vfio. It returns 0 with msg.address_lo =3D=3D 0 only when the =
VFIO
device exists on the host and is waiting for MSI enablement.

Because the polling loop only checks whether hret =3D=3D 0 && resp.address_=
lo !=3D 0
and ignores hret < 0, running a guest on an older KVM host or with a device
not backed by kvm-vfio will sleep for the full timeout_ms duration on every
device power-up or reset and log a timeout error.

> +
> +ready:
> +	pr_info("kvm-pci-msi: %s host addr=3D%08x:%08x data=3D%08x\n",
> +		pci_name(pdev), resp.address_hi, resp.address_lo,
> +		resp.data);
> +
> +	for (i =3D 0; i < kvm_msi_ctx.nr_irqs; i++) {
> +		irqd =3D irq_domain_get_irq_data(kvm_msi_ctx.domain,
> +						kvm_msi_ctx.first_virq + i);
> +		if (!irqd)
> +			continue;
> +		kvm_data =3D irqd->chip_data;
> +		if (!kvm_data)
> +			continue;
> +
> +		kvm_data->msg.address_lo =3D resp.address_lo;
> +		kvm_data->msg.address_hi =3D resp.address_hi;
> +		kvm_data->msg.data =3D resp.data + i;
> +		kvm_data->cached =3D true;
> +	}
> +
> +	desc =3D irq_get_msi_desc(pdev->irq);
> +	if (desc) {
> +		desc->msg.address_lo =3D resp.address_lo;
> +		desc->msg.address_hi =3D resp.address_hi;
> +		desc->msg.data =3D resp.data;
> +	}
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(kvm_pci_msi_wait_ready);

[ ... ]

> +static void kvm_compose_msi_msg(struct irq_data *data, struct msi_msg *m=
sg)
> +{
> +	struct kvm_msi_irq_data *kvm_data =3D data->chip_data;
> +
> +	if (kvm_data && kvm_data->cached) {
> +		*msg =3D kvm_data->msg;
> +		return;
> +	}
> +
> +	kvm_parent_compose_msi_msg(data, msg);
> +}

[Severity: High]
Won't overwriting desc->msg in kvm_pci_msi_wait_ready() and returning the
cached host physical MSI message from kvm_compose_msi_msg() in
drivers/pci/controller/pci-kvm-msi.c corrupt the guest's virtual PCI MSI
config space when MSI state is restored or recomposed?

In a KVM guest with VFIO passthrough, the PCI config space MSI capability
(PCI_MSI_ADDRESS_LO, PCI_MSI_ADDRESS_HI, PCI_MSI_DATA) is emulated by QEMU
VFIO. QEMU traps guest config writes from __pci_write_msi_msg(), decodes th=
em
as a guest virtual APIC MSI message (guest vCPU APIC ID and guest IDT vecto=
r),
and updates KVM's GSI routing table (KVM_SET_GSI_ROUTING). Only the device's
BAR MMIO registers programmed by firmware need the host's physical IOMMU IR=
TE
MSI address and data.

Because kvm_pci_msi_wait_ready() overwrites desc->msg with the host's physi=
cal
IRTE address/data and sets kvm_data->cached =3D true so kvm_compose_msi_msg=
()
returns kvm_data->msg, any subsequent PCI config space write by the guest M=
SI
core will write the host's physical IRTE message into QEMU's emulated PCI
config space:

1. On PCI reset or resume, __pci_restore_msi_state() calls
   __pci_write_msi_msg(entry, &entry->msg), writing the overwritten desc->m=
sg
   to PCI config space.

2. If an IRQ is freed and re-requested (msi_domain_activate()) or recomposed
   (msi_domain_set_affinity()), irq_chip_compose_msi_msg() calls
   kvm_compose_msi_msg(), which returns the cached host IRTE message to
   pci_msi_domain_write_msg() -> __pci_write_msi_msg().

On Intel VT-d interrupt remapping, the host IRTE data for subhandle 0 is 0,=
 so
QEMU interprets the config space write as a guest APIC MSI targeting guest
vector 0, corrupting KVM GSI routing and breaking interrupt delivery to the
guest.

> +
> +static struct irq_chip kvm_msi_irq_chip =3D {
> +	.name			=3D "KVM-MSI",
> +	.irq_compose_msi_msg	=3D kvm_compose_msi_msg,
> +	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
> +	.irq_ack		=3D irq_chip_ack_parent,
> +};
> +
> +static int kvm_pcie_domain_alloc(struct irq_domain *d, unsigned int virq,
> +				 unsigned int nr_irqs, void *arg)
> +{
> +	struct irq_alloc_info *info =3D arg;
> +	struct kvm_msi_irq_data *kvm_data;
> +	struct msi_desc *desc;
> +	struct pci_dev *pdev;
> +	u32 devid;
> +	int ret;
> +	int i;
> +
> +	ret =3D irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	desc =3D info->desc;
> +	if (!desc || !desc->dev || !dev_is_pci(desc->dev)) {
> +		ret =3D -EINVAL;
> +		goto err_free_parent;
> +	}
> +
> +	pdev =3D to_pci_dev(desc->dev);
> +	devid =3D ((u32)pdev->vendor << 16) | pdev->device;
> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		kvm_data =3D kzalloc_obj(*kvm_data);
> +		if (!kvm_data) {
> +			ret =3D -ENOMEM;
> +			goto err_free_data;
> +		}
> +
> +		kvm_data->devid =3D devid;
> +		kvm_data->vector =3D desc->msi_index + i;
> +
> +		irq_domain_set_info(d, virq + i, virq + i,
> +				    &kvm_msi_irq_chip, kvm_data,
> +				    handle_edge_irq, NULL, "KVM-MSI");
> +	}
> +
> +	kvm_msi_ctx.pdev =3D pdev;
> +	kvm_msi_ctx.devid =3D devid;
> +	kvm_msi_ctx.first_virq =3D virq;
> +	kvm_msi_ctx.nr_irqs =3D nr_irqs;
> +	kvm_msi_ctx.domain =3D d;

[Severity: High]
What happens in kvm_pcie_domain_alloc() in drivers/pci/controller/pci-kvm-m=
si.c
when more than one matching PCI device is present in the VM, or when a devi=
ce
allocates multiple MSI-X vectors?

1. kvm_pci_msi_init() and kvm_msi_bus_notify() attach kvm_msi_domain to all
   PCI devices matching kvm_msi_devids, but kvm_msi_ctx is a single global
   structure that kvm_pcie_domain_alloc() overwrites on every allocation. If
   a second matching device probes and allocates MSI vectors, it overwrites
   kvm_msi_ctx.pdev, causing subsequent calls to kvm_pci_msi_wait_ready() or
   runtime calls to kvm_pci_msi_get_address() for the first device to fail =
the
   kvm_msi_ctx.pdev !=3D pdev check and return 0.

2. kvm_pcie_msi_parent_ops sets MSI_FLAG_PCI_MSIX in supported_flags. For
   MSI-X, __msi_domain_alloc_irqs() calls __irq_domain_alloc_irqs() ->
   kvm_pcie_domain_alloc() once per MSI-X descriptor with nr_irqs =3D 1. Ea=
ch
   vector allocation overwrites kvm_msi_ctx.first_virq =3D virq and
   kvm_msi_ctx.nr_irqs =3D 1, losing all earlier vectors so
   kvm_pci_msi_wait_ready() only populates the last vector with vector 0's
   data (and irq_get_msi_desc(pdev->irq) returns NULL for MSI-X because
   pdev->irq is not set).

3. Conversely, for Multi-MSI, kvm_pcie_msi_parent_ops.supported_flags omits
   MSI_FLAG_MULTI_PCI_MSI, so msi_lib_init_dev_msi_info() masks out
   MSI_FLAG_MULTI_PCI_MSI from pci_msi_template even when the parent domain
   supports it.

> +
> +	return 0;
> +
> +err_free_data:
> +	for (i--; i >=3D 0; i--) {
> +		kvm_data =3D irq_data_get_irq_chip_data(
> +				irq_domain_get_irq_data(d, virq + i));
> +		kfree(kvm_data);
> +	}
> +err_free_parent:
> +	irq_domain_free_irqs_parent(d, virq, nr_irqs);
> +	return ret;
> +}
> +
> +static void kvm_pcie_domain_free(struct irq_domain *d, unsigned int virq,
> +				 unsigned int nr_irqs)
> +{
> +	struct kvm_msi_irq_data *kvm_data;
> +	int i;
> +
> +	if (kvm_msi_ctx.first_virq =3D=3D virq) {
> +		kvm_msi_ctx.pdev =3D NULL;
> +		kvm_msi_ctx.nr_irqs =3D 0;
> +	}
> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		kvm_data =3D irq_data_get_irq_chip_data(
> +				irq_domain_get_irq_data(d, virq + i));
> +		kfree(kvm_data);
> +	}
> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
> +}

[Severity: High]
Can kvm_pci_msi_wait_ready() or kvm_pci_msi_get_address() race with
kvm_pcie_domain_free() in drivers/pci/controller/pci-kvm-msi.c and trigger a
use-after-free on kvm_data?

kvm_pcie_domain_alloc() and kvm_pcie_domain_free() run under
domain->root->mutex, whereas kvm_pci_msi_wait_ready() and
kvm_pci_msi_get_address() read kvm_msi_ctx, call irq_domain_get_irq_data(),
and dereference irqd->chip_data (kvm_data) without holding any lock.

In kvm_pci_msi_wait_ready(), kvm_msi_ctx.pdev !=3D pdev is checked only onc=
e at
entry before the loop calls msleep(KVM_MSI_POLL_INTERVAL_MS). Meanwhile,
kvm_pcie_domain_free() calls kfree(kvm_data) before irq_domain_free_irqs_to=
p()
clears irq_data->chip_data and unmaps the virq. If a device's IRQs are freed
(or another device probes or unwinds) while kvm_pci_msi_wait_ready() is
sleeping or while kvm_pci_msi_get_address() is running, they can read or wr=
ite
freed kvm_data memory.

> +
> +static const struct irq_domain_ops kvm_pcie_domain_ops =3D {
> +	.alloc	=3D kvm_pcie_domain_alloc,
> +	.free	=3D kvm_pcie_domain_free,
> +};
> +
> +static bool kvm_pcie_init_dev_msi_info(struct device *dev,
> +				       struct irq_domain *domain,
> +				       struct irq_domain *real_parent,
> +				       struct msi_domain_info *info)
> +{
> +	struct irq_chip *chip =3D info->chip;
> +
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info)) {
> +		pr_err("kvm-pci-msi: msi_lib_init_dev_msi_info failed for %s\n",
> +		       dev_name(dev));
> +		return false;
> +	}
> +
> +	info->ops->msi_prepare =3D pci_msi_prepare;
> +
> +	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
> +	chip->irq_retrigger =3D irq_chip_retrigger_hierarchy;
> +	chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
> +
> +	return true;
> +}

[Severity: High]
Does overwriting chip->irq_set_affinity with irq_chip_set_affinity_parent in
kvm_pcie_init_dev_msi_info() in drivers/pci/controller/pci-kvm-msi.c break
guest MSI interrupt delivery whenever IRQ affinity is set or changed?

In msi_lib_init_dev_msi_info() in drivers/irqchip/irq-msi-lib.c, the
per-device MSI irq_chip's irq_set_affinity callback is initialized to
msi_domain_set_affinity():

	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
		chip->irq_set_affinity =3D msi_domain_set_affinity;

msi_domain_set_affinity() calls parent->chip->irq_set_affinity() and then
calls irq_chip_compose_msi_msg() and irq_chip_write_msi_msg()
(pci_msi_domain_write_msg() -> __pci_write_msi_msg()) so that the updated
guest virtual APIC target CPU and vector are written to PCI config space and
trapped by QEMU VFIO to update KVM's GSI routing.

By overwriting chip->irq_set_affinity on the per-device MSI chip with
irq_chip_set_affinity_parent (while kvm_msi_irq_chip also uses
irq_chip_set_affinity_parent), any affinity change (such as
ath11k_pci_set_irq_affinity_hint() -> irq_set_affinity_and_hint() during pr=
obe
or irqbalance in userspace) delegates directly to x86_vector_domain's
apic_set_affinity(). That allocates a new guest vector/CPU and returns
IRQ_SET_MASK_OK without ever composing or writing the new MSI message to PCI
config space, leaving msi_desc->msg and QEMU/KVM GSI routing pointing to the
old guest vector.

[ ... ]

> +static void kvm_msi_attach_device(struct pci_dev *pdev)
> +{
> +	if (pdev->driver) {
> +		dev_warn(&pdev->dev,
> +			 "kvm-pci-msi: driver already bound (%s), unbind/rebind needed\n",
> +			 pdev->driver->name);
> +		return;
> +	}
> +
> +	dev_info(&pdev->dev,
> +		 "kvm-pci-msi: attaching KVM MSI domain [%04x:%04x]\n",
> +		 pdev->vendor, pdev->device);
> +	dev_set_msi_domain(&pdev->dev, kvm_msi_domain);
> +}

[Severity: Medium]
Can kvm_msi_attach_device() in drivers/pci/controller/pci-kvm-msi.c race wi=
th
concurrent driver probe or unbind when called from kvm_pci_msi_init() witho=
ut
holding device_lock(&pdev->dev)?

In drivers/pci/pci-driver.c, local_pci_probe() and pci_device_remove() set =
and
clear pdev->driver under device_lock(&pdev->dev). When kvm_pci_msi_init()
iterates over existing PCI devices with for_each_pci_dev(pdev) and calls
kvm_msi_attach_device(pdev) without holding device_lock(&pdev->dev), a
concurrent unbind or failed probe can clear pdev->driver between the
if (pdev->driver) check and the pdev->driver->name dereference, or a
concurrent probe can race with dev_set_msi_domain(&pdev->dev, kvm_msi_domai=
n)
while setting up MSI vectors.

[ ... ]

> +static int __init kvm_pci_msi_init(void)
> +{
> +	struct pci_dev *pdev =3D NULL;
> +	struct pci_dev *first =3D NULL;
> +	int ret;
> +
> +	if (!kvm_para_available())
> +		return -ENODEV;
> +
> +	for_each_pci_dev(pdev) {
> +		if (pci_match_id(kvm_msi_devids, pdev)) {
> +			first =3D pdev;
> +			break;
> +		}
> +	}
> +
> +	if (!first) {
> +		pr_info("kvm-pci-msi: no matching devices found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D kvm_msi_create_domain(first);
> +	pci_dev_put(first);
> +	if (ret)
> +		return ret;
> +
> +	pdev =3D NULL;
> +	for_each_pci_dev(pdev) {
> +		if (pci_match_id(kvm_msi_devids, pdev))
> +			kvm_msi_attach_device(pdev);
> +	}
> +
> +	bus_register_notifier(&pci_bus_type, &kvm_msi_nb);
> +
> +	pr_info("kvm-pci-msi: ready, domain created for %zu device types\n",
> +		ARRAY_SIZE(kvm_msi_devids) - 1);
> +	return 0;
> +}

[Severity: High]
Won't returning -ENODEV from kvm_pci_msi_init() in
drivers/pci/controller/pci-kvm-msi.c prevent dependent wireless drivers from
loading and break PCI hotplug?

1. When CONFIG_PCI_KVM_MSI_DOMAIN=3Dm, consumer modules (such as ath11k_pci=
.ko
   and ath12k.ko) reference the exported symbols kvm_pci_msi_wait_ready() a=
nd
   kvm_pci_msi_get_address(). When modprobe loads pci-kvm-msi.ko on baremet=
al
   (!kvm_para_available()) or when no device in kvm_msi_devids is currently
   present (!first, for example with other ath11k/ath12k PCI IDs or before
   hotplug), kvm_pci_msi_init() returns -ENODEV. That causes pci-kvm-msi.ko
   to fail to load, which in turn prevents ath11k_pci.ko and ath12k.ko from
   loading due to unresolved symbols.

2. Because bus_register_notifier(&pci_bus_type, &kvm_msi_nb) is only reached
   if a matching PCI device already exists when kvm_pci_msi_init() runs,
   hotplugging a matching VFIO PCI device later will never attach
   kvm_msi_domain.

3. In kvm_msi_attach_device(), if pdev->driver is already bound at init tim=
e,
   it warns that unbind/rebind is needed and skips dev_set_msi_domain().
   However, kvm_msi_bus_notify() only acts on BUS_NOTIFY_ADD_DEVICE (which
   fires on device_add(), not on driver unbind/rebind), so unbinding and
   rebinding the driver never attaches kvm_msi_domain.

> +
> +static void __exit kvm_pci_msi_exit(void)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	bus_unregister_notifier(&pci_bus_type, &kvm_msi_nb);
> +
> +	if (kvm_msi_domain) {
> +		fwnode =3D kvm_msi_domain->fwnode;
> +		irq_domain_remove(kvm_msi_domain);
> +		irq_domain_free_fwnode(fwnode);
> +		kvm_msi_domain =3D NULL;
> +	}
> +}

[Severity: High]
Doesn't kvm_pci_msi_exit() in drivers/pci/controller/pci-kvm-msi.c leave
dangling pointers to the freed kvm_msi_domain on attached PCI devices when =
the
module is unloaded?

During kvm_pci_msi_init() and kvm_msi_bus_notify(), kvm_msi_attach_device()
overwrites pdev->dev.msi.domain with kvm_msi_domain via dev_set_msi_domain()
without saving the original parent MSI domain. In addition, when a driver
allocates MSI vectors via pci_alloc_irq_vectors() ->
pci_setup_msi_device_domain() -> msi_create_device_irq_domain(), a per-devi=
ce
child irq_domain is created in pdev->dev.msi.data->__domains with
domain->parent pointing to kvm_msi_domain, and that child domain persists
across pci_free_irq_vectors() and driver unbind until the pci_dev is remove=
d.

When kvm_pci_msi_exit() runs on module unload, it calls
irq_domain_remove(kvm_msi_domain) (which frees kvm_msi_domain) without
removing per-device child MSI domains or restoring pdev->dev.msi.domain on
attached PCI devices:

1. Any subsequent driver probe, MSI allocation (msi_create_device_irq_domai=
n()
   dereferencing parent =3D dev->msi.domain and
   parent->msi_parent_ops->init_dev_msi_info), or PCI device removal will
   dereference the freed kvm_msi_domain and unmapped module callbacks.

2. Reloading pci-kvm-msi after rmmod causes kvm_msi_create_domain() to call
   dev_get_msi_domain(&ref_dev->dev), which returns the freed kvm_msi_domain
   from the previous load and passes it as info.parent to
   msi_create_parent_irq_domain().

> diff --git a/include/linux/pci-kvm-msi.h b/include/linux/pci-kvm-msi.h
> new file mode 100644
> index 0000000000000..cc615e913a3bf
> --- /dev/null
> +++ b/include/linux/pci-kvm-msi.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* SPDX-FileCopyrightText: Copyright Red Hat */
> +
> +#ifndef _LINUX_PCI_KVM_MSI_H
> +#define _LINUX_PCI_KVM_MSI_H
> +
> +#include <linux/pci.h>
> +
> +int kvm_pci_msi_wait_ready(struct pci_dev *pdev, unsigned long timeout_m=
s);
> +int kvm_pci_msi_get_address(struct pci_dev *pdev, u32 *addr_lo, u32 *add=
r_hi,
> +			     u32 *data);
> +
> +#endif /* _LINUX_PCI_KVM_MSI_H */

[Severity: Medium]
Should include/linux/pci-kvm-msi.h provide static inline fallback stubs
guarded by IS_REACHABLE(CONFIG_PCI_KVM_MSI_DOMAIN)?

Because PCI_KVM_MSI_DOMAIN is a tristate Kconfig option, a built-in consumer
driver (=3Dy) calling kvm_pci_msi_wait_ready() or kvm_pci_msi_get_address()
under IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN) when CONFIG_PCI_KVM_MSI_DOMAIN=
=3Dm
(or an unguarded caller when CONFIG_PCI_KVM_MSI_DOMAIN=3Dn) will fail to li=
nk
vmlinux with undefined references to kvm_pci_msi_wait_ready() and
kvm_pci_msi_get_address().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D3
