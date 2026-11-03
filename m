Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733397;
	b=qbK31WHrqmMEyiBMJZAsh48l8NKy6w+tCDFj4dyUyJDuYqqeZGa5cEFDEtY0kvBj1NZp
	 4dKmJ7tQtHhMA2Sf1gATzaj4yURKQUEClNDTNzceUNlrrqfvnNNuNzFZdNoKZB7iI1FE1
	 asl+WrLjssM6z6/Y5xe0oeCUr7SKN1yxnUg8u0Cfm5SyO3Ce7hMLbPw4CI8FFazyO2595
	 6OpWsG/ZZHgG9q2CWlxMXNI//aoeWWwLyEgYDeNlxwoVLpmdKhjIBWyHRJYsW0W8yxm/k
	 TANw5qPI1hYIrHbP6V+fygM4JuOwGl24+ssc5z6OPWYwEDx9Fk0lCPmJrn+lhtZSd9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733397;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=t9ToFv1U5mehhRTkZNs2QkV6dkObvZlpqjP/BncTlJI=;
	b=vyeo09iGIqJH6iL51lFNfREcJNPzpO/FmxxdIx3iVoR3Kt0zj6vZas17ICE18elPC3NJ
	 7DVJ+TCUArNf9d0Z7kI9SvEukeXpPDEDAs7K3TXfAQGvLqzr9LZD0vnheLgeQPK3kl97Y
	 2ToyNs8X+SiBaBhtBrd8YkKfMOR9FGabTroXt5YPb4c6EFnUChByl6BiIrgHhUiOQIfWt
	 gDeoO1DlqEcOdrs5oC9zbuyT+VLWERhA8/Tq9jjwPiXyDXCanVi378+t8fYMpC1NTfB4F
	 2d/yIRq8QUu3gNpQudzP7sUhNa2fA/JN8rUdAmAQlL9n3NR3uD/G6tfSCyAfpfbJaLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=joshtriplett.org;
	spf=pass smtp.mailfrom=joshtriplett.org;
	dkim=pass header.d=joshtriplett.org header.i=@joshtriplett.org header.a=rsa-sha256 header.s=fm3 header.b=Ge5sc9nJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J4P6wWaF;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA27606A326
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 19:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA27606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=joshtriplett.org header.i=@joshtriplett.org header.a=rsa-sha256 header.s=fm3 header.b=Ge5sc9nJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=J4P6wWaF
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C00E61D001A4
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 14:16:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 14:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1793733394; x=1793819794; bh=t9ToFv1U5m
	ehhRTkZNs2QkV6dkObvZlpqjP/BncTlJI=; b=Ge5sc9nJcUEg/w63fzjMAWlKOG
	0beMzUMG3k7lis/fkxYypwtRBB2pUibnrU0qbBpDzVVhJHqBw55B4XmMpwqpNu8/
	EGMttu3od4WrtFLFcCVQokLblQfk1WH/m6eM/I2JfhJ9JQdsIFWLxsx8XkpJKa5b
	zx2MbUCkOFzNib271PxZBKEJu9ccJg7JxxtaIvlMexai2tE9uOszhvjC/xM4uSac
	AfvxEmDXRCYN4aRMJZZdgXiRWJDQfT+op/c5Kv4weBf9uuaaonnBkr4sbHE08I01
	cS1hUCexyKBfQ4LrJnlEo7Wtxtkenr96gimn2qzygJlhs88bE8r5GfrKNVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793733394; x=
	1793819794; bh=t9ToFv1U5mehhRTkZNs2QkV6dkObvZlpqjP/BncTlJI=; b=J
	4P6wWaF6GYtsx6sYBObAYBK5zyPyEpB+kra8U/GYEmZnmBhWGOUeUrD83SC4XfhG
	FvvX0aTx24419hGckbryyUDuosD+pHwcKvvJEvsAUjyXVxcDJ+kKGGTeJJZf+IgG
	hzehzPEJxWtvR9Qb3ADQs78/aQPyaaUeX73W2CO4KXeT28YCBQAM/YarijgsTckt
	vx6pB1zf2G4YR85mh1OgMxrLAUVhyL4yE7AnpSXdqPMI3jcV7Tbkb8pWxFhDahcK
	2OpEFZ0p5LWpnSreibnK8LRT3Ah6fIA5IN9D0vg2Y03UPMAK1Nx7eYKzm1Y/fUYN
	dqv6+NjbQKszgo9tdMi7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=joshtriplett.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793733394; d=joshtriplett.org;
	mf=PGpvc2hAam9zaHRyaXBsZXR0Lm9yZz4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:dMW/4RsiHKNQ8th+ww4SrvDNCHEw585+MldY7w+cPf9gZiT
	HnVefNdsG84o2r37vOHmmYSwS/CL/vGIgkBSYoz0zgGBlFbMIiNvWVcfu7n5nZ+U
	9hHEBvoB4qvoLx545Dsnr0tt1yFhCdBgp58UDD0SyjHum1FBV9OO56evKGnCEtmH
	NucgmQOI5ROQRub9T9YRbzrr285Qn6QzQ62bFd9d9zJIu1K0GXQkRUFd1O/i/fo1
	3P27EUyqWP2k8N8K1UBIXrohXhHLSf+Mm5AT7GNnZt7sYQtbwH2yhhpE/dRdCuhj
	2TOVJc9GNTHfy1ZkNquDkOsVUcO1ijGVOJjptBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:RnhRYhLQPxBFQj1hyPcn3Tc/+wx/DiXD3uk7rNVEne4=:dMLjOXvXhSFH5FxSHgejzNH3PQiTtDIuduBfmicHl8M=;
