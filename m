Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F113959D
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777861360; cv=none; b=plCcdf1rs5zhjHXHXZbYeIyBqz2DWuKGrpPOkWRZ/Ml3S65/o05cy6RHXL5c+e6LCdDsjUNW0mTKyY8+1+xip3pbLtg8w+43cQN64CZq0KWklL+qU6cQHqoZdBL3wGM69sQBpg4jRUybJqEmpoVkQzv+ielcPPItXel8gBc74s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777861360; c=relaxed/simple;
	bh=vXczmFV5IBdVUa/CHv7/dKOn+w6DOjDWTr0mGGKKpjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3f1z34HreYNUNnAagqi8QWdtITNWOGLO3LCWS6VSHT8luQ3vGTLyIhFtZlOYHSyAXyxc9ibz+jkryR2SehINIeluDwaPAAYisyLWzu/ayrS8eS0ae77p3AoA4W82mYHI84XfexYnSssJuSMawgXmHRM0mj+Z5wosjF3yv8o/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5mL4PjE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5mL4PjE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b4650d5f5cso13088135ad.0
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 19:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777861359; x=1778466159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11sBpNgZWAmpiT9L62gLgTLuG3EqsF6a4WTcpSvFCD0=;
        b=A5mL4PjExaCsqhVD5U0H7dsSH5RFC/0jR2prusMOrfnb64B1HOAJUzsW+9ODVMT+b8
         8u9dR9FRktalbL56pFYcnp2N08iQOuzwbK8NrBKVckfm0mlhP7BPTCczFtTlIHhAHMV+
         sAm1n2xuFoyAurxO6V4WYL8PCDOkBEnUH8s10pslscr4WWFkWo6uLqisaKyL1m1rNMHO
         uLq84ZjoY7T+KaGyH/mwpoEpeGlOM/y19cv0y4YGy5JPMx79SWtI76PQOUNK3O3X6C36
         MxdylaW9tDKkuUx+gPq0Cp9srT0qTcmfilCStxm+qBxslDqrgZrORThF0YTMRsnbfahd
         EdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777861359; x=1778466159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11sBpNgZWAmpiT9L62gLgTLuG3EqsF6a4WTcpSvFCD0=;
        b=K5/Z3iBwozSe99iu1CW0UFYgzbEw5EocOqG2XDnyg7ccBDgRQS+a1w2RKIJZlkSTwT
         HpK2/R4af3xHXwCD9vp7voyl3IjO1gksgm8VCbFyuxUPvferaxpAPxKPKDBvXxhBUQiP
         sawT0oSsshnYknQw3Irg4MQhbDIkQOlFbYGr0OKR+ebtwJEaDEZFq5hl/yBgNoGfQavG
         pC9fL7ND9fxfp+1+nAXjlwo5zdw8C91h1BueuZNyYp79RGiX984+y19kiKqpiUtrI37Q
         oswbE8nHe4cecyDUeU8vdimECIVEMdjIt2hI+2I8yptRVXULg7InY96vrUULH8ABCqo+
         Bosg==
X-Gm-Message-State: AOJu0YxbJ3jlf7dUkEhr0Bujrdz0ze3/4ysPakQneOOxCp3PLZggSRaH
	mnvFKof6lvTbZhVr0lK5pl8jL5JcISi4FUP5+bPYobdT6x07//ZurHE9
X-Gm-Gg: AeBDievsM2Va3EroupTRPeVvRe2CN5qTy3FRLtngmBShSneSjtk6mlA5mxqVSOZSenk
	oZvJcYSqzXgHtnXqBlKoufkJLrdL4ys8xVCuXigUk4jv2YB9QxvnGeRacSg4re6jaPj9tGH4qLQ
	BDVuwtKI1xM+ajd3AKqj3X13/EuMy6ItnbE2MS9jVYHnyohCx78e3F+v45zqvBVIRyGI17HJSK2
	exaFs4oObVSF7gYWzds2QScwJlnbq7zSOEHd3N62Tw+40kQFqul7KRYxVcf2UNZAleBVlJFKkJL
	zacRa/4jXRY82j3CL9YVT5H+dqVcbIwgvlntTXziFvY4Rc22XUB+fuNwO+J/zx+6IoQm44t6c+0
	s/A0STNUZWQwJGTv0r4GTYN34EKJYSFMX2ZFm+pYDm1D4g1Bsjy38x1H7qkEoyCr7aDtdFQ4ZnB
	1zXwbg+pGaxhlDOQ++WM+0cHgC/fr7fVjfplYLVhyCsgkjA/zP5h7hOvUA636CcoMMwjUd9/XMW
	HBQ+02pOh7pH5UBYg==
X-Received: by 2002:a17:903:1585:b0:2b2:481b:de68 with SMTP id d9443c01a7336-2b9f2841e55mr75384995ad.35.1777861358669;
        Sun, 03 May 2026 19:22:38 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:5d62:8570:2345:8a42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae11fc3sm99505505ad.47.2026.05.03.19.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:22:38 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: bhelgaas@google.com,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Subject: [PATCH v2] PCI/proc: check user access return values in proc_bus_pci_{read,write}()
