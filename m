Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6B347500
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557998; cv=none; b=HsJYUhFwWfkTf7MEWear8wMdDtlTv+kLIMF1CxF2RaqyZh4XuoyYS5dvPgQEsTf/KU4zj5phcddogXfrmt9DbWaFlXLlDnBTAhXipkO965/aK++tBB0J9lxzdJZDqx60ARcB4NyheQA6GkCOvX2gqglDZ+Hx9Za+/ZUe4L/N1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557998; c=relaxed/simple;
	bh=J4toCIxjuJ+khykwMfI/3PpF8SNfUzIvLaG4nnG6784=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4lfRUqurd11jeDBFBvtJzriouePULGH1ht1wyheMomX9CGJfQyG3DZ046T1+RvARMnnb/HpCR/B4o+JFkuRO+b4o9grCMVglk/Qnyzhd6ZhoXsZZTFhJFzq7wUO/eV/KKTyTxo7VkpX2G4geKWyIYBikWb77h3YEhDA30r7fQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaNp0Cu2; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaNp0Cu2"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1632840a91.2
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557996; x=1791162796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/CYz7uvuT/q6DGSFNNJURNLjDFD2MtCIi48nvGTm8s=;
        b=EaNp0Cu2NOvaMh/BI7yh4to0tlP30ibmqyPkMAMZPjZ58k/Z+5dY6ppIKaC/nmriZm
         IFpU4aTXYagxjq8zcMZiOmJI2mHc/UziBRYVwz85n55ZNs6PVVaHkwLGNsSSHbincs29
         r2d4z1YTlkAf0yJhT7Eo9KGnD5EJetN0YPljxVVwf/TlghFeleJ0q2J6Vw2/bLTeNqGq
         DvmC4/ecPaWqPn37IvKTYe4zA+DtEnffTxz8Ro+j2jyZdT0lsQ8j921iWgB7EYkUJ7rI
         x3XknYq+J/lBrFoqz3MPOHZL1wjOun7VSn1m9BZkqAh1LaAn1XXB2tSgq8DV4hVe294E
         jl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557996; x=1791162796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/CYz7uvuT/q6DGSFNNJURNLjDFD2MtCIi48nvGTm8s=;
        b=U+XKSyyA4Iou82hE94LgJIlTl+LUR6oa+GUcTM50XDqr468H1U5tdUYDBTTMw3/UGC
         yzEVTJ1/bwG4hHM8G9j4TXBYy/31SHQguhuTvhMzcYdQ6/Z78AwV/0lqWZ3eTSaAXABB
         u+p4ttN6CkBc6+i3lbsBl1mMlqmYNHrIqROw5G73mUm1Vznmz11fkpD9xHmK2onNMgVn
         kRkvOaXKEhQpyLyzIPj8rJMtfgA3qSF2HDIOP+CW7/oOvNk/XkF4NJ17B4nCbxcEU64Y
         nCrr8ZpDQMPsAKmlcgZIBC6W6O1k+x035dhklBEYzmgdxk59x/pWC9Ig4RFmPIFluTwa
         MP4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwfA1m0lurMKQFR1N8hUIcRUtqTQkankMQQ5CcBWQWgWPNg6ankW3ZfdLB7MSfvIidKuwWyVyVrIoM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiCEW18Ljxi/RZcDXxffJQoB4wpLwfPtSt+DQPwyJjbbAIerCe
	SlBtbkPyxnOZtLKfMpXZdDoiNnKL3jXHPsxDozg6GL4Syxfp89JfP4BE
