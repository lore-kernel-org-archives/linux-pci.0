Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218B308F2A
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408218; cv=none; b=sBhLmv3irzYQH3e9ixC+ZsKuMbz/ygzIUDFYwrSRJWgfX8tseE1xxz+2TYRLoSzoo6e0LBXWDvYSvxPAaLrR7z/KV0TYws/YTcvpCMqpOmQGOdZtvKVKVzo8mFQ9ZI9qjjb8AScABJLuZJQJekxGs+SLTRR3XG8eLptFkgwA7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408218; c=relaxed/simple;
	bh=RRnbRDbdqY7d/4OONRcDMeGYkXL6lef3FEc5JeZsykQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph0LLWbutA3YyJSVqVwEjjovVKcf1LhhlcQ2X/803JcDrBxSCruO9rZfEN0noQEXdNUZVUsF+R3Ew13a+DJffJM9hdHKyTKdntWb5/1dedajenkxD1Lz5nfv9iediYb7ZbY6jFXyYiXOLPo6PnbGNpcvXv+XqBeW7vYVP1+QMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PAIk2eyM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PAIk2eyM"
Message-ID: <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775408214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFvtQF/EQRNqZnPTUPg67LAGyHPrcqrBHQ7jLg4MTF8=;
	b=PAIk2eyMCUCV4fU3Q+SwHkNdyFkREbVgRJytHLvOs4PcnFfgF7qKdILVViQqknFRPYfPdU
	W/6pl4gJWtEXyWjIR3V9I7JKWwfIlIWxaZOnd8ZYYI1cbeXW16sa1RdvqV8ITZPNFpxjb0
	DgAJmKwf0EsTsx9JJb6XRb4OPHYUlYA=
Date: Sun, 5 Apr 2026 09:56:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: David Matlack <dmatlack@google.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal
 <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Askar Safin <safinaskar@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 David Rientjes <rientjes@google.com>, Feng Tang
 <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
 Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>,
 Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
 <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/4/3 14:58, David Matlack 写道:
> On Thu, Apr 2, 2026 at 2:29 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>> On 3/23/26 4:57 PM, David Matlack wrote:
>>> +config PCI_LIVEUPDATE
>>> +     bool "PCI Live Update Support (EXPERIMENTAL)"
>>> +     depends on PCI && LIVEUPDATE
>>> +     help
>>> +       Support for preserving PCI devices across a Live Update. This option
>>> +       should only be enabled by developers working on implementing this
>>> +       support. Once enough support as landed in the kernel, this option
>>> +       will no longer be marked EXPERIMENTAL.
>>> +
>>> +       If unsure, say N.
>> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
>> (modular support)?
>>
>> This would allow the feature to be built as a kernel module. For
>> development
>>
>> purposes, modularization means we only need to recompile a single module
>>
>> for testing, rather than rebuilding the entire kernel. Compiling a
>> module should
>>
>> be significantly faster than a full kernel build.
> I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
> pci_setup_device() (which is under CONFIG_PCI) needs to call
> pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
> module. This call is necessary so the PCI core knows whether a device
> being enumerated was preserved across a previous Live Update.

After the following changes, the liveupdate.ko can be generated 
successfully.

"

# ls drivers/pci/liveupdate.ko
drivers/pci/liveupdate.ko
"


diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig

index 05307d89c3f4..e172c31b33fa 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -335,7 +335,7 @@ config VGA_ARB_MAX_GPUS
           multiple GPUS.  The overhead for each GPU is very small.

  config PCI_LIVEUPDATE
-       bool "PCI Live Update Support (EXPERIMENTAL)"
+       tristate "PCI Live Update Support (EXPERIMENTAL)"
         depends on PCI && LIVEUPDATE
         help
           Support for preserving PCI devices across a Live Update. This 
option
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index c1251f4f8438..71bab8ecba85 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -413,3 +413,26 @@ void pci_liveupdate_unregister_flb(struct 
liveupdate_file_handler *fh)
         liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
  }
  EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_flb);
+
+extern void (*pci_liveupdate_setup_device_hook)(struct pci_dev *dev);
+extern u32 (*pci_liveupdate_incoming_nr_devices_hook)(void);
+static int __init liveupdate_module_init(void)
+{
+       pci_liveupdate_setup_device_hook = pci_liveupdate_setup_device;
+       pci_liveupdate_incoming_nr_devices_hook = 
pci_liveupdate_incoming_nr_devices;
+       pr_info("loaded\n");
+       return 0;
+}
+
+static void __exit liveupdate_module_exit(void)
+{
+       pci_liveupdate_setup_device_hook = NULL;
+       pci_liveupdate_incoming_nr_devices_hook = NULL;
+       pr_info("unloaded\n");
+}
+
+module_init(liveupdate_module_init);
+module_exit(liveupdate_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCI Live Update Support");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 979cb9921340..93f76500cb0d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1434,18 +1434,12 @@ static inline int pci_msix_write_tph_tag(struct 
pci_dev *pdev, unsigned int inde
         (PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
          PCI_CONF1_EXT_REG(reg))

-#ifdef CONFIG_PCI_LIVEUPDATE
+#if IS_ENABLED(CONFIG_PCI_LIVEUPDATE)
  void pci_liveupdate_setup_device(struct pci_dev *dev);
-u32 pci_liveupdate_incoming_nr_devices(void);
  #else
  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
  {
  }
-
-static inline u32 pci_liveupdate_incoming_nr_devices(void)
-{
-       return 0;
-}
  #endif

  #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 165056d71e66..4880302bca43 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1369,6 +1369,9 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 
*sec, u8 *sub)
         return true;
  }

