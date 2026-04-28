Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9537998A
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397101; cv=none; b=YM9KZSDEaoYHwV8uTbrpfAaB0RTMLFuYSOx1CB7hM5ETpUjyiP3XKw/81lfUTF36Y7ExrYoMAeLzmRqdPb60M0zQW+l5+WkZgEjznKgEcMDzAfCmrEfCrM159qHWf3pIBKOrLFhO2H50j9muZzaMSKR8L3XncB5FoO+iDMfMt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397101; c=relaxed/simple;
	bh=exLRwTo+54W3A66dnpUJq+YzGvJxDAtlrClsBtQ/wMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXXvkw2KNpiz0N/kVIFT+0uCsjw2DTGlAGlKDnUJJw6lJIqDLpa8RXzBk7b0EFpB30Rpf/lfvGl1ObCN6VbM0t3igamfTH+ObAm+NBxBhB3LEDWSMYawkpY5BGb6wPR0Sah0ZpzNBF49vQpkfp3SoDuy3PPd12z7at5zfAREFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiNFXs4m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiNFXs4m"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso117355ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777397099; x=1778001899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rrqnMSkJK7r/cDlRpksXyGq7DpXCCWEbuMA7lgNfeg=;
        b=EiNFXs4mMv/ICvlxdPMxq9IUVnonABUioUTpnGgIetKCyFPF3hleSEplN61VSTNS0s
         2H0SR7pmRH49cr/h7xx+gRaKgJubCX40jB+YNPwJ1P7Jpf1bW6s9ZENotAT/bAk4B00h
         RihmKffoBzBmQIzYzfbKA6IJjrBBFxA0RpIEz3LFNpSCMcyMX8Sox4T8vkwr6QfRtM7g
         dl3fshctDcZUEXWiQ6hGyoDKR9B6bsFj2BXTThRFdFT60rISMZut3yZ1rAgx9mtSrxiv
         XWZvl7FZAsMAA+YQlfYINfMV+UEuKd4urizbtABTD10yAldMY5SUwVS5GShhsdxLKXmB
         GqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397099; x=1778001899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rrqnMSkJK7r/cDlRpksXyGq7DpXCCWEbuMA7lgNfeg=;
        b=My02tt5REL+5/LconKHMKp8yeghWlpohdYQ621DhEnj7HGp/ffOuGz13RDJ3+5lddS
         7sTWkNg5S4Ahq+pzbOspsG2sY2rgc78SSstNHu7Blz0/kKZ3JgRB/JN5vtoh3T4U89GA
         ZW49WfZNsBzMWHC2V3wsdA/ZI4PEf8Kg5othzu5ySlM8kZlNY1KK0XGIavevvQj8ERrG
         l1cb4SGseKikEl7iBE8CJLqVWf73GxgR3eBlKiIYDmpUy7U7+ZGO16RtmRnikA5/8alB
         V+J01Gy7ZCS0Pg9U4zET2x0qgdfKfsQjqGs89dJdlDklJT6w6wLZRiYD/zaHn3Tiggri
         Y3Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+vkQYJkV2Xz3RvVT5ob+y9A+DQEzTOgz+aCqlO7HmUxERHJ/jxha8BJ618LUxE82j4w0Xv3301nl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBS4vJCGWoygMiGQcpaLb7AnOzdkwqREjTgq/tLDkmw8cM7Y67
	cUOwY1McsopxR3m2P9B5/YTAbw2F4y7J1v6IDXQy3gM3d9GkdjFRQ3FQnn9T09HCJg==
