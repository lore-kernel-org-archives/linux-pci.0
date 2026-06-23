Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D893A8759
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190582; cv=none; b=RxiooCizFnkjc2SgoPxGW1pDfr2y/i0DmZ21FgKdfQ+Rs6ub65GUGkiGJke2Eegf0gtbXoyC+zsoFjuwcWZ/WjtVC3/ZwcUZSAPr24u6vroyAX4lfETnKDi6yPtiMc04dbh7hPmqbY2Vwe6ayUbIS2szgQfMk6YgoHOw0dUwCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190582; c=relaxed/simple;
	bh=kW3AUL59Hr2tTRyQXaIlPnvXCxNktm7uV1VWmniiAks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBc+ac92ztXJbpY/bWDxdbMOj/AXHhFoSg3OMe8LkmDo8ysN/KgOQREDjvtDUK2tLeT5UIeD54f4JXBGytlTh01LxFPcJ4X/Y/3YQBghNmNINMC9ACzSSj7fnl4SkJYlYfuKH9Nu3QwNMZtA0YpFSBXdqtKjmUvnMexa7HyMo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj//3qBj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj//3qBj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so2155937a91.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190580; x=1782795380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EFKcg4T6UAua6CQ92GlOR9TwUuAVvHOoOJMKw5miVY=;
        b=gj//3qBj9Pa2gErEC4epBHXPv3v0d5eR7PYT6yXHuK44JE+WjB2hTtdDKOEPEPnimK
         HiNi05I0yNmOVnqRuQ6kHP14QveKo+9pkYJi+xdTaHqeVs2f4fPc8L9XIKAuqxPoTTfN
         TcQLIg4Xv0pJXffuXdD/29flqtuptWZmEk1sN20rBECzTivjh4DMyf02NuAcHJg9/Y9Y
         gniDZpUDX1bol8s1YjObsSwPFq9A7LyKOUl55q9cw15tm34hyGn+EhGdxi4jQhGtPjD/
         uraD7MtU/X78XxirhKzpQe1FMowKREKHOo89gekowEHbRTOpyCMfPvGYcRmFveTtEec3
         WD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190580; x=1782795380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0EFKcg4T6UAua6CQ92GlOR9TwUuAVvHOoOJMKw5miVY=;
        b=URePRxnjgQquyCF2sS25Yi+Romuuz2yk+ZLRIsr1QO+2vLxT9jfPvD46ous3T17vNA
         R6B6BzgfVsWA8XVPqQYu8Rk9vCMCkQibiCkBD+B6irFyiuagtY6Fu083rj9LGjVGn9or
         kquat8HNGP5Yp1+Pe66BTfWU6MR5I/MlypQe2MUoGptYj/wJp2qumITD4aSkHwcWYeeB
         CEJsJab69gsrPKUZbxoM6FRjCSWHEn+GbHhfkTQDbErhRWNL3sKONav8PTYLkM1wwqfC
         tvBwygvg8g+w1qeoA8XKMgBhmsNiWNOdEKyHx+BFjk0jAOlbemxZaB6Ddj8Ku9Ik/RnY
         W+qw==
X-Forwarded-Encrypted: i=1; AHgh+Rov5HyKR6azfkCxeB3sa8n6f/FJmOa3ipwtN65mAqTeAt6e1+fHMcz7Ssv3eep/BVJiv3nQUNX8tl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLI/LDBST6zmplAv9WHZXqgD7q8JUzURKoZniswlq/T8067cxd
	7x50W3LDn38ynVCRlVS7MFFwVygDP/jsjayG+jVBv+75A/jcWF83tX/j
X-Gm-Gg: AfdE7cmJzdjBhxvttoX9Vpz7CTmzKB2KUxfnlUdjIyew2LOawk6SwOvgzMRNrWifIaF
	kMc9I1vbaryG2rXcWdJeYQ72wD4WJA5Oc4taQadP0slPlzlcwHUTcSKuivhM3kXVGXGgkXz9Wre
	YGC07+3ErvztsGfDRWLreSpOq8E6u0+4r5IH3gwWoHD9NFOplxZvgXNrUFxKWP8GBtzn7aNgB5z
	EZJqsd/8ibI7Kcd02eUNUVuxWMrVu2hOpIu39z4AkngVPTzm5byyjnx1Dj37n9/h8o75liPquWv
	IrZ9c3L8D8t2Up5xC1V/J2jcShHz3C8LffvNLf8YN4Z6qLsdVff3kQoYCtWEdYgvXkfIrC9S4oe
	GA8rJzhzWl64PEz0wu3a+thu7p6l4FxwhfbyR0ki49nb/iJ1qv7ZixcdkVhclxXePEEUSvY7KyA
	w1RwudvFRgv9kGvDWbp6A7yxOlqSDIwxcz2IVjDZ2Q
X-Received: by 2002:a17:903:41c3:b0:2c6:bb55:4078 with SMTP id d9443c01a7336-2c718c88c55mr189612095ad.8.1782190579525;
        Mon, 22 Jun 2026 21:56:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:56:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 13/21] PCI/CMA: Validate Subject Alternative Name in certificates
Date: Tue, 23 Jun 2026 14:53:58 +1000
Message-ID: <20260623045406.2589547-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
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
index 9f2cc0b2ec8a..39a858436b28 100644
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
@@ -61,7 +182,7 @@ static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
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
2.54.0

