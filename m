Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9731B80E;
	Sun, 11 Oct 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736735; cv=none; b=svR+GZI06d4ut4GdWLmYzPOvdxWodqmO8FQOdy4e2wmT5dZtkmd9ZU/RYSfe3DLL5jClGvtz7lLJ4jRkmiSaL730146qlwStAdsfTsQl8wvf0SX3ApSdJ2qF+3sMVajDMlLWnskCgzjH6Jhc4R+oXqf4CYMybWrOAmOE+yz5nzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736735; c=relaxed/simple;
	bh=ATpH8AyNJDHhXj19fmBxktMPczSIxpTHUzLqYdZuhj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBTxDsWILp/Tb00I38lxNOdUir2K+jZ+GwV4yXIBqrY3jqtD7cSbzO9LB+6SxobDU9B0Lw8QGP+VgCXNxEwbnH3DJVvPAsGsutWPvoQ8Jni86qc+49167Q4T1d4+m4Xa/BoGTyoIer0FiPX5gT8VZpUpdPKCJn5k4ZE0+pcKl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L+vJmefA; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L+vJmefA"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j2mWT18grzKnmJ;
	Sun, 11 Oct 2026 18:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791736725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATpH8AyNJDHhXj19fmBxktMPczSIxpTHUzLqYdZuhj0=;
	b=L+vJmefAaCCYvgkYRW0uiEl5l2tboX9PGtzH/39m54Uc/0QFT3csKfVdyqrXwcVyjwmk20
	ArGASOzgVbkQsVA3C3/CMVg23V4UtjFy5F5mVd9JsK0zStxP/Xydvv0qTJSVl+I3JldVwh
	2V9zkgY684XKtcmgLNZmuiwSm6JI1lZgvAAlnS4h01nrqxkLgZuJXe+YAUhlvMzfydgP/1
	Be8WpXno2msZmWM27IC3QcGIfybxB1eIqyanVHuC8NCT9knIHuRDbKcsdYs9eP2mY9wfLd
	sLlmXArO2oM/UY9J7FAPoxL9Sykof/RuW8mJaE8ZT7CPPzcud8H3Yiu5giCOIQ==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH 0/2] PCI: Wait after FLR for devices that don't honor Immediate Readiness
Date: Sun, 11 Oct 2026 18:38:43 +0200
Message-ID: <20261011163843.21825-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010160529.27974-1-gruhlke@mailbox.org>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1ehb5q5z4nnohi3htn7xdtpos8zedqdz
X-MBO-RS-ID: 170e9bdfccd2237f23b

v2: https://lore.kernel.org/r/20261011163249.18479-1-gruhlke@mailbox.org
