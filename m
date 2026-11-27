Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774066;
	b=rzG0bWOVZK2Px65lqslu0wh+4gtClc0eYH5b+ol5oWTzbWnN7Ddym/b4TJ0ElT50ySER
	 kMR0slT+bQzt+tnQ5S16FruQEDt84fwkHl6d2QMWmP6j7FwUpu7UwWDPrOuUaGErInliu
	 804vVZJdOfWm/grlWtLeom4kdedenBWEteBdsh7HzrtZb55PKase0AsxDLLjkOYmKdXuz
	 hvdhl+uZVKlMB24+0jh92tuQpY1GKpLWmP1jitgl2W7IZ1hH+JKzxW4V/dJAj6HE89wWg
	 g3Y3gA6loura+MF3QdHGdekQ8u0dw6x2TC41aWiqcEr7DkaTVEo++tJHHCs8r+nrCBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2TsM750EvEyHCTYANfGa2Nzz7ULmsTnF7jQbx8T+XDI=;
	b=XSw694qbDDR7ZTNQgKafFu911NoNn+vr+4uY/J5GghErXkmKqEHyEPtIcMrppdIXWdhY
	 7DIbYi/g+9rzxSyiA1WuamN0ytOvuIQH8p/6X0ZQ/Xg5TsGkwSJecE+LxlakCct7gJI2h
	 A6gYMTBVpdjfTJpBPdnzern7NMSKWyFSW3UR2lQ9ZdvI0y3Do76li+NqHjU2pzGy3OTK4
	 YVVckvlMhx+IS+s7H7cGG8XQchbKZsuCCfcPRfjiNiv7btHMucDGLzqPfo8RLRMev4yat
	 Px/kHyoQGbgQB9eGUf9V7wnanniYlopel6A4iAREfOEIyMUtNKfFeFgvb/fRgjlF6iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU2ZaTq0;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B6606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 10:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU2ZaTq0
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-497614c95f0so4502324f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 02:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774064; x=1796378864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TsM750EvEyHCTYANfGa2Nzz7ULmsTnF7jQbx8T+XDI=;
        b=BU2ZaTq0d6nf1kovPAqoaEy2B2Z5juQ86UZVsyi7FuGSzKihaXuQNzdd9WoQLSo0aM
         P/cXUEp9Cq6z31xzVzvNqN4PsDGGRlJA9l0YVzY8kORBXq0HCy9XTMBUlgYoBKEB/+kH
         IL0Ddpwbyvi/NKWtVoybkKI/qsVd/SO//vMsn0OIWuTdk/ogGN/eMjoxufZ9tTUMRgJu
         aIr9AGk4gLT81BSknWgNFrXZ0ecEPnsWBwvpyBWSn/8bQUJ0Ge98uGy+cLaAMIeiDyeL
         5IbxBwpY4v/lcrhdUGRT/qtIIUmL0RpW4dv6yYQ7ZN/jacHFp8DvBkpzBY6C/gSIlzjS
         qaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774064; x=1796378864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TsM750EvEyHCTYANfGa2Nzz7ULmsTnF7jQbx8T+XDI=;
        b=dqZVXTXBc0KZbvwILhUrMWAydJE15nIFB2XcKSyhYym9kT3PCfhACscQsbBy7gZZ7E
         B/0GKseI3kmJdavAlXFWu7Px0iXl/Q5ZqoucDR2u9/ooYVTfHru0tXQkUtxI5U0pDtzL
         i/o5T5wlc28kccZzpehvB9/0QBr1JjRaKabyvPzZyUUW5L2Wz1X3dRznjCMB6uVB4zpI
         dkUvQ6ZXeFLrLw+1cTGRPREk3sEpERQyJROxos6D+bDtqYFuabepm5qCvVchHT9SxtG+
         WRUZbOcs8iXW3BI/mJn80k771YdcfNBWwjjZiZYtRoJK3rZpJvhpgnuiL2OvDT/uXZd9
         69yA==
X-Forwarded-Encrypted: i=1; AL+hErG+L2yCtegsIayQenPnhJtxPOaKoN/xb+fLCK6Uz/wOZuPGUvPjWXqlNIu26ORRxKeN7WlTK45lE68=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WPPBXylvL7h1k/O5sHiBInIzUPdbw2g3gIq69zgm/1nhVwucT
	is3W+6WXcg11duGNJWVvWoMJx6mgoKLtczyeCfVnICz5EILQ/kacFaGh
X-Gm-Gg: AZFdTZe3oFr/eY5qrLbO9nFQxdUUUCkkaeWKPEw34ZuMru42KjnnTJUXB3mKL2zCJv0
	PPlh4I69j1qIjGsusr6+sT7VJHRwleWQtsZ+A0SutcqznII5c5LL2B+R1hjbQlQcfC4h24ngMJo
	RNgQ//SwzEN3eQJoN8eaMjh+H+TOheOTe5XLb2hT/A2//xARWl+shSsYxVJnLzH6l3eUYSl2tXx
	YBanReoUcBqbglKvSKvVl5IpBSDL6OoFXvMmqeYdkx5qwis0usRJIp2qSyskRok1KsHLfUlecG7
	ZS36O4JbvcxpIHtXdNRT7byhA8cQM0Ee6zIRvhf5wuw7YeDJYrjUCeA5/ryMbMprpmyrehbDXXF
	31YV6l5XkkQgLGCTqDCvcXewDFdCU+jUCn+n30SZfkddCfdAKLUqJF7lIgpmvv1/RorF/wKvx6C
	mnf04KNe1jByXDEMbzOxCxyK+z+j/kHaEYDFJJNX4IYl16r/pXM8zSn+m/jYHmSO9asBmms0ZmJ
	3paMOAud8Gw6KWn6UX75AaIEAUZjFyIH1MckJfHXSsELFWKrb8IWhr4yf6tM09wJihKRWRT45a3
	22QzZAKZs1tIFubVr3wHyGsVEx6iJscR+aznagmvJWuy8PE=
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id 5b1f17b1804b1-4bb888169d0mr516683475e9.20.1795774064226;
        Fri, 27 Nov 2026 02:07:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm196561955e9.3.2026.11.27.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:07:43 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH] PCI: j721e: Properly check the error of a syscon lookup
Date: Fri, 27 Nov 2026 10:19:13 +0000
Message-ID: <20261127101915.1348807-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The syscon_regmap_lookup_by_phandle_optional() function returns NULL
only when the property is missing (-ENODEV). On other errors it returns
an error pointer. The j721e_pcie_ctrl_init() function checks only for
NULL and passes an error pointer to j721e_enable_acspcie_refclk(),
which uses it as a regmap. Propagate the error instead.

Fixes: 82c4be4168e2 ("PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---

(Accidentally bumped into this while working on BPF stuff.)

 drivers/pci/controller/cadence/pci-j721e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 822602836b12..fdae51e368e0 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -334,6 +334,8 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 						"ti,syscon-acspcie-proxy-ctrl");
 	if (!syscon)
 		return 0;
+	if (IS_ERR(syscon))
+		return PTR_ERR(syscon);
 
 	return j721e_enable_acspcie_refclk(pcie, syscon);
 }
