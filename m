Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829535;
	b=kh+/RUzdcr8AspiHnxw5idnbbc3bMdD2DxZkohfKno7IoeHeWfc7Kb4dMGvBTy2P1Jp2
	 DxMGtj97a1a5Xh2lfib9R6ajw7hV7CcXXbvuRNHEdMJcZO8/6s6S4gINEnz3xj8B7N5Yu
	 8P8/i54jRdsp+GgEPrkRrssClIs4dAmfg3IDkWNDn3W+B7oGiBNG6jfA+rmSw3dA1lERc
	 Lsy+pEopq9+O5s3eOKMeBdO88vobZ9k8YoyQz8SW8QAxc2cK0oLh6Bf4Hy74h45YIZHAl
	 +uG2u9Kd11vleK8uM8bxe6hXC7AMk92RBn3/yCC3zjXwjwE88XeqoXfZNWC6J55xwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T0H3EUcqnLUlnXch2HKXz39dCofeKBnFEr/JPTlHIHo=;
	b=d4SOf8uwB6ww2TZqjTLE6Ln7T6jZeqvFh09wyJmtrZF+zDmNTr7E0ZP/Lyod9p41PbFq
	 QBpgRadLjTvSN2NLJDz7cnI5fudv/vpfpe0avMr3Mz2QJRJXDC4gxwJ6B2oTZOx5UywvH
	 91Z82VSHBnPYKFk26/eL0wQgO/40+u9OrOxVsFecAjl6W+BAW4zPt4ZMM39ojLNuOYfr0
	 xjBPlZ2vsTJANWEogGf6NTECz6AdNQFSgq2Xz4gRElZs3gHPcrY5wHN+R9+16ZYqqybda
	 8LrnbbKCwnJrjtUDbUgrAMzshGaCtZmGZ3Y6glCqNiL9IOwMpEye3X4NMO26SKdpI3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x+8HY/Sk";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2756074F92
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 21:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2756074F92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+8HY/Sk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so10768945e9.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829533; x=1794434333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0H3EUcqnLUlnXch2HKXz39dCofeKBnFEr/JPTlHIHo=;
        b=x+8HY/SkqAoQD8boG9LMqxUpVX0GRRevt/KLtoNb/MCWHJzvoxH2HK4MgHjKnfHLo6
         MT0RenUXW/T6DEREkpAg5YjybKZRfrSsKGryH+ZEjNZxPa5+53lMqiVrbmN7ojb+sKjB
         Cfvm5qKqVkh/7UREcphI1uPFXNBfgzTCjEhfRmRkADQlEvjFg9f3AwJUR1Pro2c9f131
         WKgGa3QF9KBpWIgGFg3d6ZSte18EP+wfl+jCl/Ycjns3WJFfyt98iqrK/QdCYWhk6nXA
         HYuYFnems01bbkrMtDZ4vbjKHxnkKzoGkaLDr3C6OU4d/zz6nKlW33mWbvwzJb9CuhVw
         3N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829533; x=1794434333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0H3EUcqnLUlnXch2HKXz39dCofeKBnFEr/JPTlHIHo=;
        b=KGA9XRcIeuwL6G+rFIn7w9/JUjhvLgf3bMhH6yTw1dblQTj/UKha5eBeVIYI9Rvzxx
         W9bdIQYmST0jcjW6JVYf3Bliblqv24ofnGr2tISgRMVMvgSSFHhyyBtpan/AIRvIA2gc
         KhG94KE0raHJZi8R/WaRt5JQO67jaYoT0u5hXu2K5e4zShqpCsyn45LKA6/KNwVCQVru
         LMFv+yY4xjGyry510aK/xxGNAoZOCJmr/aZTDue3WJI0rBku+vU1mxNhV68T8tEfP9Nf
         IYXC1ao9TJIw+gA75OUxRHXKRnSqY+0Shsrexoj9iXcOQuGnOAULn0D27p0PIJurgcO/
         Dusg==
X-Forwarded-Encrypted: i=1; AKwUvBxrDioiuSRlsLlgOMamtZYRo60gu+L2VYe62IvfnWT3D4SODjeOGxUq+jhNLfZunrBt1IyFpwKSHdE=@vger.kernel.org
X-Gm-Message-State: APuU4Z97Y2YsSl/ivq56Yy3b3W9vZuLerwWMW4qcJrbKFJZpbQUF/70X
	GRxuMaxRHBZxnRjKmYJXqPyQBB24QYPoBvE+h0yYrCFTUWGn4ydEK2Rb
