Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68B4502F;
	Tue, 16 Jun 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627495; cv=none; b=CAzYZMrD6oeQ2PkTZ7OeUn8GZryKM3SvgA71cTrkgbTm3qkyMzBa64CcjLAlo1N5MLWSyZ9jTfwqrOu0tm48v0EpFrdWNYjBSMoGfa2PogqvQRrwTBFX9NChCi/pmCi0nycTZnSSwrPMNd9nPVlvQc2c3uTgQCdAwemSLzIzcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627495; c=relaxed/simple;
	bh=/rDWOMH899sogs/UaWmzwVDkPQTfRX06NFsU2fxEueU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qf2YKEQsGg5M1BVLoGRJfgydq+DKbDWGF9LBFnJS0XxgyKnEMrNFcYuUw42474F+WJSjH0OWG5uFwuJh0mbAB5hBwegjBHP7ORP8VUUP+XKl6M/FeYbeGOY/aesJHPNGAwVVUSvf2kaNRplMMiwANwWJLUCpUP1WN1s7hTGjzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeOtgSdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeOtgSdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007BD1F000E9;
	Tue, 16 Jun 2026 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627494;
	bh=Aozp2zOujumcKC8wqP2GFQ/wgspA7yyR0yTI4pEy3A8=;
	h=From:To:Cc:Subject:Date;
	b=PeOtgSdipUz/dqe4naZWkmAQOeCNzvh1py/zkymBX8MZu8AKlymel6AcpyGAOgS/1
	 fjFdjZqZ9ldDhL3U0F6LsVafxqeScMQbRTioRZ1Zf1TXd0C3khnuvtEEGH1N/nYGXw
	 M+2FMv6tTj0aAyaR8kV+1C55ettjtdzibRFOy9AwMcisxJiuhPuE8Agw2b7aHMP5Ya
	 0tWtSq+RH28C90yALpvPZqXJJtqDd8B9mBPauCCRpGO8mPF5n8+JDrh/rWzxM6usLQ
	 UidwkO8Ss7VvC1tBVLmcnNfeNmBmW72fTQoDLKH7KbaHHRFSK8kXg22YRiazdLIsJI
	 LyiJ4yGO7piKw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI/sysfs: Fix out-of-bounds read in pci_write_legacy_io()
Date: Tue, 16 Jun 2026 16:31:30 +0000
Message-ID: <20260616163131.2763281-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_write_legacy_io() loads 4 bytes from the kernfs write buffer
regardless of how many bytes userspace wrote:

  if (count != 1 && count != 2 && count != 4)
          return -EINVAL;

  return pci_legacy_write(bus, off, *(u32 *)buf, count);

kernfs_fop_write_iter() allocates the buffer with kmalloc(len + 1),
so a 1-byte write to the legacy_io sysfs file allocates 2 bytes and
the unconditional u32 load reads up to 2 bytes past the end of the
allocation, which KASAN reports as a slab-out-of-bounds read.
Similarly, a 2-byte write overreads by 1 byte.

Thus, read only the number of bytes requested using get_unaligned_le16()
and get_unaligned_le32() for the 2 and 4 byte cases, interpreting the
buffer as little-endian to match the byte ordering of PCI I/O port
space.

The PowerPC implementation previously compensated for the generic
code's native-endian 32-bit load by shifting the value into place
for the 1 and 2 byte cases.  The shifts were only correct on
big-endian kernels.

On little-endian PowerPC (POWER8 and later), they extracted the wrong
bytes, so a 1-byte write wrote an out-of-bounds byte instead of the
requested value.  On big-endian, the native load also caused out_le16()
and out_le32() to reverse the user's bytes on the wire for 2 and 4 byte
writes.  The little-endian helpers resolve both issues, so the shifts
are removed.

No changes are needed for the Alpha platform.

The legacy_io file is root-only and exists only on Alpha and PowerPC,
the two architectures that define HAVE_PCI_LEGACY.

Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/powerpc/kernel/pci-common.c |  9 ++-------
 drivers/pci/pci-sysfs.c          | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8efe95a0c4ff..fdc57fa2ece6 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -626,19 +626,14 @@ int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
 		return -ENXIO;
 	addr = hose->io_base_virt + port;
 
-	/* WARNING: The generic code is idiotic. It gets passed a pointer
-	 * to what can be a 1, 2 or 4 byte quantity and always reads that
-	 * as a u32, which means that we have to correct the location of
-	 * the data read within those 32 bits for size 1 and 2
-	 */
 	switch(size) {
 	case 1:
-		out_8(addr, val >> 24);
+		out_8(addr, val);
 		return 1;
 	case 2:
 		if (port & 1)
 			return -EINVAL;
-		out_le16(addr, val >> 16);
+		out_le16(addr, val);
 		return 2;
 	case 4:
 		if (port & 3)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..b56000ba3a33 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -933,12 +933,24 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
 				   char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	u32 val;
 
-	/* Only support 1, 2 or 4 byte accesses */
-	if (count != 1 && count != 2 && count != 4)
+	/* Only support 1, 2 or 4 byte accesses. */
+	switch (count) {
+	case 1:
+		val = *(u8 *)buf;
+		break;
+	case 2:
+		val = get_unaligned_le16(buf);
+		break;
+	case 4:
+		val = get_unaligned_le32(buf);
+		break;
+	default:
 		return -EINVAL;
+	}
 
-	return pci_legacy_write(bus, off, *(u32 *)buf, count);
+	return pci_legacy_write(bus, off, val, count);
 }
 
 /**
-- 
2.54.0

