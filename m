Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F233DEE9;
	Sun, 11 Oct 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737402; cv=none; b=FkNTYsmO3D712x3AIWlW40HKSTliHlpih4iARN7HbKRp6dj6s5/yFGbFWr67ARKQDC4fGb5W0TRkb2UvSmNLyuiO1Si8gqH1am32yCyHgvj/zZ0AuD9AbJM3gDH7eYtHRqM8lV12awlZfIxxr6+Zk2RbhziPeHJgIP7S4TcOEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737402; c=relaxed/simple;
	bh=jW7qFfYaPTIHT7+WxIP915i4+xod11JStOTHqdJWPv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmC4WkG4faHZz8WzR7xJfozl0+xSO9yySF02HaA0NIG2/hUMsBdyn6L3dugB7xDUqcnmUKS4USLnK+AlqoYtZ0BA0d30lH9ZMbDX44gb2exz546GDR5rSQ8I1+DxndvJEJ3vnyDAJUgjacrgPqJ3ed5uva81BNJPp3fuy9mcPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U1OkwTPq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U1OkwTPq"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j2mmP2mB6z8trS;
	Sun, 11 Oct 2026 18:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791737397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puqRLr73K8ZyLUEwINqfs9xudJKVr1Yd0xT41SauKfg=;
	b=U1OkwTPqH6PFLKaXtlM8xyOnVRkAo5fXVV+DVNW1QKsKfJiSsu9fiE3/6BY/ox6OYyzdX4
	o77VT3nHCV+TcRxNySHRPUoDxnRo4+I7inv27lGXaxeAkxqsQ09EU+eLdcdvCx2IHPmsGB
	bktRyX7JxAcDOT81JVZZ/UE+Gy8tuQyttfid7g2v8QJPLkj3rwTvIcfeSa6iVCHS2DCZVF
	smEpctgFXUsPqbrMfj/7sx7L5u80TO+5Y/2GvPP61KBQQTUKqe1hC3heYtm8kvT/1sraml
	Ic6pmWw1Mrnjy1bsIMd8ruVYeR9PnVvK1iAYQDdD9PpNeBQIe/5tJt7EgdsFgg==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	Linux-Fan <info@masysma.net>,
	sashiko-bot@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV
Date: Sun, 11 Oct 2026 18:49:55 +0200
Message-ID: <20261011164955.24425-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-167316@kernel.org>
References: <sashiko-outbox-167316@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y8hkoyuzkrqiqn6k5jqgrw4wzckfp7zm
X-MBO-RS-ID: 90b6639bb35dd80443b

On Sun, Oct 11, 2026 at 04:41:42PM +0000, sashiko-bot@kernel.org wrote:
> Does this cause pci_dev_wait() to exit prematurely for Virtual Functions
> (VFs) that return ~0 under Configuration RRS Software Visibility?

Yes, but that's the current behavior for all devices; the patch only
changes it for non-VFs.

VFs could be covered by reading the Command register when the Vendor ID
reads ~0 and waiting while that is ~0, too.  Devices that are ready would
still need only one read.

Lukas, Bjorn: should I do that in v3, or keep the current form?

Thanks,
Alexander
