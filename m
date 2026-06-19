Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E318FDBD;
	Fri, 19 Jun 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859140; cv=none; b=s/cYQBwJ/RoJdzUbNHCbVSJRMbgCv6kvkrTCgR/38ZkcfucEG5RkYkxGJxgPOrxXztlJ6Wxxc/pCf9R4p9WgNMWn30spFs9oqyc7BG21Wj9zQOXdGqeFp31ugvQKNmvB40X8bodB901ebs4XjR0c3cAbhOGd2PhOlIvEA4bmaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859140; c=relaxed/simple;
	bh=im9Vn3gtovnQ43+zgtWx6f84+VVW78Es3AfaAKaONdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7xjyrPgRp/nGPp/WNAPs4t9AdAIQwCcZicT84tS/modcLQk9u4kRlvHjtm8z6N0HMIt4Z4I9klEUrMzgbuLerUjITI3wtu5l/l46U6pCE5uhq+QIGs+v00vVDsZtOZqU4YZeE/2YTkaNmtgXrHLZnfWh0g2yfeRgdRnH4SoP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW4kBCdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW4kBCdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F07C1F00AC4;
	Fri, 19 Jun 2026 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859139;
	bh=hL5eYVsSUY1Is3NsEHFXNssm619EpveDtS/ShwL5AvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YW4kBCdiHYTHfFH9rK5KUGN4rtaCMSSInNBjv7DcP5WkWPht3N2qGueMytdws5nXX
	 wqMq9vGI4qNnSP9f0T0vnfGiq8eS0q4Uk/qeGyFd9WhH8DIq/d6s7+AHUZklaRBqHf
	 AB/SkwQtgEtnNem5jiDpyPO4ptHfePEKSntBMWDTQ27ZMeSDwFhPlSyUG1rUPWJws0
	 bG1knsJofLCS9DyL6HYWNFZH3Es8wnBTGz0X01JQTMeJwsZQ2oBR4g11Nfyw0g/INJ
	 0D3znnyEXRLfWWWUS7eH3HC5e+oaBBWJPPDf1ij+8WwNIiJGqXFhoVHVYmOhyxisaf
	 bWJSI7LUfkMUA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 04/25] PCI/sysfs: Split pci_llseek_resource() for device and legacy attributes
Date: Fri, 19 Jun 2026 08:51:39 +0000
Message-ID: <20260619085200.3729431-5-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both legacy and resource attributes set .f_mapping = iomem_get_mapping,
so the default generic_file_llseek() would consult iomem_inode for the
file size, which knows nothing about the attribute.  That is why custom
llseek callbacks exist.

Currently, the legacy and resource attributes have .size set at creation
time, as such, using the attr->size is sufficient.  However, the upcoming
static resource attributes will have .size == 0 set, since they are const,
and the .bin_size callback will be used to provide the real size to kernfs
instead.

The legacy attributes operate on a struct pci_bus, not struct pci_dev,
so calling to_pci_dev() on them would be invalid.

Thus, split pci_llseek_resource() into two functions:

  - pci_llseek_resource(), which derives the file size from the BAR
    using pci_resource_len().

  - pci_llseek_resource_legacy(), which uses attr->size directly.

Update the dynamic legacy attribute creation to use the new
pci_llseek_resource_legacy() callback.

The original pci_llseek_resource() was added in commit 24de09c16f97
("PCI: Implement custom llseek for sysfs resource entries").

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2e4e226e78d4..2280b7edb41f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -881,13 +881,26 @@ static const struct attribute_group pci_dev_config_attr_group = {
  * llseek operation for mmappable PCI resources.
  * May be left unused if the arch doesn't provide them.
  */
+static __maybe_unused loff_t
+pci_llseek_resource_legacy(struct file *filep,
+			   struct kobject *kobj __always_unused,
+			   const struct bin_attribute *attr,
+			   loff_t offset, int whence)
+{
+	return fixed_size_llseek(filep, offset, whence, attr->size);
+}
+
 static __maybe_unused loff_t
 pci_llseek_resource(struct file *filep,
-		    struct kobject *kobj __always_unused,
+		    struct kobject *kobj,
 		    const struct bin_attribute *attr,
 		    loff_t offset, int whence)
 {
-	return fixed_size_llseek(filep, offset, whence, attr->size);
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	int bar = (unsigned long)attr->private;
+
+	return fixed_size_llseek(filep, offset, whence,
+				 pci_resource_len(pdev, bar));
 }
 
 #ifdef HAVE_PCI_LEGACY
@@ -1022,7 +1035,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
 	/* See pci_create_attr() for motivation */
-	b->legacy_io->llseek = pci_llseek_resource;
+	b->legacy_io->llseek = pci_llseek_resource_legacy;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
 	b->legacy_io->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_io);
@@ -1038,7 +1051,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
 	/* See pci_create_attr() for motivation */
-	b->legacy_mem->llseek = pci_llseek_resource;
+	b->legacy_mem->llseek = pci_llseek_resource_legacy;
 	b->legacy_mem->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
-- 
2.54.0

