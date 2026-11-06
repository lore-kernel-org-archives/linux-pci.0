Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004534;
	b=f0ax9XlMozUtitl7K9WxiVOkQMZS89lfxcof8jYX7CasAuEAtfPp8b/K/dLleflWrpi7
	 izjH0jEUloup0GHxDBhBZ5peGqIF0Gx7VFRCtHl/UKBzUpx1Go+6Il3Qou2nEs+yqCFHk
	 O6ntUjvHb+TVR3W/f3Xx6BX2MdNlOIE2Za5DpnCozaoWBwTp6RquRLqjYtYwoWRetw48W
	 ul+2JXk6MTdu/TPBgz7RNBsSjHQ9YVg4NG2KxR36IVm2txlf3zx2V/PuOWzf1Jyww02HS
	 KiVyAeVbwbCVoQ2SQGolJFE1K5QUu/QyCS4XahUmMC3VqVNQUla76qk1OSb6OBdJnXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BwjRA8ftZApzwOyImkXY8LHZEAElz+0AJdwAhV3strc=;
	b=0zLbPIDZldY3WEgYdSSSbdszxAwtihDnPY5at3QuQcr9XvNrutPjX2iLxEJ/gEzcksnQ
	 O7U+/ZLHuNLzc3MQ7chECmma2dUdeCiuym+PYPapzsYT96pb1JV/T3Btto0rbSGyE8gg4
	 td062Z8TU7qMIZFpldjHdv2+oJ6KKL2gd3EeIPQwERZYJ1cpOjUW9XDBwBJe6gmPIyLVm
	 n25ecXyzzX8+1b1T3D1FYg//JtwuevZCNlA1hhouL0Ba7+JmX7+DkmBf/PHiPGVXzCX0/
	 jo45gcDZTK+o0jDBzCa6NLsLv26Tq/vQTPY2pTmWyRQ793dB0YK5mPVm3WSZ9ZvDiOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcAlRRKK;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02772606A330
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 22:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02772606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NcAlRRKK
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed3f563739so12065ad.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794004533; x=1794609333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BwjRA8ftZApzwOyImkXY8LHZEAElz+0AJdwAhV3strc=;
        b=NcAlRRKKPAjjj3R0MQ8Ie5G6V+chJBOIADQ7AtGo4vYYAU7+dXyxFCDK9w2/J+ZwmC
         6RltoK7XvSt70AoArkEGwuuNsTmkAgRiMRAppL0XaKswD0jPS9oTw17FnAvJswuvB8ye
         6PE5MkBZZYcLdTsdGBrM4IQCAd5QvEgr866oOdSyBFVpAY/DrMjmLVNUuylh8y3lpKzh
         2sDUKwJriyrG9RaErLw/St3p58hw8sRTZrpLIo49nReVZzVbdb8NQJo7qQwMWk4Y2hjL
         611IM0bnsdq0vhGRw8UhAmPiK5k80UA8hBDbwLtYvRs8EoAQ1VrK6XzBvz6afbizQmsr
         9yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004533; x=1794609333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BwjRA8ftZApzwOyImkXY8LHZEAElz+0AJdwAhV3strc=;
        b=QTvV2yb/qiDHVVinpjcjo2ZuRLFtG6btb1Ji4Ldyueh4x32yGicAEl71wnuYNTeM5P
         +KQNi3+6osJgF3Q5yRFoU05jxzu1BgKXgW7IyPCzSRRQHBli+upQg1f45kCgKxnttwCO
         lg6rdz9y9AZg48RWKtwSzON73PGR+Zf77adl83RYExcSrSrFbMV6VFt+L+J7+v/PA4TS
         QV5hrWP4J5qYSbhXTgsty9yqK1TNDSQk3RjCIHZJv9zv+GNw4THr9GAZu6GbREk0WRs0
         2u8MYuPqTGyfILMe2olDlSgcxd4zkfDIxKorREifEGPt1M8rgw+1dc3c7WnFtv2gJR6u
         100Q==
X-Forwarded-Encrypted: i=1; AL+hErE0i9M0z6mlvVdGcDUXVmV/IK68d6hiDUk43wARwg/d2rmwHkE5FpfCsIzW7CL+NuFHHv9PGlxUOmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eWIcaTB8V2HiNABKe/0ma1gUYUc3qmlW8M8wxGnPhZodBqRUZ
	OrkQuDJD8gE9dj18PwHqRO7SB6CHGJhotDeIUUq6UROfPuTvQgAn7kR2eONmklU9Bw==
