Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97537A48D
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884299; cv=none; b=PREkm8+aNp9wUvL74ROpJNNw0t5TlzKNzDxIK2xF2V2G2907p3odP6bRr/gJc6PDMaG3ZD41CmGTYJX8+CPDI9h2W1xBdUnCPcdJSTqcg+ZFH8vlNOivvS6AYuxNGyc83p5jjOTrNIRbgK+cSNCEVTOMnxb3ny40iWgoOssLNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884299; c=relaxed/simple;
	bh=AI9gfXDBkcP6WmfnkK99dAjWuc/b8hF4WRnHOyqdGgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTzrrursF984GEdAMtN8OPcWTv9lqDrNvD57UCINZPipUYwZqLJoDN7NuBSPKskuFcs9Er/Y6tljPUCXKqgph8jNQ2JVD7fKtA/a5+ZCK/B37Ev3nfDlsYQTKOWTq5dQG/SLWpxUPLjJozurvJGVpquFmmZMrjB2HFLOPSX85p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMeHxnc8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMeHxnc8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a885af8ee7so6465ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 14:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771884297; x=1772489097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHyrvIUwqGI/vsO/cw6CrNGSRQGELXRV70tcL/TCQBg=;
        b=MMeHxnc8YTsTb8et7VA60jHxEmNaLetCLFSdvpjKfVDWZlq+oBoJXzM/14/Lwol2iy
         UhkdtYtv03mTHhBnxNCbUB8rHE3luec6bYMe1TV/RLNgAkpqMRn20MO8iRlUdtK0mSra
         RAt3QEPOI9YpnwIAdwP54tMEndrTA3EJaMPAdSfQ62q18DKdgb+SbZWCpdNleb1Jh5YF
         LWOwcNskW/CmEi5hWK79uBieVFJdbQuSTzW2J9KMxEnFDfQl+JrbnVems8teUAib8UZQ
         pdQWA8TJpRoGTtZm+7ml9mFMZV+3gIqPfWwGeUvIibGEXXPJVhxQdQpBCYbMNaMz13CN
         o3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884297; x=1772489097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHyrvIUwqGI/vsO/cw6CrNGSRQGELXRV70tcL/TCQBg=;
        b=ScUJXIOqdmJ+EFX1c39Veu1gYOMQLi/4GS9b0YhbnC5UpAdwS9mFF/x/deVL2Ql9dN
         FLHxSA3ZcMZC1KkZpKhm/VqKLrZRCRX8RSLqOax7t1bqtpfgVpS4b7sNdqwshUUUQ6E8
         2GB2MEj3we79mNmi8r/1LwVMf8h9CFsnWRVTfKIbwfazWOzRNUOLlm6CalbrRziovIUN
         Xi5ZlFewMmtTYYvGmiyUO3qQHqDgmXNjIrAH4mx3x6vQveluhYKkwoi3ixxDIehx3N2k
         H6j7nftEaZZZgH49+4HZYMh1YAJ22dgDQJO8iMW7xn/yP8ufXNwhpygQms0YYnijKgZz
         jkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXO+RW7cSvdtPgkbizPRhwDLHZbQqspOnrHB1KMxxHlO5ueJ6KaVA9UVTRu9qbtbz73cahstrO0k6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwOmL9lxEi0oGxlcOvMXZJm6xkxWtlujDJo4kiw0hGdgS+yyN
	113I1GEW2Ah55KM5Ep+cy1Eus+zyBMaUbhDAOi7ofiBAr5pmq9VIG0LMpLckRGU+Fg==
X-Gm-Gg: ATEYQzwo361pdKxsNEm/nJnO+RxhBx9xZNaIjWOyRA4qTr0nImokdrvjpTtq2aizSpE
	xkMWSvyDD7X01kSDSm+T1mLbiIJ+tdKsLH3JUDUJLrV409gtxeBb40IcDBqd2zTTnSErczu6ubx
	RjjC5v4K7FHoVhwF4Pq7YLOZrtZi2g/8xMjO3T5oe0Biw60MI/IyS1NlzgFOTAEEjQbc/eb14TD
	Wufm6mteICAgVunZZxYGdz9D7Jvm98twg6OTWIAPhL5apRR9OjeDF2sZd0INYEYvlMaOaIBie2V
	kT4b2sR1YS1WFKMzpmxKtn1P2la+Nqmifr7sLkbQVQrabz9gTvF+96bbPfqM6SpGKs9L4+L5rSx
	aST2td4/RqjsPUeGmYcgUdZw8aIx6NRnMZhedYMvo0HLP+Sli02Y19E0FU4RvV91+fnwenA4FyS
	h7M8yS3mePajXz2XHSpK3yqv3cpv4YdNQhmYaxkbs2fzRIx/yw93Va4+oG8ZmfTg==
