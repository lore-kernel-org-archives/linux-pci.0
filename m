Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326931;
	b=YFFHxyB2dfj0TpoQoeFAWWOSnYJF467Dqc/qi1tLOO5Ep9i88tadJppasnD5e1faf2Dq
	 RgiGY6hbdaz7liIIKUNssykgkNt+mYOlyNgEBH/l0caD5TE5rCrI7KWw76PsX3MqqTbTr
	 kaThgxW3rfXQU9imQQGmjZNr44MnANzdd80KN6zcAuDw6Ypyk96xb2zJHNT/Yre/Ekzr7
	 URxMAYLa5Rp3uXsVOFwqfVF0XgX3gMI1N2EfvkkaYCcT9Vp8mIQveQbB0SPHC/qOfmZ7q
	 6Rftup54uyWGbK5RuXRsjvE/Qor3bMZwGRumby2xYEAyY2drXHxE1KQ5M5vs/y4kgmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326931;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QwFLOKzj3m6lhxcvsldXWAnm3jMrJWBTgKsC5EVfo04=;
	b=AL7yRxw+MoPSAaPDv1aq3tCGgN1hFkSS1+lnUsj2vnSKGk1Zeeh8EqQJH0QVSSfL0opD
	 ou7ner7HgC1fqts74QfejEvEIJNTdYGelZEVrOJ0gi9TpCJOMGzsl1DicGAQUFZeDS1hc
	 oCJtNrkKnqhvTqOVePl+Hs0fjxssJMACL9T0seJXbXzJuxgoR3ig8qAySkImGEOYp7kkL
	 0PfETfbzUVTER/UVTtmKsqfr1XvUQ7tMStsTGtr2sUnJ1z+hLWJXhUivoPMH0+wN2NyjQ
	 Sa+6rEUBYSB+Qx3izWQfbzjNiwRsOqfPKhGPXWMmQ5IJOzKDPFzrLwoPrl0r7OW2QWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9sV6YwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B1606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9sV6YwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2154F1F0089F;
	Tue, 10 Nov 2026 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326930;
	bh=QwFLOKzj3m6lhxcvsldXWAnm3jMrJWBTgKsC5EVfo04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9sV6YwZWmDEXpbpg6V6U+I5uaJzv1V+wqTvxMJ3RsohUkHNcPMvIDh/LB6911BcQ
	 AI11lg2ftSeUvomNFMXUYd7641wQck0VU0pgUmcjoky4rI0KQpCm/Pnpo2dKFmhRPF
	 gXyAtdScoUuuKuFsjwuf8p9OQVZ0H/M7Vw82lgTrwcrvNyCfi7Zst+1unCbvpCuYKF
	 f2jMOkNFswF1xjDWBW+ERe7f3UpdpYZa8BwU2rA+hIg+9kV1HK7u4jl2Wq1Q5/n/4x
	 UfZlfXgTBZcdKOoPyQAr3l7QkUo7zaTjwBKEeYCxikblpx480OEJ7yGQgf9QeLM6jA
	 ZPo/CBJiHyR7A==
Received: by pali.im (Postfix)
	id 45EDB5E0; Tue, 10 Nov 2026 17:08:47 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>
Cc: =?UTF-8?q?Filip=20=C5=A0t=C4=9Bdronsk=C3=BD?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org
Subject: [PATCH] libpci: Add new direct HW access method intel-conf1-ext
Date: Tue, 10 Nov 2026 17:08:06 +0100
Message-Id: <20261110160806.10142-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <mj+md-20261110.152044.70145.albireo@ucw.cz>
References: <mj+md-20261110.152044.70145.albireo@ucw.cz>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the intel-conf1-ext method, an extension of intel-conf1 that
allows access to all PCIe registers, including the extended PCIe space
starting at offset 0x100. This method utilizes four reserved bits above
the bus bits to represent the extended PCIe registers.

