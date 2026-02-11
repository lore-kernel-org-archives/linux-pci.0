Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE889345CBD
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780610; cv=none; b=ZEgql68SFtrZH+tHxxPwx4qlkgc1bg20SLGcJGA0dA9nHIrmWm928evJJZXCK06Ekv7owIQ+OmMD3MHXZEFYcCPqMb4aNh1Ljy4SGp1U1NB5cql5gbKsH4kQXqpdsafYhiSziGliHSW6bMSHNRxWHDEhgmMMYV7JHUUY4C2MQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780610; c=relaxed/simple;
	bh=ozbIZy3q85Dwef2HPMNXXszYSCcI73lO3Bhup+v9oFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHwL+NE7zMJawIkizKjU2UokdUQdAvuhvwVtWvrPkcqzIDB++WvJsvG1XQbwPXbQVg3CTnyMO+GrdoEYooXGOA5JP5wMo9hyx+bhNzgoFcYNINwY1scvNftFvKNBZAkAlANN6oFYc7KdU/tu8T+OkbShwapAFVsHKAHnzMcNoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srje6/uh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srje6/uh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso5289891b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780608; x=1771385408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa0FmCWNCDjXutoddDzbqHV8AHD3cr+ph1+8htfRvzI=;
        b=Srje6/uhIfA5S2tYOicqviw7lqiEUIzTSW093J/3rzJBjj2IfwI10j2jKx4L2HS3Sh
         Wa2TX2Jp/CBejexUsJcJzEbqcWwYnautmAAub+0swK3PGzcikj0wUzw/5woki4M7hHY2
         GYDB4SKNQNirHbrquo56wg2zfiDaRVi+BjUm7wb4WT/rdtcJ2ZpMubJ2f5R95ZGYWMSd
         EyDJPkdzm86Ef7t3iVNL36AWHBP97qLAV4wnYQDvcEK932HQTtgs8I03xalLbl++vyZJ
         iLdDayrCqKwX1oN3z3rxi7BLSZUDJWsHDXT5M8rxByvjQ4brFjCjWsiRLP3wm5/AIZzX
         +AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780608; x=1771385408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fa0FmCWNCDjXutoddDzbqHV8AHD3cr+ph1+8htfRvzI=;
        b=A9wT6JzkFWzMIXG3is/jjVFlTA0mmmLcimiUy/q2QUUHsTBbikIzbJLiekOa1XwDYz
         k3sMVr6BTB7iuo3KfMFZtSnYu/HWy3e+iLIFrUDzURd36kEEAePvgNoGIJh/7TmoHVch
         PY+P3wJddwyf985kbaayiUUzOjjUmdLJyQsJycoKDc+swzFPI9VY2gkWc1XcZg1yZPcT
         hrNbmf2uYlXwZip4xiU343+eAJP4StzHExowjVWfE1Agx2osKzG4POc0EZA4WbOoafLv
         KyY3JjLPyrpcJ/yqltK0A7WGcTsOv5B8mii1bkRPo4uvHMzL+Nxi/6owhwh+2iE5DpBi
         pYqA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5LkGIkMyCRhZTle9XWcCsicndq7NVxFIQ30sFZ3Msi+q/78ZuVt47jNQ7VzJuCBiJ4dq3knMpTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjuDnqIyZZD8oM9Mltz0vIVkd6u36oFFn6YF4DUt58FZAMIdQ
	YH1vP978vSoT0bwhzbODcO7IZqan2eDXS7eW88SGpnD03v9xDjcyV6jj
X-Gm-Gg: AZuq6aKvs0Y1o+fbOqDq7LO7ax6zuamFwA+y2A9euKe3mMyIYkBSTGN6nredPEyhll9
	B75DU0hxvOcl8aBnNs5PLyrWxMZ7rvni7ungam2cCO3nkMDVvauWiZ2Lc0eOmbUQ0JEPC2HR8wW
	hPLeJi2pEwh1ksAobu25i/I8sJzBM3fHJ0KYyeZuMxdNF1HGSVyA2T8fTjMoUIaCDR/D1sWBqSu
	X9zpeAvkPUCO8/tohwJH2gYvL40BB37W6qf0y0LHMk79Jn5WlMa5/6J61nm7zmInxNFlSanXTgt
	mGtx+7Yv9zEsqrQizdq1ihnD/xDtwr8sX7S7E7xVNr8ppJzuLnwI3HxibyQjEzQSe1R9HuDFvgw
	d37qFbdNOUyUq9IJzbk/sywjjDW80iNUyqWnL16awVyiNdbelmVJG/ZeV2ZH2L35tIMG9ASgf6m
	FjvsvVG+ii56TmU2BnWzbqLqk0aGbttBkbAggGXMtZrQ==
X-Received: by 2002:a05:6a21:4592:b0:366:1934:5234 with SMTP id adf61e73a8af0-3943229a8c9mr549814637.2.1770780608223;
        Tue, 10 Feb 2026 19:30:08 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:07 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [RFC v3 03/27] X.509: Parse Subject Alternative Name in certificates
Date: Wed, 11 Feb 2026 13:29:10 +1000
Message-ID: <20260211032935.2705841-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming support for PCI device authentication with CMA-SPDM
(PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
in X.509 certificates.

Store a pointer to the Subject Alternative Name upon parsing for
consumption by CMA-SPDM.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 2fe094f5caf3..363acd87dba1 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -596,6 +596,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_subjectAltName) {
+		if (ctx->cert->raw_san)
+			return -EBADMSG;
+
+		ctx->cert->raw_san = v;
+		ctx->cert->raw_san_size = vlen;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_keyUsage) {
 		/*
 		 * Get hold of the keyUsage bit string
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
index 8b68e720693a..4e6a05a8c7a6 100644
--- a/include/keys/x509-parser.h
+++ b/include/keys/x509-parser.h
@@ -38,6 +38,8 @@ struct x509_certificate {
 	unsigned	raw_subject_size;
 	unsigned	raw_skid_size;
 	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	const void	*raw_san;		/* Raw subjectAltName in ASN.1 */
+	unsigned	raw_san_size;
 	unsigned	index;
 	bool		seen;			/* Infinite recursion prevention */
 	bool		verified;
-- 
2.52.0