X-Received: by 2002:a17:903:38d0:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2ada346b6a8mr76155ad.7.1771884296114;
        Mon, 23 Feb 2026 14:04:56 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm87224705ad.80.2026.02.23.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:04:55 -0800 (PST)
Date: Mon, 23 Feb 2026 22:04:51 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-3-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
>Add an API to enable the PCI subsystem to track all devices that are
>preserved across a Live Update, including both incoming devices (passed
>from the previous kernel) and outgoing devices (passed to the next
>kernel).
>
>Use PCI segment number and BDF to keep track of devices across Live
>Update. This means the kernel must keep both identifiers constant across
>a Live Update for any preserved device. VFs are not supported for now,
>since that requires preserving SR-IOV state on the device to ensure the
>same number of VFs appear after kexec and with the same BDFs.
>
>Drivers that preserve devices across Live Update can now register their
>struct liveupdate_file_handler with the PCI subsystem so that the PCI
>subsystem can allocate and manage File-Lifecycle-Bound (FLB) global data
>to track the list of incoming and outgoing preserved devices.
>
>  pci_liveupdate_register_fh(driver_fh)
>  pci_liveupdate_unregister_fh(driver_fh)
>
>Drivers can notify the PCI subsystem whenever a device is preserved and
>unpreserved with the following APIs:
>
>  pci_liveupdate_outgoing_preserve(pci_dev)
>  pci_liveupdate_outgoing_unpreserve(pci_dev)

