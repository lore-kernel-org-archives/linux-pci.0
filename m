Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861733A9E2;
	Sun, 11 Oct 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746421; cv=none; b=bgybaQF7s9vWmhAxSmjWP8wC1RDThTWtWSbQBEWGhA5FHcOtTrGN4eLIUIKI8ZS4jWyMNZzTGuKA0gqJo1XyWeyISl5yRxCQlX5wnLfKahz9XNod2g69m3bkYmfo4QaOusKXrJ9j6oV48JM7ei+LM3UKIHuRpo7drBZjVt8YGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746421; c=relaxed/simple;
	bh=f4FHRxJ7UpSCdpNw7AcT/KcEiu6qtu9i9VnqIuYGdT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgZa1bfDnEyhHJ9wJtbeQ7+u2Hra7O7Fc/dgzQ6vVB369mv17xH0KEDgCUfxPfruP8ExSDWzzroUtNQOcrwZjxlXza5emDh8QVAJE4Q0SBBENaS/coatEc199NGDfn1f/QJcBB7D2NS4/cY0n6joBJH3ptHJGeuMl1nyTmOC77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eWZjXhzS; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eWZjXhzS"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j2r5r0pFQzMlJS;
	Sun, 11 Oct 2026 21:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791746416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJtciINNgx8fYnJ2OsvPZorrbosOGE70eBd4o4W0rZw=;
	b=eWZjXhzS5PbIimRybGDqKSmw5Aq7MiaSO3uI1YTyDBmKRH9qRR7oUWYw8xFmq7DG0nNPM9
	oRrAdOaUOE3o53obYTuNFMTeX8yVhJo/XSNRCjEAyYDC2IYmeS731mInzkC/HnTVkcU7dM
	SAEiK86VwU5pOgM/YHi4UIwaJVyCThNnDcb4g+DXxmGF2PuETvYAcxLiYMHw5dQnYwtW44
	ua4HwAlkUJVsnA5Gj5r4LINt2HDcizaBZmDEeQLOY7XtKTXGQ3dJEXX/uvnJ7VHfEIdOvP
	Rg2XZ1djeqAfev8UPEinD+QngpoqN5cqkqEJarniV69D0sawsdPuXdPNYdKFPQ==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	Linux-Fan <info@masysma.net>,
	sashiko-reviews@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v3 1/2] PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
Date: Sun, 11 Oct 2026 21:20:14 +0200
Message-ID: <20261011192014.29307-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-167396@kernel.org>
References: <sashiko-outbox-167396@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3w6ftp7cwuzfubg6y159dzi8duiqa9b8
X-MBO-RS-ID: d953c5c073d00f2c1ef

On Sun, Oct 11, 2026 at 07:14:44PM +0000, sashiko-bot@kernel.org wrote:
> Can this result in a C bitfield data race where either the imm_ready = 0
> update or the sysfs attribute update is silently lost, potentially breaking
> the VFIO passthrough (the bug this patch intended to fix) or corrupting PCI
> power management state?

imm_ready is set in pci_init_capabilities(), after the header fixups, so
a final fixup is the earliest place a quirk can clear it.  At boot, final
fixups run before userspace starts, and other final quirks such as
quirk_no_msi() and quirk_broken_intx_masking() set pci_dev bitfields the
same way.  So I'd leave it as is.

Thanks,
Alexander
