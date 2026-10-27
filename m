Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088898;
	b=RzJ+nZuEAwqHfFUWQfcLSUGy7x0SfGZDG5+CsAj/gisZI/Y8ftnIi8XlbsyXfFLvMnf1
	 cgV2IMyhCaRwcbysUO8r8liHG/+CbF8IoTWFsgaXxbtFJNbLTMIZbFg6orZof1KhfpL1r
	 /Ax7251/nPLhFCKCnQLeO9wjH1mAc5gKYQMn7gNTybVy0myYLQJFTybDX7XFjIJXclt0f
	 qNd3r9meXGIS/Xy+4wn3njjqE8GR7mHmynop2lBm+5vITkcxcG52Gt885mAiFOEK7+sAu
	 F/v9LhRCKdyikoPlGmQKRNq25UJl2ISvACBn6he+HMD19ml4LIOKbJ4CWJBGNuSglIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088898;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=DQ1O5D8XCRfscupgrJRVMbXZrkg6BlOL7s17MUvfBDo=;
	b=YeD+oP0NLclhx6QNAzS1YKIWVv8w9MObTl/NxCNxjXcX9NDaeaKwxooo6xEz13QKilgF
	 /wyDsnYvVO2RpFaXxTmL3F/4rxdVrJZnLNum+O2jgmBqLiNuJzHB9WvOKM2usSqJXj3hQ
	 YEfW0gAB5pc3oQd7t5S/J/2y+Y1UyJRMwb17wsQywZ83E3raQfP+5Lm3dBIsai0yteTOn
	 5nADSgOGAdXib+uTA4626uqa0cKTYNjhV9JvOEY4OyZJB9CZXP3znddYHyMcEYdg4oQfi
	 qD424aA6O3uOOMFNlJbc0CyIHUMQo02UmNL6ADxFRokU4VtVHlK1y1ivfiZnixyMGlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=joshtriplett.org;
	spf=pass smtp.mailfrom=joshtriplett.org;
	dkim=pass header.d=joshtriplett.org header.i=@joshtriplett.org header.a=rsa-sha256 header.s=fm2 header.b=1PS7tLLT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=a1863jL1;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E6606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 274E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=joshtriplett.org header.i=@joshtriplett.org header.a=rsa-sha256 header.s=fm2 header.b=1PS7tLLT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=a1863jL1
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7112C7A0111
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 04:14:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 04:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793088890; x=1793175290; bh=DQ1O5D8XCR
	fscupgrJRVMbXZrkg6BlOL7s17MUvfBDo=; b=1PS7tLLTgyk6mpr0iINctDgSoG
	2nuswQamfw0rQwoicPYTXtDUeEaOluQgJQKq2aS9CkT/eH8Aa2oo4jtl/EVSI72+
	WAO522rZMuL2V1dmJOkIy4Sdvvs3mFj+wje02jawolV/VsxXBzAJ8wLjDIXeF/G3
	Ky7Z5URLRXsTDWaZvMB9p3SZyXF1/IdOcvYAPQeD4qw+ZLTF0cWEUSmCnICVK7wN
	E8rNGPXzmEUZCIupwVl09nFje1LByc6AJ0D/vU6NuW/BUCHHFSwoJW/czUBgDu4v
	dL6MFzNgCE6Rx21XAYWNPg3o7R+/v0wVrjZpzOgWAzBsVqeXxIhhQT1aULfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793088890; x=
	1793175290; bh=DQ1O5D8XCRfscupgrJRVMbXZrkg6BlOL7s17MUvfBDo=; b=a
	1863jL1gJuQ/MtMvxXLIHdvUyB0uolILE92fvCNXSyfshY6dgFzz4jkATcFqhQYF
	wsh4PhGNS+oOMXESXeCUzrUQMlq8qM7mirFqqq2DBtbV564WvSJMdF5sfzR9SCF5
	gj6JWCRJFYsTFP1KVkO983Q2OuNV1/V2EP4oRqudRLYRTZTOOh730mpm6OEANHBM
	MGfQvMCtmqNm8RrGmhqJ6MQwpSBMsMEtLzDamHJTja1FNLJCK/6CnuzLXWSf5OwG
	pU7aWKj+cRoqOd2d9YyMqizRxFvrou01cjJlDGS390wnQCRfSCbmF67aRaCpxH9I
	o56fseEP8cO7Z9JmmWpPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=joshtriplett.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793088890; d=joshtriplett.org;
	mf=PGpvc2hAam9zaHRyaXBsZXR0Lm9yZz4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:N3mqICNKTNOZGpOG/z8HP03CMnsnVHIUkylPz/p47mgsBAl
	4QXgCNDpcG1KEtOGrZhytZxP5+u1HqKcYRHdtMbU3LceH9YNDq5r21Tgffg+QUdg
	YAoq7JPYsbIb7YHf9rXmOirzfhvLaYDVEx5b+x6M/DxTMtcSY9sPj9JT4HeMBukq
	1QzCS+bg7HUrLSysES+DuVyUVnFUMAKZe8C6sBo+z7AdlUucWkJQVOHkuz9UxA8V
	4SEaujQFVV8mGZmKI+LWr63wj3Hn/d/3LYgmrL6xHBra3C+HNvnRoJpr50B7sX0t
	FSYRPraNW6ZJQASZOimq1Qf8d9VWX6BPacnOJwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:X7GI2RF4A9VBkMYRS0wzaYT9U8SCUELBmSu7Wl6R3Xw=:V4DdvxFzeA6wC1TolVWuj0hyWB7hbsf5T4ZM7+HYRJ0=;
