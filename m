Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6B357CFC
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968431; cv=none; b=T5S2WDLCdKOFWiixaGEnNKtMkYoad31RMaWVUB/I7no+zT+fiblRZLDTCy84h34h8UjwVBjkZ+qqXHDmfC+5Dp/5VJNI3LecE0nv8Rp/kpdMCGiGUeBVzOuEDK2pExcmvJzLJFzs57u+jPKbNV9UoBbvF/fAQb0s+/K3MMcsRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968431; c=relaxed/simple;
	bh=K4dXuFjdLrygWeliwvNV/H7rdoqVo5eXsrZKXIh50eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be/qnX/bqE505eL92Co/x86ccDLHLSNlIJiFHPyzPJWEIMXcAA4AXddoGN/PZn813H9aZpb941f0wtq4SnvMXXYTr7e13bzdobttJhwslqNQXUpidIFWy80CH5zyrphUyGwN3agZd+vU+71yTDo4Odwi+ZqQZNplbB4a6Tsi+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djF6GEmG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djF6GEmG"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so25645355ad.3
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789968425; x=1790573225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xd8o2pAawE0z2eISzR2WyTi70wnc7/XhLNuD2B4d+0U=;
        b=djF6GEmGU86IVo3BorEOrk4ox1l4b9E5ym/I0UaxOqeNzMMgIt1PA8F7reLvucP+kp
         anhUqkgYs93cMXz6JrTDp1w0PamdLwVjZV6K/vTukPeMl3RzbW+ReJq96DjM9O6uU8/P
         98/JaNPUQlXYuaeLVlHFRR4P/ON4W4q8tiE+XWQemfjaZuDuwXzF4U3pmvD0VBFRFv3N
         2dDRvvdkoC3Nsak+iXNJ4pKysYc/ld7aUB4uq5uZ+FUiFtPYt+hJFzr+LpqilY54ev8g
         NBGQVfalMZmEHIQqkRDOC5Jt3p18ksFtcVzgEI4m9u0xufTR2UotN0/t2kjqD1LkcI+1
         /FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789968425; x=1790573225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xd8o2pAawE0z2eISzR2WyTi70wnc7/XhLNuD2B4d+0U=;
        b=F4yDDi0WVI7JLHOV/sYBou1eqMFRB9UD7MTeGCSSXLHAP88Ty3JhC7KyyPTF5tpBS0
         KrpsSbZ92pcFd+0NLjqnJ+XV9LbV4OkaEq4ncwf2Oqg/Jg1jjPMUIz8frTkFfRRP+Iz6
         gfcFkQeAfQmJNUVO+qLiYoBWvb3eo0FCApNe4gbZDMG6QO6RKeHsQZKjMH+HvNAChHZT
         JXg9ShxkEG/5bnStOr+D297pE8vU5zaDCT3oqx6R075LUA2qDOa4+MzThb7mfdK5z/FX
         UB1a90P3Vg9R+EbdVHMh6eG8Zknss8IFeHOCnWckTNL25JygXlT6Gm2LGdMec5ci1c1I
         +ilQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8FOhDvJ/HN8JE/RTkBYiFoPca+p3Uucfz7fowTojpjkGJO+SbAsIo3uFfrBjS+4rx7bCIR0gV5fU=@vger.kernel.org
X-Gm-Message-State: AFuF++k8fKb1BBbXg1Vpd920X/IavbMf0UJO7mYubUYi8FZvdikeooZD
	VBa3LR43HAyp534UNV+9RIlUqMzYld5yXz3fpzVU1gxwlkVRIUCLto/D
