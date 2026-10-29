Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293144;
	b=jaLNmzVNwiFHtP3EBgctuhmMwVbsiLn3JfuK4wBQ06/Hh31zNlumUNE7GB2tGf8e/gHy
	 2OpDLMv74bDsrGBKpW0D9mgu5GuyQI89HZ8XRNtOd+hT2yHyOzlQ40eJjw38PgNiQiBWq
	 HQ5w1Zdq2ixQ2vh+iyLMSaGmtNUHJXEEe4tTBxry38AHNSa1nvFWEk98TWfmASILwOXbC
	 EeURIfInQMs/QwgQF/Yqm5f1b6H2L7FRioe2B/gels50KLyt0Qsq/NSIxxEMLUyFfgNJY
	 Z7RdQxYbZOuP/aKYbpM+Vb5JTRpkGPq0xnPB9kPn7FfLqdaDC88LK4e9mmDjOJ3SsRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AxqVU3KZlDY7Od+7CkcPxepWZ35319DU/3cQEepQ+uk=;
	b=kvUE2VrL35LRatWgk1yLUTDEg2/H++ECcjgNvJvYseN3Op7gQbMO70CZWx2gmcICPFcw
	 9KiNQxjmukgbb7B2uP+K3fVcXeAAyHW2hFN7fku6Ut/4KFYH179uukT7jBN9apgEPg4Be
	 FMVgim9yKYUop21u9h6pnlVOFrSFg3c+YCA4MTokZDHf8FQuBbEzjnw83dCq+HPSvc9Tq
	 KgmvymM7DuoevXTj7CptfUMSCtI+kkxsfB06gUtq1tg6LcaOxkSQGb8VkeK6eLQiTiOpO
	 RTNQPoe6zTC5cjXzgG+DNBq2WFeN7mJdQ9DLFvXOTvta8ckOPzRAk32HeLGjt9FHVNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkg+L4eQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EEF606A31A;
	Thu, 29 Oct 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkg+L4eQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E297E1F01816;
	Thu, 29 Oct 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293143;
	bh=AxqVU3KZlDY7Od+7CkcPxepWZ35319DU/3cQEepQ+uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkg+L4eQSY2GFyf4EqBkC3/65xjEY0HzxMpx5vbiHFsH1Wzoxdc/Xs72aW+FYnoKH
	 17GNNxbMZk0Oit9x+/sAOYjxb/C4oUfLBOZzC7yMuQTLaID9bf1QB9XoklWcfkDL4I
	 sbqez19ZKmBoY/U2Hs0SNGSQam0alfQInGsYiVg24Da4ei3R1mplT6tl/9RVNtOpU6
	 UjjuHW3OHwXyK54W08O0Cv+g6C9b7Dzg91Wf0VvLShUuw8VROGGzx98ObEgYrUGQS5
	 eIZJyu5qlPf7reHO8mNiTM5t1yOww3qYXecaZn0I9tIwW5rCuiLbPyHpHiGE42I5Pe
	 Bea35qoo6W/pg==
Message-ID: <sashiko-outbox-189700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] KVM: add PCI MSI hypercall for VFIO passthrough
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261029163713.1366077-3-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:59:02 +0000
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
- [Critical] kvm: vfio: use-after-free on struct kvm_vfio and race on pci_m=
si_alloc
- [Critical] kvm: vfio: use-after-free on vfio_device, msi_desc, and irq_da=
ta
- [High] kvm: deadlock acquiring kvm->lock in kvm_vfio_pci_msi_alloc()
- [High] kvm: vfio: guest-triggerable WARN_ON_ONCE via unvalidated MSI vect=
or
- [High] kvm: vfio: broken Multi-MSI message lookup in kvm_vfio_pci_msi_all=
oc()
- [High] kvm: vfio: ambiguous and unisolated device lookup in kvm_vfio_pci_=
msi_alloc()
- [Medium] kvm: vfio: link failure calling vfio_file_find_pci_device() dire=
ctly
- [Medium] kvm: x86: KVM_HC_PCI_MSI_ALLOC lacks feature enumeration and opt=
-in
- [Low] kvm: vfio: build failure accessing irq_data.parent_data directly
--

commit dc68213ab54a0729231a44c10317169580ab3c78
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

KVM: add PCI MSI hypercall for VFIO passthrough