X-Gm-Gg: AYBFou1x+XY4YoUPiKc5KjImkP/4+iDpI8mpWtA17KQwfp9hTLpaNBrmObGCDADAUSG
	rqU5w8Cf2YrPaUDe3XRLVr09iYptU2o2Vnd8VAMbu/Rvp0lCZzS07Ktj5j3e0qTK5akGlcSVNEs
	lkPA1l1Ys+LZ8I1hru+gzW09FyP27yKxCyiU75oPJRLa2AP5hjW9eJkPc+sh/GcA3A68CBWB5g6
	ABCK3cFT3ESLMKp0JqYC6BXAj582l8IjhW4rfjNn3ZFC/qGS1d3FmlqNMfF315QRwW7vgPk4Srw
	nVjfnBF7O+Iu/AW4L3XiOxOI5h+p8cpc46AHeYNlZn+7Q0joPvsThPemsMGm9wY9gZDKGsISCPQ
	rO9Zu1UqWVJw+UDmot+Hg6R7+TXqflLMpBIe+RGgXdFmFnBXBtKYaJpU76aH3XqO53YgUAkFFVg
	o2GJ7T1ZHkC3YgsBdawbLV2sYaGM9FNASU2vbGhX8CVwRlys5C2P9jmuIGyfa+E4bESb5VbAJPf
	+AB5Ek0gTNB1EQ+pVwfExuxWsDC0w1zSEopEuk2TBQ7Cx2axLpTJio+rtf7eu2XUyzTmWJxRwzW
	NV/5zwdIY3Jzf46MxZhOSWy3+hnx+wM9bPw53mOmqecoy1rdX21rNjv/37izbrNE6bjxX4hTHBn
	2DmWOFv9FL0xIq+Xdc5tg
X-Received: by 2002:a17:902:e80e:b0:2ea:1079:e519 with SMTP id d9443c01a7336-2ed6a97c2c6mr202835ad.17.1794004532665;
        Fri, 06 Nov 2026 14:35:32 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103435561sm482994a91.3.2026.11.06.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:35:31 -0800 (PST)
Date: Fri, 6 Nov 2026 22:35:27 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <au5VMy7zhOb65xIE@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-8-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:36AM -0800, Vipin Sharma wrote:
>Implement the Live Update file handler callbacks to preserve a vfio-pci
>device in noiommu mode across a Live Update while keeping it running
>across kexec. Subsequent commits will enable userspace to retrieve and
>take over this file after the Live Update.
>
>State about each device is serialized into struct vfio_pci_core_device_ser
>using Kexec-Handover (KHO) to preserve the pages holding the struct and
>the Live Update Orchestrator (LUO) to preserve the physical address of
>the struct.
>
>Key design notes and constraints:
>
> * Noiommu-only policy and bound cdev requirement: can_preserve() verifies
>   that the preserved file is a bound vfio-pci cdev file descriptor via
>   vfio_file_is_bound_cdev(), and preserve() requires the device to be in
>   noiommu mode via vfio_device_is_noiommu() (returning -EOPNOTSUPP
>   otherwise). CONFIG_VFIO_PCI_LIVEUPDATE now depends on
>   CONFIG_VFIO_DEVICE_CDEV and CONFIG_VFIO_NOIOMMU.
>
> * Serialized state: During preserve(), serialize the PCI domain, BDF,
>   config space size, reset_works flag, and the initial pci_saved_state
>   captured when the device was first opened. During freeze(), snapshot
>   the virtualized PCI config space (vconfig) and capability map
>   (pci_config_map).
>
> * Keep-running freeze and unfreeze: Do not reset the device, clear
>   PCI_COMMAND_MASTER, zap BAR mappings, or revoke dma-bufs during
>   freeze(). Validate that VFIO interrupts are disabled, that the device
>   is in PCI_D0 (and not in VFIO runtime PM low-power mode), and that
>   SR-IOV is not enabled, as VFs are not preserved and the next kernel
>   disables SR-IOV on the running device. Then mask physical INTx
>   (recording the prior state) and mark the device frozen. If the
>   Live Update is aborted after freeze(), unfreeze() restores the physical
>   INTx state and clears liveupdate_frozen so the existing FD remains
>   usable.
>
> * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
>   on entry to the ioctl, read/write and mmap paths, and re-checked under
>   a lock that freeze() holds before any operation that could change the
>   device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
>   around every config-space write in vfio_pci_config_rw_single(), under
>   vdev->memory_lock in vfio_pci_runtime_pm_entry(),
>   vfio_pci_ioctl_reset() and the SR-IOV enable path of
>   vfio_pci_core_sriov_configure(), and under dev_set->lock in
>   vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
>   before freeze() takes its snapshot or fails, while existing BAR mmaps,
>   ioeventfds and dma-bufs keep working. Serializing config writes on
>   igate covers the PCI_COMMAND, INTx disable emulation, power state and
>   FLR paths at one point (the INTx disable emulation now uses the
>   igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
>   helpers), and also serializes the irq_type and virq_disabled accesses
>   of config writes with VFIO_DEVICE_SET_IRQS.
>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> drivers/vfio/pci/Kconfig               |   2 +-
> drivers/vfio/pci/vfio_pci_config.c     |  19 +-
> drivers/vfio/pci/vfio_pci_core.c       |  49 +++-
> drivers/vfio/pci/vfio_pci_intrs.c      |   4 +-
> drivers/vfio/pci/vfio_pci_liveupdate.c | 303 ++++++++++++++++++++++++-
> drivers/vfio/pci/vfio_pci_priv.h       |  13 ++
> include/linux/kho/abi/vfio_pci.h       |  52 ++++-
> include/linux/vfio_pci_core.h          |   4 +
> 8 files changed, 434 insertions(+), 12 deletions(-)
>

