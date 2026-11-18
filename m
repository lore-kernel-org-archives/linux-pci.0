Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.76.78.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993975;
	b=gjNbiu/lp+jIYlodQ82RGty9sRVPVIaEDo82h3Ext9F1+wPVDTvz2XPUNQWf13Q5FHPE
	 beD7zJm+cD+FTOwFKlHUnUmds5kYOJPaOpdfgoxRb661p5N4mqlwHFbYfHyfa9pXHxqCd
	 4/E0YPsPJusAA/Ft/vXJg8AjSvXc2fiXAgWI4Ro1YRfZEK44lbPDR0FcusevNxRLq/Ln8
	 SMje5lEYV3vJER3TO3yPVIdQaCImT0xCVE5T9uhnBV7xRWRsGovI6olVyVkRAWnH1C9lv
	 MSZtv2GcMf9/FGLl8XsCfUXcgJVgWvUQZ0zowXRa3NYK4GZkGl8xTnCCnTDkidWU4aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993975;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=GaMlISYuqBRz58Q42qtm8oVBsqSnGT8qAf9wEXA5LCY=;
	b=V+6Sv16BoHmP3y962aMvh0aiI6tt2J6SL6mceg8aElU8A8QxsW4geFs8dd39ZIn4FyBX
	 RPS4PDI4kURnwx+FCqURj0mzZf9G/l0ct2PBwrrb5cWFnyltd7LYBQxUcR2r0bY/7LK59
	 KFb71hwcH/4dGLIxuye0++0cToxl4GBrtFtZOq11n+pbJflQczin6QdGHTZOYnRQpTgyK
	 ieojrJ32NXsFURAmTjpr5bHDdI6TrxQzdw6X+w/MQpkHn8OzOe1milJDKfTHivEWPxEhp
	 Z/WpHUWA/Q/Rgyc1aZ7RzFU6N04P0+GHG5ayz4e74Anvz+neahsiHMPuZ75Pc9d7EIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	dkim=pass header.d=eswincomputing.com header.i=@eswincomputing.com header.a=rsa-sha256 header.s=dkim header.b=RLjGci7b;
	arc=none smtp.remote-ip=13.76.78.106
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F0606A31C;
	Wed, 18 Nov 2026 09:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E8F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eswincomputing.com header.i=@eswincomputing.com header.a=rsa-sha256 header.s=dkim header.b=RLjGci7b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=eswincomputing.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=GaMlISYuqB
	Rz58Q42qtm8oVBsqSnGT8qAf9wEXA5LCY=; b=RLjGci7bIZwWBrbTR1DxSw01Gc
	ynxarXAmLXhbr0QSgP9Wq3KCppXWteJD2/MHRfUciRVKoH3Fla+PsQglAClMqurF
	JcZoZOWcqvM1AJMqIZSpA6KbsMCDOBkgdL8bpfIvbFGPhrV+woM6pKjBAXEeYq52
	QYuuPmCaAfJDlZsdw=
Received: from E0007865LT.eswin.cn (unknown [10.64.112.9])
	by app1 (Coremail) with SMTP id TAJkCgA3JuUsb_1qFR8AAA--.206S2;
	Wed, 18 Nov 2026 17:26:05 +0800 (CST)
From: Donghui Zhao <zhaodonghui@eswincomputing.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	zhengyu@eswincomputing.com
Subject: [PATCH] MAINTAINERS: update PCIE DRIVER FOR ESWIN maintainer
Date: Wed, 18 Nov 2026 17:26:03 +0800
Message-ID: <20261118092603.1331-1-zhaodonghui@eswincomputing.com>
X-Mailer: git-send-email 2.55.0.windows.4
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
X-CM-TRANSID:TAJkCgA3JuUsb_1qFR8AAA--.206S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF17ur1kCFyxJry7AF4UCFg_yoW3Grb_Ca
	18Jan7XFWrJF1Iy3y0vFZakryYvw4rAr1Yy3WkK3WqyayFqFn0qF1qqa92ya10kF4fWr9F
	qas3GFZrGF17XjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUd-B_UUUUU=
X-CM-SenderInfo: p2kd0vxrqjx33l6h245lqf0zpsxwx03jof0z/

Senchuan Zhang has left ESWIN Computing, so replace him with Donghui
Zhao as the maintainer of the ESWIN PCIe controller driver.

Signed-off-by: Donghui Zhao <zhaodonghui@eswincomputing.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d738990161bd..879a51fe36b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21767,7 +21767,7 @@ S:	Odd Fixes
 F:	drivers/pci/controller/pci-thunder-*
 
 PCIE DRIVER FOR ESWIN
-M:	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+M:	Donghui Zhao <zhaodonghui@eswincomputing.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/eswin,pcie.yaml
-- 
2.34.1

