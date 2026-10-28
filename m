Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208682;
	b=Meq1CQNkgtVhX1GIE7eTCMA/44FMqILGeZ6/KnUXO7XTCEhVcSGQC5eHvGnC9Tu2epCY
	 U60b+H88PCe16ePZXayIrcg3A6NRPce//Az1H6vy+1CkXQi0nHSDNRdVLiBffMFHNOUTh
	 K2kmYQftses6isopui+ma0kr1yU2P5t4Wpu2mvTFzSFQ2wuwHGGw6UIaxTSZ9iOEYFKIO
	 2YGVQDjkRfEiXdj4FkuTPZl2h0s67BVe5kqRHU8P25f9iG4FbakDp6sAwMC5aKQh/kHJL
	 8+c69hfLl/S9sZ/lHNWEduFAjedC9QNNigM3X3vQ/JCKwt0tvXVyju3/CbT/9g4Lzfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tTbN8QdJzbNFg7HFB2EoFWXNNo+FJ0ZvprR3p/0DA4Q=;
	b=GBoLG1AIG1M8pKSFe+r4XEQ+8zIVXBviQPWQEyND+bERi/J4HZoAz6LRUJ1bkwG2zeFw
	 GaDFHvvf68PkDJkC79iJQWpEdb66Twcyjj5UUGx8MNy0A+xZtWOdu1RC328QENfu4aC9/
	 I22DqEoZcAM1j7TNQjl/s95InpycJeaRjs97u5rlJ7AldhlAvqam0K0TurwKqe5Zuvb55
	 16iU/3WoY+5SiR8N9U7F6hkmv/tOxFV47cxfD+d5t02DrNLwZghNtaqtJSS2W06T9hgsz
	 XQLxl2Xsko9eNzJukglSUaibLf4+z8OnJ2CV6pmsw451U41J/wg3QcM3Wl8I5qPEeQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rj5AXwlI;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F02606A325
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F02606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rj5AXwlI
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so11568785e9.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208681; x=1793813481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTbN8QdJzbNFg7HFB2EoFWXNNo+FJ0ZvprR3p/0DA4Q=;
        b=Rj5AXwlIRL1sM/sCWx/9TgqY1uZioctwcdwe23Su+an66Dqioq2hXH34IGZMtMjlNZ
         c6HbI5Xmhd+ZP7Hx+cWqoi3dAjlmxXVC7112rgscq4+HMiIJfKSx/VQEKYCCOUBqlwGC
         jHFBJeolrICukui6tBM3wuMTuKAcFUABKr41L84uYmWOSobC1okBV45oSHMP3bsdJSiB
         TZtr3QzQC9aLP5v8PgFq/XoD662rug3mQtnh2w0Tpn0ADA2Ad3eFdht2hOUY/8mDvavl
         yuGhdRax/mp5lm6KtXyqMkEsnAWnfZWLE84MspzN2kgfK0YIDikLfZwBTP6ZxuSfqdmV
         fYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208681; x=1793813481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTbN8QdJzbNFg7HFB2EoFWXNNo+FJ0ZvprR3p/0DA4Q=;
        b=c+WaG4hO8uJY6WneQwvdjsryCWuhZ8mpzfYFuPAA/h2D+PaCHkdBr9VCK0Eu08hr6P
         ly7CbSyKJQUp5mZVgF017MNX+0iU6crA+T4ExJ6SfHVclH1bShR2nsJtP9cH0b2soYb+
         w6xo0gv4sDDaGv9jVeDiRfFsTC+vlyXmZPoRCp0F0qfTbdMQ37xn/ytpIdT8RdOU9sI4
         Vu3AB7LCJMGs/2IeylYb2gN6g8X7iSJS934tRAgtE3Icz/o7zzimCdPKWdTd19FGuDGU
         iyToGoEkX79wS8gM9xTj8ss5M2Q8Hm8WE6po/uWstkrtaunVQq/9YCyCT6UtrT0d1e6z
         dlvg==