X-Gm-Gg: AeBDiesJWFKzjn9sO1wnmfOKwIXNZuh9/5O7Gw0yynSLFHKTDXkKNGu6pD8SMW2r/Jl
	XibLsrFCtoY6DxqqxiT4TkK4/7TliExpTdcYhnHlMXM3dtHod0YMWpkxbXCDJMlsH8dgxOEOK8v
	IVVp68PdVEWTi0ZtUddJ+bVX8uPamujN/fPTr4u8wL7RT1xppAMSN9Gmu2h2N78/lpIA8K+cw2k
	jLSdxUAlVP1/1gsSOfCWqpBSAxEml/j3jY23yv5L8XOZjQMPy4LmMLWgiCHVip9VAGxUAdpzedF
	4kEYq4qJvhdiSizwl0E9rO9oOZ8HIIwoW+f30Vm0pinH+NKAEAAE0CO7weXq5zJRx5/8HJGoP2n
	9jAZIPyl5E5zGn8fReKYsI1/UYYuLZheTHjti/K9uAFBBqtmqX1Q3hPkI8Xfep6MqqxvCLrNmxY
	L+pccqQdRE76yGRby2JxtBO3JazXQLYyyzan0HxM8P6pWCBl2u3hmWOZk3cgowQIVNbe/HtTrnF
	FKh2cxr5Sw=
X-Received: by 2002:a17:903:380e:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b987f6d05dmr24355ad.11.1777397097903;
        Tue, 28 Apr 2026 10:24:57 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm31190845ad.75.2026.04.28.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:24:57 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:24:53 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afDqs6oqWlhoVqMN@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-3-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>Add APIs to allow drivers to notify the PCI core of which devices are