X-Gm-Gg: AYBFou2emputtzDSX2b/uDKIg42TMZq7zYPBtQ6U0m23kiK5Dn0dVpJwywna0v6rlK+
	lieoqN2U1vWuMal9w2BN8nh/A84iKZaG8k3ZLCzAycqEHwbxzi6nPaOn0Cw8aLkAhiLN+hdrvKA
	uYeqQTymUBnTl2v2uwJwGy0QGUNyZd2bV7S6fW/xxAozql2CVOsDjE3VPGNIpA0Il8g6h1tQgVT
	lUAuRQ6NydH2JPGigwJw28WBBRYYu6Wc3UF/mtvLloYSZWmhHMm6v80Qsi9YKH2v4hyB+ZDFOk+
	XSN8NOB36hjc5anoR6+/6Dy9O/r0pYYJqd8yBigysKXr8i7tLvfI8mU2Cn1WLYsQofbG0VrDMfB
	5pPR9vUths8h9PL8xnOeuLqCSNTFRAkZ/g+BXiwRVSzE24v90IlDk6r/fLL/GpVpogxRrXZ3wXS
	JF3Pxto2St88aCE6tp7XnekWBnxPdofoVnUVnzNfQTz906D1nELnlIQYMAjos54MjRiiYoQlPJb
	XSPZnGleNyLcnhF9w==
X-Received: by 2002:a17:90b:2ccf:b0:3a0:cc33:22af with SMTP id 98e67ed59e1d1-3a0cc33259emr5273985a91.2.1790557995639;
        Sun, 27 Sep 2026 18:13:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:13:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 14/22] PCI/CMA: Validate Subject Alternative Name in certificates
Date: Mon, 28 Sep 2026 11:11:15 +1000
Message-ID: <20260928011123.450800-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
presented by devices, in particular the presence of a Subject Alternative
Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.