+u32 (*pci_liveupdate_incoming_nr_devices_hook)(void) = NULL;
+EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_nr_devices_hook);
+
  static bool pci_assign_all_busses(void)
  {
         if (!pcibios_assign_all_busses())
@@ -1389,7 +1392,7 @@ static bool pci_assign_all_busses(void)
          * numbers during the initial cold boot, and then that topology 
would
          * then remain fixed across any subsequent Live Updates.
          */
-       if (pci_liveupdate_incoming_nr_devices()) {
+       if (pci_liveupdate_incoming_nr_devices_hook && 
pci_liveupdate_incoming_nr_devices_hook()) {
                 pr_info_once("Ignoring pci=assign-busses and inheriting 
bus numbers during Live Update\n");
                 return false;
         }
@@ -2030,6 +2033,9 @@ static const char *pci_type_str(struct pci_dev *dev)
         }
  }

+void (*pci_liveupdate_setup_device_hook)(struct pci_dev *dev) = NULL;
+EXPORT_SYMBOL_GPL(pci_liveupdate_setup_device_hook);
+
  /**
   * pci_setup_device - Fill in class and map information of a device
   * @dev: the device structure to fill
@@ -2091,7 +2097,8 @@ int pci_setup_device(struct pci_dev *dev)
         if (pci_early_dump)
                 early_dump_pci_device(dev);

-       pci_liveupdate_setup_device(dev);
+       if (pci_liveupdate_setup_device_hook)
+               pci_liveupdate_setup_device_hook(dev);

         /* Need to have dev->class ready */
         dev->cfg_size = pci_cfg_space_size(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27ee9846a2fd..aaab6adb487e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -592,7 +592,7 @@ struct pci_dev {
         u8              tph_mode;       /* TPH mode */
         u8              tph_req_type;   /* TPH requester type */
  #endif
-#ifdef CONFIG_PCI_LIVEUPDATE
+#if IS_ENABLED(CONFIG_PCI_LIVEUPDATE)
         unsigned int    liveupdate_incoming:1;  /* Preserved by 
previous kernel */
         unsigned int    liveupdate_outgoing:1;  /* Preserved for next 
kernel */
  #endif
@@ -2876,7 +2876,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  
pci_ers_result err_type);
         WARN_ONCE(condition, "%s %s: " fmt, \
                   dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)

-#ifdef CONFIG_PCI_LIVEUPDATE
+#if IS_ENABLED(CONFIG_PCI_LIVEUPDATE)
  int pci_liveupdate_preserve(struct pci_dev *dev);
  void pci_liveupdate_unpreserve(struct pci_dev *dev);
  int pci_liveupdate_retrieve(struct pci_dev *dev);
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 874830f8e44d..33fbdc6c417c 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -461,7 +461,7 @@ int liveupdate_register_flb(struct 
liveupdate_file_handler *fh,

         return 0;
  }
-
+EXPORT_SYMBOL_GPL(liveupdate_register_flb);
  /**
   * liveupdate_unregister_flb - Remove an FLB dependency from a file 
handler.
   * @fh:   The file handler that is currently depending on the FLB.
@@ -487,7 +487,7 @@ void liveupdate_unregister_flb(struct 
liveupdate_file_handler *fh,

         luo_flb_unregister_one(fh, flb);
  }
-
+EXPORT_SYMBOL_GPL(liveupdate_unregister_flb);
  /**
   * liveupdate_flb_get_incoming - Retrieve the incoming FLB object.
   * @flb:  The FLB definition.
@@ -525,7 +525,7 @@ int liveupdate_flb_get_incoming(struct 
liveupdate_flb *flb, void **objp)

         return 0;
  }
-
+EXPORT_SYMBOL_GPL(liveupdate_flb_get_incoming);
  /**
   * liveupdate_flb_get_outgoing - Retrieve the outgoing FLB object.
   * @flb:  The FLB definition.
@@ -552,6 +552,7 @@ int liveupdate_flb_get_outgoing(struct 
liveupdate_flb *flb, void **objp)

         return 0;
  }
+EXPORT_SYMBOL_GPL(liveupdate_flb_get_outgoing);

  int __init luo_flb_setup_outgoing(void *fdt_out)
  {

-- 
Best Regards,
Yanjun.Zhu