X-ME-Sender: <xms:ETPqasBQfhhEXkM9fJcNRwMzLryw6p5Oeow3jPUpNDLBMi0mhL2Yhg>
    <xme:ETPqaq5hNRyOv9SWDGfUTlTNwKoajuX_Ojf8_bkGxvj2QyLnGxc-lzgAW0MSobwqm
    WhJHT7nEWpbji6bpJV4I235qWZch77m7GT6pqf93NY_pa-TWPafz_sh>
X-ME-Received: <xmr:ETPqakB8oCtmfpTiwuvHUqrh6DSEoO0OJvnmYy-f8CgLfDd6IZsNLOgkwA>
X-ME-Proxy-Cause: dmFkZTEeAUF+jeExjbpD9ca1sqlLHcyF2D7vsKe4wn7GV+2Q5L3ds20LnwwTE5ShV+v3RA
    76fnEffie4ozdDr0oL6Ps6X46b7pWjfPfZp6aWD+AmgyItGcqb1jH4g3FKguNDv6cbcjPH
    zMemOttMuWuxHwFlob6JjjJfzbH6xG1o5LUG4TSeA8LUVIjVXpE6ZObykcn4Lymjv8h++r
    mv0FCxEp9g/naXEsxDmZkQ65iFJvB5vCbXOGPM/XuCtC/WJvmN2WsVaujr38gyls7sjii4
    +fFhvPXDjAC6+3JUoYv1QZ0Gge20LBhXJSYLdEke/rhl53TyksgpgG103ROAc8CRqlbfHz
    Qmtk2yJElw7DGf1+9JShFP7qhaRurE2T/rn5ejfT8IGdqM3W/+VoqgiVMDXmQ1jwuK2RbB
    5jlBNE3VDQGcuBw6t+r3M+vDvDCSgw+oJJjyATDXi+5wXvO1dqHxSrwMPvRYTh6JIyEDs4
    jWX/mKwUQo1Xf+lkwPFjEId//xuP6guG6Is4DFhuTqIcFSWqODXARQKpJBMRz8yg9NLoAd
    KNIC9PhMkmqy2t4PGjjOHDVoJpk1bRlt5LRpBTVEK1cuo+ymDpKVZx3LwlWZ3mmKkJODUk
    jmWiBV4yj+ZmcNwNxsa3q19twO1jLCUiapccIzr80HYySwZ9+rRQaTfJgEQg
X-ME-Proxy: <xmx:ETPqag58K1WxtSV_a3zdVSXVrBInlEh6cQpZvgqpcYQeZL7VyaT6Rg>
    <xmx:ETPqatsFp4KFMbULCBdaQtYg1nQRNsegIdjVJ-eEU-mUuJYHd1JsAg>
    <xmx:ETPqal5kqxsiid9iaLnAriTuM7YGtgZg1rMLAq76bIbIb-dpHnUzEQ>
    <xmx:ETPqah01-WI8EKIStnp7tF7IvtromJpvgQvh6VkbMDSQdYFvhvA3xA>
    <xmx:EjPqakefiDNkt_Tjyw1PNHzjrn7jWLS5PzpTnXXS8DRSyyYEe6Qkv36j>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:16:31 -0500 (EST)
Date: Tue, 3 Nov 2026 11:16:31 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH for 7.5] pci: Support preferring MMCONFIG for all config
 space accesses
Message-ID: <e1b3a7d153da74d3c50d7c90696b2881f4c0e97d.1793727991.git.josh@joshtriplett.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Even when MMCONFIG is available, PCIe currently defaults to IO-based
accesses for the first 256 bytes of config space.

IO-based accesses are serialized, and can cause substantial scalability
issues when initializing a large number of devices on a system with many
CPUs. (Those often coincide, because many systems have PCIe devices per
CPU.)

Add a `pci=prefer_mmconf` option to use MMCONFIG for all config space
accesses. Also add a Kconfig option (default n) to make that the
default, allowing a boot-time opt out with `pci=no_prefer_mmconf`.

Tested on an AWS c8i.48xlarge system, with 192 CPUs, over five boots
with and five boots without.

