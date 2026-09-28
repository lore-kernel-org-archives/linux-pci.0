Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130029A309
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598646; cv=none; b=Og9vFUW/uSVrlcrzs329cAO0D0ScOojSIk8wMP3ZTgT05GlKRtu7slG9khzbMMBMysScrToduftbPFcUZgw43yr0mAIEvV5TRN4r1n3Frtna7uK54teEGSjJ7b+OR26xsEubGREBS2IF9sGR1bUv/7kuEGEB+X8WpGe9vN9jduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598646; c=relaxed/simple;
	bh=lW1sE3GkZSINChbEihYaVI4nLt96EbTsmg4AS8HyOt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRUioL/ROGbXiZiZYPBM3A+rnGfUftGsl+3Xl3/7C0V8xElbF0IwVhYluYld9M66Lz4FZx4zx/5rUSC7aSqQ3FAuseHYw8SzVGktCThAPKuvhP/vvWSMy7WCIJrCvjy1gFMu3YxXyNtCaJPC8wvFjw57z59+qRLanYi7xv/6KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9hjUjLl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9hjUjLl"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398beb616f5so1497344a91.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790598645; x=1791203445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kRdJi1zk/+tXAmS2OAPRi0foJMTeGfHkadWquQLI/Ac=;
        b=p9hjUjLlzkpxsWeUXKTamma7T+fJBZhxfPnIbfBwihp7CLqXR2hibAgUGfrvHGRNW8
         Oo/BTzzBbSAgZ49daUH1yG9+YWkdbwOLQF4AD9Nm4wuEwdpZEenNFHSg3O258lu32QPU
         oNu81O/C2JBoRFJGw/cAAqpcd8dOVU7EOaYSZI91iiGkdyLAy9AKGhTCo0FJarl9CJqf
         6SkkM/PjvlKbKWrL/u/Ra4ELYhN8Dw5mvlzi3RbjplaozcFUWHoLuad9W70sQ6dbt5n+
         tSZRDfL36Tvh6g4s+bugBYlOiuueNLsHDuW6uaL65/y/TAwGs/1fNRA60+yX97EhYm3R
         I+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598645; x=1791203445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRdJi1zk/+tXAmS2OAPRi0foJMTeGfHkadWquQLI/Ac=;
        b=sewyejGLgsTd5HR9H92lilM3KTuQheapuSMoeNnvj83GP5T3sgAjSSC/oXBNp68X8y
         7i66VDFl50bx4fUoQXUcl+nrjrn9killspecap6F4QJ8SgEy50PN3lq1sN2rYJdRZsy8
         Y2Rr3A32IszC69R7wImp/UcpvPPk/8igwHK7DjZeZtEzJwWCvJFCRM0pJF/HHFwxSnsZ
         KN+DEVmpJmY179jRXd5u5+t5Q9IS1WHjYtx51FpMg0yD60zhIhvgrgEqq7LS780NQgRB
         AtEG3AJ/BPhcabOS/mMLwf+iul/HjBk0qEm2p820FgQ5gmpnzFl/MyHrmNf/G3R595SF
         g3mA==
X-Gm-Message-State: AFq9FYLSRq2UyMa9agi3V82+cfBDIhjQLECgwU4QSEF6Jg/jhUnBe4Qt
	ywiTCtcvjNh+obyt7/1m/vQ0TE/AyU+e6yMIr4y0auy7ZHZMMPPkoO1m
X-Gm-Gg: AYBFou1prLZzo1OmA1Ac+NnNfD70/R2tftbf2rp1Otxt8hQZiecfCHlY9mdbzHk8osV
	NNXVWK9pjWNxB0mJ+yt2hkCwbBeSfSuxk1aHpxwBLRqDr4+lHbEtBXeWClyPsccO3nXbPeXmbhs
	3mgt7HfJaBDs+kVb2hXZFETIQUnWFDhOvAevWRjauvKHIccDy23WZ/omvs6ijLyR/DhBF7wM40K
	X6Q98OLvGbUszhU2yWpXTn0dgQ02N+rnlRw5CI3aRvlqaHfPCmIfxsfczIwXFqZ59QZz6v2MO6H
	E5eINrKTeRxSYlNlvjCRVtH/oiCzjKEE4p1+YfcpNhrTplfTa0wTmVLN9+GZ7u5nRoGTbIizcH8
	3QR4Af7HtbQnRpeqgJ+I0t5/JuuyCrE4CG9sXuryxQfMYg/G3UkbWjMe/OjQREnJleASr4TGWDv
	yslaYjs1tmcYerGmP1fi4E65grpKdwgb3tqSDEYmE2ObsVvhJbCQ50Bh174kutXurbaw4fO+obH
	/hlDyNB/QApVmqpau8fbg7GMFIYXbdSVV8yrFghaPRHQt+2ttkk6iTqz70eOnYg
X-Received: by 2002:a17:90b:1dc7:b0:3a0:b7b4:b65e with SMTP id 98e67ed59e1d1-3a0b7b4bae2mr4411774a91.2.1790598644712;
        Mon, 28 Sep 2026 05:30:44 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:92e9:2799:890f:9b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913ff34fsm39878305ad.37.2026.09.28.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:30:43 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: bhelgaas@google.com,
	david.laight.linux@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: [PATCH v2] PCI: sysfs: Reject unaligned resource I/O port accesses
Date: Mon, 28 Sep 2026 18:00:36 +0530
Message-ID: <20260928123036.7902-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_resource_io() validates that the requested port lies within the
BAR but never checks that it is aligned to the access size. A
pwrite64()/pread64() on a resourceN file with an odd offset and
count=2 or count=4 reaches outw()/outl() with a misaligned address.
On arm64 this becomes a store/load to a Device-memory mapping
(PCI_IOBASE + port), which architecturally requires natural
alignment, causing an alignment fault and kernel oops.

Reject misaligned 2- and 4-byte accesses before they reach the
low-level accessor. With natural alignment enforced, an access that
starts inside the BAR cannot extend past its end, so drop the
port + count - 1 range check.

Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Check alignment per access size in the case 2/case 4 branches
    instead of using IS_ALIGNED() with a user-controlled count, and
    drop the now-redundant port + count - 1 range check.
    (Bjorn, David, sashiko)
---
 drivers/pci/pci-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1f21856aac8a..8118cc6b3a61 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1209,9 +1209,6 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	if (port > pci_resource_end(pdev, bar))
 		return 0;
 
-	if (port + count - 1 > pci_resource_end(pdev, bar))
-		return -EINVAL;
-
 	switch (count) {
 	case 1:
 		if (write)
@@ -1220,12 +1217,16 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			*(u8 *)buf = inb(port);
 		return 1;
 	case 2:
+		if (port & 1)
+			return -EINVAL;
 		if (write)
 			outw(*(u16 *)buf, port);
 		else
 			*(u16 *)buf = inw(port);
 		return 2;
 	case 4:
+		if (port & 3)
+			return -EINVAL;
 		if (write)
 			outl(*(u32 *)buf, port);
 		else
-- 
2.43.0

