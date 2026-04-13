Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11093264F7;
	Mon, 13 Apr 2026 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080024; cv=none; b=Fh8cFIxoeYOcwBuYpOr5hiPoDNYYRWGwxPQq06MTjrW38OTpKqkTaBTuVcnyhMIqDZasZBgVlG67MaZwD22NrDkSrcP0ZCdE7Nrm1LeO45hqWCVHANJIWdcQkaPQSFtF7tJMOTTV2zdYG60XCVBodioT9N1Jc21nhuhImsUW5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080024; c=relaxed/simple;
	bh=GTCKNZw5ZA4+F2UX1Lc+WkH6dsotMD/7hwFxEdmg10w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nKZ1woeI2Qd5JMM84SBze51LnyMdr27hUdQNDt5InRFCDNfObMZ0706iyhZerP/SQMLgijVAX2FZpf6Mm6DwZo2tMT0V0zK1B+R0d3CBGlGIl8soVppYHutE9F2WV3zBzWRJHkqQGIvCVnzhZ6Gu3yMmXt5axHZf/GkBbFZowq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0XvF9dk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0XvF9dk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776080023; x=1807616023;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GTCKNZw5ZA4+F2UX1Lc+WkH6dsotMD/7hwFxEdmg10w=;
  b=S0XvF9dks/smhol0At9wqXdLvLz1zsJ64MalZavuqJ7gqAx1wQkvpbqi
   xYl0TEtEtZfbhpsv4j5DiWO2Tr2D4rGyCyiiALNNclsGCN4MSDznlBBfP
   s6qP9SOm0L5sS/UqgcmO0rZK9NxL2Q/6i0c6N6MBkGe0DUJjw5uL5sZva
   bO3d9+u8uV+0Q/laVccWAdz5nnftCRCJ4T2IIt/IcTg6hNexEVqx9OfdW
   O6ejniuCfEcSQCFAG2N2WqPnP/Ex7Y3XAQTBQDwgWmdPzrrxQqhsqqNdc
   zOqyju0cn2VeLW4EarqFJ32PtfgHKeN2tPF90naCZMPDwrDpLw5Tr4xj+
   Q==;
X-CSE-ConnectionGUID: nldj48pBRS2T44QSkc+tOQ==
X-CSE-MsgGUID: XcdLoJSQQxGGFmAbh+m1HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94585522"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="94585522"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:33:42 -0700
X-CSE-ConnectionGUID: 9KDOc8NYQn+oZbaM1eeHMQ==
X-CSE-MsgGUID: ASfdxeGQT8KxN8XgI6GeFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="223276752"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:33:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:33:29 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Christophe Leroy <chleroy@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Dexuan Cui <decui@microsoft.com>, 
    =?ISO-8859-2?Q?Krzysztof_Ha=B3asa?= <khalasa@piap.pl>, 
    Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Shuan He <heshuan@bytedance.com>, 
    Srivatsa Bhat <srivatsabhat@microsoft.com>, linux-pci@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 07/24] PCI/sysfs: Convert PCI resource files to static
 attributes