X-Forwarded-Encrypted: i=1; AKwUvBzEtvWwFdm8ZlrZj/sO+o+M7Cq6AaHMTo+51EmWdrm/hfAQJWDSp6mMWaXvE40cmqCAmJvsYflMEH8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbImkoQkl6+8KHCgeNcjtKF7Sl+YIcgisMlz8QIetBykvvGsqT
	cWkTqVjg/qU7fwzJDIQoPnNwG3qk3AVzJJEasxFGTfmxy4gQiDL8qDm1
X-Gm-Gg: AYBFou1kmriw3jm24hNYhV/f7iRBYQIZ+YDgXzJA0mHuBsz8k6y5GLn8cwO0Nzli8/D
	D7k4XLcce9JKvCyfEiJyKU4F27OWdTQDhbp/lEY1einQpkL/xeSsn5Q7cqNNvhCLABu9GG88oPF
	phBZ+dxzWmGRCxUDFk8wQVj8ytN0rdrJXpgq6T8KndbcC4D0TgwdzZd4H2fwiLVRMidtv5MJi+8
	c5glzTNk8nxNKajgNjq6XonyoaI0HUQiFFwNwd9EWo2Cy7UAeDPRrgdvqenZ1pAtKasoPHHIKdN
	qoxrfAqjaeSMs3WIo8sNrQyO4zwBPte9pwaSr0SphmQ7pu64fCYypxYpeDQRKC8bixltqySLUNX
	hXvmNPK51QbPZJVqAOS1f1vjduxH7OthRK1QUYdDQX4MqdpIhk0WREQyHaQkKKPR/HjqgOWxUZe
	eEh+A7yar2x5VuyInUry9Q9n0Wt5Yit01ApJ4Snks1LHYhSz6DXo3afr9X3y6bjUp1c+iK1e/rC
	Ter1IBs3ZUJ+5VA2WXaTP8pNt50CyvW6y//gvC1fGCLFVv8wWv82grmiRy/Xjq8uHG2+B4JUdqN
	og++dEyPLYpJcWCBu4ImY41SAPO8W0uRaaK7Deys5JPpllC6oGh1BZz/lomGkzFpGrjRcueTbMl
	uim7IA9jcW7Tf6zQHoFq3ukyFbYd04i75f67pxTkt0AVsmA==
X-Received: by 2002:a05:600c:1546:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4aa86a42518mr6057825e9.2.1793208680690;
        Wed, 28 Oct 2026 10:31:20 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80285b2dsm6496175e9.13.2026.10.28.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:31:19 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: iav@iav.lv
Cc: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Date: Wed, 28 Oct 2026 17:31:17 +0000
Message-ID: <20261028173117.3457220-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com> <20261026-rockchip-pcie-shawn-reply-1@iav.lv> <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com>
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

You said both SErrors and synchronous external aborts occur. In my logs which
of the two you get tracks the cluster the access runs on, which might be worth
a look before you move the hook.

Every asynchronous SError in rockchip_pcie_rd_conf landed on CPU4 or CPU5, the
A72s, across six boots on two different kernels. The one time the same read
aborted synchronously it was on CPU3, an A53. They also carry different ISS:
0xbf000002 for these config-read aborts, against 0xbf000000 for the unrelated
runtime SErrors on this board.

That is one synchronous case, so not a law, but it is cheap for you to test:
pin enumeration to an A53 and see whether your aborts all become synchronous.

It matters because only the synchronous form can be repaired. When it arrives
as an SError the load has retired and there is no destination register left to
write all-ones into, so no fixup can help.

I prototyped the synchronous half in September: an exception-table entry
consulted from do_sea(), with the driver substituting the all-ones the PCI core
expects rather than only surviving. arm32 has had that for years --
imx6q_pcie_abort_handler() in dwc/pci-imx6.c decodes the faulting instruction
and makes a read look like all-ones, under #ifdef CONFIG_ARM -- and arm64 has
no equivalent path. It only ever worked for me with enumeration pinned to an
A53, which is what made me look at the cluster in the first place.

Not proposing anything, and not reviving that prototype. Yours if any of it
is useful.