[snip]

>diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>index 67e8199eec59..725043a44b55 100644
>--- a/include/linux/kho/abi/vfio_pci.h
>+++ b/include/linux/kho/abi/vfio_pci.h
>@@ -9,14 +9,19 @@
> #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
> #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>
>+#include <linux/bits.h>
>+#include <linux/compiler.h>
>+#include <linux/types.h>
>+
> /**
>  * DOC: VFIO PCI Live Update ABI
>  *
>  * VFIO uses the ABI defined below for preserving device files across a kexec
>  * reboot using LUO.
>  *
>- * Device metadata is serialized into memory which is then handed to the next
>- * kernel via KHO.
>+ * Device metadata, virtualized PCI configuration space, VFIO's capability map,
>+ * and the initial PCI saved state captured when the device was first opened are
>+ * serialized into memory which is then handed to the next kernel via KHO.
>  *
>  * This interface is a contract. Any modification to any of the serialization
>  * structs defined here constitutes a breaking change. Such changes require
>@@ -25,4 +30,47 @@
>
> #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>
>+/**
>+ * define VFIO_PCI_SER_RESET_WORKS - Device supports function reset.
>+ *
>+ * Set in &vfio_pci_core_device_ser.flags when the preserved device had
>+ * ``vdev->reset_works == true`` prior to kexec.
>+ */
>+#define VFIO_PCI_SER_RESET_WORKS	BIT(0)
>+
>+#define VFIO_PCI_SER_KNOWN_FLAGS	VFIO_PCI_SER_RESET_WORKS
>+
>+/**
>+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
>+ * device.
>+ *
>+ * @domain: The device's PCI domain number (segment).
>+ * @bdf: The device's PCI bus, device, and function number.
>+ * @cfg_size: Size in bytes of the device's PCI configuration space
>+ *            (``PCI_CFG_SPACE_SIZE`` or ``PCI_CFG_SPACE_EXP_SIZE``).
>+ * @size: Total size in bytes of this serialized buffer, equal to
>+ *        ``sizeof(struct vfio_pci_core_device_ser) + 2 * @cfg_size + @saved_state_size``.
>+ * @flags: Bitmask of ``VFIO_PCI_SER_*`` flags; unknown bits are rejected.
>+ * @saved_state_size: Size in bytes of the serialized &struct pci_saved_state_ser
>+ *                    blob stored in @data after ``config_map``, or 0 if none.
>+ * @reserved: Reserved for future use; must be 0.
>+ * @data: Variable-length payload containing, in order:
>+ *        1. ``u8 vconfig[@cfg_size]`` - VFIO virtualized config space snapshot
>+ *           captured during ``freeze()``.
>+ *        2. ``u8 config_map[@cfg_size]`` - VFIO capability map snapshot
>+ *           captured during ``freeze()``.
>+ *        3. ``u8 saved_state[@saved_state_size]`` - serialized
>+ *           &struct pci_saved_state_ser captured during ``preserve()``.
>+ */
>+struct vfio_pci_core_device_ser {
>+	u32 domain;
>+	u16 bdf;
>+	u16 cfg_size;
>+	u32 size;
>+	u32 flags;
>+	u32 saved_state_size;

We will need space for iommufd_token when we preserve that, we should
probably add it now as otherwise the compatibility would be broken when
we add it? Is the reserved here for that?
>+	u32 reserved;
>+	u8 data[];
>+} __packed;
>+
> #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
>diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>index 9a1674c152aa..6bae7581f4f4 100644
>--- a/include/linux/vfio_pci_core.h
>+++ b/include/linux/vfio_pci_core.h
>@@ -149,6 +149,10 @@ struct vfio_pci_core_device {
> 	struct notifier_block	nb;
> 	struct rw_semaphore	memory_lock;
> 	struct list_head	dmabufs;
>+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
>+	bool			liveupdate_frozen;
>+	bool			liveupdate_intx_disabled;
>+#endif
> };
>
> enum vfio_pci_io_width {
>-- 
>2.56.0.317.g454f8302e1-goog
>

Thanks,
Sami
