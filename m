Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871053;
	b=EdBPV3oAXljO7Lebmf5IYiThnHqc06vDltmdJYxvf/zdToA5Fso7RneyNSvNzb1s0eL2
	 Pf1jB4yWcEq2GHbODJQi/h/+6CZMj2hhLSXK9TXRbazJp1N8YpshbdsHMOfY98PHLn5AK
	 /8r1pmOgzC8g7sXX7JSOVXUp0U5GOD/gXVebdCE/TXMqE6NHoZYXdAefYqv25nAuUqj/e
	 WGnKuBYE15LHVAhYrPCegAYnG0Nsy+iVHYO0J0JxfmuAjaI+r63C/cR6xewtkTicwp7ga
	 ZbXt++SXxHoRW2UdEfp+8AXY5CQQdhK1N9UPmGO5mfngVKUGg+8t68yMa1arEh1qljg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871053;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=37wtj/M3le9oyNnQ1tTCunMmuSqLkcRxzy3Nls/GfTI=;
	b=yChtjVRIm1seJDapWUk4V8CAOarG/Y25enL/7RSTx3bVXf5VRxgPD6fzvuKGItmLJsPW
	 QEEDGhdlw2AYKr0sckl6ONF7JG/o7kyT5+vy2/1pECHo3TeB16MlwJ7dCXOpaZo/iWlbY
	 hCx5DyKSG0d6h7plRHAGDa08YGEqjPiKFShAgJXXp+TU/uhs8ZQuUvlQql+SsWdffNhIb
	 CvCGBiSax3ihHplCW4KDstHU1TtKII9StUNspK03+xf/LSf899NBpBxJikMHBuXTqLeWF
	 kmqd1qI/fG8adhirwzh399m/uiZdkxJ006bC80ZuzUnpDtRjnMpxy4nzlygGD5+RWaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Tiaujjsp;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2012606A326;
	Thu,  5 Nov 2026 09:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2012606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Tiaujjsp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Tiaujjsp/ZKmhtc29nwvRGQw07XNt+bd4zZ9A8XcyoZTEFiVMSlrZGGItTwYVKa3vM17kA0a8VYo3
	 77ypBNL6vH75No7bueBKypssIgYkS/D2DUEU3Mk5Jl90F96yJvTg8gt1NzkczZuBzjNzXvj642Vr9W
	 C5niU1w2wZXMgaqQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aec4cc690b-ab8a8;
	Thu, 05 Nov 2026 17:30:47 +0800 (CST)
X-RM-TRANSID:2ee96aec4cc690b-ab8a8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aec4cc6d57-444ad;
	Thu, 05 Nov 2026 17:30:47 +0800 (CST)
X-RM-TRANSID:2ee76aec4cc6d57-444ad
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: octep: size the interrupt name buffer for the full format range
Date: Thu,  5 Nov 2026 17:27:04 +0800
Message-ID: <20261105092705.3099201-1-xujiahao@cmss.chinamobile.com>
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

octep_hp_request_irq() formats the interrupt name with "octep_hp_%d"
into a 16-byte array.  The prefix is 9 bytes and a full-range %d
argument can add up to 11 more, so the worst case needs 21 bytes
including the terminator and 0-day reports:

  drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output
  may be truncated writing between 1 and 10 bytes into a region of size 7
  [-Wformat-truncation=]
  note: 'snprintf' output between 11 and 20 bytes into a destination of
  size 16

The values passed today are OCTEP_HP_INTR_ENA and OCTEP_HP_INTR_DIS, so
no truncation actually happens, but the buffer carries no margin over
the format's worst case.  Give it the room so the warning stops coming
back from builds that cannot narrow the argument.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507261457.SXXHOjUk-lkp@intel.com/
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/pci/hotplug/octep_hp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
index a0a7f9ccb..801c080e6 100644
--- a/drivers/pci/hotplug/octep_hp.c
+++ b/drivers/pci/hotplug/octep_hp.c
@@ -52,7 +52,7 @@ struct octep_hp_slot {
 struct octep_hp_intr_info {
 	enum octep_hp_intr_type type;
 	int number;
-	char name[16];
+	char name[24];
 };
 
 struct octep_hp_controller {
-- 
2.43.0



