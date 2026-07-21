Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387435DA77
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599474; cv=none; b=oJJZn5SlIQOEi6AzP/hqn+VUebuq7hzBUSuL8G+Q0Z4b18q4ti11jDvfhqf3lc1ES1VMktNNYoDLoeKy/aEn8nqlsBkn7d48S3zdtAHRXUHx05cJMvZEFXpYqUKAm9Y47uK0ToOJ+UI4rJkkfriiAZkZCKJG5bxm2Q1NSvBaUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599474; c=relaxed/simple;
	bh=k2c42uhrg5RGbFv5xlJv4UvcMUKbGQFNHC4GXNo/DIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5NgFletwxefaTE335FL2mi++Hhr0k5ZlJ9vuIN2WWqkCGkIqHixKVsVc3xDNq/OloEm5io3BVpm+kGHjXvUBr2+0vPPeTMoPgOZJIHK4E7b5zQQ/GXbM/ZHQwUX1qD9XrH0ojpVRAGBy0PUecVer9GZ0bWvCF3Vy27G0OXT7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8xVuJ/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8xVuJ/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADE21F00A3A;
	Tue, 21 Jul 2026 02:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599473;
	bh=MavKVSGjSyiAWlUJC2qYZAVGHnAaWhyVxvHL6bCGyYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8xVuJ/uMtHMCQyW/syPaPMTzHh+8Ji6QMWFVbXOKo0cc0n6RxKIKP0GN3PeL5BhN
	 qgohbwRr/7EQz6Az0h7Q4HQnY3TLrSVsTnqNTGjywWHoskWrXNKNBOUf0cxOHecIW5
	 iQAty6vSVl4TxywqS70piRVqtdIsLhEWR5uOp/RME2Xtivk+DSn+Hb2zTCUmaQmU5I
	 9Sp8vyLoVBhrkL30EsJrKBbU2AA7Vcp0DOWX42ylpx2M47zKtGBIFdRqgtWluT0esd
	 XyyzwNAFsC9joSGGvMsKq4yBG1eML79u8xpbS6zmAbOkmKg6y5rYRmPZLSN+l33Axa
	 FTz7l9lZh+vBQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/3] alpha/PCI: Make the suffix the first __pci_dev_resource_attr() parameter
Date: Tue, 21 Jul 2026 02:04:25 +0000
Message-ID: <20260721020427.1541197-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721020427.1541197-1-kwilczynski@kernel.org>
References: <20260721020427.1541197-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the __pci_dev_resource_attr() helper macro takes the
attribute name suffix as its third parameter, even though the suffix is
what distinguishes the three attribute variants built on top of it.

Additionally, the pci_dev_resource_attr() wrapper passes an empty
suffix, and with the suffix placed in the middle of the parameter list
its invocation contains two consecutive commas, which checkpatch.pl
highlights, as follows:

  ERROR: space required after that ',' (ctx:VxO)

Thus, move the suffix to the front so that the variant selector comes
first and the empty argument follows the opening parenthesis, which
checkpatch.pl does not complain about.  This also matches the parameter
order used by the PCI legacy I/O and memory attribute macros introduced
in a subsequent change.

No functional changes intended.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 94dbc470cd6c..37cba711ade5 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -102,25 +102,25 @@ static int pci_mmap_resource_dense(struct file *filp, struct kobject *kobj,
 	return pci_mmap_resource(kobj, attr, vma, 0);
 }
 
-#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)		\
-static const struct bin_attribute					\
-pci_dev_resource##_bar##_suffix##_attr = {				\
-	.attr = { .name = __stringify(_name), .mode = 0600 },		\
-	.private = (void *)(unsigned long)(_bar),			\
-	.mmap = (_mmap),						\
+#define __pci_dev_resource_attr(_suffix, _bar, _name, _mmap)	\
+static const struct bin_attribute				\
+pci_dev_resource##_bar##_suffix##_attr = {			\
+	.attr = { .name = __stringify(_name), .mode = 0600 },	\
+	.private = (void *)(unsigned long)(_bar),		\
+	.mmap = (_mmap),					\
 }
 
-#define pci_dev_resource_attr(_bar)					\
-	__pci_dev_resource_attr(_bar, resource##_bar,,			\
-			    pci_mmap_resource_dense)
+#define pci_dev_resource_attr(_bar)			\
+	__pci_dev_resource_attr(, _bar, resource##_bar,	\
+				pci_mmap_resource_dense)
 
 #define pci_dev_resource_sparse_attr(_bar)				\
-	__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,	\
-			    pci_mmap_resource_sparse)
+	__pci_dev_resource_attr(_sparse, _bar, resource##_bar##_sparse,	\
+				pci_mmap_resource_sparse)
 
 #define pci_dev_resource_dense_attr(_bar)				\
-	__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,	\
-			    pci_mmap_resource_dense)
+	__pci_dev_resource_attr(_dense, _bar, resource##_bar##_dense,	\
+				pci_mmap_resource_dense)
 
 static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
 {
-- 
2.55.0

