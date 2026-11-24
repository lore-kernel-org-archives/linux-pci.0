Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529697;
	b=QXY2rgJhsd6195IoZ0NMSbqTmvs4RLXPUqghJo3lyXSJpG6Qc/o9o3jyitrV8cJaK7wG
	 wAsri37aOoZI+EPp19W9I10iWYCDr+laW7ZfNWuYbIkZAQ/v/1EqLyRmWV0hDwc3190PT
	 qcnZkDuQCXrV15F0FWOpT7ZHb1JMSm70362q7qLsn1bbOX3tVAirqZmzxPoFrU1Kip5f+
	 ZSLwFQEiZF5vwpNFkKnRkz6fz8SwKlNo4Qw5moGH0PzfUDvHIzJvu/uID+1XY+H9LyD0c
	 r+yA/07Wd8HCkDdiPvjZtonQbScyTuJBIGtC2aHsdHQs/fE4lmCmrkWACK8qrZMgxRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529697;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=FKlt33JJFFfMucq+OJkCuDuJ/+/09WWDq0lxZ46juB8=;
	b=Fb9SpzoI806+QyD1y5HeD6Vt2w6j6Vx3nc31y0ZCf+Yw0y6l1eC+qHk8Rgz3WYazzzhd
	 VNkzUFE2w8CMZSO/ZxYhtlW1zXdPlEXtsPAHf6dy5JzAWiYzkd3Cjb9bUqkUCA7r5JwWu
	 VJm+Xxgo2vDY0LA3xiFEXW8CDUd46Jov5GZHqhXw2akxeZsBmTloQYt5ErnC73eM9FlJe
	 7ih1a4qwYIi9Ais61n8fb4qkzpj89LwiedXhkev8ITqjTKCmwCPaEPMB84+LhDJbRf6PV
	 +VATXmLq6/AyBeIzFXqt86Dsdf41aeA0YSXuWtZ16ApiOlQ+neVKFEYP3xztXQPnoTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kXqo+9DR;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55B606A31E;
	Tue, 24 Nov 2026 14:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B55B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kXqo+9DR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FK
	lt33JJFFfMucq+OJkCuDuJ/+/09WWDq0lxZ46juB8=; b=kXqo+9DRZw6jA1Uric
	u17JtrVVUau4ek4e2EUhtMf5aezugqZV0xQ2NaHsHBbvN6i2CILCucUTzsh5lc/w
	bKBk2OXA1kO88lNVzhymjP5Y8UEulhUh1xyCpFqSEnKztV6Is3v0EzgKLd1R3QxB
	xkIX01Sp/kBIdZLBQovyuwIQg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXH6a6mwVrmD+JJg--.26188S2;
	Tue, 24 Nov 2026 22:14:18 +0800 (CST)
From: Kean Ren <rh_king@163.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Brue <ryanbrue.dev@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3] PCI: Disable spurious s2idle wake from the NVMe root port on ThinkPad P1 Gen 9
Date: Tue, 24 Nov 2026 22:14:15 +0800
Message-ID: <20261124141415.3464263-1-rh_king@163.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116202943.GA204660@bhelgaas>
References: <20261116202943.GA204660@bhelgaas>
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
X-CM-TRANSID:_____wDXH6a6mwVrmD+JJg--.26188S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyUZr15WryfuryxJrWUArb_yoWxCFb_Xa
	15tay7uw18Zr1qkF4rGr4vvrsrtFZrWryF9rW8Kr4Yyr1kGr4DG3y3C34SvFWrJrW5XF13
	tr4Ik3yfWw1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb0Jm5UUUUU==
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC3xox32sFm7rpzAAA3B

Hi Bjorn,

Please drop this patch -- I'd like to withdraw it.

Further testing shows the problem depends on the configuration of
M.2 Slot 2.  On some models this slot is used for the WWAN card,
and a recent BIOS update has already fixed the s2idle abort on those.
On other models M.2 Slot 2 is still an NVMe slot, and installing an
SSD there still triggers the spurious wake (GPE 0x6F) and aborts
s2idle.

We have reported this to the firmware team and asked them to fix it in
the BIOS, so I don't think a DMI-matching kernel quirk is the right
place to handle this.  If the BIOS cannot fix it, I'll resubmit the
patch with more testings.

Thanks a lot for your review.

Best regards,
Kean

