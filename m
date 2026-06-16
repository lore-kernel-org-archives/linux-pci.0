Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299724779A7;
	Tue, 16 Jun 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627498; cv=none; b=LNB5leL1PWY88eg33L1lfLj+IcwudOWkV5WLMQz7NuDYbcbGFrMeaW1rp8LPWuhSqq7PE317WR6CIUE8gj6c2EtVr+Qo6bDZHPadyLfqtQvbTJTdPdM4fNXJZvH9+OVJPubXrZGIFWAgHWIdgHeU+ZLRlnpJp105QUeYynZUUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627498; c=relaxed/simple;
	bh=6LymVRRxUU4SFnO+nJpXtO2scRrpg09FjEcIbrFWeq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/NCfwAaEROZknhj8+kxM87RzbZAdKs/xAIDYXz/652PraKBVTCc/GMgkfHZ+8vOck6Qt8XPNzpKsp5dDPgMyV+dS4IxaFvXhJFTLE6i9J59adK62hZ/RIYmj0XEazX2RNY3DAq49eiPwgUZUVLRXOdlDvxOTw4YGaqDnCdeSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/MOK4O6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/MOK4O6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA8E1F00A3D;
	Tue, 16 Jun 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627496;
	bh=rfOBWu4WGt30uIecGlCElGeir0L2JNoVF0lc9QokdN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/MOK4O67K2skWmmisnBHBY2zXyU2PEUqFqnMpM3Ssx/4ta+m1Z64wnKK20cj7xSx
	 zoGibbH8IrTbIqXUXh/CoULhJRb6+2U42n08leeoyCgsRgSqHT3XYOX2FJh36iQEpx
	 SaXwoV2yCASCywmxxilxS/4cmUD3sB/PkJtP2z0hNqeZyjdJiIfxdmORa80a/2zb6M
	 Xj8vwybQcgHTuGSR9e93u5KkOXOsTOkW0zTVgUi9JVia4FjORIZOclxSa1vSt5DTws
	 BFHMYnUHcK9AZeEVMW8fC1SPJOS1TTV/cVjt6PNBwXAIY1qk/yx9dFXhOL8QepIyIn
	 mJhvf+DlTMa2w==
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
Subject: [PATCH 2/2] PCI/sysfs: Fix read byte order in pci_read_legacy_io()
Date: Tue, 16 Jun 2026 16:31:31 +0000
Message-ID: <20260616163131.2763281-2-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616163131.2763281-1-kwilczynski@kernel.org>
References: <20260616163131.2763281-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_read_legacy_io() passes the sysfs buffer directly to pci_legacy_read():

  return pci_legacy_read(bus, off, (u32 *)buf, count);

The PowerPC implementation stores the result as a native-endian integer:

  *((u16 *)val) = in_le16(addr);

On big-endian PowerPC this stores the bytes in the wrong order, so
a 2-byte read of a device register returns different bytes than two
1-byte reads at the same addresses.  The same applies to 4-byte
reads.  On little-endian the native byte order already matches PCI
I/O port byte order, so the conversion is a no-op.

Thus, let pci_legacy_read() store into a local u32 variable, then
copy the I/O port value to the sysfs buffer using put_unaligned_le16()
and put_unaligned_le32() for the 2 and 4 byte cases, converting from
the native integer to little-endian byte order matching PCI I/O port
space.

No changes are needed for the Alpha platform.

The legacy_io file is root-only and exists only on Alpha and PowerPC,
the two architectures that define HAVE_PCI_LEGACY.

Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b56000ba3a33..2354d09fd3fa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -908,12 +908,30 @@ static ssize_t pci_read_legacy_io(struct file *filp, struct kobject *kobj,
 				  char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	u32 val = 0;
+	int ret;
 
 	/* Only support 1, 2 or 4 byte accesses */
 	if (count != 1 && count != 2 && count != 4)
 		return -EINVAL;
 
-	return pci_legacy_read(bus, off, (u32 *)buf, count);
+	ret = pci_legacy_read(bus, off, &val, count);
+	if (ret < 0)
+		return ret;
+
+	switch (count) {
+	case 1:
+		buf[0] = *(u8 *)&val;
+		break;
+	case 2:
+		put_unaligned_le16(*(u16 *)&val, buf);
+		break;
+	case 4:
+		put_unaligned_le32(val, buf);
+		break;
+	}
+
+	return ret;
 }
 
 /**
-- 
2.54.0

