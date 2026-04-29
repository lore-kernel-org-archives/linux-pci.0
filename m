Received: from mail.m10.be (mail.m10.be [172.233.33.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F63B47FF;
	Wed, 29 Apr 2026 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.33.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453129; cv=none; b=ZGiDewQ2amNX93PkQf8HF+5CevlQxMjgbUX63E0NTPVQoi1MR69AhvIKYFA7ZAe2tlzYopgik4d4ArsZr2sibIpGP4jNkOG0GF9/TXlsCNiGBpQWNAGGnHjc7poagHciG1oijGegIJGVfAa15B3xK2sSpn9FaScm15Fyc1nSy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453129; c=relaxed/simple;
	bh=C+h8HgEnNSuCzU3ag2uQxz1V8h02BaXX+aAt2iE5qoI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hs+8PDSv4mq5eapBGR9zKTb7DOXEjitl/g8Mh5qI2wAZh0Cz8hmWoh4fkFJoFNs2RMmCsglHhMsCThv8pQCVKS2cFfKRCweiBpk8y8xEX2N9mZXbGe8ZyjixlI0Rvi2qimnMCYBXiKL87EKr3Bl5nBv3sGlOtriZqsl0LxmKjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maxboone.com; spf=fail smtp.mailfrom=maxboone.com; dkim=temperror (0-bit key) header.d=maxboone.com header.i=@maxboone.com header.b=V5xsm5ho; arc=none smtp.client-ip=172.233.33.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maxboone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=maxboone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=maxboone.com header.i=@maxboone.com header.b="V5xsm5ho"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FADB46877;
	Wed, 29 Apr 2026 10:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxboone.com;
	s=dkim; t=1777453124;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qpvwgnlTAQ8g9wVEsK04P0MJezG6PFyvMb+dfNOSRyw=;
	b=V5xsm5ho/M3/dePidVb4OZQ9BepQt87yTSCK0GQP7HkJp/k91G9d7xC9MYpvES8xC29gWu
	7SG0kuCWN60d65IJRnXmxeKKOpLd4saxRNXmKOFUPdg0xp+siHKtptSaVRKig8nJkEGJHb
	pk8zqQ1XFc3xAzTEjO3YqxCoEfTOt96DyAIEDz/IGKNTjTZ7EBe4mt7RiE+9S5eT1lWxuX
	esN5diONHHpioUmVh69ajdmxgtUl/FDgUrebA6VfUJGLh+oKrmJM4zV8LPoPfqfPnhERKl
	eVh8dCMoBkHgPbJrs44XQzHRtmzZKF5HNwKN3ohDFSvseMy6T3fP0mgGgueMSQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
From: Max Boone <contact@maxboone.com>
In-Reply-To: <20260414141514.1341429-5-den@valinux.co.jp>
Date: Wed, 29 Apr 2026 10:58:28 +0200
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>,
 Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>,
 Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ntb@lists.linux.dev,
 mboone@akamai.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2F607BF-6225-4799-A708-F908C7869DE3@maxboone.com>
References: <20260414141514.1341429-1-den@valinux.co.jp>
 <20260414141514.1341429-5-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>,
 mani@kernel.org,
 Frank Li <Frank.Li@nxp.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Last-TLS-Session-Version: TLSv1.2



> On Apr 14, 2026, at 4:15=E2=80=AFPM, Koichiro Den <den@valinux.co.jp> =
wrote:
>=20
> Prepare pci-ep-msi for non-MSI doorbell backends.
>=20
> Factor MSI doorbell allocation into a helper and extend struct
> pci_epf_doorbell_msg with:
>=20
>  - irq_flags: required IRQ request flags (e.g. IRQF_SHARED for some
>    backends)
>  - type: doorbell backend type
>  - bar/offset: pre-exposed doorbell target location, if any
>=20
> Initialize these fields for the existing MSI-backed doorbell
> implementation.
>=20
> Also add PCI_EPF_DOORBELL_EMBEDDED type, which is to be implemented in =
a
> follow-up patch.

I=E2=80=99m not very fond of keeping this implementation in the =
pci-ep-msi file,
as the platform MSI and this implementation are both iiuc specific to
the designware ep driver. Even more so because the MSI implementation
is enabled by config rather than through device tree.

Wouldn=E2=80=99t we want end-users to specify what kind of doorbell they =
want,
as it seems to be that a more specific doorbell BAR layout can be=20
programmed with eDMA, allowing native support for nvmet=E2=80=99s =
doorbell
BAR for example.

Originally in a patchset by Frank Li the API that was proposed was more
generic, and the pci-epc-msi implementation was chosen because there
was only one implementation:
- https://lore.kernel.org/imx/20231019150441.GA7254@thinkpad/
- https://lore.kernel.org/imx/20231019172347.GC7254@thinkpad/

I=E2=80=99d personally prefer to see an abstraction that is weaved into =
pci-epc-core
and pci-epf-core that can be implemented by drivers as they wish. While=20=

still keeping the enum for different types.

That also gives room to pull a poll-mode doorbell into the pci-epc-core,
which deduplicates that code from the nvmet and vntb epfs, and allows
other functions to use RC->EP doorbells without needing to bother with
writing the polling mechanism.

P.S. I=E2=80=99ve been working on a vfio-user based epc for development =
purposes
personally, and the last hurdle before I want to send it in for comments =
is=20
support for doorbells, and came across this patchset checking if =
there=E2=80=99s
any other activity in the space. Having an implementation-agnostic
doorbell API in the EPF/EPC core would be very helpful to me.

>=20
> No functional changes.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> drivers/pci/endpoint/pci-ep-msi.c | 54 ++++++++++++++++++++++---------
> include/linux/pci-epf.h           | 23 +++++++++++--
> 2 files changed, 60 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c =
b/drivers/pci/endpoint/pci-ep-msi.c
> index 1395919571f8..85fe46103220 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -8,6 +8,7 @@
>=20
> #include <linux/device.h>
> #include <linux/export.h>
> +#include <linux/interrupt.h>
> #include <linux/irqdomain.h>
> #include <linux/module.h>
> #include <linux/msi.h>
> @@ -35,23 +36,13 @@ static void pci_epf_write_msi_msg(struct msi_desc =
*desc, struct msi_msg *msg)
> pci_epc_put(epc);
> }
>=20
> -int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 =
num_db)
> {
> - struct pci_epc *epc =3D epf->epc;
> + struct pci_epf_doorbell_msg *msg;
> struct device *dev =3D &epf->dev;
> + struct pci_epc *epc =3D epf->epc;
> struct irq_domain *domain;
> - void *msg;
> - int ret;
> - int i;
> -
> - /* TODO: Multi-EPF support */
> - if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) !=3D=
 epf) {
> - dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
> - return -EINVAL;
> - }
> -
> - if (epf->db_msg)
> - return -EBUSY;
> + int ret, i;
>=20
> domain =3D of_msi_map_get_device_domain(epc->dev.parent, 0,
>      DOMAIN_BUS_PLATFORM_MSI);
> @@ -74,6 +65,12 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 =
num_db)
> if (!msg)
> return -ENOMEM;
>=20
> + for (i =3D 0; i < num_db; i++)
> + msg[i] =3D (struct pci_epf_doorbell_msg) {
> + .type =3D PCI_EPF_DOORBELL_MSI,
> + .bar =3D NO_BAR,
> + };
> +
> epf->num_db =3D num_db;
> epf->db_msg =3D msg;
>=20
> @@ -90,13 +87,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, =
u16 num_db)
> for (i =3D 0; i < num_db; i++)
> epf->db_msg[i].virq =3D msi_get_virq(epc->dev.parent, i);
>=20
> + return 0;
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +{
> + struct pci_epc *epc =3D epf->epc;
> + struct device *dev =3D &epf->dev;
> + int ret;
> +
> + /* TODO: Multi-EPF support */
> + if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) !=3D=
 epf) {
> + dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> + return -EINVAL;
> + }
> +
> + if (epf->db_msg)
> + return -EBUSY;
> +
> + ret =3D pci_epf_alloc_doorbell_msi(epf, num_db);
> + if (!ret)
> + return 0;
> +
> + dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> return ret;
> }
> EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
>=20
> void pci_epf_free_doorbell(struct pci_epf *epf)
> {
> - platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> + if (!epf->db_msg)
> + return;
> +
> + if (epf->db_msg[0].type =3D=3D PCI_EPF_DOORBELL_MSI)
> + platform_device_msi_free_irqs_all(epf->epc->dev.parent);
>=20
> kfree(epf->db_msg);
> epf->db_msg =3D NULL;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 7737a7c03260..cd747447a1ea 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -152,14 +152,33 @@ struct pci_epf_bar {
> struct pci_epf_bar_submap *submap;
> };
>=20
> +enum pci_epf_doorbell_type {
> + PCI_EPF_DOORBELL_MSI =3D 0,
> + PCI_EPF_DOORBELL_EMBEDDED,
> +};
> +
> /**
>  * struct pci_epf_doorbell_msg - represents doorbell message
> - * @msg: MSI message
> - * @virq: IRQ number of this doorbell MSI message
> + * @msg: Doorbell address/data pair to be mapped into BAR space.
> + *       For MSI-backed doorbells this is the MSI message, while for
> + *       "embedded" doorbells this represents an MMIO write that =
asserts
> + *       an interrupt on the EP side.
> + * @virq: IRQ number of this doorbell message
> + * @irq_flags: Required flags for =
request_irq()/request_threaded_irq().
> + *             Callers may OR-in additional flags (e.g. =
IRQF_ONESHOT).
> + * @type: Doorbell type.
> + * @bar: BAR number where the doorbell target is already exposed to =
the RC
> + *       (NO_BAR if not)
> + * @offset: offset within @bar for the doorbell target (valid iff
> + *          @bar !=3D NO_BAR)
>  */
> struct pci_epf_doorbell_msg {
> struct msi_msg msg;
> int virq;
> + unsigned long irq_flags;
> + enum pci_epf_doorbell_type type;
> + enum pci_barno bar;
> + resource_size_t offset;
> };
>=20
> /**
> --=20
> 2.51.0
>=20
>=20
--
Max

P.P.S. Sorry for the duplicate mail, the mailto link from lore didn=E2=80=99=
t work properly, at least this should put it in-thread.
