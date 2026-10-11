Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9EB394464;
	Sun, 11 Oct 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742733; cv=none; b=rHxmCiqIh3cp1xqpxS6xehY4QqqDsZeml6pJNSz/5JipJ95iYwOHj4iUp82s7EmXdJbqdyoQwXYqCDedCIA2xnKLe7Rl2P9UxWXEWrtHRYCqoptz79t6xL6Vpv5b/g+Tdq/ED7J5miwLlR8tlhUQRd6Lbq4zY/oa6kfOfXqDurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742733; c=relaxed/simple;
	bh=/VD9mPgOyCiNHCobVgJVc5LbWvoyXHB4SxRD01h6rtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiLPgYSfe3zs6qX1CJASeOtbN3P32S2qtPsqbj+pJkjPjL3cPOd8L/efeScYCe3MXDb6sgyG1db9Kfu2S/AQbX20ELUT2+urGTcyVRbF+M9fRphAkA+kPIxY6z0xfRzdHqExLZb/F3D4genMvbvxnfg8YBgNhqP1V4eHX2Ir06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PE2FFYH5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PE2FFYH5"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j2pkv0NC5zMlZj;
	Sun, 11 Oct 2026 20:18:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791742727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1OLzrZasTnZM5m5JuAXuZlWlpLYil5FONjrowZ3J2w=;
	b=PE2FFYH5/1+YpyK4Ie5ajPo16xR8QW6YJ600GZWi+ZbwTsVdqYAm4T2a61lRUZFrGZTX0a
	tvaQ7oTNIoai7CF29RGJ0l4qbAMjBMEth6Y2jCYrTlWdUR3J8skb+95KKUOXUsMikJjeG6
	gY7L3R/qv2580ZoQJqmdjBi5e17aI3ghpmOePrFQ61d/hq07XMEO63f6ra9m4WbFE6RvKV
	l95WiayXqBip9n9L2J6l8VKxueMPHm8ic6onVEfZVXE0uypLJfqPKPDracoABvIqoezvl7
	5hihObdixa5XbwNVJv75ey3hAB99GU5Zxz4z6QNgwFcURiI2QlTNASwPaxqu5Q==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
Date: Sun, 11 Oct 2026 20:18:45 +0200
Message-ID: <20261011181845.7695-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <asvOwGIE9bBkGtfL@wunner.de>
References: <asvOwGIE9bBkGtfL@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f88e8f76ca8a4d1e689
X-MBO-RS-META: 5p1emct4sqgxrph7udcf467a37zut865

On Sun, Oct 11, 2026 at 08:00:32PM +0200, Lukas Wunner wrote:
> It's also a bit of a bummer that the quirk can't check the
> firmware version.  Has the upgrade changed the Revision ID
> in the Config Space header?

No, it's 0x00 with both 1B2QJXD7 and 8B2QJXD7, and the Subsystem ID
(144d:a801) didn't change either.  On fixed firmware the quirk only
costs the 100 ms wait per FLR.

Fine with me either way, thanks for the review.

Alexander
