Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580143;
	b=r2D10S3O+ot+nSIXjT8ZccVOgvkn2hXNOjF0yamVHde6lnykeN5kdp3J30FkluvAEf4x
	 ZrXQzbm39GBBCZ23luauYHdwnWdUeyYrnhHICyQ0B/pQOvlM1iGZzElzsxd6zrD1nSCu4
	 zSGTAJmbFZndHdtQ7xMjA2QPv9JNQIz3Dvl/D+fK0WppRNjKWPG/bao/ejSc2q9AaBMOp
	 ACNxVj7fin0qiRXdoTE8MHeE2VI2TNjoVAJy8Nvi8JK35skEzsE99Qnq3MrM+ZELw8XQN
	 8OGn3WzlKqF6H9IlfcqZXSTzIbq4ZzpXybM9djpMk/eOnnKyOwlp48UgJp+Rl5EfuBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PpG3C9sh88JfyNsM0V7xmO9UxxWA9lSYPUbiUsd72nw=;
	b=pVt8YE1bMiImj3w+869PodTKOfrhdHWefzcyBLjkUdUjC+SPAO4m2Gn5QPiDrdHi0WSl
	 HzW2FI/XLArHYf0XsAKFPnIXNl5OngNRedDBNpRtuFfLn9GwH5KwmnyBiiVajRmYLRi+b
	 zebq1SrFOVn3F7oEWc+q7GngPsUkarJR3X40Jcsc1AGypYXVRq3M0U8pRVl24mMMqlp/t
	 Un1vN8ZuEi0+EP0AE/fni0g0LpVJK6CLbhCrYC7ypKCkScqps3/r+YyW7hVKb5IVI5Z3Y
	 SGIJ6ZwXyJ/8bzbf7TuFOyHdfvysjiaDZT0s67aUpN2AjScjdUkZXxpR7FpVLOHAGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFAd1nxk;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CF606A333
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 651CF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFAd1nxk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb9f760337so3113981a12.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580143; x=1796184943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpG3C9sh88JfyNsM0V7xmO9UxxWA9lSYPUbiUsd72nw=;
        b=jFAd1nxkyDHlYP8vDA8XBLXojJOHRjb9TlD+l1dN4S2F238hvJZizt+W+ul+5yjyH4
         EV/WIbFPzT4KcJj2m80tv36HJePWxGNGdG4IpKm0P/1N7Yx3ec+t0R3Duh/RyH3KyMiv
         0kzjA3UunV872M6wvtFD9DgjGqiHSQW4ddx/U5m/ebXuQAc0nwCtaIVte/JeQmX6Kl7M
         2iwbKCUwxKn0CNm+8xA+Yhd7GeyhfpEzLb9CEXK1JSBONuQqqJ+fCt/Szqdl7oBVvmy7
         a8PYSDaF1C4Hvxc2m0Lz2rATzoucQA7nDp3T3RT9gtlK8o3fZGD3uTmaHvg01ZccX3NP
         4GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580143; x=1796184943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PpG3C9sh88JfyNsM0V7xmO9UxxWA9lSYPUbiUsd72nw=;
        b=TVRw5AfKJmUJ+BSgWMcB64hI/YwQB10KYpj8msXXy8ApcPZZrNji3ichupGO+JpMon
         envDnu1AxA/dNAdB4hgonm7iXlPL/8u0RPiVQLIRMtOWkPXwOXlf8PBlLsR3izAmDHgO
         wL2pEETqxs1qCr+9x5sVNzm3HX9p3ZXJbjWqnUIxXggkG9D9NQGzMWNqyX8uWqDbVPlh
         i7LdRtfDBu0CJXEPVTKUXNfz55ngXDu5896ozqsCrIU7bHuT0YPDFSbGIy+PHB/LkbLc
         j6pphnYdKb9qpJHjGjKcLD/O12XxE+QsHGboAmLDVM47y0ajoMO3aAhgIQq2fOk25wv+
         UGlg==