This prevents a mismatch between the device identity in Config Space and
the certificate.  A device cannot misappropriate a certificate from a
different device without also spoofing Config Space.  As a corollary,
it cannot dupe an arbitrary driver into binding to it.  Only drivers
which bind to the device identity in the Subject Alternative Name work
(PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").

The Subject Alternative Name is signed, hence constitutes a signed copy
of a Config Space portion.  It's the same concept as web certificates
which contain a set of domain names in the Subject Alternative Name for
identity verification.

Parse the Subject Alternative Name using a small ASN.1 module and
validate its contents.  The theory of operation is explained in a
comment at the top of the newly inserted code.

This functionality is introduced in a separate commit on top of basic
CMA-SPDM support to split the code into digestible, reviewable chunks.

The CMA OID added here is taken from the official OID Repository
(it's not documented in the PCIe Base Spec):
https://oid-rep.orange-labs.fr/get/2.23.147

Side notes:

* PCIe r6.2 removes the spec language on the Subject Alternative Name.
  It still "requires the leaf certificate to include the information
  typically used by system software for device driver binding", but no
  longer specifies how that information is encoded into the certificate.

  According to the editor of the PCIe Base Spec and the author of the
  CMA 1.1 ECN (which caused this change), FPGA cards which mutate their
  device identity at runtime (due to a firmware update) were thought as
  unable to satisfy the previous spec language.  The Protocol Working
  Group could not agree on a better solution and therefore dropped the
  spec language entirely.  They acknowledge that the requirement is now
  under-spec'd.  Because products already exist which adhere to the
  Subject Alternative Name requirement per PCIe r6.1 sec 6.31.3, they
  recommended to "push through" and use it as the de facto standard.

  The FPGA concerns are easily overcome by reauthenticating the device
  after a firmware update, either via sysfs or pci_cma_reauthenticate()
  (added by a subsequent commit).

* PCIe r6.1 sec 6.31.3 strongly recommends to verify that "the
  information provided in the Subject Alternative Name entry is signed
  by the vendor indicated by the Vendor ID."  In other words, the root
  certificate on pci_cma_keyring which signs the device's certificate
  chain must have been created for a particular Vendor ID.

  Unfortunately the spec neglects to define how the Vendor ID shall be
  encoded into the root certificate.  So the recommendation cannot be
  implemented at this point and it is thus possible that a vendor signs
  device certificates of a different vendor.

* Instead of a Subject Alternative Name, Leaf Certificates may include
  "a Reference Integrity Manifest, e.g., see Trusted Computing Group" or
  "a pointer to a location where such a Reference Integrity Manifest can
  be obtained" (PCIe r6.1 sec 6.31.3).

  A Reference Integrity Manifest contains "golden" measurements which
  can be compared to actual measurements retrieved from a device.
  It serves a different purpose than the Subject Alternative Name,
  hence it is unclear why the spec says only either of them is necessary.
  It is also unclear how a Reference Integrity Manifest shall be encoded
  into a certificate.

  Hence ignore the Reference Integrity Manifest requirement.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
[ Changed by AF:
 - Fixup a few issues caught by Sashiko
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/pci/Makefile         |   5 +-
 drivers/pci/cma.asn1         |  41 ++++++++++++
 drivers/pci/cma.c            | 123 ++++++++++++++++++++++++++++++++++-
 include/linux/oid_registry.h |   3 +
 4 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/cma.asn1

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 16abfd0e17e1..882cbb108364 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,7 +41,10 @@ obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o
 
-obj-$(CONFIG_PCI_CMA)		+= cma.o
+obj-$(CONFIG_PCI_CMA)		+= pci-cma.o
+pci-cma-y			:= cma.o cma.asn1.o
+$(obj)/cma.o:			$(obj)/cma.asn1.h
+$(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/cma.asn1 b/drivers/pci/cma.asn1
new file mode 100644
index 000000000000..da41421d4085
--- /dev/null
+++ b/drivers/pci/cma.asn1
@@ -0,0 +1,41 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Component Measurement and Authentication (CMA-SPDM, PCIe r6.1 sec 6.31.3)
+-- X.509 Subject Alternative Name (RFC 5280 sec 4.2.1.6)
+--
+-- Copyright (C) 2008 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.6
+--
+-- The ASN.1 module in RFC 5280 appendix A.1 uses EXPLICIT TAGS whereas the one
+-- in appendix A.2 uses IMPLICIT TAGS.  The kernel's simplified asn1_compiler.c
+-- always uses EXPLICIT TAGS, hence this ASN.1 module differs from RFC 5280 in
+-- that it adds IMPLICIT to definitions from appendix A.2 (such as GeneralName)
+-- and omits EXPLICIT in those definitions.
+
+SubjectAltName ::= GeneralNames
+
+GeneralNames ::= SEQUENCE OF GeneralName
+
+GeneralName ::= CHOICE {
+	otherName			[0] IMPLICIT OtherName,
+	rfc822Name			[1] IMPLICIT IA5String,
+	dNSName				[2] IMPLICIT IA5String,
+	x400Address			[3] ANY,
+	directoryName			[4] ANY,
+	ediPartyName			[5] IMPLICIT EDIPartyName,
+	uniformResourceIdentifier	[6] IMPLICIT IA5String,
+	iPAddress			[7] IMPLICIT OCTET STRING,
+	registeredID			[8] IMPLICIT OBJECT IDENTIFIER
+	}
+
+OtherName ::= SEQUENCE {
+	type-id			OBJECT IDENTIFIER ({ pci_cma_note_oid }),
+	value			[0] ANY ({ pci_cma_note_san })
+	}
+
+EDIPartyName ::= SEQUENCE {
+	nameAssigner		[0] ANY OPTIONAL,
+	partyName		[1] ANY
+	}
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index 6b52b129574e..6e4eb3b92113 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -12,6 +12,9 @@
 #define dev_fmt(fmt) "CMA: " fmt
 
 #include <linux/err.h>
+#include <keys/x509-parser.h>
+#include <linux/asn1_decoder.h>
+#include <linux/oid_registry.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
@@ -20,8 +23,126 @@
 #include <linux/spdm.h>
 #include <linux/tsm.h>
 
+#include "cma.asn1.h"
 #include "pci.h"
 
+/*
+ * The spdm_requester.c library calls pci_cma_validate() to check requirements
+ * for Leaf Certificates per PCIe r6.1 sec 6.31.3.
+ *
+ * pci_cma_validate() parses the Subject Alternative Name using the ASN.1
+ * module cma.asn1, which calls pci_cma_note_oid() and pci_cma_note_san()
+ * to compare an OtherName against the expected name.
+ *
+ * The expected name is constructed beforehand by pci_cma_construct_san().
+ *
+ * PCIe r6.2 drops the Subject Alternative Name spec language, even though
+ * it continues to require "the leaf certificate to include the information
+ * typically used by system software for device driver binding".  Use the
+ * Subject Alternative Name per PCIe r6.1 for lack of a replacement and
+ * because it is the de facto standard among existing products.
+ */
+#define CMA_NAME_MAX sizeof("Vendor=1234:Device=1234:CC=123456:"	  \
+			    "REV=12:SSVID=1234:SSID=1234:1234567890123456")
+
+struct pci_cma_x509_context {
+	struct pci_dev *pdev;
+	u8 slot;
+	enum OID last_oid;
+	char expected_name[CMA_NAME_MAX];
+	unsigned int expected_len;
+	unsigned int found:1;
+};
+
+int pci_cma_note_oid(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct pci_cma_x509_context *ctx = context;
+
+	ctx->last_oid = look_up_OID(value, vlen);
+
+	return 0;
+}
+
+int pci_cma_note_san(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct pci_cma_x509_context *ctx = context;
+
+	/* These aren't the drOIDs we're looking for. */
+	if (ctx->last_oid != OID_CMA)
+		return 0;
+
+	if (tag != ASN1_UTF8STR ||
+	    vlen != ctx->expected_len ||
+	    memcmp(value, ctx->expected_name, vlen) != 0) {
+		pci_err(ctx->pdev, "Leaf certificate of slot %u "
+			"has invalid Subject Alternative Name\n", ctx->slot);
+		return -EINVAL;
+	}
+
+	ctx->found = true;
+
+	return 0;
+}
+
+static unsigned int pci_cma_construct_san(struct pci_dev *pdev, char *name)
+{
+	unsigned int len;
+	u64 serial;
+
+	len = scnprintf(name, CMA_NAME_MAX,
+			"Vendor=%04hx:Device=%04hx:CC=%06x:REV=%02hhx",
+			pdev->vendor, pdev->device, pdev->class, pdev->revision);
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+		len += scnprintf(name + len, CMA_NAME_MAX - len,
+				 ":SSVID=%04hx:SSID=%04hx",
+				 pdev->subsystem_vendor, pdev->subsystem_device);
+
+	serial = pci_get_dsn(pdev);
+	if (serial)
+		len += scnprintf(name + len, CMA_NAME_MAX - len,
+				 ":%016llx", serial);
+
+	return len;
+}
+
+static int pci_cma_validate(struct device *dev, u8 slot,
+			    struct x509_certificate *leaf_cert)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_cma_x509_context ctx;
+	int ret;
+
+	if (!leaf_cert->raw_san) {
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has no Subject Alternative Name\n", slot);
+		return -EINVAL;
+	}
+
+	ctx.pdev = pdev;
+	ctx.slot = slot;
+	ctx.found = false;
+	ctx.expected_len = pci_cma_construct_san(pdev, ctx.expected_name);
+
+	ret = asn1_ber_decoder(&cma_decoder, &ctx, leaf_cert->raw_san,
+			       leaf_cert->raw_san_size);
+	if (ret == -EBADMSG || ret == -EMSGSIZE)
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has malformed Subject Alternative Name\n", slot);
+	if (ret < 0)
+		return ret;
+
+	if (!ctx.found) {
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has no OtherName with CMA OID\n", slot);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int pci_doe_transport(void *priv, struct device *dev,
 			     const void *request, size_t request_sz,
 			     void *response, size_t response_sz)
@@ -64,7 +185,7 @@ static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
 	}
 
 	cma->spdm = spdm_create(&pdev->dev, pci_doe_transport, cma->host.doe_mb,
-				PCI_DOE_MAX_PAYLOAD, NULL);
+				PCI_DOE_MAX_PAYLOAD, pci_cma_validate);
 	if (!cma->spdm) {
 		pci_tsm_host_destructor(&cma->host);
 		kfree(cma);
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index ebce402854de..113f4e802ec4 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -150,6 +150,9 @@ enum OID {
 	OID_id_ml_dsa_65,			/* 2.16.840.1.101.3.4.3.18 */
 	OID_id_ml_dsa_87,			/* 2.16.840.1.101.3.4.3.19 */
 
+	/* PCI */
+	OID_CMA,			/* 2.23.147 */
+
 	OID__NR
 };
 
-- 
2.55.0