In-Reply-To: <20260411080148.471335-8-kwilczynski@kernel.org>
Message-ID: <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-8-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-991724749-1776080009=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-991724749-1776080009=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, the PCI resource files (resourceN, resourceN_wc) are
> dynamically created by pci_create_sysfs_dev_files(), called from
> both pci_bus_add_device() and the pci_sysfs_init() late_initcall,
> with only a sysfs_initialized flag for synchronisation.  This has
> caused "duplicate filename" warnings and boot panics when both
> paths race on the same device.
>=20
> This is especially likely on Devicetree-based platforms, where the
> PCI host controllers are platform drivers that probe via the driver
> model, which can happen during or after the late_initcall.  As such,
> pci_bus_add_device() and pci_sysfs_init() are more likely to overlap.
>=20
> Thus, convert to static const attributes with three attribute groups
> (I/O, UC, WC), each with an .is_bin_visible callback that checks
> resource flags, BAR length, and non_mappable_bars.  A .bin_size
> callback provides pci_resource_len() to the kernfs node for correct
> stat and lseek behaviour.
>=20
> As part of this conversion:
>=20
>   - Rename pci_read_resource_io() and pci_write_resource_io() to
>     pci_read_resource() and pci_write_resource() since the callbacks
>     are no longer I/O-specific in the static attribute context.
>=20
>   - Remove pci_create_resource_files(), pci_remove_resource_files(),
>     and pci_create_attr() which are no longer needed.
>=20
>   - Move the __weak stubs outside the #if guard so they remain
>     available for callers converted in subsequent commits.
>=20
> Platforms that do not define the HAVE_PCI_MMAP macro or the
> ARCH_GENERIC_PCI_MMAP_RESOURCE macro, such as Alpha architecture,
> continue using their platform-specific resource file creation.
>=20
> For reference, the dynamic creation dates back to the pre-Git era:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit=
/drivers/pci/pci-sysfs.c?id=3D42298be0eeb5ae98453b3374c36161b05a46c5dc
>=20
> The write-combine support was added in commit 45aec1ae72fc ("x86: PAT
> export resource_wc in pci sysfs").
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 242 +++++++++++++++++++++-------------------
>  include/linux/pci.h     |   2 -
>  2 files changed, 127 insertions(+), 117 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ca0074674acc..2922905ff070 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1200,14 +1200,14 @@ static ssize_t pci_resource_io(struct file *filp,=
 struct kobject *kobj,
>  #endif
>  }
> =20
> -static ssize_t pci_read_resource_io(struct file *filp, struct kobject *k=
obj,
> +static ssize_t pci_read_resource(struct file *filp, struct kobject *kobj=
,
>  =09=09=09=09    const struct bin_attribute *attr, char *buf,
>  =09=09=09=09    loff_t off, size_t count)
>  {
>  =09return pci_resource_io(filp, kobj, attr, buf, off, count, false);
>  }
> =20
> -static ssize_t pci_write_resource_io(struct file *filp, struct kobject *=
kobj,
> +static ssize_t pci_write_resource(struct file *filp, struct kobject *kob=
j,
>  =09=09=09=09     const struct bin_attribute *attr, char *buf,
>  =09=09=09=09     loff_t off, size_t count)
>  {
> @@ -1261,129 +1261,136 @@ static const struct bin_attribute dev_resource#=
#_bar##_wc_attr =3D {=09=09\
>  =09.mmap =3D pci_mmap_resource_wc,=09=09=09=09=09=09\
>  }
> =20
> -/**
> - * pci_remove_resource_files - cleanup resource files
> - * @pdev: dev to cleanup
> - *
> - * If we created resource files for @pdev, remove them from sysfs and
> - * free their resources.
> - */
> -static void pci_remove_resource_files(struct pci_dev *pdev)
> +static inline umode_t
> +__pci_resource_attr_is_visible(struct kobject *kobj,
> +=09=09=09       const struct bin_attribute *a,
> +=09=09=09       int bar, bool write_combine,
> +=09=09=09       unsigned long flags)
>  {
> -=09int i;
> +=09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> =20
> -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> -=09=09struct bin_attribute *res_attr;
> -
> -=09=09res_attr =3D pdev->res_attr[i];
> -=09=09if (res_attr) {
> -=09=09=09sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> -=09=09=09kfree(res_attr);
> -=09=09}
> -
> -=09=09res_attr =3D pdev->res_attr_wc[i];
> -=09=09if (res_attr) {
> -=09=09=09sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> -=09=09=09kfree(res_attr);
> -=09=09}
> -=09}
> -}
> -
> -static int pci_create_attr(struct pci_dev *pdev, int num, int write_comb=
ine)
> -{
> -=09/* allocate attribute structure, piggyback attribute name */
> -=09int name_len =3D write_combine ? 13 : 10;
> -=09struct bin_attribute *res_attr;
> -=09char *res_attr_name;
> -=09int retval;
> -
> -=09res_attr =3D kzalloc(sizeof(*res_attr) + name_len, GFP_ATOMIC);
> -=09if (!res_attr)
> -=09=09return -ENOMEM;
> -
> -=09res_attr_name =3D (char *)(res_attr + 1);
> -
> -=09sysfs_bin_attr_init(res_attr);
> -=09if (write_combine) {
> -=09=09sprintf(res_attr_name, "resource%d_wc", num);
> -=09=09res_attr->mmap =3D pci_mmap_resource_wc;
> -=09} else {
> -=09=09sprintf(res_attr_name, "resource%d", num);
> -=09=09if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
> -=09=09=09res_attr->read =3D pci_read_resource_io;
> -=09=09=09res_attr->write =3D pci_write_resource_io;
> -=09=09=09if (arch_can_pci_mmap_io())
> -=09=09=09=09res_attr->mmap =3D pci_mmap_resource_uc;
> -=09=09} else {
> -=09=09=09res_attr->mmap =3D pci_mmap_resource_uc;
> -=09=09}
> -=09}
> -=09if (res_attr->mmap) {
> -=09=09res_attr->f_mapping =3D iomem_get_mapping;
> -=09=09/*
> -=09=09 * generic_file_llseek() consults f_mapping->host to determine
> -=09=09 * the file size. As iomem_inode knows nothing about the
> -=09=09 * attribute, it's not going to work, so override it as well.
> -=09=09 */
> -=09=09res_attr->llseek =3D pci_llseek_resource;
> -=09}
> -=09res_attr->attr.name =3D res_attr_name;
> -=09res_attr->attr.mode =3D 0600;
> -=09res_attr->size =3D pci_resource_len(pdev, num);
> -=09res_attr->private =3D (void *)(unsigned long)num;
> -=09retval =3D sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
> -=09if (retval) {
> -=09=09kfree(res_attr);
> -=09=09return retval;
> -=09}
> -
> -=09if (write_combine)
> -=09=09pdev->res_attr_wc[num] =3D res_attr;
> -=09else
> -=09=09pdev->res_attr[num] =3D res_attr;
> -
> -=09return 0;
> -}
> -
> -/**
> - * pci_create_resource_files - create resource files in sysfs for @dev
> - * @pdev: dev in question
> - *
> - * Walk the resources in @pdev creating files for each resource availabl=
e.
> - */
> -static int pci_create_resource_files(struct pci_dev *pdev)
> -{
> -=09int i;
> -=09int retval;
> -
> -=09/* Skip devices with non-mappable BARs */
>  =09if (pdev->non_mappable_bars)
>  =09=09return 0;
> =20
> -=09/* Expose the PCI resources from this device as files */
> -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +=09if (!pci_resource_len(pdev, bar))
> +=09=09return 0;

Hi,

Did you accidently forget to address some of the comments as I thought you=
=20
were agreeing to changing this to resource_assigned() but I found no=20
resource_assigned() from entire series?

--=20
 i.

> =20
> -=09=09/* skip empty resources */
> -=09=09if (!pci_resource_len(pdev, i))
> -=09=09=09continue;
> +=09if ((pci_resource_flags(pdev, bar) & flags) !=3D flags)
> +=09=09return 0;
> =20
> -=09=09retval =3D pci_create_attr(pdev, i, 0);
> -=09=09/* for prefetchable resources, create a WC mappable file */
> -=09=09if (!retval && arch_can_pci_mmap_wc() &&
> -=09=09    pci_resource_flags(pdev, i) & IORESOURCE_PREFETCH)
> -=09=09=09retval =3D pci_create_attr(pdev, i, 1);
> -=09=09if (retval) {
> -=09=09=09pci_remove_resource_files(pdev);
> -=09=09=09return retval;
> -=09=09}
> -=09}
> -=09return 0;
> +=09if (write_combine && !arch_can_pci_mmap_wc())
> +=09=09return 0;
> +
> +=09return a->attr.mode;
>  }
> -#else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOU=
RCE)) */
> -int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
> -void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
> +
> +static umode_t pci_dev_resource_io_is_visible(struct kobject *kobj,
> +=09=09=09=09=09      const struct bin_attribute *a,
> +=09=09=09=09=09      int n)
> +{
> +=09return __pci_resource_attr_is_visible(kobj, a, n, false,
> +=09=09=09=09=09      IORESOURCE_IO);
> +}
> +
> +static umode_t pci_dev_resource_uc_is_visible(struct kobject *kobj,
> +=09=09=09=09=09      const struct bin_attribute *a,
> +=09=09=09=09=09      int n)
> +{
> +=09return __pci_resource_attr_is_visible(kobj, a, n, false,
> +=09=09=09=09=09      IORESOURCE_MEM);
> +}
> +
> +static umode_t pci_dev_resource_wc_is_visible(struct kobject *kobj,
> +=09=09=09=09=09      const struct bin_attribute *a,
> +=09=09=09=09=09      int n)
> +{
> +=09return __pci_resource_attr_is_visible(kobj, a, n, true,
> +=09=09=09=09=09      IORESOURCE_MEM | IORESOURCE_PREFETCH);
> +}
> +
> +static size_t pci_dev_resource_bin_size(struct kobject *kobj,
> +=09=09=09=09=09const struct bin_attribute *a,
> +=09=09=09=09=09int n)
> +{
> +=09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> +
> +=09return pci_resource_len(pdev, n);
> +}
> +
> +pci_dev_resource_io_attr(0);
> +pci_dev_resource_io_attr(1);
> +pci_dev_resource_io_attr(2);
> +pci_dev_resource_io_attr(3);
> +pci_dev_resource_io_attr(4);
> +pci_dev_resource_io_attr(5);
> +
> +pci_dev_resource_uc_attr(0);
> +pci_dev_resource_uc_attr(1);
> +pci_dev_resource_uc_attr(2);
> +pci_dev_resource_uc_attr(3);
> +pci_dev_resource_uc_attr(4);
> +pci_dev_resource_uc_attr(5);
> +
> +pci_dev_resource_wc_attr(0);
> +pci_dev_resource_wc_attr(1);
> +pci_dev_resource_wc_attr(2);
> +pci_dev_resource_wc_attr(3);
> +pci_dev_resource_wc_attr(4);
> +pci_dev_resource_wc_attr(5);
> +
> +static const struct bin_attribute *const pci_dev_resource_io_attrs[] =3D=
 {
> +=09&dev_resource0_io_attr,
> +=09&dev_resource1_io_attr,
> +=09&dev_resource2_io_attr,
> +=09&dev_resource3_io_attr,
> +=09&dev_resource4_io_attr,
> +=09&dev_resource5_io_attr,
> +=09NULL,
> +};
> +
> +static const struct bin_attribute *const pci_dev_resource_uc_attrs[] =3D=
 {
> +=09&dev_resource0_uc_attr,
> +=09&dev_resource1_uc_attr,
> +=09&dev_resource2_uc_attr,
> +=09&dev_resource3_uc_attr,
> +=09&dev_resource4_uc_attr,
> +=09&dev_resource5_uc_attr,
> +=09NULL,
> +};
> +
> +static const struct bin_attribute *const pci_dev_resource_wc_attrs[] =3D=
 {
> +=09&dev_resource0_wc_attr,
> +=09&dev_resource1_wc_attr,
> +=09&dev_resource2_wc_attr,
> +=09&dev_resource3_wc_attr,
> +=09&dev_resource4_wc_attr,
> +=09&dev_resource5_wc_attr,
> +=09NULL,
> +};
> +
> +static const struct attribute_group pci_dev_resource_io_attr_group =3D {
> +=09.bin_attrs =3D pci_dev_resource_io_attrs,
> +=09.is_bin_visible =3D pci_dev_resource_io_is_visible,
> +=09.bin_size =3D pci_dev_resource_bin_size,
> +};
> +
> +static const struct attribute_group pci_dev_resource_uc_attr_group =3D {
> +=09.bin_attrs =3D pci_dev_resource_uc_attrs,
> +=09.is_bin_visible =3D pci_dev_resource_uc_is_visible,
> +=09.bin_size =3D pci_dev_resource_bin_size,
> +};
> +
> +static const struct attribute_group pci_dev_resource_wc_attr_group =3D {
> +=09.bin_attrs =3D pci_dev_resource_wc_attrs,
> +=09.is_bin_visible =3D pci_dev_resource_wc_is_visible,
> +=09.bin_size =3D pci_dev_resource_bin_size,
> +};
> +
>  #endif
> =20
> +int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
> +void __weak pci_remove_resource_files(struct pci_dev *dev) { }
> +
>  /**
>   * pci_write_rom - used to enable access to the PCI ROM display
>   * @filp: sysfs file
> @@ -1861,6 +1868,11 @@ static const struct attribute_group pci_dev_group =
=3D {
> =20
>  const struct attribute_group *pci_dev_groups[] =3D {
>  =09&pci_dev_group,
> +#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
> +=09&pci_dev_resource_io_attr_group,
> +=09&pci_dev_resource_uc_attr_group,
> +=09&pci_dev_resource_wc_attr_group,
> +#endif
>  =09&pci_dev_config_attr_group,
>  =09&pci_dev_rom_attr_group,
>  =09&pci_dev_reset_attr_group,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05aceb7f1f37..9c0782899ef9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2526,10 +2526,8 @@ int pcibios_alloc_irq(struct pci_dev *dev);
>  void pcibios_free_irq(struct pci_dev *dev);
>  resource_size_t pcibios_default_alignment(void);
> =20
> -#if !defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
>  extern int pci_create_resource_files(struct pci_dev *dev);
>  extern void pci_remove_resource_files(struct pci_dev *dev);
> -#endif
> =20
>  #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
>  void __init pci_mmcfg_early_init(void);
>=20
--8323328-991724749-1776080009=:962--
