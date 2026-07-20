Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F63BED24
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580388; cv=none; b=f40JduI+ErjyatqM+oWbr8IsuzvOIRdG7y73+GMehWAOHAxdhN1JaOpUTSb/ivbBkk6M0aDUCJbv7AuaDx+hPPgtH2aeW7dy2Bd96sWX6+B6ESSZTllULxqzfrPROqzis+DFRI0RMM6PFOXitlk9SuiwDv2wHWZNBLkm/P5um2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580388; c=relaxed/simple;
	bh=ShSDV/KJtYRQmCnumfL3yH2eBc7NPzSDeoVK7xkU9nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnNnfBBbWvOJUPxgxjqzM4+fqAG9sK18MvUy0qu3PUfTo02xAqQz7zgnmox40FRFuVOyvEWS172dW9yJCNVR2XBWNAE+dTAg6EeKm0eFwS6oNF1t/WXivUgZaztaCbZJOcL5rFAj32rj3z4sE6Xfu+OLZlKQV9cHJnnPR71PKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOYfL9u4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOYfL9u4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1570D1F000E9;
	Mon, 20 Jul 2026 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580387;
	bh=aE2kNppi6KNqKYjvOjOfitNEsS4EvIPoy1Z1HpBTMwQ=;
	h=From:To:Cc:Subject:Date;
	b=fOYfL9u4Q1S9i/gAXr/vhZl8ELPGWY4vpyaCUMLVKO1lM1I9BSkhObQKzSjm/N4FP
	 dmAKPk4z8s4TlKvg/Yjo8oKv9oVg84GrZsvqj6M/MGXZBpH3gGVb6UX38vvkCywe4o
	 Ee0AabrXzYHTIljTtZCMolvbwFUIALzpaewUPq4kqP9ucfgi+W+QxiRtHYqW8OaORz
	 XcWooXJtlR9EtPVkuh8J1sgeq8ixrd2fyNoJbNJm56Smgo/B6D/SyaWQO3awlYA6gE
	 NeNAZAxie5OCTqPma6auZY1IOflIctvMKHvuWBKgI10gNLDgByz0fK4f11FUo1EGrr
	 cg+NM6PUXUNEg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/sysfs: Return -EINVAL for unsupported I/O BAR mmap
Date: Mon, 20 Jul 2026 20:46:24 +0000
Message-ID: <20260720204624.1503794-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, mmap() of a resourceN file for an I/O BAR fails with
-ENODEV on architectures where arch_can_pci_mmap_io() is 0, such as
x86, because the attribute has no mmap callback there and the error
comes from the generic kernfs dispatch.

This is a side effect of commit e854d8b2a82e ("PCI: Add
arch_can_pci_mmap_io() on architectures which can mmap() I/O space"),
which removed the mmap callback from the I/O resource attribute on
these architectures.  Previously the request reached the architecture
mmap code and failed with -EINVAL, and the same commit deliberately
kept -EINVAL for the identical operation on the procfs interface, so
the two PCI userspace interfaces have disagreed ever since.

Therefore, add a pci_mmap_resource_io_unsupported() callback that
returns -EINVAL and use it as the mmap handler of the I/O resource
attribute when arch_can_pci_mmap_io() is 0, so the failure is
produced deliberately by PCI code, consistent with the procfs
interface and with the behaviour before e854d8b2a82e.

Architectures where arch_can_pci_mmap_io() is non-zero keep the real
pci_mmap_resource_uc() handler and are unaffected.  The mmap() fails
either way.  Only the reported error changes from -ENODEV to -EINVAL.

Fixes: e854d8b2a82e ("PCI: Add arch_can_pci_mmap_io() on architectures which can mmap() I/O space")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..4cc082929d1a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1244,7 +1244,16 @@ static loff_t pci_llseek_resource(struct file *filep,
 	.llseek = pci_llseek_resource,		\
 	.mmap = pci_mmap_resource_uc,
 #else
-# define __PCI_RESOURCE_IO_MMAP_ATTRS
+static int pci_mmap_resource_io_unsupported(struct file *filp,
+					    struct kobject *kobj,
+					    const struct bin_attribute *attr,
+					    struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
+# define __PCI_RESOURCE_IO_MMAP_ATTRS	\
+	.mmap = pci_mmap_resource_io_unsupported,
 #endif
 
 #define pci_dev_resource_io_attr(_bar)					\
-- 
2.55.0

