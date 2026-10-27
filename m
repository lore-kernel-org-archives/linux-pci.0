Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078755;
	b=gJbsdp28Edi9j9Ba6SIQPpAsUCoTL37QhVeKzAqWiWkCc5moA/8/oVgOhtE9uJ6byQJE
	 9ynqOPLjumlErjIJgI/SyX968meYjoonrkiTjncsvbsgxCw08c+isIL0UPwM9vl1vmWPh
	 fJZQkUjallRvqCd8ZtYCOXje87LReYE6btPbVT7sITYjMvG+TR0m/T0NxvHyRa2nm0fYY
	 Id03MKGU7SUhSCOiDLKBLO/TX9UQgI/LN7WdD2okYPZNuk9g+bdqbFUxfz3/CvbfpIrg/
	 BXxJ7906UwTT5BcjEZ0Y46y5aBL8wxnUvrblC8f0JBxN8Kq+o/NgfYG7gutoNKQ5/9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
	b=X39xIr0vOLDIsiDXVz61gMMzfcudg8ONvKbyTYkcEnJo7Ob3yYwL/3ELev3YHdIJwDfE
	 6iIfYgDp0bxFoxsONKQ4WSWL7ams9pDwxom3lz9KLGCnla+2lim0SYynctxq41qcBEVou
	 pMwGrx/CUvkMBiq2RNcq4Ppaa57Xr8rOyOtIlJ4OoXKPimeU5XHCOPofmyU/qukH6c+OQ
	 yvZ5bJj9lqW8Wk6EzxOWJNhn6dbw8q9h7Egj7ncYx3uccEQ7/Nl6SpD8Xy3Mh4MDXs1sk
	 INTTsrfMlPiXfEGRnSENl4akdYfBupayvflSK3/rqcIttLtzDB2SU40niNi7NnxFiGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cz2btDR8;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF0606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52EF0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cz2btDR8
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e5fb79ce82so23678695ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078754; x=1793683554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
        b=Cz2btDR8XV2eezXzWRlq7mbSvagoFv+4MtQfyrcCn7L4Haf3pdebXhwFFcMA+fiAoI
         nNym5bMFgAm6rEppUfIigN//XpHC9ruj35Ed6Ve+0Q0JhUswR98+bZorurlfG2FazHVi
         ziQibUSnNZzwIsS8pgeY8ZpwnqSMKD0Fcv13o317DItLWyEaK3e7sEHJEKlyNMENKuu8
         27AWXQByvboKoYM5r93nHfR9FwfezhgVBEPVE4oDs+ozM0O4fg8OYBmOHKwH4R8DrNka
         0zLj8jAwl/gpVw7mSunoRfESjwWHrwvwtm9EETHzkkT3Gi6N4St+LRscwDcyxk8bepH0
         un9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078754; x=1793683554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
        b=2NVd8xDpQNGtHFYXMY/P8OPLqx6lNiw41NcX9wX5oN/jE8qeJ8P91uT+JksBg7/ckp
         iu9fOTKxEkTrdYIh/yXsd4s5Aka6nY6AKiTFK3qL4f+EglW1G0AGdRwTNtHVLeap705n
         fWoAbmvU/JzdRA2orx9D/Dfyej3owO5oDoDl9h2vXmkWKcakt23+ycio7SvH0qhf+k5q
         feQbvbqqgG526eI3PzbwCe6l3KCcXt0wVWs29J4DglfnlaY7G5Lr0A0nt7WnCYTMcpFV
         5pVEmD2QbN9fZ3rWNTKI/npqq7lBMBUBc+vKQRcnFJoPd9YvLKgPITgahXIewUQU3CyY
         S/LA==
X-Forwarded-Encrypted: i=1; AKwUvBzsf2z4b7+kOPtcLTiPZhloxPlrAlnDnfwcV9e5WBvT/kWPefbaI/YJgalYeBD9tSpCjwkh9nuUaEA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZZfvftIcYH8OSdafdsDnwDtpZuRCpssFytwQg2/+WPBgM6vuB
	7lxSHgEViCMEpf0gkb8owbT9qAOIkCUaxYcKsSqCOKtBjPUV7k2dvlcf
X-Gm-Gg: AYBFou0d3Nn4aSgrxc7ZWDIoPTEEJ1bOgbqONiDxTTW9/nTzlzw86Q0kc6EkvZPaWP4
	x7UUGtS+ZXTl9j3BQfIBz1KeaDi2r35LWAmrZz6tr5tShuJ2Cmrcq2U7shQUyu0eyvfMPyiI+r7
	dWXYbWV2I7eGu2vNGXZlcNtnHm5cR8TbnPlPkcxrkbx8pQoJeA8JEE3GCSc3UrbsKwYlg21l8yT
	GV/IZlpOCLgsA6X7kTXa3Vs8sClKmMUjgMyUaaM0xBy99KlZJayUwDpVF61/xOKTrpodF0VYZpf
	ywtihXJ3wU2kVfMuLYbbrNsJHTTpqLq8HrO7le0aBAsoFTWXoAMrwMEvFL90CXqv0SFivV0IbQn
	4Dk1Zuy1AdElQYbbMDq4/TE5z2GLz98JcR3uRyCq5Um8kSkrh0UfxhLtRrx9lMLks1TqZoL854r
	Mpo1Eb1Y3RsfKojPK+BQA7S8epRlPzAKmBN5rptmiOyc6Y/bOJnCZ5vHV2Rf7hStnszaDADFkx3
	KMCpnWY/n4CkEV0l7vH6G6l2j6KXqq83fZTh5vGn6qGLNqu6nWj49WD0TTzSMH816rFWRnMqw==
X-Received: by 2002:a17:902:da85:b0:2ea:71a7:7f21 with SMTP id d9443c01a7336-2ea9c6c245fmr69254805ad.13.1793078753628;
        Mon, 26 Oct 2026 22:25:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:25:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 01/23] virt: coco: change tsm_register() to use a const struct
Date: Tue, 27 Oct 2026 15:25:14 +1000
Message-ID: <20261027052536.1722081-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The tsm_register() function takes a struct pci_tsm_ops *ops argument.
This eventually is stored in struct tsm_dev as a const, so we should
just change the tsm_register() register function argument to be a const.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/crypto/ccp/sev-dev-tsm.c | 2 +-
 drivers/virt/coco/tsm-core.c     | 4 ++--
 include/linux/tsm.h              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 46f2539d2d5ab..48df8c579c74d 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -339,7 +339,7 @@ static void dsm_disconnect(struct pci_dev *pdev)
 	streams_teardown(dev_data->ide);
 }
 
-static struct pci_tsm_ops sev_tsm_ops = {
+static const struct pci_tsm_ops sev_tsm_ops = {
 	.probe = dsm_probe,
 	.remove = dsm_remove,
 	.connect = dsm_connect,
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index e784993353d8f..6b735ac2a814e 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -57,7 +57,7 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 }
 
 static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
-						 struct pci_tsm_ops *pci_ops)
+						 const struct pci_tsm_ops *pci_ops)
 {
 	int rc;
 
@@ -78,7 +78,7 @@ static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
 	return tsm_dev;
 }
 
-struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
+struct tsm_dev *tsm_register(struct device *parent, const struct pci_tsm_ops *pci_ops)
 {
 	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
 	struct device *dev;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 381c53244c835..6ac12de8c4d36 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -120,7 +120,7 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
-struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
+struct tsm_dev *tsm_register(struct device *parent, const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 #endif /* __TSM_H */
-- 
2.56.0

