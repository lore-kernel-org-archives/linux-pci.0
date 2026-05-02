Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4917DA66
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777684494; cv=none; b=V2JNOUgqofBrY18MVdRxrJyP58mjd+60YugyjCBeVRe9P3miXC4RCkSDR7ZpnUUFhGm4ujEa53DCY6P1ox74YfMObAjghyNX72qPg53p71tVedpRYA7t6zRsZwzFiw/mJ6i6dsldG5E8BSSArOA+N905sApzx54s2DBKOw3XaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777684494; c=relaxed/simple;
	bh=NVRIJd3sZaE3k1Wk/wG1jgBSallzpNrHo8Bzg1ND7So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0ud6aPDcOJiU3/6bCSfZhysqg/S7Ies/rIR4ox7bzcnSGiyKlN0M1XUC7DBkEriV2jdJSWVun7Y6BisJ1lQ6ptmfcdRaEGFxDlqCPYEW8+yiMZzRYalchoptZu2EAjR79T5PcxzPjK8lZFtDYcobIzO/lwnvA7MClozStEYNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYBY0wzH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYBY0wzH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35e576110adso1740175a91.0
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777684492; x=1778289292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeW4hvV/WgVLnj/KuoEdcGxxm7PZW4GZRo6L36S6Gq0=;
        b=KYBY0wzHyBDbRO/no9hZBaOOugPuMM9H8tHVBNksxdU63o4cTvKB/ZJ77xaWzb3V3p
         sv53QJXLQ7AEZdSPCdEj556p69cYnCaLZRTH3rdU0mDen9fGtx5ak83AOK/yG9L+lM+T
         CkSYMU8pkd3uMXM6HC0/6RX9hpXV++L6bV6pj/tr1JHxjXCt70AdnhlZZ4P9p7BPvfeH
         zNIbhcB1mkydtUbtA3xmBXq/vxV0U9CMoZR79lU6venrzKQnGWZRlInvib8pRmqTg5wL
         EnWiG5uFDsKgdhmJshWer/iJKtqc9JxkMgtZxRROAPnEYrsR8Svcg9b0/byvw4Bg9UxW
         tjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777684492; x=1778289292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeW4hvV/WgVLnj/KuoEdcGxxm7PZW4GZRo6L36S6Gq0=;
        b=kOmrxfiLov+Ayhj66insXnPlJEVADPTDNy/FJm2b9gwugbVKG5ADy0qGNXt09iqnM4
         c6gvl5bWQ2TbDYiWTTuZl6EnhCWG5dtzaiTEx7E3+w0o9wuR18WURNKR/LVimj5icT0F
         Q9T1FurAoECjNaoWdioWQIILrxNyjQ0jDYB8fYQAQqCVYSeg3p1EJxZR2mrSKjTD7Hes
         gpjWJd6C1QtNS5mO1U6NxbjkhM4z5Nt23RytvYoDPP27xCgL86cL9X8jeIwmINt99rB4
         5Z+pJkRCPP1lcNCv5kLObDgqw1oFsFG5fTHgfTykYlmzXqFbt/hEaaGMpq/eYMZKMX1v
         05Aw==
X-Gm-Message-State: AOJu0YwEg6iviPetWlLoGTPF8sOLym+gd+/HQr+04l5ifpfUcIfNY7uA
	hkQNRzdXLcI13hu4xOcVn9NaaTMlQm96HDNDqpdQ4z1YfUWGjnQPTmr3
X-Gm-Gg: AeBDiesW1aB8KcIFTAQ7scaC6euWK0vVd2b7L2YEolEGksxLLSb0PDfFNiPZ98p2BLZ
	WDyGrucN1wrugPkVt/vn8AxqFVPEPRsslC0B0DGQyl3Iwan42tu4f3u8Lx61I14mv6ntqojs+US
	7FPc3nfOO5nXtlb7QXuse+RYZAzV+3kR0m16PTY/YfSt2PqJIVT0Qy5rLesaPEMjRjsupCWV3J7
	ZXwW8hFbOazzzH4GDo1FABemhWwYmFJZfqycX5Ab75ANFCaochHCgRmuxCK7F93Ky488kb25arm
	AgXUS6P9VWdRShUBz1tmj/xBOKxVxRIFohhxK05aHsHJqqx0yzEAf/ALpwjHTH1WycK/XTABXOW
	sCL1ks72UOZZudt+jUPCS6D0e8enByIdP78teRyg1GzG4ojtfiBcdNkQOlGLfj9ALoI1YWFSolf
	qNa86ZGrQ2A0fZ6LeXhdP9/B+djKs9JfwLgS/FiSiEjS15wHfv6r4OVux03ysg4h8xTX71fx9S0
	Maytajx5WP1KUsoPQ==
X-Received: by 2002:a17:90b:52:b0:35d:a31e:6b04 with SMTP id 98e67ed59e1d1-364c44b5c8bmr8336612a91.3.1777684492207;
        Fri, 01 May 2026 18:14:52 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:844b:65dc:f203:e880])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec736dsm3631644a91.3.2026.05.01.18.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 18:14:51 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Subject: [PATCH] PCI/proc: check __get_user() return value in proc_bus_pci_write()
Date: Sat,  2 May 2026 06:44:46 +0530
Message-ID: <20260502011446.125268-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_bus_pci_write() does not check the return value of __get_user().
On a faulting user pointer the extable fixup zeros the destination,
and the function writes those zeros to PCI configuration space.

syzbot exploits this by writev()-ing a NULL iov_base to
/proc/bus/pci/00/03.0 (the virtio-blk controller in the syzkaller VM):
zero is written to the Command register, clearing Bus Master Enable,
and the disk stops responding. In-flight journal writes never complete
and jbd2 hangs in wait_on_buffer() indefinitely.

Check __get_user() and return -EFAULT on failure.

Reported-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c7604c9fdd7580cca4e0
Tested-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/pci/proc.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..54052157c276 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -136,7 +136,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
-		__get_user(val, buf);
+		if (__get_user(val, buf)) {
+			ret = -EFAULT;
+			goto out;
+		}
 		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
@@ -145,7 +148,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if ((pos & 3) && cnt > 2) {
 		__le16 val;
-		__get_user(val, (__le16 __user *) buf);
+		if (__get_user(val, (__le16 __user *) buf)) {
+			ret = -EFAULT;
+			goto out;
+		}
 		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
@@ -154,7 +160,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	while (cnt >= 4) {
 		__le32 val;
-		__get_user(val, (__le32 __user *) buf);
+		if (__get_user(val, (__le32 __user *) buf)) {
+			ret = -EFAULT;
+			goto out;
+		}
 		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
 		buf += 4;
 		pos += 4;
@@ -163,7 +172,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (cnt >= 2) {
 		__le16 val;
-		__get_user(val, (__le16 __user *) buf);
+		if (__get_user(val, (__le16 __user *) buf)) {
+			ret = -EFAULT;
+			goto out;
+		}
 		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
@@ -172,16 +184,21 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (cnt) {
 		unsigned char val;
-		__get_user(val, buf);
+		if (__get_user(val, buf)) {
+			ret = -EFAULT;
+			goto out;
+		}
 		pci_user_write_config_byte(dev, pos, val);
 		pos++;
 	}
 
+	ret = nbytes;
+out:
 	pci_config_pm_runtime_put(dev);
-
 	*ppos = pos;
-	i_size_write(ino, dev->cfg_size);
-	return nbytes;
+	if (ret > 0)
+		i_size_write(ino, dev->cfg_size);
+	return ret;
 }
 
 #ifdef HAVE_PCI_MMAP
-- 
2.43.0