X-ME-Sender: <xms:eV3galXlcj_scSoU3Hqv1NADbVX05JVBYwSpcLbi3WypcbSxK8bAdQ>
    <xme:eV3gah-DMp9SrzsQreJosTVvxSkTCK_x4eVhtbswvvsox3qTVaJzWiP8MZVGsX0ej
    kIxcx7TJ7d7Si91co7IWzyTUyA8JA0KAr_UbLQa7UsDj6u3-VsoSpk>
X-ME-Received: <xmr:eV3gal0_ny_FAVYuRLc6-UTqRsQhbxpAK5SGok9edGWNdePmJl_I-Q8dSQ>
X-ME-Proxy-Cause: dmFkZTGrWbY5Vw0aiQoHkO8jbm2XLbZm9c2gvrh5uZvUCxmh6DJEUnUukC6n1U1R3OV6pI
    ZgLOzQnbLbtPesu2kZjA14WWItr0URYHFkBLWiv0V1PcXCxAs7dhWdvd4fymHMxsZORcy8
    nMkAOyBabtGGLWdZ7/vb+R5aQXr1e7PzY7uAQVnd9gwZHmtrPe2hSIrmjh8m/UoaxdPvMd
    f4GGz/D3ZEi/HjvRlHoFJ0vv10fjnZ9ok7j3bi7JUF6zCd7XDftGugpwCZM+WX9mG7Nq5U
    t4zl6GQUES7GfkhDvEz5Dhc6WfMFMrG3aKfBAHdACbvGJ3uD3U98gppyfRo9HU4Ce9Y2q0
    J01tJHY2olgVdQHnQHiDnpGW5iLCNS4/lUGy9c+wpVzvOBGzamRUt+ABfGXvUbBuQP7De/
    ZX0hLVTpoRp57UU6JpKuEkmAU7Ex4YZAWkf2cMWyO5rW4oJ63lweQ5FgT78lKfXHgjGLf1
    9cwuITXp55ltOfQugPfaetT8S4LMzgbso8MJ6r4ROFXVbxe33py0SRG2dov/HBJiEHFy8V
    4yKASewSfTBKxpbfBQTZ/DQc/lk/512yIy145abItHJowmLiHT8YEYG4JI+q3fc8pRm/UO
    u+8Gm4tHtFjQr2oG82dXFR5VELt0J6n8vNuFU7m9J3iAzIUfB7gZ9WwUkEPQ
X-ME-Proxy: <xmx:eV3gamedrPD0pEWewVTVAacbb1AHmJ7vZY2syW4mvT1qevLRtnbDUg>
    <xmx:eV3gasAupKgZa_gtyPD5Qx26qRlrVRdjTChKI9Yxhbdqh4bm3dMHQg>
    <xmx:eV3gat-LTwTlokUk7ZU74ElSMryzSsZtlb99P6OF9MnVBBPANfvy9w>
    <xmx:eV3gagrtRzXrPxzf0k4OxvVI1A0KQ_Zhw_Vtxh1c0KXelwVf1ZVwWA>
    <xmx:el3gauSKc-A-1SlO5eUMg4TfW0Y9_NX6XagqEj5apYL9_pU0GtZHv1X6>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:14:46 -0400 (EDT)
Date: Tue, 27 Oct 2026 00:14:45 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Support preferring MMCONFIG for all config space
 accesses
Message-ID: <a7d2b402784a409f5564c1fdce77a41e09f29280.1793087687.git.josh@joshtriplett.org>
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

This has come up a few times, such as in 2017:
https://lore.kernel.org/linux-pci/20170302232104.10136-2-andi@firstfloor.org/

We have even more parallel systems now than we did then, and the
performance hit from the serialized IO path hurts.

This *should* be safe everywhere. It seems exceedingly unlikely that any
systems need this. Despite that, this patch makes it `default n` out of
an abundance of caution.

I expect this to have even more impact on larger systems. I'd be
thrilled to test this on a 384-way system, if I had access to one. If
anyone at AWS would like to approve quota increase case ID
179306079200327 so I can test on a c8i.96xlarge, I'd be happy to test
that. ;)


 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/Kconfig                              | 24 +++++++++++
 arch/x86/pci/common.c                         | 41 +++++++++++++++++--
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d0f174288365..64a138ea8f54 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5018,6 +5018,11 @@ Kernel parameters
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
index bdad90f210e4..e8f2d02562ed 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2888,6 +2888,30 @@ config PCI_MMCONFIG
 
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

