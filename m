Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284386;
	b=WExah55UG9by0zqyf4IkQpdru9ZrFgODzv9s2vHzu2K4FsXWhxQruBXAGUuOvAYPYtU8
	 /cv/5Ps3WPRH2zgEVO4k8ODQ8+yhr1/7iOhx8gv1FTeZhhj/X/bVZaL+LsBLmsCUgjJBu
	 tiC6pbaP9RrNJvgSaC9n0m3flN4BSu12PL9oRYBajxM9jvtZcoSz+qROr3NGrnjGpB2no
	 UUm3EXD+CvZe+gWiyn3bZjDjw2mik20SNl09iY9RfLj7fBb96g35W/MzloETEXumCUP74
	 aa7MWd9P2A+3Vi52F7ih6HkakMPaLGnvozGYdUAw3oM//pObkRIJk51TYSBCP2beGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GWNZ8zQxqiZGzpWyot+03nwu4qhuEeSDcx/Yq9DH+WA=;
	b=s9yTi6luA+uqbuN5pujGQ9/bSYEeJXE3qi/El7dHT2ADTBi4el38jWCSg2AaJujkIXWY
	 zCGLjGu3LVrPnebeEkCNoxwCjrSyW02U8By44sUor+J1w3H+AUnsMf0QOJVZjwTJaMwDC
	 V1m/5Kh3+xBBlSgNyXHOEQu2yi9hahH/cOUuy2o1Iu9ewuaOBpvpEd6nIZCNn+KANxIuK
	 V4/bBcGEWueabeCdHyubKx+B20SsZ2TFxZaiMFoVZ05zeFZeAdvOSiAXGLG2X+R75jvES
	 lODgWrwNdvo5I0+WHCKsVymXgMtfUAFwlFWgoEmNvLN0A8aY9FsdabLa+RIDYUZi3HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGtenEbZ;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B88606E8E9
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B88606E8E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGtenEbZ
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so2710292c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284385; x=1794889185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWNZ8zQxqiZGzpWyot+03nwu4qhuEeSDcx/Yq9DH+WA=;
        b=yGtenEbZG7Qy6TLOfNHH0y5Y07HDUztMPNGH3pc770I1r2cy3ZaH19A2RVmEr0UI/O
         NZeYX9CpwtGDlWb0S9HZyajA8d25SmnVgJ4F6kjH4/q45zPIe1zefUOfIaqHT0g3hwFK
         Cn6+z73Wn3D/7ZIxwbuXvB0QWjr96G80mTxU2EXqHyigkYPy0OKly1nGOk5paCbWlat3
         Qk2roQcaq3Gvka9pimS3DGiW9wA52FY8ZRCFgkmUQEq86+1KQeoXmZW/nju7ed4FzWuB
         NbXDttmUANX+suQLHNmfzHEMZ0+Kzh8LhSxP+wbrlgmKTAIxym4xWpgfOT7EiNtfWu01
         T+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284385; x=1794889185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWNZ8zQxqiZGzpWyot+03nwu4qhuEeSDcx/Yq9DH+WA=;
        b=av6dIMmQbptnRLI34EJiZXIjl3+Xpk6QXphVbryPN7pwjYiAY4VESKMxWEeq7jOgug
         D59wQPFHXrh7QS405mXTtLiuJZ5zbiPXBi5RTrinCtz04UKQZjxBUvFFb2ENVUF/qoN2
         KidMV3uYtvULHn3jmGAjQPvipkMej2KeqWKXWLhpiL7iNvnK6jTQwT4KUQE+TTftS6+N
         Djl6sqMm1D9KfK8hXPGuNHVhb5bhQYOIp70T5wbA+0xaDwt39YBtiQ8Z25k1Dx2Be+L9
         d55EJHkMg3S9GchoHSLfrf3JsVxntovFoEk70qKO8z4GenfIZY9v6tc0Qw8XwYhqNVVF
         f0wg==
X-Forwarded-Encrypted: i=1; AL+hErF47qB1kTMm7pC8GZMdcVuYyMbTHEUjFxgKW8Qd4KCfeIVFKYxfTfA7ebxQne6IXlONAWqibZ758zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tr8LkO4wCdX5khLBoOO6KZ5sTaGFx7lfb8/GA4Ylleh3qIHFP
	4xUT9daqKKw9rCJ2g67yPQa8CDDWRZJOBrAR71bipaMuBdJ+wnBQsSGM
X-Gm-Gg: AYBFou1ptJmTi/MqlZW0AsPeFDnJxwQzcEPLHTxOk7G1jZN00WdeCU3JrXw+P9m203y
	2FJGetWkO9Wz53LDGn3YPDOGGeI+UiL7yKsNTMwbx/ud+SSzxjPIh7s+6p6J/2R4GpjBmXmQ2b3
	R6i92wVgwVQqMTUc55znYSTuu6cpAI9Ejznx8GeQ4GqmdD2QnrKZeMVvukm/y7dTiqqRKMKzcsR
	QwVx6D1lAG3wUWSfbkLEB2yzdUED/pCRWl7zD08gUJvAe7XAYPguuChzcGjB42949JRFN2Djw3z
	QCND9sC0jOx6tPQ9vIv0bF5S2E9YUEysXVhjDD//s9ajgNFFL7PSpkUkfYdvMZHGuyzp94WkfzE
	nY9Fo68uUi2Et75DaVqt2e4MC2Q+ebMtRiFFPnvil+GOEkqBPOKZwEzByp2TrN0nm5UI2WkwHNh
	R28gJZAP14BqwU5AmdXydA8XVRQte5OdRr+aa1ndRoubtxly3PMWxsWWKOSFb6NJPaKswbz/gMP
	f0ucjV3r45bZv6XIWBicl/brhS+DkUkmW/5e7tMKHd0vgjTPCYy3KzqWLqNkMQaaI5R3A21Xi8B
	kOSpKe73y4oAHfD24ILiUAu0ARB/7GBJ6HOjrdoA3AligIA=
X-Received: by 2002:a05:701b:450c:10b0:149:49c:233 with SMTP id a92af1059eb24-1b3b603e878mr2107744c88.27.1794284384921;
        Mon, 09 Nov 2026 20:19:44 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:44 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 07/25] rust: add bindings for hash.h
Date: Tue, 10 Nov 2026 14:18:14 +1000
Message-ID: <20261110041832.1730924-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hash.c             | 22 ++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 24 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc73..4992bc3194e7e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
  */
 #include <linux/hrtimer_types.h>
 
+#include <crypto/hash.h>
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_device.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 0000000000000..1e50fe16c5031
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+#ifdef CONFIG_CRYPTO_HASH2
+
+__rust_helper unsigned int rust_helper_crypto_shash_descsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_descsize(tfm);
+}
+
+__rust_helper unsigned int rust_helper_crypto_shash_digestsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_digestsize(tfm);
+}
+
+__rust_helper void rust_helper_crypto_free_shash(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+#endif /* CONFIG_CRYPTO_HASH2 */
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7bd..0dcdad905f0ef 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -67,6 +67,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "hash.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
-- 
2.56.0