nit: Preserve and Unpreserve can only be done from outgoing kernel, maybe
remove the "outgoing" from the function name.
>
>After a Live Update, the PCI subsystem fetches its FLB global data
>from the previous kernel from the Live Update Orchestrator (LUO) during
>device initialization to determine which devices were preserved.
>
>Drivers can check if a device was preserved before userspace retrieves
>the file for it via pci_dev->liveupdate_incoming.
>
>Once a driver has finished restoring an incoming preserved device, it
>can notify the PCI subsystem with the following call, which clears
>pci_dev->liveupdate_incoming.
>
>  pci_liveupdate_incoming_finish(pci_dev)
>
>This API will be used in subsequent commits by the vfio-pci driver to
>preserve VFIO devices across Live Update and by the PCI subsystem.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/Makefile        |   1 +
> drivers/pci/liveupdate.c    | 212 ++++++++++++++++++++++++++++++++++++
> drivers/pci/probe.c         |   2 +
> include/linux/kho/abi/pci.h |  55 ++++++++++
> include/linux/pci.h         |  47 ++++++++
> 5 files changed, 317 insertions(+)
> create mode 100644 drivers/pci/liveupdate.c
> create mode 100644 include/linux/kho/abi/pci.h
>
>diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>index 8c259a9a8796..a32f7658b9e5 100644
>--- a/drivers/pci/Makefile
>+++ b/drivers/pci/Makefile
>@@ -16,6 +16,7 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
> obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
> obj-$(CONFIG_ACPI)		+= pci-acpi.o
> obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
>+obj-$(CONFIG_LIVEUPDATE)	+= liveupdate.o
> endif
>
> obj-$(CONFIG_OF)		+= of.o
>diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>new file mode 100644
>index 000000000000..182cfc793b80
>--- /dev/null
>+++ b/drivers/pci/liveupdate.c
>@@ -0,0 +1,212 @@
>+// SPDX-License-Identifier: GPL-2.0
>+
>+/*
>+ * Copyright (c) 2025, Google LLC.
>+ * David Matlack <dmatlack@google.com>
>+ */
>+
>+#include <linux/bsearch.h>
>+#include <linux/io.h>
>+#include <linux/kexec_handover.h>
>+#include <linux/kho/abi/pci.h>
>+#include <linux/liveupdate.h>
>+#include <linux/mutex.h>
>+#include <linux/mm.h>
>+#include <linux/pci.h>
>+#include <linux/sort.h>
>+
>+static DEFINE_MUTEX(pci_flb_outgoing_lock);
>+
>+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>+{
>+	struct pci_dev *dev = NULL;
>+	int max_nr_devices = 0;
>+	struct pci_ser *ser;
>+	unsigned long size;
>+
>+	for_each_pci_dev(dev)
>+		max_nr_devices++;

This will not work for SRIOV as new devices will be registered when
sriov is enabled and the max will increase. As we are not handling VFs
with this patch series, this can be fine?
>+
>+	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
>+
>+	ser = kho_alloc_preserve(size);
>+	if (IS_ERR(ser))
>+		return PTR_ERR(ser);
>+
>+	ser->max_nr_devices = max_nr_devices;
>+
>+	args->obj = ser;
>+	args->data = virt_to_phys(ser);
>+	return 0;
>+}
>+
>+static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
>+{
>+	struct pci_ser *ser = args->obj;
>+
>+	WARN_ON_ONCE(ser->nr_devices);
>+	kho_unpreserve_free(ser);
>+}
>+
>+static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>+{
>+	args->obj = phys_to_virt(args->data);
>+	return 0;
>+}
>+
>+static void pci_flb_finish(struct liveupdate_flb_op_args *args)
>+{
>+	kho_restore_free(args->obj);
>+}
>+
>+static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
>+	.preserve = pci_flb_preserve,
>+	.unpreserve = pci_flb_unpreserve,
>+	.retrieve = pci_flb_retrieve,
>+	.finish = pci_flb_finish,
>+	.owner = THIS_MODULE,
>+};
>+
>+static struct liveupdate_flb pci_liveupdate_flb = {
>+	.ops = &pci_liveupdate_flb_ops,
>+	.compatible = PCI_LUO_FLB_COMPATIBLE,
>+};
>+
>+#define INIT_PCI_DEV_SER(_dev) {		\
>+	.domain = pci_domain_nr((_dev)->bus),	\
>+	.bdf = pci_dev_id(_dev),		\
>+}
>+
>+static int pci_dev_ser_cmp(const void *__a, const void *__b)
>+{
>+	const struct pci_dev_ser *a = __a, *b = __b;
>+
>+	return cmp_int(a->domain << 16 | a->bdf, b->domain << 16 | b->bdf);
>+}
>+
>+static struct pci_dev_ser *pci_ser_find(struct pci_ser *ser,
>+					struct pci_dev *dev)
>+{
>+	const struct pci_dev_ser key = INIT_PCI_DEV_SER(dev);
>+
>+	return bsearch(&key, ser->devices, ser->nr_devices,
>+		       sizeof(key), pci_dev_ser_cmp);
>+}
>+
>+static int pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
>+{
>+	struct pci_dev_ser *dev_ser;
>+	int i;
>+
>+	dev_ser = pci_ser_find(ser, dev);
>+	if (!dev_ser)
>+		return -ENOENT;
>+
>+	for (i = dev_ser - ser->devices; i < ser->nr_devices - 1; i++)
>+		ser->devices[i] = ser->devices[i + 1];
>+
>+	ser->nr_devices--;
>+	return 0;
>+}
>+
>+int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
>+{
>+	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
>+	struct pci_ser *ser;
>+	int i, ret;
>+
>+	/* Preserving VFs is not supported yet. */
>+	if (dev->is_virtfn)
>+		return -EINVAL;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	if (dev->liveupdate_outgoing)
>+		return -EBUSY;
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+	if (ret)
>+		return ret;
>+
>+	if (ser->nr_devices == ser->max_nr_devices)
>+		return -E2BIG;
>+
>+	for (i = ser->nr_devices; i > 0; i--) {
>+		struct pci_dev_ser *prev = &ser->devices[i - 1];
>+		int cmp = pci_dev_ser_cmp(&new, prev);
>+
>+		if (WARN_ON_ONCE(!cmp))
>+			return -EBUSY;
>+
>+		if (cmp > 0)
>+			break;
>+
>+		ser->devices[i] = *prev;
>+	}
>+
>+	ser->devices[i] = new;
>+	ser->nr_devices++;
>+	dev->liveupdate_outgoing = true;
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_outgoing_preserve);
>+
>+void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev)
>+{
>+	struct pci_ser *ser;
>+	int ret;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+	if (WARN_ON_ONCE(ret))
>+		return;
>+
>+	WARN_ON_ONCE(pci_ser_delete(ser, dev));
>+	dev->liveupdate_outgoing = false;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_outgoing_unpreserve);
>+
>+u32 pci_liveupdate_incoming_nr_devices(void)
>+{
>+	struct pci_ser *ser;
>+	int ret;
>+
>+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
>+	if (ret)
>+		return 0;
>+
>+	return ser->nr_devices;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_nr_devices);
>+
>+void pci_liveupdate_setup_device(struct pci_dev *dev)
>+{
>+	struct pci_ser *ser;
>+	int ret;
>+
>+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
>+	if (ret)
>+		return;
>+
>+	dev->liveupdate_incoming = !!pci_ser_find(ser, dev);
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_setup_device);
>+
>+void pci_liveupdate_incoming_finish(struct pci_dev *dev)
>+{
>+	dev->liveupdate_incoming = false;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_finish);
>+
>+int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh)
>+{
>+	return liveupdate_register_flb(fh, &pci_liveupdate_flb);
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_register_fh);
>+
>+int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh)
>+{
>+	return liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_fh);
>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>index 37329095e5fe..af6356c5a156 100644
>--- a/drivers/pci/probe.c
>+++ b/drivers/pci/probe.c
>@@ -2060,6 +2060,8 @@ int pci_setup_device(struct pci_dev *dev)
> 	if (pci_early_dump)
> 		early_dump_pci_device(dev);
>
>+	pci_liveupdate_setup_device(dev);
>+
> 	/* Need to have dev->class ready */
> 	dev->cfg_size = pci_cfg_space_size(dev);
>
>diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
>new file mode 100644
>index 000000000000..6577767f8da6
>--- /dev/null
>+++ b/include/linux/kho/abi/pci.h
>@@ -0,0 +1,55 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+
>+/*
>+ * Copyright (c) 2025, Google LLC.
>+ * David Matlack <dmatlack@google.com>
>+ */
>+
>+#ifndef _LINUX_KHO_ABI_PCI_H
>+#define _LINUX_KHO_ABI_PCI_H
>+
>+#include <linux/compiler.h>
>+#include <linux/types.h>
>+
>+/**
>+ * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
>+ *
>+ * This header defines the ABI for preserving core PCI state across kexec using
>+ * Live Update File-Lifecycle Bound (FLB) data.
>+ *
>+ * This interface is a contract. Any modification to any of the serialization
>+ * structs defined here constitutes a breaking change. Such changes require
>+ * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>+ */
>+
>+#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
>+
>+/**
>+ * struct pci_dev_ser - Serialized state about a single PCI device.
>+ *
>+ * @domain: The device's PCI domain number (segment).
>+ * @bdf: The device's PCI bus, device, and function number.
>+ */
>+struct pci_dev_ser {
>+	u16 domain;
>+	u16 bdf;
>+} __packed;
>+
>+/**
>+ * struct pci_ser - PCI Subsystem Live Update State
>+ *
>+ * This struct tracks state about all devices that are being preserved across
>+ * a Live Update for the next kernel.
>+ *
>+ * @max_nr_devices: The length of the devices[] flexible array.
>+ * @nr_devices: The number of devices that were preserved.
>+ * @devices: Flexible array of pci_dev_ser structs for each device. Guaranteed
>+ *           to be sorted ascending by domain and bdf.
>+ */
>+struct pci_ser {
>+	u64 max_nr_devices;
>+	u64 nr_devices;
>+	struct pci_dev_ser devices[];
>+} __packed;
>+
>+#endif /* _LINUX_KHO_ABI_PCI_H */
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index 7e36936bb37a..9ead6d84aef6 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -40,6 +40,7 @@
> #include <linux/resource_ext.h>
> #include <linux/msi_api.h>
> #include <uapi/linux/pci.h>
>+#include <linux/liveupdate.h>
>
> #include <linux/pci_ids.h>
>
>@@ -582,6 +583,10 @@ struct pci_dev {
> 	u8		tph_mode;	/* TPH mode */
> 	u8		tph_req_type;	/* TPH requester type */
> #endif
>+#ifdef CONFIG_LIVEUPDATE
>+	unsigned int	liveupdate_incoming:1;	/* Preserved by previous kernel */
>+	unsigned int	liveupdate_outgoing:1;	/* Preserved for next kernel */
>+#endif
> };
>
> static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>@@ -2854,4 +2859,46 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> 	WARN_ONCE(condition, "%s %s: " fmt, \
> 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
>
>+#ifdef CONFIG_LIVEUPDATE
>+int pci_liveupdate_outgoing_preserve(struct pci_dev *dev);
>+void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev);
>+void pci_liveupdate_setup_device(struct pci_dev *dev);
>+u32 pci_liveupdate_incoming_nr_devices(void);
>+void pci_liveupdate_incoming_finish(struct pci_dev *dev);
>+int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh);
>+int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh);
>+#else /* !CONFIG_LIVEUPDATE */
>+static inline int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev)
>+{
>+}
>+
>+static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>+{
>+}
>+
>+static inline u32 pci_liveupdate_incoming_nr_devices(void)
>+{
>+	return 0;
>+}
>+
>+static inline void pci_liveupdate_incoming_finish(struct pci_dev *dev)
>+{
>+}
>+
>+static inline int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh)
>+{
>+	return -EOPNOTSUPP;
>+}
>+#endif /* !CONFIG_LIVEUPDATE */
>+
> #endif /* LINUX_PCI_H */
>-- 
>2.53.0.rc1.225.gd81095ad13-goog
>
