Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580147;
	b=eaGLNQ6JinvP2QsqjyQuyQrh4x+n9WWlRqThhNmYaDYJrFnteeLui9U5JhIMsb/8q/Vc
	 Txmj4rlNjh79i7xgbBexJTK/GqPv8EZjeHPdJ/av8vuMuyi9TD3Vaj+or9pubJAAypeKy
	 mmUot02YfAB/M5ZnGjB3FOrwqWO1QhW6I2TIIx5niKmJi+pJmSiC0yyRQVQptVe+/yUGX
	 bDfWEKO3Y6xI+oX4HuJg7lVPo1qmWMUiDgz1iH+Hbi8IQuBL72SntOO4KijUQXoj+3Krw
	 OZ9U3Ssycy+ePS3Hu5zy7TSmXKWxRhXiTPk60x2SpNSbLO7XP1lV6LKggo7/64+tKEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UBdZz/M5NDcaiH2YNNBzA7mMgFU5hsYYyPrjQqPIGtE=;
	b=c++UcOFHs2Vae8ZEZzuMAqORvrdt1c+KIvnmZVcyl7RnmBgEE+zrm0sj+DJZ3b0pXayZ
	 BrnEqjGR16W18f+CaQ6OpZSgZWNphIiGtB1LXaDPr2tq5Z+p+uuNMzqMBnKfA5BZqkExO
	 988mnCD528P0Dad6BmtFS3ZLbAvaN5HUlkDcHVZfEJrqW3c8Sdy2jbI3iZ1WwGwUS3Tn4
	 KA3YQoIC5q6O05VHRlAih2WHGNTd+wK3VV1ixbs8iLi5+hBInfQc+3R6XM+cmX7gILfE7
	 PabrFEo5nFVQYQPWYLrYG2D45TNUc4QpO6VKv4xOkU/R/uh9RaXapzeKxc7vdzuhWUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RY9UffRu;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE9606A32C
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDE9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RY9UffRu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8ca6a12efd9so1624836b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580146; x=1796184946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBdZz/M5NDcaiH2YNNBzA7mMgFU5hsYYyPrjQqPIGtE=;
        b=RY9UffRu/b2u3n5dhx0nPxdAeyUJQhaf+fZ1XpKlVoaBHtN1QcheQI0PhaP5qVgqN6
         8QRqa4tEnEXCM21sRSzXp1x4YhLKv50d29Y+0RrgRjssM3+e0GXv+js4bzR31xJdXK5X
         pmozDbM9tovgNHS0blZx7WxmktDhgT5kSa8Q5uK3O0drzUR9HjHJw1+6nxXZPd2sQTvs
         mpoDTlOviZjjxdxdnJT441Qk2q7bfESj/BVstY3mZ8l33WGetv7c5WvxJoPR862XTtag
         1qWkLuOMZV5TVR4LSVxEd8meTUV4bLmMizPewvZXUvH94g3pcDJwOD7sBffQzyVxgngM
         1NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580146; x=1796184946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBdZz/M5NDcaiH2YNNBzA7mMgFU5hsYYyPrjQqPIGtE=;
        b=NVafaPyDlDZsFXwLrdelEoV2Sz6SPZIFmV0NZoSQmmwvh7F/gs7af3ZqCMNzm0gM4S
         2PGt3rFRpwcJywCNWQ5Nai19XO2cEWYaB/vciWs6Si523YIrhWXS51q75eCZcmWmU1UR
         hXYkUwPtvDkXliXh+4EDLcyDVZ+FabIgCvOePNFgw7uye9uSJP0mAnIwwp1lyvnbcagz
         0tpzBnvpPwfpm7VzBRb4i3TAg8QhNuxxaM9jLAZsMpU9XZMImM60CeGCSr9jQu+MEwQv
         /nX41LMCv0psvDxa0mkSmixQ0lTssuQ18UUDX/iJwwLN20tA2qqwvLn7dCRBu9EPZmTQ
         aopw==
X-Gm-Message-State: APuU4Z9tQqvB4JXww8GcsRjpCpjfkrt0nvjLwAX48FulkcToMAJBPsIc
	hb2CAr85p4j5/Vb8OBeei91SrFmMd3jADmEZiAv7+SyGSBWdd2MRXWJ5
X-Gm-Gg: AZFdTZfE90O/hMGmA5Q/zeprVFFRZbhAUUSJtKVRJqbh7CVdhAlWRbA0dNByI0LnZkE
	jMOvV57AdlEjheOpUXQyo36KNViIOYZUfa8qXy1Iqsb50DgoI9o4Od4isSmm8LMokndxSU4xXW+
	G004FpCIy1IJOqc+BqSZ+O4Qr7tm2L6+1yNZs8VDqASrwDLmHW2kPFeyxEZaVtQbqelDRLuUkOR
	84UOfKmuwHFIMPQc3d23nAIYI2MNZq0GPUyunc98r8vjihVkQ9eiRB5Ej8eSv5G+2HBnNU9zTuV
	VkOIVakt9AhTm2ixUK0j9zyxinU8XjQp2GB6zVmj7Takdfo9aOoNOk2mANOJmGORHXQ4oS9wO4B
	5TuAn918avGp767y6jJCTjBgOO4cgbpHVf3LcwM1hUrfNrbLKHOIAyqoS5FRfsD6mEfYca8LtbE
	b3gcYtbbTs3q3kdRROjJb59FC9sf/mRgz0F5irm6FnB14CynaX358wnhLjw4u77WBaBh2KXQK7W
	DVBDuZ1RWjgnxxVzhlsjhvOWO+erREtNHuERU45Dsl0XsGAeCvFXippNqevS1Jq4o1a30vHo7KI
	3wFeTDdbbQwwgak/kqphwHdmmcM=
X-Received: by 2002:a05:6a21:3b8d:b0:3e2:1a24:fb82 with SMTP id adf61e73a8af0-4014c94a7a3mr16524789637.16.1795580145986;
        Tue, 24 Nov 2026 20:15:45 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c272sm8306084b3a.19.2026.11.24.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:15:45 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v8 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for MSI handle check
Date: Wed, 25 Nov 2026 12:15:18 +0800
Message-ID: <20261125041523.242588-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125041523.242588-1-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
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

The IMSIC device on RISC-V based system does not require ID
remapping for MSI. So this device only needs "msi-parent"
property for IMSIC-based SoC, and the "msi-map" is not a
necessary property.

Add new condition for MSI handling on IMSIC based SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index b3216141881c..91bbbc8924f6 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -27,8 +27,11 @@ allOf:
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
   - if:
       not:
-        required:
-          - msi-map
+        anyOf:
+          - required:
+              - msi-map
+          - required:
+              - msi-parent
     then:
       properties:
         interrupt-names:
-- 
2.56.1