Date: Mon,  4 May 2026 07:52:31 +0530
Message-ID: <20260504022231.15501-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_bus_pci_write() ignores the return value of __get_user(). On a
faulting user pointer the extable fixup zeros the destination, and the
function writes those zeros to PCI configuration space.

syzbot triggers this with writev()-ing a NULL iov_base to
/proc/bus/pci/00/03.0 (the virtio-blk controller in the syzkaller VM):
zero is written to the Command register, clearing Bus Master Enable,
and the disk stops responding. In-flight journal writes never complete
and jbd2 hangs in wait_on_buffer() indefinitely:

  INFO: task jbd2/sda1-8 blocked in I/O wait for more than 143 seconds.
   __wait_on_buffer fs/buffer.c:123
   jbd2_journal_commit_transaction+0x388a/0x6870 fs/jbd2/commit.c:837
   kjournald2 fs/jbd2/journal.c:201

proc_bus_pci_read() has the symmetric problem with __put_user(): a
faulting user pointer silently drops config-space data and returns
success.

Switch both functions to get_user()/put_user(), which combine the
access_ok() check with the load/store and return -EFAULT on failure.
The up-front access_ok() can be removed accordingly. On error, jump to
a common label that releases the runtime-PM reference and returns
-EFAULT.

Reported-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c7604c9fdd7580cca4e0
Tested-by: syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
 - Use get_user()/put_user() and drop access_ok() (Krzysztof)
 - Rename label to err: per kernel convention (Krzysztof)
 - Simplify error path to release runtime-PM and return -EFAULT (Krzysztof)
 - Apply the same fix to proc_bus_pci_read() (Krzysztof)
---
 drivers/pci/proc.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..8e624d829840 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -53,15 +53,13 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 		nbytes = size - pos;
 	cnt = nbytes;
 
-	if (!access_ok(buf, cnt))
-		return -EINVAL;
-
 	pci_config_pm_runtime_get(dev);
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
 		pci_user_read_config_byte(dev, pos, &val);
-		__put_user(val, buf);
+		if (put_user(val, buf))
+			goto err;
 		buf++;
 		pos++;
 		cnt--;
@@ -70,7 +68,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
 		pci_user_read_config_word(dev, pos, &val);
-		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
+		if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
+			goto err;
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -79,7 +78,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	while (cnt >= 4) {
 		unsigned int val;
 		pci_user_read_config_dword(dev, pos, &val);
-		__put_user(cpu_to_le32(val), (__le32 __user *) buf);
+		if (put_user(cpu_to_le32(val), (__le32 __user *) buf))
+			goto err;
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
@@ -89,7 +89,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	if (cnt >= 2) {
 		unsigned short val;
 		pci_user_read_config_word(dev, pos, &val);
-		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
+		if (put_user(cpu_to_le16(val), (__le16 __user *) buf))
+			goto err;
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -98,7 +99,8 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	if (cnt) {
 		unsigned char val;
 		pci_user_read_config_byte(dev, pos, &val);
-		__put_user(val, buf);
+		if (put_user(val, buf))
+			goto err;
 		pos++;
 	}
 
@@ -106,6 +108,10 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	*ppos = pos;
 	return nbytes;
+
+err:
+	pci_config_pm_runtime_put(dev);
+	return -EFAULT;
 }
 
 static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
@@ -129,14 +135,12 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 		nbytes = size - pos;
 	cnt = nbytes;
 
-	if (!access_ok(buf, cnt))
-		return -EINVAL;
-
 	pci_config_pm_runtime_get(dev);
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
-		__get_user(val, buf);
+		if (get_user(val, buf))
+			goto err;
 		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
@@ -145,7 +149,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if ((pos & 3) && cnt > 2) {
 		__le16 val;
-		__get_user(val, (__le16 __user *) buf);
+		if (get_user(val, (__le16 __user *) buf))
+			goto err;
 		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
@@ -154,7 +159,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	while (cnt >= 4) {
 		__le32 val;
-		__get_user(val, (__le32 __user *) buf);
+		if (get_user(val, (__le32 __user *) buf))
+			goto err;
 		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
 		buf += 4;
 		pos += 4;
@@ -163,7 +169,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (cnt >= 2) {
 		__le16 val;
-		__get_user(val, (__le16 __user *) buf);
+		if (get_user(val, (__le16 __user *) buf))
+			goto err;
 		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
@@ -172,7 +179,8 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (cnt) {
 		unsigned char val;
-		__get_user(val, buf);
+		if (get_user(val, buf))
+			goto err;
 		pci_user_write_config_byte(dev, pos, val);
 		pos++;
 	}
@@ -182,6 +190,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	*ppos = pos;
 	i_size_write(ino, dev->cfg_size);
 	return nbytes;
+
+err:
+	pci_config_pm_runtime_put(dev);
+	return -EFAULT;
 }
 
 #ifdef HAVE_PCI_MMAP
-- 
2.43.0

