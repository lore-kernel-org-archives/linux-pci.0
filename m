Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB24ED1A1
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780943; cv=none; b=Zk+Fiy7qqhmkEOdy+J0LDpFtXGEjG6OiYGTLWc+0/UCB8c2whB87bcnBSCVez9DNhIS1An1QYbSXNCb7z/LRYpb4Q0fic2PwFZLxwjyEB3qfESjnqy6RqUiVbpkM6avCjFczgDV+MRdFxMFPJ5QoMPOpLMHbLQzTDeoMxVIJqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780943; c=relaxed/simple;
	bh=DPVKVN5xXXAoaMKbr9xf4JRJlRrtKEzhZ77EGh6aO/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye9FAtN7D2B2yoin8+D7VXQocCtVlhu4eFqitmjFWPWbC6Fb1vn8UIXNgapzjdcburhDBLi/p1aSKdP4pKVeNeof4UH3tWgkRhSsb6+s8+hrnvDl+0G5ObnGfusmWZe7ZLPEHNX6Ve2hKjqYK66SYqvvV86A4WjSR1UsZIMMBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElgjC/o+; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElgjC/o+"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7dfso2969605a34.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780934; x=1791385734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPgmINCV8SVNtxSwxWT/uE2/pfejEYPQvV6kz07ef0s=;
        b=ElgjC/o+m9EGCSMuUCxjvJxSyRWInYLIh4wPpEL2U2uhr3IKDOyiRzMzGaPPolj55/
         STnTo7GBULtTRnGn/jopxFyPjd70jMjVUasHAUzrCGz+N9EJK9bnmexCUui3d7+rPlPH
         MMZrrjrz2nkuA9T2JkDPBrn9kFjb1wtMiuBOprv5kSl/1jQ5i/F14z7YSaaXdN/vvpSS
         WXlxCzQEektylYTIgRbunjBT7NaakE5SVMHJa4rQExxCv7etZ5W+AHTTKU7BG0EkcisG
         nWsT+IBeBhKqJY7I57OKYvfoQyR6YIeO7VuzXHEerIL2cdt1w4p5SMrlZ2P1ydzcl5PG
         gA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780934; x=1791385734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPgmINCV8SVNtxSwxWT/uE2/pfejEYPQvV6kz07ef0s=;
        b=oDbps1vaTaB4u/jPQCVgXaVirFrZsP5S4gvbjV2P2PlO1sIvGhDHQSP90U5stdQGZp
         /uywWhLvhN1B5+9Ybzh74omAwTr19HuIakolCUedsiJ73/JMc9kLjCnlXQwu8AT5pxYU
         dAKdTGEup8vbYWxe8VZRW9GMGhmMIq9NY6WMVUpj5NM/lF4lNU+cHvNSLUyLC3kmtVLN
         O6thXnltEZEdhfvtsRlRJ0VdlsDAJ3VOMlxIWTSilfQCsKi0A1ZXTevQfo16iv3vOEyb
         2H6DLdzpDrL3WxnuiZshc3euK8YQ07PZf378kDkxldAYb/9buOmwCWtq0kNyPYKVVWqL
         qEiQ==
X-Gm-Message-State: AFuF++kTe/X1IWhckAes7OHiJ4QwB4ODsc/vZk4ZLUOfIwevq9mkXGlZ
	Dggfu4NgC4peT8S2Y6o9aCyCzx0gfKreMgdUeEwdxiMDiB0xL4PEF21nTgsXI/oI
X-Gm-Gg: AYBFou0AtACVep8Kg0i3TMSBuMZ3Xk8vtByWblHrOE+LcqkyKKEtSXewjlTUyOINXw0
	VUNBkzaxZJA9d1Wi4gwwPcxSP3Xogu8S/biO6NXyufXIH8wk0oY0H6BIjEsxSj8SfX+Yg6Fc2BA
	KIjpcVYXOmwfm7KTQMrw5lmCOfHfiyvn7JK76KGgMcRxMF8dMyKrlvZSHgjPgD6bWWEL+jyXajB
	1anOx1l2P0lU4h6cCfpQXGoeNoWr3AAji7M/1TL1juP7VBJIUwmTEw4ObE/U9lIqwhMUD8WFf/z
	scv2+kn/eaGVw3Kt1gLNHi6z5roA42fnmccAXHdUvEA+WvijHVY7vloGEux+F915nHU1naE2ykB
	AYrBQQtfkkvRF+T6LwtGnqnkr2i0X/Wm3hsCDE7lYH5fr8r1VAs4XvwAnEX9alQQhnYWSwWynd7
	Hnakj4ORjKGi3XRjb5kuZjgjeYoM/B1Fhre5fbRvWJhfg39sYB8QDvSDV54hV8rIv4O2oZYmvSU
	t4qebKaOZQb/zoePBkE
X-Received: by 2002:a05:6830:3916:b0:7fa:5c68:d04c with SMTP id 46e09a7af769-8204b5c2093mr2071820a34.22.1790780934250;
        Wed, 30 Sep 2026 08:08:54 -0700 (PDT)
Received: from localhost.localdomain ([103.179.231.92])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82062ccb8c9sm1087165a34.6.2026.09.30.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:08:53 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com
Cc: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] PCI: mediatek: Fix integer truncation and handle oversized resources
Date: Wed, 30 Sep 2026 15:07:27 +0000
Message-ID: <20260930150727.2897-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930120539.4967-1-sreekuttan2156239@gmail.com>
References: <20260930120539.4967-1-sreekuttan2156239@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi PCI Maintainers,

Apologies for omitting the revision history in the main patch post.
Here is the complete changelog for v4:

Changelog:
 - v4: Fixed struct device pointer access (pcie->dev) for dev_err().
       Verified build and passed Sashiko review checks.
       [Subject: PCI: mediatek: Fix integer truncation and handle
       oversized resources]

 - v3: Replaced clamping logic with strict size validation
       (size_order > 31 returns -EINVAL), added !size check, and
       updated size calculation to fls64(size - 1) to handle
       power-of-two sizes correctly.
       [Subject: PCI: mediatek: Fix integer truncation and handle
       oversized resources]

 - v2: Added size clamping for size_order > 31 to prevent overflowing
       the 5-bit AHB2PCIE_SIZE() macro mask.
       [Subject: PCI: mediatek: Fix integer truncation in fls() and
       clamp size]

 - v1: Initial submission using fls64() to handle 64-bit resource
       sizes and prevent integer truncation.
       [Subject: PCI: mediatek: Fix integer truncation in fls() for
       resource size]

Best regards,
Sreeraj
