Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63199194C95
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491696; cv=none; b=Mn6iDXvV9TUC746ns0eYr4zycnY7eps4OiihHR6pfkOLAaOYaxf4pVeRDduRWSD/+9SiIIS5IZSqkM6fKDoWhwUMAr2p11JMZOxaSvdWUFTzvcmKZ0oeJYZ5dV/YNDXX7kGcIdQtHwWHoNNV2BrbMpfZRhKIGQvOoJaskvS0WGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491696; c=relaxed/simple;
	bh=I5LiEPYHyfYN2sGvuXOiWyPgDHM6sRAC8/Jw2yALC6I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ww/4P05ma0IWrg1fKJnqckIf2sZhGuO8mP0RA8SMM4bddlk807tJOf4mDpOyXUXKmntrg3J6F2x5aA1X9jxBBZeYMcBvm7OWBwkYgGutCP+ScU2dN8MqQRPDTuJDdEf0ROXMBCMx82wmvIR6emUL+KCYOnUFUekzV/D6Sj1jluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShcZ60Gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShcZ60Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F2C19423;
	Mon,  2 Mar 2026 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772491696;
	bh=I5LiEPYHyfYN2sGvuXOiWyPgDHM6sRAC8/Jw2yALC6I=;
	h=Date:From:To:Cc:Subject:From;
	b=ShcZ60Gp95EoSk1Xca5kitC4jfnr0AF0HIKyURkWz8DjerQR5aEyPLHcgj4+S1HN+
	 aVZsYFFi+yYhf4WhVdi6ROytvdsj/6ZL2NjGK90HTtcZ85OX8SmJDjn6HLjac9VrMe
	 n7zFrDkY9FFvnOPre9tFQIw/kEHyk2IpJjaKecoOlh0WSIiDxn64CpAjdMdCY9rl5c
	 1+kaxd86GaxxD9uxpNqBR/hlsTmC/rXy8M/6hjTXfA4zPoaUO/+qViZKkVYAhn5gpr
	 hD8Tqjx6zqGr75seA7w5UVS0sSY+ZwNBlWXovCtE1L0GBsPwqpGIX8otpolaYCA2Sz
	 k87E+h9M4wXXQ==
Date: Mon, 2 Mar 2026 16:48:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Subject: W=1 pcie-mediatek.c snprintf warnings
Message-ID: <20260302224814.GA4029890@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Just noticed the following errors in W=1 builds.  I doubt there's any
real way to actually overflow the buffer given constraints in the
code, but these are the only warnings in drivers/pci/, so I'd like to
get them fixed so W=1 is more useful:

  $ make W=1 drivers/pci/controller/pcie-mediatek.o
    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      drivers/pci/controller/pcie-mediatek.o
  drivers/pci/controller/pcie-mediatek.c: In function ‘mtk_pcie_parse_port’:
  drivers/pci/controller/pcie-mediatek.c:963:43: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Werror=format-truncation=]
    963 |         snprintf(name, sizeof(name), "port%d", slot);
	|                                           ^~
  drivers/pci/controller/pcie-mediatek.c:963:38: note: directive argument in the range [0, 2147483647]
    963 |         snprintf(name, sizeof(name), "port%d", slot);
	|                                      ^~~~~~~~
  drivers/pci/controller/pcie-mediatek.c:963:9: note: ‘snprintf’ output between 6 and 15 bytes into a destination of size 10
    963 |         snprintf(name, sizeof(name), "port%d", slot);
	|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