Without:
PCI init 266ms
Boot to minimal /init 726ms

With:
PCI init 213ms (~20% faster)
Boot to minimal /init 661ms (~9% faster)

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Resending because I realized my previous submission was during the 7.4
merge window, and as a new patch this was obviously not meant for that
merge window. I'm hoping this would be a candidate for 7.5.

 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/Kconfig                              | 24 +++++++++++
 arch/x86/pci/common.c                         | 41 +++++++++++++++++--
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..afb77bfc96f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5079,6 +5079,11 @@ Kernel parameters
 				disable the use of PCIE advanced error reporting.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
+		prefer_mmconf	[X86] Prefer use of MMCONFIG even for base (<256)
+				config space accesses.
+		no_prefer_mmconf	[X86] Don't prefer use of MMCONFIG for
+				base (<256) config space accesses, even if
+				CONFIG_PCI_MMCONFIG_PREFERRED=y.
 		nommconf	[X86] Disable use of MMCONFIG for PCI
 				Configuration
 		check_enable_amd_mmconf [X86] check for and enable
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..f9ac4c1bf5cd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2905,6 +2905,30 @@ config PCI_MMCONFIG
 
 	  Say Y otherwise.
 
+config PCI_MMCONFIG_PREFERRED
+	bool "Prefer mmconfig for all accesses"
+	depends on PCI_MMCONFIG
+	help
+	  Use memory-mapped accesses for all PCI config space accesses where
+	  supported.
+
+	  Historically, Linux used legacy direct accesses for the first 256
+	  bytes of each device's configuration space, even if memory-mapped
+	  accesses were supported. Legacy accesses are serialized across all
+	  CPUs, so they can become a bottleneck on systems with many CPUs.
+	  Enabling this option substantially improves the scalability of PCI
+	  config space accesses.
+
+	  In the unlikely case that enabling this configuration option causes
+	  problems, you can switch it off with `pci=no_prefer_mmconf`.
+
+	  Even if this option is disabled, it can be set at boot time with
+	  `pci=prefer_mmconf`; this option just sets the default.
+
+	  You should say Y unless you have a very old system that doesn't
+	  support this. If you have a system that requires saying N here,
+	  please report it.
+
 config PCI_OLPC
 	def_bool y
 	depends on PCI && OLPC && (PCI_GOOLPC || PCI_GOANY)
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 63105b29fbf5..13e547f88d75 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -26,6 +26,13 @@ unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 
 static int pci_bf_sort;
 int pci_routeirq;
+#ifdef CONFIG_PCI_MMCONFIG
+#ifdef CONFIG_PCI_MMCONFIG_PREFERRED
+static int pci_prefer_mmconf = 1;
+#else
+static int pci_prefer_mmconf;
+#endif
+#endif /* #ifdef CONFIG_PCI_MMCONFIG */
 int noioapicquirk;
 #ifdef CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
 int noioapicreroute = 0;
@@ -40,9 +47,20 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val)
 {
+	bool tried_mmconf = false;
+
+#ifdef CONFIG_PCI_MMCONFIG
+	if (pci_prefer_mmconf && raw_pci_ext_ops == &pci_mmcfg) {
+		int ret = raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
+
+		if (ret != -EINVAL)
+			return ret;
+		tried_mmconf = true;
+	}
+#endif
 	if (domain == 0 && reg < 256 && raw_pci_ops)
 		return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
-	if (raw_pci_ext_ops)
+	if (!tried_mmconf && raw_pci_ext_ops)
 		return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
 	return -EINVAL;
 }
@@ -50,9 +68,20 @@ int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 val)
 {
+	bool tried_mmconf = false;
+
+#ifdef CONFIG_PCI_MMCONFIG
+	if (pci_prefer_mmconf && raw_pci_ext_ops == &pci_mmcfg) {
+		int ret = raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
+
+		if (ret != -EINVAL)
+			return ret;
+		tried_mmconf = true;
+	}
+#endif
 	if (domain == 0 && reg < 256 && raw_pci_ops)
 		return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
-	if (raw_pci_ext_ops)
+	if (!tried_mmconf && raw_pci_ext_ops)
 		return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
 	return -EINVAL;
 }
@@ -551,7 +580,13 @@ char *__init pcibios_setup(char *str)
 	}
 #endif
 #ifdef CONFIG_PCI_MMCONFIG
-	else if (!strcmp(str, "nommconf")) {
+	else if (!strcmp(str, "prefer_mmconf")) {
+		pci_prefer_mmconf = 1;
+		return NULL;
+	} else if (!strcmp(str, "no_prefer_mmconf")) {
+		pci_prefer_mmconf = 0;
+		return NULL;
+	} else if (!strcmp(str, "nommconf")) {
 		pci_probe &= ~PCI_PROBE_MMCONF;
 		return NULL;
 	}
-- 
2.55.0

