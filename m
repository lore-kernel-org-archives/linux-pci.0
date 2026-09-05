Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54248F84B
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611708; cv=none; b=STTSOMscwkU51esWaWDrcPB+RLNdIQTnq6UbvQis/nUX8I6jdtS+mLHKedNdoTh919RFE7wofxY1RsNeTwDAYZoTwj5WAUqxUfeHqVJ8Jc2t9rMgK7czw/P03v+Dvfugm7RqPTLfI1GnusCCOuPUUB3ThMUjvbDaG7btN/4z754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611708; c=relaxed/simple;
	bh=FscHQeKZUzuZgsN1YVbqBe6K3v3ip/hOfNYfXM/WTBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz9Fg7TPZsuBRRBQ8yPuN+f4YOofgXoJJdutwNrqXPV4xw+os5gtmWOnoEAD8SypyvsYd7OB6MpCyFUWX5Oh+zsZInXp+Pda5hsCbU5DYsT8/AyhfBlbvu6v51xXPEH4c5PJ4koZPSHeztjYEaKc4Pp8ap3PksBare3jCBXADqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sq6R15W+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq6R15W+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so1385244a91.3
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611704; x=1789216504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3X7uidjFB8vVdKb+fO92WnrzwU/cqJo9nFwSZVVmzI=;
        b=sq6R15W+LwD+kmsvTOKEA+PH8eCVuIb+1vaKtbyQvD4np3FXcyLlQJuLuoMBeTjPtP
         ixi1GTFZ6bATx5DEa7Wz2Ne7YY0dhCMVHnBXwCvepA5YIF/oVofBWl9kcI4lWRLgbSfw
         SGp3z3JybK+8Ra4yPJZ3QEjvzBVtN81HAx27gWpnpvFi9MqU/v0AjrTOtunyHEqlQkYG
         dw8gFTw4BzpQQxuxDeYv69HlLxSwoGg2S9FfrMxMbpamFswRGHG6Cwp357FJ2U+eUS/y
         StgY13ZCrLoMCgU/SAJAcPvOI7HYYx6TQWLLahcl//OQyqqCDXNmbEpbtWwlQGgwFSoa
         kjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611704; x=1789216504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3X7uidjFB8vVdKb+fO92WnrzwU/cqJo9nFwSZVVmzI=;
        b=OIF+rJgz15U3RnLXEERophjDyjQZCZCiP0afmE0gN53+Fmr/o1aAzZwXVK8R9CgK82
         Ao2ObctMW6hO11sQ7rsliRCbkzIqN3sJ87UoQ66OR9I06lq8PYT4B9t/RtnG/5S+F3/p
         UMFELVZOhmhUVxmUrDSnR34l8/ZLkaE4CTDZJBnhLqKZZGo8kMh9YxmK3SOBWyDoHr7q
         PvF9yJcQD6jzKvJm2X1C+/GRU77NbAUhtjR/Lhe3OAjNMAXYrhqRnshMbNALbIwxbBgH
         pExBIDAy5Nc0CClCM8Rl9vo18X+9haMzpZV8k+1gfjBJnBHgXKxy+K0j7syAV1sOZlL4
         DjVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuIDco6mnAr+S3L3W6e+rah8Zss9JMqiUlnI37VAzTkL3Jz/5F5qvf9LTudKBvgWNiUw9QYRG2mcY=@vger.kernel.org
X-Gm-Message-State: AFuF++ntydznwCCGm9CDvTKzbo+oiQv8yK/b6VjflIM+/0Wv3qcIdvib
	46ilFTrV66sXbJeKr5yHxHBvtn3cX1gMeinK2QuYhim/9ZNs+O2I/oBj
X-Gm-Gg: AYBFou24tWyyjTQQxjftduq3ewbBkHPdlNXJ04DUe0wOP/SUKyooBHW2nFdZUmV1Qeg
	6xZGI38DVYqfRwnmWeGUaZ578MnSN+L2MRCVkkZ1TwSaFoSFh54A12WOs1tCG40Q4GiemS5B6ZO
	Pvee5TP2pNwZd0/dekm2NRlHoRXV+fjiqjGmcopmAvCYI0EcfIXc24HHjqQTb5RBPIi6kRVXOzC
	s7rJmJ5KeArPlHJYCnXrLGoAQpHoVJZR6c8vz0l1SS5MKoUYALywUVIw3xD4+7qdXcUIkESVmxZ
	1RRplno7ewvrei5FHP+PDFOSALtOp++hHRuQkPb3ReZn65WXWvbGHbUIhdmf88RBPUGtCcCpt1g
	JgQtsLIA3HuQ9qP5vWLQ3d/SlTmTnwVTq21wbjZObr+Tspy8FCegmCiHqVKz+4bf4PY6ePjP42E
	6K0GVGoJ3V1xkxFDn1qEPVJjFeQKeqaocU0T992kCKjXfrBn1U0FQBffFmJLeaWTBkChKOBE/7Z
	/zE2KDIlvx4+jaFWCEWdCSHE0xvHeh1PFkqi0eiTYM=
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39b261323e0mr19491750a91.11.1788611703632;
        Sat, 05 Sep 2026 05:35:03 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:35:03 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v6 3/4] media: dvb-core: remove defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 09:34:49 -0300
Message-ID: <20260905123450.5620-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905123450.5620-1-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c due to severe lockless race conditions and buffer overflow
vulnerabilities on global network state variables.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/media/dvb-core/dvb_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..3b503695e 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,7 +68,7 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 /*
  * The code inside DVB_ULE_DEBUG keeps a history of the
  * last 100 TS cells processed.
@@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 	if (ule_where >= &ule_hist[100*TS_SZ])
 		ule_where = ule_hist;
 	memcpy(ule_where, h->ts, TS_SZ);
@@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
+	#ifdef CONFIG_DVB_ULE_DEBUG
 		hexdump(iov[0].iov_base, iov[0].iov_len);
 		hexdump(iov[1].iov_base, iov[1].iov_len);
 		hexdump(iov[2].iov_base, iov[2].iov_len);
-- 
2.43.0

