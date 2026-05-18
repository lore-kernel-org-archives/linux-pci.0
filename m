Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46B390205;
	Mon, 18 May 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131547; cv=none; b=oTqRlWF20FYVeldlcpLZWi/LA8t/lJUO3035xtTGpjWRO8QW52hxa8g9vHicF0fcCnDmPsBDCgt63kdh/FDUe+728Dhcle8raJSrRcc1Vikl7PRkU55EUouOgCO4MR2P5Z4lMCPcQvpx3zAtAZBesNVA6Pz8HrRQeOa0YcXqS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131547; c=relaxed/simple;
	bh=kPWcdiQYkZSqMHHL/8MYdL+/3A96p7AAFzS0+qkC1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFkTFauGwsDKx8AkM/3IT48o/a10DC3yuf19h1PgGnvfxwy5GxNOV0rB/KtFfB5eCb2IsvPPWFGSTANP0dcibvcvaUP0f6yOEqfJWXV5+UCyO5puQw/PsWvRB7Ur0IdRxSBdlS0wlR9pksKcVJXfXU9ij7pr2om1LAPTt87YNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWnfbIXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWnfbIXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58B1C2BCC6;
	Mon, 18 May 2026 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131546;
	bh=kPWcdiQYkZSqMHHL/8MYdL+/3A96p7AAFzS0+qkC1Z4=;
	h=From:To:Cc:Subject:Date:From;
	b=YWnfbIXqOwykqFDZdaGmcMlC9FApjs2ExnBIQpOi1wHBw/PsvEK31hx6kCwQWTtkI
	 mcnUfVs34sZ4o7pwd9+hA8X4y2LvvdqPa37yeRvFQZqrOA9yq5ceZCR2hojy1hOrSf
	 mz0n2Hapci+9F/i9i/X3HsI4wVm/jSKMZxxHN/Ihvzr26Ispvmh9g5w5A0aHyCuO/f
	 +oe0pAknagv35R/6KByZhReckOcScQSqJgqZUzXBf2dHU/JF2kl//Jn00fL01BbP0Y
	 8YdOHH25sal1qDxPSlNb59wDH5LAfwfCIqEAgTXzxcr7+efPgrf5eCytIf2GM95E3J
	 twgNyj8tIe5GQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>,
	Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] Wait for device readiness after D3hot -> D0uninitialized transition
Date: Mon, 18 May 2026 14:12:17 -0500
Message-ID: <20260518191220.636213-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pci_power_up(), wait for device to become ready after a soft reset
(D3hot->D0uninitialized transition).  We already wait 10 ms, but even after
that, the device is permitted to respond to config requests with Request
Retry Status (RRS) completion status.  Use pci_dev_wait() to wait for
successful completion.

Bjorn Helgaas (2):
  PCI: Log device readiness timeouts as errors
  PCI: Wait for device readiness after D3hot -> D0uninitialized
    transition

 drivers/pci/pci.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)


Changes since v1:
  - Log device readiness timeouts as errors, not warnings
  - On timeout, set dev->current_state to D3cold and return -EIO

v1: https://lore.kernel.org/all/20260514153124.404060-1-bhelgaas@google.com/