>being preserved across a Live Update for the next kernel, i.e.
>"outgoing" devices.
>
>Drivers must notify the PCI core when devices are preserved so that the
>PCI core can update its FLB data (struct pci_ser) and track the list of
>outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
>device must be preserved across Live Update. pci_liveupdate_unpreserve()
>reverses this (cancels the preservation of the device).
>
>This tracking ensures the PCI core is fully aware of which devices may
>need special handling during shutdown and kexec, and so that it can be
>handed off to the next kernel.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
> include/linux/kho/abi/pci.h |   7 +--
> include/linux/pci.h         |  26 ++++++++++
> 3 files changed, 131 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>index d4fa61625d56..2dd8daa2f17c 100644
>--- a/drivers/pci/liveupdate.c
>+++ b/drivers/pci/liveupdate.c
>@@ -43,6 +43,26 @@
>  *
>  *  * ``pci_liveupdate_register_flb(driver_file_handler)``
>  *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
>+ *
>+ * Device Tracking
>+ * ===============
>+ *
>+ * Drivers must notify the PCI core when specific devices are preserved or
>+ * unpreserved with the following APIs:
>+ *
>+ *  * ``pci_liveupdate_preserve(pci_dev)``
>+ *  * ``pci_liveupdate_unpreserve(pci_dev)``
>+ *
>+ * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
>+ * with the list of **outgoing** preserved devices for the next kernel.
>+ *
>+ * Restrictions
>+ * ============
>+ *
>+ * The PCI core enforces the following restrictions on which devices can be
>+ * preserved. These may be relaxed in the future:
>+ *
>+ *  * The device cannot be a Virtual Function (VF).
>  */
>
> #define pr_fmt(fmt) "PCI: liveupdate: " fmt
>@@ -57,6 +77,8 @@
> #include <linux/pci.h>
> #include <linux/sort.h>
>
>+static DEFINE_MUTEX(pci_flb_outgoing_lock);
>+
> static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> {
> 	struct pci_dev *dev = NULL;
>@@ -124,6 +146,85 @@ static struct liveupdate_flb pci_liveupdate_flb = {
> 	.compatible = PCI_LUO_FLB_COMPATIBLE,
> };
>
>+int pci_liveupdate_preserve(struct pci_dev *dev)
>+{
>+	struct pci_ser *ser;
>+	int i, ret;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+	if (ret)
>+		return ret;
>+
>+	if (!ser)
>+		return -ENOENT;
>+
>+	if (dev->is_virtfn)
>+		return -EINVAL;
>+
>+	if (dev->liveupdate_outgoing)
>+		return -EBUSY;
>+
>+	if (ser->nr_devices == ser->max_nr_devices)
>+		return -ENOSPC;
>+
>+	for (i = 0; i < ser->max_nr_devices; i++) {
>+		/*
>+		 * Start searching at index ser->nr_devices. This should result
>+		 * in a constant time search under expected conditions (devices
>+		 * are not getting unpreserved).
>+		 */
>+		int index = (ser->nr_devices + i) % ser->max_nr_devices;
>+		struct pci_dev_ser *dev_ser = &ser->devices[index];

nit: Maybe we can move this logic in a separate function as down the road
when we expand this to add VFs and Hotpluggable devices, this might
change significantly? It's good if it is self-contained.
>+
>+		if (dev_ser->refcount)
>+			continue;
>+
>+		pci_info(dev, "Device will be preserved across next Live Update\n");
>+		ser->nr_devices++;
>+
>+		dev_ser->domain = pci_domain_nr(dev->bus);
>+		dev_ser->bdf = pci_dev_id(dev);
>+		dev_ser->refcount = 1;
>+
>+		dev->liveupdate_outgoing = dev_ser;
>+		return 0;
>+	}
>+
>+	return -ENOSPC;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>+
>+void pci_liveupdate_unpreserve(struct pci_dev *dev)
>+{
>+	struct pci_dev_ser *dev_ser;
>+	struct pci_ser *ser = NULL;
>+	int ret;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+
>+	if (ret || !ser) {
>+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
>+		return;
>+
>+	}
>+
>+	dev_ser = dev->liveupdate_outgoing;
>+	if (!dev_ser) {
>+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
>+		return;
>+	}
>+
>+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
>+	ser->nr_devices--;
>+	memset(dev_ser, 0, sizeof(*dev_ser));
>+	dev->liveupdate_outgoing = NULL;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>+
> int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> {
> 	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
>diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
>index 5c0e92588c00..5b4c8d9e462c 100644
>--- a/include/linux/kho/abi/pci.h
>+++ b/include/linux/kho/abi/pci.h
>@@ -23,19 +23,20 @@
>  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>  */
>
>-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
>+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>
> /**
>  * struct pci_dev_ser - Serialized state about a single PCI device.
>  *
>  * @domain: The device's PCI domain number (segment).
>  * @bdf: The device's PCI bus, device, and function number.
>- * @reserved: Reserved (to naturally align struct pci_dev_ser).
>+ * @refcount: Reference count used by the PCI core to keep track of whether it
>+ *            is done using a device's struct pci_dev_ser.
>  */
> struct pci_dev_ser {
> 	u32 domain;
> 	u16 bdf;
>-	u16 reserved;
>+	u16 refcount;
> } __packed;
>
> /**
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index d70080babd52..eb94cbd8ab9d 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -41,6 +41,7 @@
> #include <linux/msi_api.h>
> #include <uapi/linux/pci.h>
> #include <linux/liveupdate.h>
>+#include <linux/kho/abi/pci.h>
>
> #include <linux/pci_ids.h>
>
>@@ -594,6 +595,9 @@ struct pci_dev {
> 	u8		tph_mode;	/* TPH mode */
> 	u8		tph_req_type;	/* TPH requester type */
> #endif
>+#ifdef CONFIG_PCI_LIVEUPDATE
>+	struct pci_dev_ser *liveupdate_outgoing; /* State preserved for next kernel */
>+#endif
> };
>
> static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>@@ -2880,6 +2884,14 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> #ifdef CONFIG_PCI_LIVEUPDATE
> int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
> void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
>+
>+int pci_liveupdate_preserve(struct pci_dev *dev);
>+void pci_liveupdate_unpreserve(struct pci_dev *dev);
>+
>+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>+{
>+	return dev->liveupdate_outgoing;
>+}

Is this expected to be called under the outgoing lock?
> #else
> static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> {
>@@ -2889,6 +2901,20 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
> static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
> {
> }
>+
>+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
>+{
>+}
>+
>+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>+{
>+	return NULL;
>+}
> #endif
>
> #endif /* LINUX_PCI_H */
>-- 
>2.54.0.rc2.544.gc7ae2d5bb8-goog
>
