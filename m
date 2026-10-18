Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5203DD532;
	Sun, 18 Oct 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341593; cv=none; b=f+Wb6HDa0D+Rc27D2UzE3EP7LG70cYCsKihdlQOArEhm6fsedgKVSjl9ujwfPe1cCV8bBwkGP2uU76e1CT42GM69lsUZPDGsIE9ZL2XvbFjYfKFjjddWKQd42wqkpM3A6Lw1IXw64pIrTueMruBbGnZvWJAI9JXmU22F/lZPgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341593; c=relaxed/simple;
	bh=xnz7VyyvGosr1DkFBgY1vAtFglzhSfCFgKNu3qVaUPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO/dNY5raO35sNZl7xXhENUx6o11DI2Wg62T5PQ05t9LqFQlsxjk/WmjufDtY94Lg5X7kKRTAajWLYHYN8uI9kpeo+1Lpip3Pwrfak/HzwLUIr2zPaLoPceztQKRpMPhRZ7Bml6jH0zUw3JUc/7Qlpft5m+/n/uBBUxy2M22nbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=CheW6/hz; dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=FNMkCy1W; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="CheW6/hz";
	dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="FNMkCy1W"
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=unwrap.rs; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341582; bh=uZDJsaDR/e
	x/tkUGgMpptdKBo0kd2xMrKUBmb9WaJLc=; b=CheW6/hzWWTs6Q0f9DJrbXmmcvztpxl0w1lfY
	UbyI3jaabrWlzrvk/Cj8gjonharhj2G/rn5iPCBEvghgQx0dSAptXQseDBp8hH0L/YIHnZ6Xs5W
	qEdYBYe/8INAymm/RQgsyEtqOJ98rG6Ng7Q8tS3a6TU6Mr9++Y8rGf4qoq/glssY3SA6KaraYcA
	sTWcxdMqsDJv9IgxO02Ncrxsy5Ul3LTBbPiDa31fbgNsqYv4Y7/IkyDXQIn91FciEkJdgVKAut7
	XgY0PZQf9jH7sIjmLuYMVmaSTWucuTHhLseAFM5BtgDYq3sPAyePe2Xf8QpAJrPt42RYLARXyqe
	0K2qg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=unwrap.rs; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341582; bh=uZDJsaDR/e
	x/tkUGgMpptdKBo0kd2xMrKUBmb9WaJLc=; b=FNMkCy1WyChku0/YDsvm3bS6vq01aCTNy0/61
	ostvN7wYmAYXAbP9yhAzonI3ABb2p2ZLf39ErQnWoeIjKx4AA==;
From: Cole Leavitt <cole@unwrap.rs>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>
Cc: Cole Leavitt <cole@unwrap.rs>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thunderbolt: Don't resume the software CM if the host controller is gone
Date: Sun, 18 Oct 2026 12:39:08 -0400
Message-ID: <20261018163910.132231-2-cole@unwrap.rs>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018163910.132231-1-cole@unwrap.rs>
References: <20261018163750.130470-1-cole@unwrap.rs>
 <20261018163910.132231-1-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nhi_resume_noirq() sets nhi->going_away when the host controller is not
present anymore on resume (commit bdccf295d7cd ("thunderbolt: Do not
touch the hardware if the NHI is gone on resume")). With going_away set
tb_ring_start() refuses to start the control channel rings, but the
software connection manager's tb_resume_noirq() still goes through the
whole resume sequence. Every control channel request then fails with
-ESHUTDOWN from __tb_ring_enqueue(), and tb_cfg_read()/tb_cfg_write()
WARN for each one:

  tb_cfg_write: -108
  WARNING: drivers/thunderbolt/ctl.c:1157 at tb_cfg_write+0x94/0xf0 [thunderbolt]
  Call Trace:
   tb_switch_configure+0x8f/0x1d0 [thunderbolt]
   tb_switch_resume+0xb9/0x3d0 [thunderbolt]
   tb_resume_noirq+0x5d/0x2e0 [thunderbolt]
   tb_domain_resume_noirq+0x42/0x60 [thunderbolt]
   ...
  tb_cfg_read: -108
  WARNING: drivers/thunderbolt/ctl.c:1131 at tb_cfg_read+0x94/0xf0 [thunderbolt]
  ...
  thunderbolt 0000:8a:00.0: 0: failed to restore TMU configuration

This happens on a discrete Barlow Ridge host when the root port link
does not come back in time on resume from s2idle: pciehp marks the
subtree disconnected in pciehp_resume_noirq(), so pci_device_is_present()
returns false for the NHI and the (about to be removed) domain is then
"resumed" through dead rings.

The firmware connection manager already honors the flag in
icm_complete(). Do the same in the software connection manager and skip
tb_resume_noirq() when the host controller is gone. The domain is torn
down when the controller is removed, and hotplug_active stays false so
no events are processed in the meantime.

Fixes: bdccf295d7cd ("thunderbolt: Do not touch the hardware if the NHI is gone on resume")
Cc: stable@vger.kernel.org
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---

Notes:
    Tested on a Lenovo ThinkPad P16 Gen 3 (Core Ultra 9 275HX, JHL9580
    Barlow Ridge host, I226 Ethernet), in daily use with s2idle since
    2026-09-17.

 drivers/thunderbolt/tb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 4e5d0578fd4b..d236de1e5568 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3177,6 +3177,19 @@ static int tb_resume_noirq(struct tb *tb)
 	unsigned int usb3_delay = 0;
 	LIST_HEAD(tunnels);
 
+	/*
+	 * The host controller is gone (for example the last device was
+	 * unplugged, or the PCIe hotplug driver found the controller
+	 * removed or replaced during system sleep). The control channel
+	 * rings are not started in that case so every config space access
+	 * below would just fail. Leave the domain as is; it is torn down
+	 * when the controller is removed.
+	 */
+	if (tb->nhi->going_away) {
+		tb_dbg(tb, "host controller not present, skipping resume\n");
+		return 0;
+	}
+
 	tb_dbg(tb, "resuming...\n");
 
 	/*
-- 
2.54.0

