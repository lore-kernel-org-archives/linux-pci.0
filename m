Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585822;
	b=jmmZ5NlWcTXwiKvtJORagXngv8RjEVT8RH6TORJ+gzL+ofQ7J61ut7/8vx7jEeelR2T/
	 Qy8qrT2cEiFsABIn9xR2UiSs4N++RhqYCnsvVxnoABX4IrNENR/TYdcL/XN9UPgFm0C4V
	 ZfJSyAPylsBmagE5GjAckQD+jUfgahmA9UFgH5/6YsYIhGxw60mRoJQuI37WCy0WDo5cO
	 FTJAWP+OVmVTCDzsL/VYZW3x6cpz2jNXuD2zO1uosUtGeQlXeysfrlctih73OVR9426sb
	 n/JaFUeJ3Zs/x5h/wMnlxmzNrfmmAgS5jRKCn6OeYTlYAZDgoEnDOlK0JZNZRXjyiBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RRd33+XEcq4pKriFON0uSxTbfftuE/2w5ZtcZY7JL4o=;
	b=hKTMrTl8n+mP9b5mJiXtqRfn6dx+e3w03Lj18x+U/CcAvW5rvY9XFyeUiw4zUXjTeg5y
	 No8XMfLbTRNuDAiwtDbhvYlBmYfTS5JsA4+HqSj7KOpXzme+Z0QQVxgzX5Z+pmnpIBO+B
	 7vqbLX1vLOYaSsO3SsZbseYgcfrVxVjrhZMzMtT/KPfxBIlL6qneV+gGZgCk0VE+x4WmX
	 CPhS50jhx5BVyFsCZ3VqeElX5nnAta9ZawNfOb2qum5Wh5YCY4xJCmiSreqkioH2Tdti7
	 xvseMbosuCk6zTvrzztfQGNSshgD1Xik2VcUo9kuRwbI5AVheGz0bvuTp2BFU3WPRnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QoZsCaZs;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318F606A33C
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 05:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A318F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QoZsCaZs
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso4900376a91.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 21:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795585821; x=1796190621; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRd33+XEcq4pKriFON0uSxTbfftuE/2w5ZtcZY7JL4o=;
        b=QoZsCaZsnfO++l4IySdISChkd2Fxze8jULoZ8Brl4/jC1eicd+DWKt5ejgfVex8zFp
         nUNiOCCOH6IZN3QtkhU/ha7pafkrqQxdfPQtie4MlkDnlq63MDzrVqQmqSd+jctrlJ/3
         kxEUnbMZ+SSFffax5LifBi6cVJyIHssSE51G8j2x5O/TUQfWythDFdoZ9hPr+veKjGyR
         aggN2S7KvtO5HeyUOXpRmb2N3bODWerA2lRYiDQNNvZFbc+/qeLiEtq8DOkZy8m2Xkck
         SFdsw55JpIx8z9uQNPyybGx2n7wfsxsjOfN5HzrmERtzqm5yiQxWerAiiuJA3EsACGRp
         sQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585821; x=1796190621;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRd33+XEcq4pKriFON0uSxTbfftuE/2w5ZtcZY7JL4o=;
        b=x6V13JeDrEFG0J6iWvmMrdBArY65WKvmOY0GiToixUB+5oVDr1NV+vMRUVGWE0EEbY
         KkbyZ0PKAcQoiVvaPJ5jOCVN/WEaDQCHWkHbR8UksTVXxHDIT+SAJob1BVkrnD5BM0PL
         9vjBj43AJzARGehowj9BKuzGaxvou8vGk4D1XjlSmGJXDJI6iVWpbicTKIWD0W5UnYDu
         xicZN7IKVDAoJUK36ueXNABma3Q+CMeK1X7MxCtYAcm5nbaLu9LylkEUTnseUAUMnVlr
         Du3g1tmzIqwljd23ae/xMyf4Ek58Cvu6GU2Ypxf+Otslf1DLsQM+SKJ59dBxCohw0rQ3
         01zg==
X-Forwarded-Encrypted: i=1; AL+hErHDIjGEsgDVjuW49JyFt7gBGMWLzj49tbA6K5t1XYbtkB31eZ8UB1KTsX9/vVo/RbEVIBbmdE/gi2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HzX8RhTkeCnfT0UvtiYakCRnbQGcWkCj92JsqzOEIZjevhd+O
	Uv6lfwH2M0EzKhR0RLil+3ASuhzG6g+cTbjG8/DBaQaa/TgRSGfosPaQiOhJnJ3Di9zWP3w3VBq
	MSntp03OhZg5jbMuE9/KnsMIsWn8xC/aUgg==
X-Received: from pjyu14.prod.google.com ([2002:a17:90a:e00e:b0:3b4:128d:a03f])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1802:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b41c959dfbmr15898646a91.52.1795585820750;
 Tue, 24 Nov 2026 21:50:20 -0800 (PST)
Date: Wed, 25 Nov 2026 05:50:19 +0000
In-Reply-To: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261125-fix-aer-mask-override-v2-1-fb5931dc9462@google.com>
Subject: [PATCH v2 1/2] PCI/AER: Make aer_mask_override effective for injected errors
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Prarit Bhargava <prarit@redhat.com>, Huang Ying <ying.huang@linux.alibaba.com>, 
	Terry Bowman <terry.bowman@amd.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, Daniel Pereira <danielmaraboo@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"

