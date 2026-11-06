Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793928687;
	b=i+72f/ci7Uh0T9ZUJTVsc3vovmbMR2PZLPJo4xsrysg+QxAgifWOJda80ZRm1d0ENPhv
	 T3a69a3/qAVm0Ux4U0Ecd6WelU5Q9+PLMOf3LfwKUqlESVO0mQ/zhWHAuOszx2LYYz7YN
	 3bL3Np8bOA6i0IoiGB8TIxwzyWUS2VduwvxiODI9Or5CAuBQELalWIq8ixPo2dcxOInPr
	 TRTiyjHZ1ZlqjDTXChrsOabKXohl2pJxgmcIgoWmghjn+m4K+LPg22+x94KmcHQeMTvNC
	 9bFe3/trdSdcqFf9YObXN0iMQsrZB7Sea1T/dgW/D9/4GQcUmKD/iGsR+kWzphOJYLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928687;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VZFjzE4JaCP7wPf5JkNzWBu5CcPsvgM0/fKZ0Mjg4xg=;
	b=Pyi8eLzO7vI0PUhQcYb/Skmu0VPSMuWsQFwO01UH68N1gFkzbAqUGpxYJm0ObEiVsFbz
	 V2MTth+kOnkrChQOhGz5pCxNWjEm0Pv1HRkecb9froCMXMDUW7xjdAxaJkPqM8BEQqb3k
	 VrMZGdtUbNDxpAm9pbBvOyTqLE19wfgXVMjTbB4wj6q8dAx7WCcYE9hsZw2gZuRrpPZ19
	 ocQwSKv32lgYwXOCkqNOEnckKowMj0ZxurzLBWz7qQp+3uoYV1U+iDH2RkmnP/dSwROgf
	 a1PV4EyYBadQTeuS53ZQpaSew3baoiqj2KEvdWRHPgMpWusch7hXbECAZF7hhfp01HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Zw0FKRxt;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75795606A31B;
	Fri,  6 Nov 2026 01:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75795606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Zw0FKRxt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Zw0FKRxtbhAaytD+dW2XOGlsdn5D9rY6RZMS7gvBPnruICfP4escli813RoSM/ut9QqR9flgh6KwD
	 H32iwXqZFae3hlnKNnKD1zeYmaj81eVsCzm3dwMYRJ4IsBkVVJgT/ww1fPgYoAYInmmnSbKwxw6oly
	 p7SLT+5H7XkJ3XPc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aed2de574d-76fcc;
	Fri, 06 Nov 2026 09:31:17 +0800 (CST)
X-RM-TRANSID:2ee66aed2de574d-76fcc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46aed2de4190-0c293;
	Fri, 06 Nov 2026 09:31:17 +0800 (CST)
X-RM-TRANSID:2ee46aed2de4190-0c293
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] PCI: octep: Size the interrupt name buffer for the full format range
Date: Fri,  6 Nov 2026 09:21:26 +0800
Message-ID: <20261106012126.3385789-1-xujiahao@cmss.chinamobile.com>
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

  drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 7 [-Wformat-truncation=]
  note: 'snprintf' output between 11 and 20 bytes into a destination of size 16

The values passed today are OCTEP_HP_INTR_ENA (0) and OCTEP_HP_INTR_DIS (1),
so no truncation actually happens, but the buffer carries no margin over the
format's worst case.  Give it the room so the warning stops coming back from
builds that cannot narrow the argument.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507261457.SXXHOjUk-lkp@intel.com/
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
Changes in v2:
- Keep the compiler warning text on single lines so it stays greppable in
  the git log (Bjorn Helgaas)
- Capitalize the subject to match drivers/pci/hotplug/ style (Bjorn Helgaas)
- Spell out the enum values passed to the format (Bjorn Helgaas)
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



