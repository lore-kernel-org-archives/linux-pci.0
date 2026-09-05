Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD636A37F
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611700; cv=none; b=fUa1FcbdoxIOqpOQteUk6Ygz+Op06yeD1VwpX5xp/Q3K3a3HZftARaimY4/HE//eXACN9GUtRWZNRLgCrSbLmgtu4OYzOy3yKepCH6Q/t5Cvhkgm0ZtHX/alGZP9CMQzK9BZQhUYaezbXgJ/e4WdPL3LDBud1PmktzfmS2wCK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611700; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWYUPkfPbVX2FYdJTnZigfJ/odzxODj0e7VAGLfCs8jPNjd1l801TAzC2kull/n7SK8By2MndeE5Jiddt61DZzKjD8S83ktxAMZjMb0Mi9mhjHayglupM81w2Q1PZT0WrB6vch31/Iicbx6Ot209yoy0ECxliF6q275EwcNjuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtbnSs8q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtbnSs8q"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso1894010a91.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611696; x=1789216496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=YtbnSs8qfPdzgH+oeRaodn+q8Vb2tox19c9H6lxT0EFKc+LY1/TEPedO12k3EV0weq
         ZubHW2aMvu5d9wRdvZ2JZKz7OYJGt9lSYnONx4iIPgTgklB3Zi9nQUeDscBHQNI2nipN
         8PAydIGehlYBeD+FYQjwg6pUJGFz8Zv+UkkQ3/NrLop+gj8ozrTjmwWo2IbPI+M0RoI2
         BN+5/uzNIMcpl8wO3T4RqLVBYURIS6zQbCgT+MIiipkpQV3o9deat8Ivesk3Ege7KHGV
         agTdBI1D8e/AHP9rHdTaJMom7wYS+xvDGlXRUX3Io89bY3cqjDkY4ewjOrVt3ANdSDC6
         BPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611696; x=1789216496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=BHy12SXdpMShlXfXfAaveWhIWbIeZfyZjBc4MBRGxKp/VCGbCxCMnPqCZ0I0poMDzu
         e2nr+kXLrPAVWK8T1DTcQ2FdEcZDJzdY+uXeSwxv1nt8XPJl7mxY9qO6RxZkrJARSDrD
         I0jluvxsgku43pW5RHk6OFwCy8g5mEkS2SEMu4iOKfgJv0DpPa7R/YYGQiu6rNAa/ayO
         /NvhQoZ9s4bJLR/xV/hhvSKNB/EZEdAzosicoPoCRhURn6xHtQXqdB/bOTw0WPmSXaBC
         0EcEnc1CnewLcDIJWANeTRpSXrZPcO0H1l6qZ8jyYvnUIKFsMnB8bPok82Ora7tkEOg0
         cHRw==
X-Forwarded-Encrypted: i=1; AKwUvBy0U5o+KEaUB2qOmdpmqpukkosQceYEcM7LHf4C/yGqGe9vlh/76JMghETx5Q47U5d4477mrOfpMzY=@vger.kernel.org
X-Gm-Message-State: AFuF++kGAKsx/BCmFuEWldrw5JYJ/78nyrJnZ6p2ZI1FU2XPeCsX35+L
	uVdQv81UHHTK4UE2mj7CG6LrinctsUzSExZ1PIvycwXS7f+xQ4etwje8
X-Gm-Gg: AYBFou3Cfkd9cQweKNfXY3Skwz013SC6rtypBAgibIRWDTisHVX5EFY//ZknAftgmzV
	tLOHMP+uHu+y1IxhHo0+JMYQ0hRcwF7U2/wI89I4cYLmDG0vMBcJr6qZAXmYZFNqZv4/JRrgWxZ
	eIq3WXa5CoYJMSqLDXjenkjJUt0wtS9jexy9ddChB7eWG7hwkpcsOjCQ584EZT2LDekZcghPzVd
	GJrHPRL1SYcWXgCfPhB/o8/6/pbk/KINwroKJ6O4jzuyDjJ4/AAkelLBFshfYI6dA2PNNKCe14y
	FylaaexZL/QW7qNK5I6mWRDPxg7B/3QS/S1SnLpN48WHc1NsRZsR+1UsAtXYVYlt/exxaAm3DpD
	3qPQV/AU9+TKwqGgZ4+02x+DGSyEb/guihVR+7m4M4U+9XRvp3mrWKwXXf9lZ9SCXJpuaCJxUan
	b93zSP5b9XrBTI9vIRuimXU2cp85abeQxWf3G8LB+Jx6+DJjIqp4z2Nuc2tKNjyjf8ZVbpdAEKM
	Mwf6zUtvb1dVwwVFYFkTLqpjKajmikq
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr17366120a91.18.1788611696373;
        Sat, 05 Sep 2026 05:34:56 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:55 -0700 (PDT)
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
Subject: [PATCH v6 1/4] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:34:47 -0300
Message-ID: <20260905123450.5620-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0