X-Gm-Gg: AYBFou0waGaEJtG8MURVHI2U0Ne4qo6w5OP9Jt1YGtHLzC+D+oKjEfPFrORjDwRgixS
	ySFcyFTANfT8DDV8PHhfOhCPkHl+QrW4K9d79hSox6mS1wwvZDMrQdlYZwLxmEdlrBEJ02wqXI9
	501UJ4ePebm8zwJ+xHPWX4rM/et2ElYc8j794bsVP8+5mmMtIZh//ylNOdRYUmfaEig6zW0wEPo
	+HrGegMWT35WoyoUMpdHcREC29GhFE6I5K0QlviUkRUHkddpIIBXiqQer5XjuaCDpWcRdOe2K4l
	hWLOEyxL+9SdKzExnJdrPctpGF+3b6vJwyGuOhOEFprzYc7tmtiGSVRxNka35yIWo7WozQozMGm
	6tAsFSu+lSXHOrvEuXdq2UmKNIG8BxafOMfe9wbgmdth0NNS+wg7Y0vZKuhjCNO6ScIEd5cLYmL
	0+gNaA1ZofvtHZBU5gEIi1XTUvdOW/nDSAkIA2iFFOmo4vXhDvr9aoPvPf9MlM73xb75uCyGp3+
	3coAdGFK6eaw+JUhykJS0DfO6Ss24dentBiHI4iV3BskBZEZHbeDl2zupBRZFZ9+FI1IGSyZdgV
	cVduEDsXrQ==
X-Received: by 2002:a17:90b:39ae:b0:39e:6c69:34d2 with SMTP id 98e67ed59e1d1-39e6c693659mr8697371a91.54.1789968424789;
        Sun, 20 Sep 2026 22:27:04 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e554e5529sm6677054a91.4.2026.09.20.22.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:27:04 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: bhelgaas@google.com,
	airlied@redhat.com
Cc: benh@kernel.crashing.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	benquike@gmail.com
Subject: [PATCH v2 1/2] PCI/VGA: fix inverted vga_tryget() return check in vga_arb_write()
Date: Mon, 21 Sep 2026 05:27:01 +0000
Message-ID: <20260921052702.1725696-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919222629.3798073-1-benquike@gmail.com>
References: <20260919222629.3798073-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vga_arb_write(), the "trylock" command handler calls
vga_tryget(pdev, io_state) and checks:

  if (vga_tryget(pdev, io_state)) {
      /* Update the client's locks lists... */

However, vga_tryget() returns 0 on success and a negative errno (-EBUSY)
when the VGA resources are already locked. Because the check tests for a
non-zero return value, a successful vga_tryget() skips incrementing
priv->cards[i].io_cnt / mem_cnt and skips reporting success, leaking the
acquired VGA lock, whereas a failed vga_tryget() (-EBUSY) erroneously
records the lock in priv->cards[i] so a subsequent "unlock" or file
release decrements the lock count without holding the lock.

Check if (vga_tryget(pdev, io_state) == 0) in vga_arb_write().

Tested in QEMU against Linux 7.3.0-rc3 by opening /dev/vga_arbiter and
writing "trylock io+mem" followed by closing the file descriptor. On the
unfixed kernel, write("trylock io+mem") acquires the VGA lock
(locks=io+mem(1:1)) but takes the error branch and returns -EBUSY (-16)
without recording the lock in priv->cards[], permanently leaking the
lock on close(); with this patch applied, write("trylock io+mem")
succeeds (ret = 14) and close() cleanly releases the lock
(locks=none(0:0)).

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the vga_tryget() return check fix in vga_arb_write() from the
  PCI_INVALID_CARD hot-unplug cleanup fix into a 2-patch series, and fix
  the commit message to reference vga_arb_write(), as noted by Sashiko.
- Update Fixes: tag from the file-move commit 1d38fe6ee6a8 to
  deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux").

 drivers/pci/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3de05aee7859..350ab9624eb9 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1272,7 +1272,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 
-		if (vga_tryget(pdev, io_state)) {
+		if (vga_tryget(pdev, io_state) == 0) {
 			/* Update the client's locks lists... */
 			for (i = 0; i < MAX_USER_CARDS; i++) {
 				if (priv->cards[i].pdev == pdev) {
-- 
2.49.0