X-Gm-Gg: AYBFou30gIYBZpXQgxPsIwwiBTmABnb9oEpoiv3dhLV7iBF1yJr+DcHzTiC1/uvBlj4
	l4SNtkEO1IQkM8qA4kX5xaugtFfgEIrSXjL3TdcLx3EvE9pxo0LFv2/9ZputvDEOiXxWtHQV+yq
	Xg27I68aGI7JvVQs/nyo+tVc5p978QgQIgJVYEyasxjO5m0gHeNLYmKJO4FDSMQ1OSqfr5iHbBd
	Eyd79Ej6irmR/fefcRkAJD/mznx+yVSzbI7OT4FQuUVDcVybUtMAnz0yJ9IvZNk4v1JbTDfJxKq
	YLMW4JmH0F6CGJpxEVM+wx0lNAp/kcO8k/3oObEeRdfLpg51MCOZokteQD5cFHUTCBGs2O7UX/P
	fLKU2WIQKi4lLlNjBBwNHd8pvHMgESMmLMBNwJhHYv6HZsuphiUUVXgZ2nfL1eog+Nm2nbE/2Lp
	e85WfwpQFYlC58kQXu9+tAQ/fwsVzSJSx71z4uunT3I96Z+zwAOwsjRFgbo2yRiYBa083lnmZvz
	IRjEJv9nw0ax1FbyL0Z19E4wLNjfDmUTxFjfr+McRbq+utsM761dxHlZZSSumwuAUZaPQSn1flo
	qJl7+el1QSptCEA7TgHDOdT3L8H1Q6m9GVWTguLIBKa4zoaKTxGf/V/nFk/2PT2/xlr/+VSstCG
	aNQiFkQrn9zx6JoolY+4IqhYkasoBWLUx6Oj/Hq8hnuxNiA==
X-Received: by 2002:a05:600c:c107:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4b1202673f8mr162862935e9.30.1793829533381;
        Wed, 04 Nov 2026 13:58:53 -0800 (PST)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e65b0sm15526735e9.11.2026.11.04.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:58:52 -0800 (PST)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	iav@iav.lv,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: rockchip,rk3399-pcie: Add PERST# inactive delay properties
Date: Wed,  4 Nov 2026 21:58:46 +0000
Message-ID: <20261104215848.2087944-2-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104215848.2087944-1-ehbello@gmail.com>
References: <20261104215848.2087944-1-ehbello@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver holds PERST# asserted for T_PVPERL (100 ms) before releasing it.
Endpoints disagree about what they want there: some need longer than the
default to settle, while others stop answering configuration reads when the
reset pulse is stretched that far, because PERST# stays asserted for the
whole wait.

Describe two properties so a board can state what its endpoint needs, named
after the ones the Rockchip vendor driver already uses for the dwc-based
controllers:

  rockchip,perst-inactive-ms      - the delay used at probe
  rockchip,s2r-perst-inactive-ms  - the delay used when resuming

Both are optional and the defaults preserve the current behaviour.

Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
---
 .../bindings/pci/rockchip,rk3399-pcie.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
index 720a5f9..7ac915c 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
@@ -40,6 +40,21 @@ properties:
     maxItems: 1
     description: pre-reset GPIO
 
+  rockchip,perst-inactive-ms:
+    default: 100
+    description:
+      Time PERST# is held asserted before it is released, which is also the
+      width of the reset pulse. The default meets T_PVPERL for a slot that
+      is powered at the moment PERST# is asserted. Some endpoints need more
+      settling time than that, while others stop responding when the pulse
+      is that long. A value of 0 selects the 100 us minimum the PCI Express
+      CEM specification sets for the pulse.
+
+  rockchip,s2r-perst-inactive-ms:
+    description:
+      The same time, applied when resuming from system suspend. Defaults to
+      the value of rockchip,perst-inactive-ms.
+
   vpcie12v-supply:
     description: The 12v regulator to use for PCIe.
 
-- 
2.56.0

