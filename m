Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AB30100E
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573584; cv=none; b=dI5TXFY6ltWkLpqYcbQz0CkViAwJzLlHCB61XIXRONFZ4HyZXi9+Lb88RYcRaTdjIJNtHxfXsvuU8Xgdy79hcP0Nm7JJEH1VsrgraAesey59B36o1CLCUWRMouILFirnNze0RK74c0YnUiamPysd89aRoGC8Hhuka6q44UvfAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573584; c=relaxed/simple;
	bh=aJtKhPA8Ii89k5Bn+ANeNGZlEn8xfbMvKK5TkqbdCFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHXYM1jsWoP0TQh5QK7Zltxlhsd6M02Z1yfqvXyblSRplJtlQTcAHmwb2LwBjPDxn1skpmKFIWInbpbSaz0dcT17PlS3k6eOgv1ZLLgn3+45kCOX/EC0QAC2IduiQOSxaFpsBiqW/tsORwplMNLrwK1lg4KyavztOHfZa47ZqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRQx/u9L; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRQx/u9L"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a4805e15cfso37890a91.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573582; x=1791178382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJtKhPA8Ii89k5Bn+ANeNGZlEn8xfbMvKK5TkqbdCFo=;
        b=SRQx/u9LwsgONKwh2yNpAE/GYyxErVeBKHdSMymnX5H1lKnrXiWnUGN20hhECZq1hx
         kJPyOawDx8eVETyp7qLWXtp4hfmsvgZw+mLkmJZr4V3tRX4BYHAZrZFvny80qHN0tO5O
         drUmNpOXEVzY+qxDRRvZoDs8WR1UJNL7LYaEhTBh2+Om1dz3Rqnb1dHZ7v3WTet2Ybg+
         yg0fD5CWvFODWMiacqRDVXXEE2YWfDkgeVafl2rKsgdYvr45vh5k8FWWuUip2GdRQgvP
         Erws6yoHMyLH78Nh1keS0OXgHU3oTQrxVDwFUZRnE4dOE+ciWVdme7reGmZzWcYJJpAl
         4ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573582; x=1791178382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJtKhPA8Ii89k5Bn+ANeNGZlEn8xfbMvKK5TkqbdCFo=;
        b=cYcmWnMgOKkxUBzDQCtj3cJIo68QGZyFd8i6EaCtQbZWuw1EH8f4iKJjU+o3c5RaHx
         mtmsmGhCJNeBUR0wiNelnL1no5u6GnXBKADWA7ZPHmsm91yirYeslIrYar0Q3uF5XW28
         gEyVVDE6ak1qKu1Kge0Zi/tH5ltzlGalfJuKC2DMhH6xNPCm4ky5jtQmSP15Foo5mBqi
         XrvPaRyak0YfhaA6IVj9oOZ8iXL3RpvRPhwXqRUv/9sIa6VSliEu3or8TJ7urZhS4XVs
         fAwip46pwmKWNcFLKn3gfoQ66MOPr4qsN93/WyBFolrxqmXJAUOBHFukneWTiTbxvW10
         F3+w==
X-Forwarded-Encrypted: i=1; AKwUvByK+QeK63/vYK7eA6wPRAnLmMZjS3A5oW41wTY1QrnNNEc2IdG/qlF2gk4tAga3P8CbsBokB/sI9pY=@vger.kernel.org
X-Gm-Message-State: AFq9FYINIyw9tO+KEUC2B/j0FO3wPIjj9Ve7RVI+PM+iUeHWXB72fBom
	pPWg4dp8R4UXow/gZvf6qydI5EAcG9M/1ahBP7IAyVoBjYN728To+Ng=
X-Gm-Gg: AYBFou0T+L32zr1kZ1ftEr/1d4Yo1dFwKV5fnGIuZjcNFdeSAi3eIy5Iy2IkN/zVys/
	HAuBp3i73YREy5mNmZlUkzLyvTqeGjJxQfyLopskvokW+rKdRdydehle2L6hXi/Si+i/1n80od5
	poZhLL1mHRGcTnnUuTt1JA2FxRzeWKzsJxiWDbt7WO2R16hFn0QXjdhYqhz26qj+JtqKiStMzKq
	UojdAs6XdWgk4T47L/LEy5KAcUxMz1ADU8US/oTfRsGEdhcY4YbPrMgGBWLfpvFqpetDbeV84YC
	IkLPlPArvrf7IWC3CHX84Qr3QGEhXxfiLpObbArvHSeH+HMvjF9eyYtyru0N4KTxMoMp14bo7is
	qUFFfLWeNCxI/29kurIFCdqHHa0zhh+6FUYmzeTmdXn+IkmibuYon1c758Ab2yBAhbUFvEp//ST
	CMSP7vCJ2sJFqfSbnG8x+2SJjc5QVUGwCK4kwK8NPb2g/HAkZca0zCh80QnWKC9ysQe2hznDVeq
	6GhYwR8hh9DBPaaSAAfKYJo9Aw=
X-Received: by 2002:a17:90b:440b:b0:3a0:b540:c00e with SMTP id 98e67ed59e1d1-3a0b540ccf2mr7945136a91.40.1790573582298;
        Sun, 27 Sep 2026 22:33:02 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:712c:b4ae:f935:9398:3170:36f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec711sm25046924a91.6.2026.09.27.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:33:01 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alistair <alistair@alistair23.me>,
	bhelgaas@google.com
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	jic23@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Fix double free of a duplicate feature's sysfs name
Date: Mon, 28 Sep 2026 14:32:56 +0900
Message-ID: <20260928053256.742182-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c4cdeb880a6eb8368c4fdc8de58f3b0bc6c753fa.camel@alistair23.me>
References: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com> <c4cdeb880a6eb8368c4fdc8de58f3b0bc6c753fa.camel@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 15:19:32 +1000, Alistair wrote:
> On Mon, 2026-09-28 at 12:50 +0900, Donggeun Yoo wrote:
> > Leave the name to pci_doe_sysfs_feature_remove(), which already frees
> > it for every entry.
>
> What about adding a NULL check in pci_doe_sysfs_feature_remove()
> instead? Seems silly to keep duplicate but unused names allocated until
> teardown.

That works too, and I considered it. I went with dropping the kfree()
because freeing them in one place seemed reasonable, and I thought the
cost was small.

If there are no other views in a day or so, I'll send a v2 your way.

Thanks for the review!

Donggeun