This commit introduces a new x86 hypercall, KVM_HC_PCI_MSI_ALLOC, to allow a
guest to query the host physical MSI address and data for a VFIO passthrough
PCI device. It connects arch/x86/kvm/x86.c to a new kvm_vfio_pci_msi_alloc()
helper in virt/kvm/vfio.c via a pci_msi_alloc callback on struct kvm.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32563a91fba99..2f0cae07f9786 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -7490,6 +7491,44 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcp=
u, int cpl,
>  		vcpu->arch.complete_userspace_io =3D complete_hypercall;
>  		return 0;
>  	}
> +	case KVM_HC_PCI_MSI_ALLOC: {
> +		struct msi_msg msg =3D {};
> +		struct {
> +			u32 address_lo;
> +			u32 address_hi;
> +			u32 data;
> +			u32 reserved;
> +		} resp;
> +
> +		if (vcpu->kvm->pci_msi_alloc =3D=3D NULL) {
> +			ret =3D -KVM_ENOSYS;
> +			break;
> +		}

[Severity: Medium]
Should KVM_HC_PCI_MSI_ALLOC be gated behind a paravirtual CPUID feature bit
checked via guest_pv_has() or an explicit userspace capability opt-in?

In ____kvm_emulate_hypercall() in arch/x86/kvm/x86.c, other KVM hypercalls
such as KVM_HC_KICK_CPU, KVM_HC_SEND_IPI, and KVM_HC_SCHED_YIELD check
guest_pv_has(vcpu, KVM_FEATURE_*), and KVM_HC_MAP_GPA_RANGE checks
user_exit_on_hypercall(). Here, kvm_vfio_create() unconditionally sets
dev->kvm->pci_msi_alloc =3D kvm_vfio_pci_msi_alloc whenever a kvm-vfio devi=
ce
is created, making this hypercall and the host physical MSI routing
information available to any guest by default without enumeration or
userspace opt-in.

Also, since the guest memory layout of resp is part of the guest-host ABI,
should that structure be defined in include/uapi/linux/kvm_para.h rather th=
an
as an anonymous local struct in ____kvm_emulate_hypercall(), and should
64-bit hypercall arguments a0 and a1 be validated for upper-bit truncation
before being passed as u32 and unsigned int?

> +
> +		/*
> +		 * a0 =3D PCI vendor:device (vendor << 16 | device)
> +		 * a1 =3D MSI vector index
> +		 * a2 =3D GPA of response buffer
> +		 */
> +		ret =3D vcpu->kvm->pci_msi_alloc(vcpu->kvm, a0, a1, &msg);
[ ... ]
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 19548a4309426..60356173e69f3 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
[ ... ]
> @@ -315,6 +318,8 @@ static void kvm_vfio_release(struct kvm_device *dev)
> =20
>  	kvm_vfio_update_coherency(dev);
> =20
> +	dev->kvm->pci_msi_alloc =3D NULL;
> +
>  	kfree(kv);
>  	kfree(dev); /* alloc by kvm_ioctl_create_device, free by .release */
>  }
> @@ -349,6 +354,98 @@ static int kvm_vfio_create(struct kvm_device *dev, u=
32 type)
>  	mutex_init(&kv->lock);
> =20
>  	dev->private =3D kv;
> +	dev->kvm->pci_msi_alloc =3D kvm_vfio_pci_msi_alloc;
> +
> +	return 0;
> +}
> +
> +/**
> + * kvm_vfio_pci_msi_alloc - Get physical MSI address/data for a VFIO dev=
ice
> + * @kvm: the VM instance
> + * @devid: PCI vendor:device packed as (vendor << 16 | device)
> + * @vector: MSI vector index
> + * @msg: output MSI message (address + data)
> + *
> + * Walks VFIO files attached to this VM, uses vfio_file_find_pci_device()
> + * to find the PCI device matching the given vendor:device ID, and retur=
ns
> + * the host's physical MSI address/data for the requested vector.
> + *
> + * Returns 0 on success, negative errno on failure.
> + */
> +int kvm_vfio_pci_msi_alloc(struct kvm *kvm, u32 devid,
> +			     unsigned int vector, struct msi_msg *msg)
> +{
> +	struct kvm_vfio_file *kvf;
> +	struct kvm_vfio *kv =3D NULL;
> +	struct vfio_device *vdev;
> +	struct kvm_device *dev;
> +	struct msi_desc *desc;
> +	struct irq_data *irqd;
> +	struct pci_dev *pdev;
> +	u16 vendor =3D devid >> 16;
> +	u16 device =3D devid & 0xffff;
> +	int irq;
> +
> +	scoped_guard(mutex, &kvm->lock) {
> +		list_for_each_entry(dev, &kvm->devices, vm_node) {
> +			if (dev->ops =3D=3D &kvm_vfio_ops) {
> +				kv =3D dev->private;
> +				break;
> +			}
> +		}
> +	}

[Severity: High]
Can acquiring kvm->lock here in kvm_vfio_pci_msi_alloc() cause a deadlock?

When a guest invokes KVM_HC_PCI_MSI_ALLOC, the call chain is:

  kvm_vcpu_ioctl() [holds vcpu->mutex]
    -> kvm_arch_vcpu_ioctl_run()
      -> vcpu_enter_guest() [holds kvm->srcu via kvm_vcpu_srcu_read_lock()]
        -> handle_exit()
          -> kvm_emulate_hypercall()
            -> ____kvm_emulate_hypercall()
              -> kvm_vfio_pci_msi_alloc()
                -> mutex_lock(&kvm->lock)

According to Documentation/virt/kvm/locking.rst, kvm->lock must be acquired
outside vcpu->mutex (for example, kvm_lock_all_vcpus() and
kvm_vm_ioctl_create_vcpu() in virt/kvm/kvm_main.c take kvm->lock and then
vcpu->mutex). In addition, synchronize_srcu(&kvm->srcu) is called while
holding kvm->lock or vcpu->mutex.

Doesn't taking kvm->lock while holding both vcpu->mutex and the kvm->srcu
read lock introduce an ABBA lock inversion and an SRCU deadlock?

> +
> +	if (!kv)
> +		return -ENODEV;
> +
> +	guard(mutex)(&kv->lock);

[Severity: Critical]
What prevents struct kvm_vfio (kv) and its kv->file_list entries from being
freed before or during kvm_vfio_pci_msi_alloc()?

In kvm_vfio_pci_msi_alloc(), kvm->lock is released at the end of the
scoped_guard block without pinning dev or kv. If userspace closes the
kvm-vfio device fd concurrently:

  kvm_device_release()
    -> mutex_lock(&kvm->lock)
    -> list_del(&dev->vm_node)
    -> mutex_unlock(&kvm->lock)
    -> synchronize_rcu()
    -> kvm_vfio_release(dev)
      -> list_for_each_entry_safe(kvf, tmp, &kv->file_list, node)
           kvm_vfio_file_free(dev, kvf);
      -> dev->kvm->pci_msi_alloc =3D NULL;
      -> kfree(kv);

Because synchronize_rcu() does not wait for preemptible vCPU threads in
____kvm_emulate_hypercall(), and kvm_vfio_release() frees kv->file_list
without taking kv->lock and then frees kv, can kvm_vfio_pci_msi_alloc()
access freed memory when locking kv->lock or iterating kv->file_list?

Similarly, in ____kvm_emulate_hypercall():

	if (vcpu->kvm->pci_msi_alloc =3D=3D NULL) {
		ret =3D -KVM_ENOSYS;
		break;
	}
	ret =3D vcpu->kvm->pci_msi_alloc(vcpu->kvm, a0, a1, &msg);

could kvm_vfio_release() set dev->kvm->pci_msi_alloc =3D NULL between the N=
ULL
check and the indirect call, resulting in a NULL function pointer call?

> +
> +	vdev =3D NULL;
> +	list_for_each_entry(kvf, &kv->file_list, node) {
> +		vdev =3D vfio_file_find_pci_device(kvf->file, vendor, device);
> +		if (vdev)
> +			break;
> +	}

[Severity: Medium]
Will calling vfio_file_find_pci_device() directly break the build when
CONFIG_KVM=3Dy and CONFIG_VFIO=3Dm (with CONFIG_VFIO_GROUP=3Dy)?

In virt/kvm/vfio.c, all other VFIO helpers (such as vfio_file_set_kvm and
vfio_file_enforced_coherent) are looked up dynamically via symbol_get() and
symbol_put() so that built-in KVM does not have a link-time dependency on
vfio.ko. Calling vfio_file_find_pci_device() directly from virt/kvm/vfio.c
causes an undefined symbol reference at link time when KVM is built-in and
VFIO is a module.

Also, in include/linux/vfio.h, vfio_file_find_pci_device() is guarded by
#if IS_ENABLED(CONFIG_VFIO_GROUP). When CONFIG_VFIO_DEVICE_CDEV=3Dy and
CONFIG_VFIO_GROUP=3Dn, vfio_file_find_pci_device() compiles to the inline s=
tub
returning NULL, causing kvm_vfio_pci_msi_alloc() to always return -ENODEV on
cdev-only builds.

[Severity: High]
Is matching solely by 16-bit vendor and device ID sufficient when looking up
the VFIO device in kvm_vfio_pci_msi_alloc()?

If a VM has two passthrough PCI devices with the same vendor:device ID, this
loop always stops at the first device in kv->file_list and returns its MSI
message for both devices, which will trigger IOMMU source-ID validation
faults on the second device.

In addition, when kvf->file is a VFIO group fd, vfio_file_find_pci_device()
walks group->device_list and matches any PCI device in the host IOMMU group
without checking whether that device is opened or assigned to this VM. Can a
guest use this hypercall to read the host physical MSI address and data of
unassigned sibling PCI devices in the same IOMMU group?

> +
> +	if (!vdev)
> +		return -ENODEV;
> +
> +	pdev =3D to_pci_dev(vdev->dev);
> +
> +	if (!pdev->msi_enabled && !pdev->msix_enabled) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	irq =3D pci_irq_vector(pdev, vector);

[Severity: High]
Can a guest trigger a host WARN_ON_ONCE in msi_domain_get_virq() by passing
a vector index greater than MSI_MAX_INDEX (0xffff)?

In ____kvm_emulate_hypercall(), the guest-controlled register a1 is passed
directly as vector to kvm_vfio_pci_msi_alloc(), which passes it unvalidated
to pci_irq_vector(pdev, vector) -> msi_get_virq() -> msi_domain_get_virq():

kernel/irq/msi.c:msi_domain_get_virq() {
	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >=3D MSI_MAX_DEVICE_IRQDOM=
AINS))
		return 0;
}