X-Gm-Message-State: APuU4Z+8lwrnQfEbhe0AS8/Tm4HNpjQ8yfNTZIspIz3JqW00mGs7uG0K
	5QzMfOOcMm+LExTpuNzxvHyhbOMmZ1390Wm8GaC89WHW3aOV43K/NUh4
X-Gm-Gg: AZFdTZfpioteFypv3ZSdxQWAtTpZkle0vO242QxL0WwsAwGcwzkcy21FfK+9kPIMLuf
	+iOIlqP4529GKAijc12+66NTljSSc5oiSlkCMxdi9rCg6NNQqWsj34/DswLrt/IGoZ6+x8r5lqc
	bQ1WJq6HmAmAlKKlrM+mxhdz79fIjfTTMyXQKb33u3BJ5nlyCjZkkn/05KNxAYLm0rB9tAtBk4e
	80jU8+6p1xiOWM8UcZWw8Lxm4sGsGA6gniqmyh8MtmPlQix7ASws9ktuqMAXCSjrn5oqE50Tsft
	jwnKVYNRpfzZN9rpbI+757ABHGjxK6V8OoCUYhKTh37bv6MKB8xW20Qzv8Hr1sbAsrbHw9RHLyA
	Knb839YR2qfqldl2IQOqPn/lOTM6PytT0hNcr6Y6JZVy7Xk71tX4vyNQjucYZ4V/SOEmhBlYqUR
	SAu2uxlYcRfwa7Ed8z8qsOmGNjSj0JNCA0xHzmmfc08Dx5rzd8IioY1hPhgs9ItYffKCXCs+frc
	KGOqBefN1JPfMYNjN7JQjHQg8lJqrdYddgYhJTwEm26Y4WU25xOT6i8gTk/nxjhnH04T3OY9UuZ
	A13F2uJuG3HBUagRKlJjScS1LJhCcxz/AZwMZKNcKT6Fq7yi
X-Received: by 2002:a17:90b:3b8f:b0:3ac:b3c7:de04 with SMTP id 98e67ed59e1d1-3b41c95f0e1mr11207523a91.34.1795580142737;
        Tue, 24 Nov 2026 20:15:42 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm27848549a91.13.2026.11.24.20.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:15:42 -0800 (PST)
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
	Longbin Li <looong.bin@gmail.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v8 3/6] PCI: spacemit-k1: Add device id update helper
Date: Wed, 25 Nov 2026 12:15:17 +0800
Message-ID: <20261125041523.242588-4-inochiama@gmail.com>
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

Both K1 and K3 need to set vendor id and device id, add a helper function
to simplify this.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 8a3cae32609f..f20c74eca73e 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -55,6 +55,7 @@ struct k1_pcie_device_data {
 	const struct dw_pcie_ops *ops;
 	int (*parse_port)(struct k1_pcie *k1);
 	unsigned int max_phy_count;
+	unsigned int device_id;
 };
 
 struct k1_pcie {
@@ -156,6 +157,16 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+static void k1_pcie_set_device_id(struct k1_pcie *k1)
+{
+	struct dw_pcie *pci = &k1->pci;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, k1->data->device_id);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static int k1_pcie_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -171,10 +182,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 		return ret;
 
 	/* Set the PCI vendor and device ID */
-	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
-	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
-	dw_pcie_dbi_ro_wr_dis(pci);
+	k1_pcie_set_device_id(k1);
 
 	/*
 	 * Start by asserting fundamental reset (drive PERST# low).  The
@@ -384,6 +392,7 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
 	.ops		= &k1_pcie_ops,
 	.parse_port	= k1_pcie_parse_port,
 	.max_phy_count	= 1,
+	.device_id	= PCI_DEVICE_ID_SPACEMIT_K1,
 };
 
 static const struct of_device_id k1_pcie_of_match_table[] = {
-- 
2.56.1

