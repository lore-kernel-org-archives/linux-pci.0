Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C233FE09;
	Sun, 11 Oct 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707122; cv=none; b=OEm9RL6GP3+9nsTIumEUnq9w75GVrl4QyfN/K0DALULzvQjSYsejlvh1TTK/ntcRjBxXyqCkVjVu2SWCSIu3hXLFq0C3vPGGEdDjfb9tHO2Bs7ZoxaDqNYfGDNyhUqBBfKpYH/VoI0Ph5+ic+XDPJlQ9o6/I0WN0qXb9k1O4Tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707122; c=relaxed/simple;
	bh=iIqnJiQvwbRFtrw+Izriaf7uIR6F5MCj/oQ2CoYWY3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shLMMaSF3wxG8kzii5mYzlNQ5vfg+7Laf9gfP4XGbYpY8fZemPADYDf51Gitz1/iYaXT1kbQeJZG6fl4pnv3Hzku9J/ZiMu9BKOsoc2e8ECnSBRM8qXKuAYCkrZeYSOcExDGKiA6A5M+2X11eXGMMHMYxVnOBJwoEV7CwKR8MCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dpwlwJ1p; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dpwlwJ1p"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j2YZ53gGlzKp2c;
	Sun, 11 Oct 2026 10:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791707117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIqnJiQvwbRFtrw+Izriaf7uIR6F5MCj/oQ2CoYWY3E=;
	b=dpwlwJ1ptWcHzbz+o2eJF7D6oYwuUgibkZqvQ9qnyyr24N3Fn064ximT8+qTCsmuiITV9E
	J8qNMc+qZewOFkkL21gWsTKgwn/2GTBmye/Gx1Oo5g9G2EEC+tj/dd0OLi9XrMl4BY4wht
	i25drT51n0L53ptuDVUkH4Nmm8jgLq/N9KyAYjeF7MhmbwUNBC4Xl+qz+/q+EiywknuQ+G
	JV0GCIxF266GNxpkRH4xjwEKn4chv6Dd80vvEgdN7eTpsa87eWdYjxlQWOosENOX2S7F2X
	1z8LXlKoMpbtJGlHlAVlV4sNlExc+BUXIGm7Xq7m048uTgEdWXmCxT1cojGH6A==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: lukas@wunner.de
Cc: bhelgaas@google.com,
	rafael@kernel.org,
	alex@shazbot.org,
	hui.wang@canonical.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: Wait for readiness after FLR even with Immediate Readiness
Date: Sun, 11 Oct 2026 10:25:15 +0200
Message-ID: <20261011082515.18546-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <asp7HDfhDSjNtx5p@wunner.de>
References: <asp7HDfhDSjNtx5p@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3u4turbp3gf1s8y7gt8xpg4xtoej1nb8
X-MBO-RS-ID: 105180cbf0675f47723

On Sat, Oct 10, 2026 at 07:51:24PM +0200, Lukas Wunner wrote:
> The device is incorrectly advertising Immediate Readiness, so I suggest
> clearing dev->imm_ready from a DECLARE_PCI_FIXUP_FINAL() quirk and
> emitting a message with KERN_INFO severity with something like
> "Ignoring incorrectly advertised Immediate Readiness support".

Makes sense, I'll do that in v2.

Thanks,
Alexander
