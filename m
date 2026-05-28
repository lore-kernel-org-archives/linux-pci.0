Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232D332909
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999844; cv=none; b=tXLZxrXE+VMPy5tOEgcrh+kUxtOqJ5INL2cwyoX77pmd9n3m7IY/1wvOHPkXLtVGlpNrBKVbxxY5b5+bjzGMQYXpL4ULAqEb6UA7d5sln2JWnxb4+V+E8JJ7s9Ok2xybal84ibaGGNcNLIghDlAutPIq0DxBHh2E0wUcAKswPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999844; c=relaxed/simple;
	bh=EnNz1gQUCzAadvQoxG6N8mxuCZNBo1KHJ3OP2DBjMlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KcC3NHeY4sNMaLhGLe5xYdp88987yasx3b0N7ENF2Y7kNi0PkqE2YHeSjNmTPl6GlAN06CPsuxigr3TtEONhA7BeLMnWSmN8JlBbWhaEFFOldbMuyTNwQiWlLYsN5ken8+LVhvRprNSl19letDvzrpMQ4FRC8XBuyaY3bvCOyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uo5Vb4LQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo5Vb4LQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf0607b5f5so15076945ad.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999842; x=1780604642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF2OaZLydlq8fssyfbqW+m3pz8p9r7jLJNQQhoc0Wjc=;
        b=Uo5Vb4LQUywxcUlWzfBQVUqhlihinHwj6Vu8jXlrKOYvdJeePR3BN2++q6khExbEOm
         vi2rWLg+8U1EBh6Phij9NQPNUP1G2iCwdENQMLzmUJ4L/ASwefeENaa0js0xUNc+DKKE
         CEv35qsPGmo0EZPFg4JkttikCxdBIU7lxEcv9tbbQnAR2IoVo5+0qvZNsbMt2L9z6F9z
         EnHenla9uGsU1TlX7ri5g0y5WIR3FG1wzsKE0nU3HAiFGPYqAdN9o9/Xrj5ZHRgq+6Df
         vCiroi4w6+7XymUSgLMM0CWlUcncDG3+cc77bET7snHCtrHwD87xBAmoQ+yoP+mjMd6b
         HGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999842; x=1780604642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF2OaZLydlq8fssyfbqW+m3pz8p9r7jLJNQQhoc0Wjc=;
        b=LsAwvwr06JouL9zTe4Ve8AyEmol2WPjyDF6Ob/VsizFe9laMasE1Oizu77N6N3UMf+
         qtAJFBWWaIjwo/SAeFF7fM/4RXzBjJE/3Uwv3LOaOZrGfHZ4yq+w2XxvA87JCFNOHe4/
         GZhw6wI2c7yIh5/k5r/ZLtNKmitsJPETYOQT7zGdaYATC4LBL1Cm9SiAL9N0APb10S6u
         Fha7NyXRYgwCQhkY6Xj5nins50zTczaWbFuzam30S50Ef+87jGJWI8+qrk/6VuTrC9Kb
         u03N+pWdi8pDD+wZPbEjQq+zBp0vODl4bmMYWDMHcovjK2Tynrcrw/3FyviPwkjNm0GZ
         Xmgw==
X-Forwarded-Encrypted: i=1; AFNElJ/Jra92L7Mn1kDoUWg/j5w3/Me0v0cmgSy2YYPlBbn4XqW6B4qyTwznYCvdgvfjR+Yn6kUFhRxsSFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8P3TlD5BMKUKZOERg0PN3mYV4Efb0dH1jINqQbBLzxLnwnPKa
	Dvzj8ER0mjHIVEz0ReRmSmfnPRSN7OQK0LqrIA7PNy+iRGEkHoVzq8MKHc9hGEYZ/l4uHVyr2B3
	5cA==
X-Received: from plhe2.prod.google.com ([2002:a17:903:1c2:b0:2ae:5d79:a153])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f601:b0:2b4:696b:7bb7
 with SMTP id d9443c01a7336-2bf1eb7c31cmr3931325ad.15.1779999841997; Thu, 28
 May 2026 13:24:01 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:49 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-4-praan@google.com>
Subject: [PATCH v5 3/7] PCI/ATS: Decouple pci_ats_supported() from pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to remove the internal support check. This
decouples support verification from the configuration phase, ensuring
that drivers can distinguish between a device that does not support ATS
and one that has a true configuration error (e.g. STU mismatch).

Update the function documentation to mandate that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 8057c24b0469..92c2a6bc2dcc 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
  * @ps: the IOMMU page shift
  *
  * This must be done by the IOMMU driver on the PF before any VFs are created to
- * ensure that the VF can have ATS enabled.
+ * ensure that the VF can have ATS enabled. Callers must verify that ATS is
+ * supported by the device (e.g. via pci_ats_supported()) before calling this
+ * function.
  *
  * Returns 0 on success, or negative on failure.
  */
@@ -64,9 +66,6 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
-		return -EINVAL;
-
 	if (WARN_ON(dev->ats_enabled))
 		return -EBUSY;
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