aer_mask_override=1 is supposed to allow injecting masked errors, but
aer_inject() corrupts the hardware Mask registers with "&= !" and
restores them before irq_inject_interrupt(), so aer_isr() still drops
the error as masked.  Emulate aer_mask_override in config space reads
and writes instead of modifying the hardware Mask registers, and
document the parameter with MODULE_PARM_DESC().

Fixes: 457d9d088b02 ("PCI: aer-inject: Override PCIe AER Mask Registers")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer_inject.c | 74 +++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 09bfc7194ef3..a71313964c66 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -27,9 +27,16 @@
 
 #include "portdrv.h"
 
-/* Override the existing corrected and uncorrected error masks */
+/*
+ * Allow injecting errors that are masked in PCI_ERR_COR_MASK or
+ * PCI_ERR_UNCOR_MASK.  aer_inject never writes the hardware Mask registers
+ * itself: aer_inj_read_config() emulates the override and
+ * aer_inj_write_config() keeps the emulated value from being written back.
+ */
 static bool aer_mask_override;
 module_param(aer_mask_override, bool, 0);
+MODULE_PARM_DESC(aer_mask_override,
+		 "Allow injecting errors that the device masks");
 
 struct aer_error_inj {
 	u8 bus;
@@ -59,6 +66,9 @@ struct aer_error {
 	u32 header_log3;
 	u32 root_status;
 	u32 source_id;
+	/* Hardware Mask bits hidden from readers by aer_inj_read_config() */
+	u32 uncor_mask_hidden;
+	u32 cor_mask_hidden;
 };
 
 struct pci_bus_ops {
@@ -218,7 +228,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
 	u32 *sim;
-	struct aer_error *err;
+	struct aer_error *err = NULL;
 	unsigned long flags;
 	int domain;
 	int rv;
@@ -241,6 +251,27 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 	}
 out:
 	rv = aer_inj_read(bus, devfn, where, size, val);
+
+	/*
+	 * Report the injected errors as unmasked while they are pending in
+	 * the emulated Status registers, and remember which hardware Mask
+	 * bits were hidden that way so that aer_inj_write_config() can keep
+	 * a value derived from this read (e.g., by pci_save_state()) from
+	 * clearing them.  *val is unspecified if the read failed and ~0 if
+	 * the device is gone, so leave it alone then.
+	 */
+	if (!rv && !PCI_POSSIBLE_ERROR(*val) && aer_mask_override && err) {
+		switch (where - err->pos_cap_err) {
+		case PCI_ERR_UNCOR_MASK:
+			err->uncor_mask_hidden |= *val & err->uncor_status;
+			*val &= ~err->uncor_status;
+			break;
+		case PCI_ERR_COR_MASK:
+			err->cor_mask_hidden |= *val & err->cor_status;
+			*val &= ~err->cor_status;
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
 }
@@ -249,7 +280,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
 	u32 *sim;
-	struct aer_error *err;
+	struct aer_error *err = NULL;
 	unsigned long flags;
 	int rw1cs;
 	int domain;
@@ -275,6 +306,22 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 		return 0;
 	}
 out:
+	/*
+	 * Set the hardware Mask bits hidden from readers again, so that a
+	 * value derived from such a read (e.g., by pci_save_state()) can't
+	 * clear them.  The record is never cleared, so until aer_inject is
+	 * unloaded no dword write can unmask those bits.
+	 */
+	if (aer_mask_override && err) {
+		switch (where - err->pos_cap_err) {
+		case PCI_ERR_UNCOR_MASK:
+			val |= err->uncor_mask_hidden;
+			break;
+		case PCI_ERR_COR_MASK:
+			val |= err->cor_mask_hidden;
+			break;
+		}
+	}
 	rv = aer_inj_write(bus, devfn, where, size, val);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return rv;
@@ -326,7 +373,7 @@ static int aer_inject(struct aer_error_inj *einj)
 	unsigned long flags;
 	unsigned int devfn = PCI_DEVFN(einj->dev, einj->fn);
 	int pos_cap_err, rp_pos_cap_err;
-	u32 sever, cor_mask, uncor_mask, cor_mask_orig = 0, uncor_mask_orig = 0;
+	u32 sever, cor_mask, uncor_mask;
 	int ret = 0;
 
 	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
@@ -371,18 +418,6 @@ static int aer_inject(struct aer_error_inj *einj)
 		goto out_put;
 	}
 
-	if (aer_mask_override) {
-		cor_mask_orig = cor_mask;
-		cor_mask &= !(einj->cor_status);
-		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
-				       cor_mask);
-
-		uncor_mask_orig = uncor_mask;
-		uncor_mask &= !(einj->uncor_status);
-		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK,
-				       uncor_mask);
-	}
-
 	spin_lock_irqsave(&inject_lock, flags);
 
 	err = __find_aer_error_by_dev(dev);
@@ -447,13 +482,6 @@ static int aer_inject(struct aer_error_inj *einj)
 	}
 	spin_unlock_irqrestore(&inject_lock, flags);
 
-	if (aer_mask_override) {
-		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,
-				       cor_mask_orig);
-		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK,
-				       uncor_mask_orig);
-	}
-
 	ret = pci_bus_set_aer_ops(dev->bus);
 	if (ret)
 		goto out_put;

-- 
2.56.1.831.g720f3f5937-goog