Should vector be bounds-checked before calling pci_irq_vector()?

> +	if (irq <=3D 0) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	irqd =3D irq_get_irq_data(irq);
> +	if (!irqd) {
> +		memset(msg, 0, sizeof(*msg));
> +		return 0;
> +	}
> +
> +	desc =3D irq_get_msi_desc(irq);
> +	if (desc) {
> +		*msg =3D desc->msg;

[Severity: Critical]
What protects vdev, pdev, irqd, and desc from concurrent teardown while
kvm_vfio_pci_msi_alloc() accesses them?

First, for a VFIO group file, vfio_file_find_pci_device() drops
group->device_lock before returning vdev without acquiring a reference on
vdev. Holding the group file in kv->file_list does not prevent an individual
vfio_device in group->device_list from being unregistered via
vfio_unregister_group_dev(), so vdev and pdev can be freed while
kvm_vfio_pci_msi_alloc() dereferences them.

Second, pci_irq_vector() only holds msi_descs_lock(&pdev->dev) internally
while looking up the Linux IRQ number. Once it returns irq,
kvm_vfio_pci_msi_alloc() calls irq_get_irq_data(irq), irq_get_msi_desc(irq),
and reads desc->msg (or walks irqd->parent_data) without holding
msi_descs_lock(&pdev->dev), vdev->igate, or the IRQ descriptor lock. If host
userspace concurrently reconfigures or disables MSI/MSI-X via
VFIO_DEVICE_SET_IRQS -> vfio_msi_disable() -> pci_free_irq_vectors(), can
both the irq_desc and struct msi_desc be freed while kvm_vfio_pci_msi_alloc=
()
is dereferencing desc or irqd?

[Severity: High]
Does reading desc->msg return the wrong MSI message for Multi-MSI vectors
where vector > 0?

For PCI Multi-MSI, __msi_domain_alloc_irqs() in kernel/irq/msi.c attaches t=
he
same shared struct msi_desc to all allocated Linux IRQs in the Multi-MSI
group:

	for (i =3D 0; i < desc->nvec_used; i++) {
		irq_set_msi_desc_off(virq, i, desc);
		...
	}

And pci_msi_domain_write_msg() in drivers/pci/msi/irqdomain.c only caches
desc->msg for the first vector:

	if (desc->irq =3D=3D irq_data->irq)
		__pci_write_msi_msg(desc, msg);

Because irq_get_msi_desc(irq) is non-NULL for every MSI/MSI-X vector, the
if (desc) branch is always taken (making the else branch unreachable dead
code), and any Multi-MSI request with vector > 0 receives vector 0's cached
desc->msg instead of the composed message for that vector. Should this use
irq_chip_compose_msi_msg() or adjust the message for Multi-MSI vectors?

> +	} else {
> +		struct irq_data *pos;
> +
> +		for (pos =3D irqd; pos; pos =3D pos->parent_data) {
> +			if (pos->chip && pos->chip->irq_compose_msi_msg) {
> +				pos->chip->irq_compose_msi_msg(pos, msg);
> +				break;
> +			}
> +		}

[Severity: Low]
Can accessing pos->parent_data directly fail to compile when
CONFIG_IRQ_DOMAIN_HIERARCHY is disabled?

In include/linux/irq.h, struct irq_data only defines parent_data under
#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY:

struct irq_data {
	...
#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
	struct irq_data		*parent_data;
#endif
	void			*chip_data;
};

On architectures that select CONFIG_KVM_VFIO without unconditionally
selecting CONFIG_IRQ_DOMAIN_HIERARCHY (such as s390 or powerpc configs
without CONFIG_PCI_MSI), referencing pos->parent_data directly in
virt/kvm/vfio.c will break the build unless irq_chip_compose_msi_msg() or a
config guard is used.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D2
