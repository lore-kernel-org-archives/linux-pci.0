Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312733F8C5;
	Tue, 27 Jan 2026 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509828; cv=none; b=Ab64rZqdGHL9nT0s6LuXQFzAY6eNHqbC7VprumDjE2rcFZavY4hciH7qu0V7zXtc05gccDerdX8oCePVrypP0Dx1VasXNXZ05AkFmOwxU1QyOmRyIRVHEk0npIZpBNDZynD0IqXB2ScX8RuAIVXpcU35QHHNB/EuCPlROuoPkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509828; c=relaxed/simple;
	bh=pe4cHHVWeu3WRBqDfGNX5Ssdo8XICk4NB162PNWOgaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P9YsgYbih1l+YyJiT5vDyxKkFG+gW5/EBPBxbLiwP+O4C5niJYrmtaHvRcpIiOpYNE6APE6YVzou6EeCHha4r8tiIQiNgxyfF9BbfLKjXbUMRlj5Fg4lruIN1iLchhjn/ZOBBowMIlvLdbqLXRJUTZakMDHXe2UKegZnM5a6sew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biZJ+QPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biZJ+QPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D7C116C6;
	Tue, 27 Jan 2026 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769509827;
	bh=pe4cHHVWeu3WRBqDfGNX5Ssdo8XICk4NB162PNWOgaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=biZJ+QPBygYJ1fo1uyD8cuVYpXMogC1D2Ld/ZFMGGb1Ij78MqASLs6tLcNCzKLOI3
	 qQcKQYPQd75Px4JEPnzq3NQNR3yYKXGxG9XQ8o85dJbVo7LLbSBdK/Ivc8vo5fpEkZ
	 C1u39rrfFCl+qQhg06Ow+jSoLySFJCaKV9mmfAc23LGeKjDwCbiJtWsTkgb6Tyadnx
	 jPslLseiUk2sjQajv1exwhWNIMm//8zx+7FJSNf9RMviGPYSnItCrAKsjsryppgcuM
	 6qb9o5GIJSsZqdYCz9jeVrJy8zXzH8IrwUatE3GJ7BryRMrnPWEFyt36yRiwOTuMe1
	 t4eRVGNoj4I+w==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <rrendec@redhat.com>, Jon Hunter <jonathanh@nvidia.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Brian
 Masney <bmasney@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
In-Reply-To: <221f6dadb6d8ce06f30a24baaa2777e90d75b130.camel@redhat.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
 <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
 <87sebsdcte.ffs@tglx> <255713ca-bf91-4f7e-8df2-33b7b614a1bb@nvidia.com>
 <221f6dadb6d8ce06f30a24baaa2777e90d75b130.camel@redhat.com>
Date: Tue, 27 Jan 2026 11:30:23 +0100
Message-ID: <87h5s7bb5s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26 2026 at 17:26, Radu Rendec wrote:
> On Mon, 2026-01-26 at 22:07 +0000, Jon Hunter wrote:
>> > Jon, can you please validate that this happens as well on
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git://git.kernel.org/pub/scm/linux/kern=
el/git/tip/tip.git irq/msi
>>=20
>>=20
>> I tried this branch and I see suspend failing with that branch too. If I=
=20
>> revert this change on top of your branch or -next, I don't see any=20
>> problems.
>
> The closest hardware I have access to is Jetson Xavier NX, and you
> already mentioned you couldn't reproduce the issue there (and it looks
> like I can't even get a hold of that board anyway). So I'm going to ask
> you to test a few more things for me.
>
> Can you please apply the patch below on top of the previous one I sent?
> The suspect is the spinlock lock in irq_migrate_all_off_this_cpu(),
> although I can't think of any reason why it shouldn't be free. But I
> don't have any better idea, and I would like to narrow down the spot
> where hotplug gets stuck.

Can we please take a step back and think about what is actually
different when this change is in effect instead of halluzinating about
completely unrelated spinlocks?

Without this change the interrupt is ignored in the hotplug migration
because it has MSI_FLAG_NO_AFFINITY set.

Now with this new magic in place the following happens:

migrate_one_irq()
   ...
   irq_do_set_affinity()
      chip->irq_set_affinity()                // --> msi_domain_set_affinit=
y()
         parent->chip->irq_set_affinity()     // --> irq_chip_redirect_set_=
affinity()
            update target_cpu/effective mask; // Benign
         ...
         irq_chip_write_msi_msg()             // --> pci_msi_domain_write_m=
sg()
=20=20
I'm pretty sure that this write screws things up because the
devices/busses are already frozen. It simply hangs there.

Usually this is prevented by this check in pci_msi_domain_write_msg():

        if (dev->current_state !=3D PCI_D0 || pci_dev_is_disconnected(dev))
        	do_nothing();
        else ...

As the boot log contains this:

[   44.101151] tegra194-pcie 14100000.pcie: Link didn't transition to L2 st=
ate
[   44.110764] Disabling non-boot CPUs ...

... I suspect that there is some weirdness going on with this PCIe
controller which subsequently screws up the check.

The below untested hack should confirm that theory.

Thanks,

        tglx
---
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -672,7 +672,11 @@ int msi_domain_set_affinity(struct irq_d
 	if (ret >=3D 0 && ret !=3D IRQ_SET_MASK_OK_DONE) {
 		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
 		msi_check_level(irq_data->domain, msg);
-		irq_chip_write_msi_msg(irq_data, msg);
+		// Hack alert
+		struct irq_desc *desc =3D irq_data_to_desc(irq_data);
+
+		if (!(desc->istate & IRQS_SUSPENDED))
+			irq_chip_write_msi_msg(irq_data, msg);
 	}
=20
 	return ret;