Currently, on x86 architectures, this method is supported exclusively
by AMD Family 10h-18h CPUs. Newer AMD CPUs require a setup that has not yet
been documented by AMD and remains unknown. Intel CPUs do not support this
method yet.
---
 lib/i386-cpuid.h | 108 +++++++++++++++++++++
 lib/i386-ports.c | 245 +++++++++++++++++++++++++++++++++++++++++++++--
 lib/init.c       |   6 ++
 lib/internal.h   |   2 +-
 lib/pci.h        |   1 +
 pcilib.man       |   4 +
 6 files changed, 357 insertions(+), 9 deletions(-)
 create mode 100644 lib/i386-cpuid.h

diff --git a/lib/i386-cpuid.h b/lib/i386-cpuid.h
new file mode 100644
index 000000000000..783e9159b5ae
--- /dev/null
+++ b/lib/i386-cpuid.h
@@ -0,0 +1,108 @@
+#if defined(__GNUC__) && ((__GNUC__ == 4 && __GNUC_MINOR__ >= 3) || (__GNUC__ > 4))
+
+/*
+ * GCC's cpuid.h header file is buggy and cannot be included more times.
+ * MinGW's intrin.h header file in some versions includes cpuid.h and
+ * therefore intrin.h and cpuid.h cannot be mixed in one source unit.
+ * libpci's i386-io-windows.h in some cases include intrin.h and therefore
+ * in some configurations it is not possible to include cpuid.h here again.
+ * GCC's cpuid.h since beginning define __cpuid macro, so it could be used
+ * as a include guard. But unfortunately MinGW-w64 since version 10.0.0
+ * automatically undefine macro __cpuid in intrin.h.
+ */
+#if defined(__MINGW64_VERSION_MAJOR) && __MINGW64_VERSION_MAJOR >= 10
+#include <intrin.h>
+#elif !defined(__cpuid)
+#include <cpuid.h>
+#endif
+#ifndef __get_cpuid
+#define __get_cpuid __get_cpuid
+#endif
+
+#elif defined (__GNUC__)
+
+static inline int
+__get_cpuid(unsigned int level, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
+{
+#ifndef __x86_64__
+  /* cpuid does not have to be supported on 32-bit x86, check for it. */
+  unsigned int eflags_orig, eflags_mod;
+  asm (
+    "pushfl\n\t"
+    "pushfl\n\t"
+    "popl\t%0\n\t"
+    "movl\t%0, %1\n\t"
+    "xorl\t%2, %0\n\t"
+    "pushl\t%0\n\t"
+    "popfl\n\t"
+    "pushfl\n\t"
+    "popl\t%0\n\t"
+    "popfl\n\t"
+      : "=&r" (eflags_mod), "=&r" (eflags_orig)
+      : "i" (0x00200000)
+  );
+  if (!((eflags_mod ^ eflags_orig) & 0x00200000))
+    return 0;
+#endif
+
+  asm ("cpuid\n\t" : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx) : "0" (level));
+  return 1;
+}
+#define __get_cpuid __get_cpuid
+
+#elif defined(_MSC_VER)
+
+/* MSVC provides intrinsic __cpuid since version 14.00 included in VS2005. */
+#if _MSC_VER >= 1400
+#pragma intrinsic(__cpuid)
+#else
+static void
+__cpuid(int CPUInfo[4], int InfoType)
+{
+  __asm {
+    mov esi, CPUInfo
+    mov eax, InfoType
+    xor ecx, ecx
+    _emit 0x0F __asm _emit 0xA2 /* cpuid */
+    mov dword ptr [esi +  0], eax
+    mov dword ptr [esi +  4], ebx
+    mov dword ptr [esi +  8], ecx
+    mov dword ptr [esi + 12], edx
+  }
+}
+#endif
+static inline int
+__get_cpuid(unsigned int level, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
+{
+  int regs[4];
+
+#ifndef _M_AMD64
+  /* cpuid does not have to be supported on 32-bit x86, check for it. */
+  unsigned int eflags_orig, eflags_mod;
+  __asm {
+    pushfd
+    pushfd
+    pop eflags_orig
+    push eflags_orig
+    pop eflags_mod
+    xor eflags_mod, 0x00200000
+    push eflags_mod
+    popfd
+    pushfd
+    pop eflags_mod
+    popfd
+  }
+  if (!((eflags_mod ^ eflags_orig) & 0x00200000))
+    return 0;
+#endif
+
+  __cpuid(regs, level);
+  *eax = regs[0];
+  *ebx = regs[1];
+  *ecx = regs[2];
+  *edx = regs[3];
+  return 1;
+}
+#define __get_cpuid __get_cpuid
+
+#endif
diff --git a/lib/i386-ports.c b/lib/i386-ports.c
index b9d863c0762a..952e74e9688d 100644
--- a/lib/i386-ports.c
+++ b/lib/i386-ports.c
@@ -36,6 +36,8 @@
 #error Do not know how to access I/O ports on this OS.
 #endif
 
+#include "i386-cpuid.h"
+
 static int conf12_io_enabled = -1;		/* -1=haven't tried, 0=failed, 1=succeeded */
 
 static int
@@ -50,7 +52,10 @@ static void
 conf12_init(struct pci_access *a)
 {
   if (!conf12_setup_io(a))
+  {
+    a->debug("\n");
     a->error("No permission to access I/O ports (you probably have to be root).");
+  }
 }
 
 static void
@@ -103,8 +108,6 @@ intel_sanity_check(struct pci_access *a, struct pci_methods *m)
  *	Configuration type 1
  */
 
-#define CONFIG_CMD(bus, device_fn, where)   (0x80000000 | (bus << 16) | (device_fn << 8) | (where & ~3))
-
 static int
 conf1_detect(struct pci_access *a)
 {
@@ -132,19 +135,19 @@ conf1_detect(struct pci_access *a)
 }
 
 static int
-conf1_read(struct pci_dev *d, int pos, byte *buf, int len)
+conf1_ext_read(struct pci_dev *d, int pos, byte *buf, int len)
 {
   int addr = 0xcfc + (pos&3);
   int res = 1;
 
-  if (d->domain || pos >= 256)
+  if (d->domain || pos >= 4096)
     return 0;
 
   if (len != 1 && len != 2 && len != 4)
     return pci_generic_block_read(d, pos, buf, len);
 
   intel_io_lock();
-  intel_outl(0x80000000 | ((d->bus & 0xff) << 16) | (PCI_DEVFN(d->dev, d->func) << 8) | (pos&~3), 0xcf8);
+  intel_outl(0x80000000 | ((pos & 0xf00) << 16) | ((d->bus & 0xff) << 16) | (PCI_DEVFN(d->dev, d->func) << 8) | (pos & 0xfc), 0xcf8);
 
   switch (len)
     {
@@ -164,19 +167,28 @@ conf1_read(struct pci_dev *d, int pos, byte *buf, int len)
 }
 
 static int
-conf1_write(struct pci_dev *d, int pos, byte *buf, int len)
+conf1_read(struct pci_dev *d, int pos, byte *buf, int len)
+{
+  if (pos >= 256)
+    return 0;
+
+  return conf1_ext_read(d, pos, buf, len);
+}
+
+static int
+conf1_ext_write(struct pci_dev *d, int pos, byte *buf, int len)
 {
   int addr = 0xcfc + (pos&3);
   int res = 1;
 
-  if (d->domain || pos >= 256)
+  if (d->domain || pos >= 4096)
     return 0;
 
   if (len != 1 && len != 2 && len != 4)
     return pci_generic_block_write(d, pos, buf, len);
 
   intel_io_lock();
-  intel_outl(0x80000000 | ((d->bus & 0xff) << 16) | (PCI_DEVFN(d->dev, d->func) << 8) | (pos&~3), 0xcf8);
+  intel_outl(0x80000000 | ((pos & 0xf00) << 16) | ((d->bus & 0xff) << 16) | (PCI_DEVFN(d->dev, d->func) << 8) | (pos & 0xfc), 0xcf8);
 
   switch (len)
     {
@@ -194,6 +206,15 @@ conf1_write(struct pci_dev *d, int pos, byte *buf, int len)
   return res;
 }
 
+static int
+conf1_write(struct pci_dev *d, int pos, byte *buf, int len)
+{
+  if (pos >= 256)
+    return 0;
+
+  return conf1_ext_write(d, pos, buf, len);
+}
+
 /*
  *	Configuration type 2. Obsolete and brain-damaged, but existing.
  */
@@ -294,6 +315,202 @@ conf2_write(struct pci_dev *d, int pos, byte *buf, int len)
   return res;
 }
 
+static int cpu_detected = -1;
+static int
+conf1_ext_detect_cpu(struct pci_access *a)
+{
+#ifdef __get_cpuid
+  unsigned int eax, ebx, ecx, edx;
+  unsigned int family;
+#endif
+
+  if (cpu_detected >= 0)
+    goto out;
+
+#ifndef __get_cpuid
+  a->debug("...cannot determinate CPU model");
+  cpu_detected = 0;
+  goto out;
+#else
+  if (!__get_cpuid(0, &eax, &ebx, &ecx, &edx))
+    {
+      a->debug("...detected unsupported CPU without cpuid instruction");
+      cpu_detected = 0;
+      goto out;
+    }
+
+  /* Check for AuthenticAMD or HygonGenuine signature. */
+  if ((ebx != 0x68747541 || edx != 0x69746E65 || ecx != 0x444D4163) &&
+      (ebx != 0x6f677948 || edx != 0x6e65476e || ecx != 0x656e6975))
+    {
+      a->debug("...detected unsupported CPU %.4s%.4s%.4s", (char *)&ebx, (char *)&edx, (char *)&ecx);
+      cpu_detected = 0;
+      goto out;
+    }
+
+  /* Get the CPU family number. */
+  if (!__get_cpuid(1, &eax, &ebx, &ecx, &edx))
+    {
+      a->debug("...detected unsupported CPU AMD/Hygon");
+      cpu_detected = 0;
+      goto out;
+    }
+  family = (eax >> 8) & 0xf;
+  if (family == 0xf)
+    family += (eax >> 20) & 0xff;
+
+  /* For now only AMD Family 10h-18h CPUs are supported (see conf1_ext_setup). */
+  if (family < 0x10 || family > 0x18)
+    {
+      a->debug("...detected unsupported CPU AMD Family %xh", family);
+      cpu_detected = 0;
+      goto out;
+    }
+
+  a->debug("...detected supported CPU AMD Family %xh", family);
+  cpu_detected = family;
+  goto out;
+#endif
+
+out:
+  return cpu_detected;
+}
+
+static int
+conf1_ext_setup(struct pci_access *a)
+{
+  const char *reg_name;
+  struct pci_dev d;
+  int off;
+  int bit;
+  u32 val;
+  u32 tmp;
+
+  /*
+   * AMD Family 10h-16h:
+   * EnableCf8ExtCfg bit [46] in NB Configuration 1 [NB_CFG1] register controls
+   * whether CF8 extended configuration cycles are enabled or not. This 64-bit
+   * register is mapped to MSR register [MSRC001_001F] and its upper 32 bits
+   * also to PCI register [D18F3x8C]. That PCI register is in config space of
+   * bus 0x00 device 0x18 function 0x3 offset 0x8c.
+   * AMD Family 17h-18h:
+   * EnableCf8ExtCfg bit [0] in Core Coherent Master Configuration Access
+   * Control register mapped to PCI register [D18F4x044] controls whether CF8
+   * extended configuration cycles are enabled or not. That PCI register is in
+   * config space of bus 0x00 device 0x18 function 0x4 offset 0x44.
+   * AMD Family 19h+:
+   * Not supported for now, seems that EnableCf8ExtCfg bit is by default not
+   * enabled and documentation does not specify where is this register located.
+   * Public references:
+   * BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h-16h Processors
+   * Non-public/NDA references:
+   * Processor Programming Reference (PPR) for AMD Family 17h Processors
+   */
+
+  memset(&d, 0, sizeof(d));
+  d.bus = 0;
+  d.dev = 0x18;
+  d.func = cpu_detected < 0x17 ? 0x3 : 0x4;
+  off = cpu_detected < 0x17 ? 0x8c : 0x44;
+  bit = cpu_detected < 0x17 ? (46-32) : 0;
+  reg_name = cpu_detected < 0x17 ? "NB_CFG1" : "CCMCAC";
+
+  a->debug("...reading %s", reg_name);
+  if (!conf1_read(&d, off, (byte *)&val, sizeof(val)))
+    {
+      a->debug("...failed");
+      return 0;
+    }
+
+  if (!(val & (1 << bit)))
+    {
+      a->debug("...EnableCf8ExtCfg unset");
+      val |= (1 << bit);
+      a->debug("...setting EnableCf8ExtCfg in %s", reg_name);
+      if (!conf1_write(&d, off, (byte *)&val, sizeof(val)))
+        {
+          a->debug("...failed");
+          return 0;
+        }
+      a->debug("...reading %s", reg_name);
+      if (!conf1_read(&d, off, (byte *)&val, sizeof(val)))
+        {
+          a->debug("...failed");
+          return 0;
+        }
+      a->debug("...verifying EnableCf8ExtCfg");
+      if (!(val & (1 << bit)))
+        {
+          a->debug("...failed");
+          return 0;
+        }
+      a->debug("...passed");
+    }
+  else
+    a->debug("...EnableCf8ExtCfg already set");
+
+  /*
+   * Set CF8 address to the first register from extended config space (0x100)
+   * and verify that address was set the correct value. When Cf8ExtCfg access
+   * is unsupported or not enabled then CF8 address bits for extended config
+   * space cannot be set and are hardwired to zeros.
+   */
+  a->debug("...verifying Cf8ExtCfg access");
+  intel_io_lock();
+  tmp = intel_inl(0xcf8);
+  intel_outl(0x81000000, 0xcf8);
+  val = intel_inl(0xcf8);
+  intel_outl(tmp, 0xcf8);
+  intel_io_unlock();
+  if (val != 0x81000000)
+    {
+      a->debug("...failed");
+      return 0;
+    }
+  a->debug("...passed");
+
+  return 1;
+}
+
+static void
+conf1_ext_init(struct pci_access *a)
+{
+  if (cpu_detected < 0)
+    {
+      a->debug("detecting CPU");
+      conf1_ext_detect_cpu(a);
+    }
+  if (!cpu_detected)
+    {
+      a->debug("\n");
+      a->error("Unsupported CPU for Intel conf1 extended interface (requires AMD Family 10h-18h).");
+    }
+
+  conf12_init(a);
+
+  if (!conf1_ext_setup(a))
+    {
+      a->debug("\n");
+      a->error("Cannot setup Intel conf1 extended interface (probably not supported).");
+    }
+}
+
+static int
+conf1_ext_detect(struct pci_access *a)
+{
+  if (!conf1_ext_detect_cpu(a))
+    return 0;
+
+  if (!conf1_detect(a))
+    return 0;
+
+  if (!conf1_ext_setup(a))
+    return 0;
+
+  a->debug("\n");
+  return 1;
+}
+
 struct pci_methods pm_intel_conf1 = {
   .name = "intel-conf1",
   .help = "Raw I/O port access using Intel conf1 interface",
@@ -306,6 +523,18 @@ struct pci_methods pm_intel_conf1 = {
   .write = conf1_write,
 };
 
+struct pci_methods pm_intel_conf1_ext = {
+  .name = "intel-conf1-ext",
+  .help = "Raw I/O port access using Intel conf1 extended interface",
+  .detect = conf1_ext_detect,
+  .init = conf1_ext_init,
+  .cleanup = conf12_cleanup,
+  .scan = pci_generic_scan,
+  .fill_info = pci_generic_fill_info,
+  .read = conf1_ext_read,
+  .write = conf1_ext_write,
+};
+
 struct pci_methods pm_intel_conf2 = {
   .name = "intel-conf2",
   .help = "Raw I/O port access using Intel conf2 interface",
diff --git a/lib/init.c b/lib/init.c
index 10b39e48c821..1702d3fb64e7 100644
--- a/lib/init.c
+++ b/lib/init.c
@@ -173,6 +173,11 @@ static struct pci_methods *pci_methods[PCI_ACCESS_MAX] = {
 #else
   NULL,
 #endif
+#ifdef PCI_HAVE_PM_INTEL_CONF
+  &pm_intel_conf1_ext,
+#else
+  NULL,
+#endif
 };
 
 // If PCI_ACCESS_AUTO is selected, we probe the access methods in this order
@@ -195,6 +200,7 @@ static int probe_sequence[] = {
   PCI_ACCESS_MINIOS,
   // Low-level methods poking the hardware directly
   PCI_ACCESS_ECAM,
+  PCI_ACCESS_I386_TYPE1_EXT,
   PCI_ACCESS_I386_TYPE1,
   PCI_ACCESS_I386_TYPE2,
   PCI_ACCESS_MMIO_TYPE1_EXT,
diff --git a/lib/internal.h b/lib/internal.h
index feb3ad377e17..a784ecfb5567 100644
--- a/lib/internal.h
+++ b/lib/internal.h
@@ -141,7 +141,7 @@ void pci_free_params(struct pci_access *acc);
 void pci_scan_caps(struct pci_dev *, unsigned int want_fields);
 void pci_free_caps(struct pci_dev *);
 
-extern struct pci_methods pm_intel_conf1, pm_intel_conf2, pm_linux_proc,
+extern struct pci_methods pm_intel_conf1_ext, pm_intel_conf1, pm_intel_conf2, pm_linux_proc,
 	pm_fbsd_device, pm_aix_device, pm_nbsd_libpci, pm_obsd_device,
 	pm_dump, pm_linux_sysfs, pm_darwin, pm_sylixos_device, pm_hurd,
 	pm_mmio_conf1, pm_mmio_conf1_ext, pm_ecam,
diff --git a/lib/pci.h b/lib/pci.h
index 8d66f1d5ee2a..4f7b64b3e69f 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -58,6 +58,7 @@ enum pci_access_type {
   PCI_ACCESS_AOS_EXPANSION,		/* AmigaOS Expansion library */
   PCI_ACCESS_RT_THREAD_SMART_DM,	/* RT-Thread Smart pci */
   PCI_ACCESS_MINIOS,			/* Xen MiniOS */
+  PCI_ACCESS_I386_TYPE1_EXT,		/* i386 ports, type 1 extended */
   PCI_ACCESS_MAX
 };
 
diff --git a/pcilib.man b/pcilib.man
index 286651623fe7..b2b5950bf49f 100644
--- a/pcilib.man
+++ b/pcilib.man
@@ -35,6 +35,10 @@ to all users, the rest only to root.
 Direct hardware access via Intel configuration mechanism 1. Available on i386 and compatibles
 on Linux, Solaris/x86, GNU Hurd, Windows, BeOS and Haiku. Requires root privileges.
 .TP
+.B intel-conf1-ext
+Direct hardware access via Extended PCIe Intel configuration mechanism 1. Available on
+AMD Family 10h-18h CPUs. Requires root privileges.
+.TP
 .B intel-conf2
 Direct hardware access via Intel configuration mechanism 2. Available on i386 and compatibles
 on Linux, Solaris/x86, GNU Hurd, Windows, BeOS and Haiku. Requires root privileges. Warning: This method
-- 
2.20.1

