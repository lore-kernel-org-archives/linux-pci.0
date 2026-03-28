Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA52FFDEA;
	Sat, 28 Mar 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707083; cv=none; b=vAKvSlvpLBgrObipTgS4FbxvujMItQ9BbGrWz4EQdvNrE7dzO4pUUu6UGjyW+RrCIy61P1rOmJ6OXLje2Hf/aw82SA2dE0zdIGngYuYzbygwH29Ypk0ZtsJTIm0M62vDGkUMxxO7EjGhDXNcueKg73iT+B2aHEnRQWq3372Kb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707083; c=relaxed/simple;
	bh=rGoZpzdSWZaBJQNSlTX86fArMCUueK1ZkiH6zVSRw/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz+iTY+ra9f5ONGKv918t9JJKHIG3SnGv7xxsej6hrzAOPZKyCU8ttCfF/YGVW/m2sVc8WpshVOQWVpb0gN5i3qC79wcXfWrs0VB+kg7lBB0lsbGRaBNlSh2kWuilzC1xRnON+66hWNM1fS5nV3KeDHPrKLDOzMaXUUUmjlGKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 79D5FC19;
	Sat, 28 Mar 2026 15:11:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3BACE6028F47; Sat, 28 Mar 2026 15:11:11 +0100 (CET)
Date: Sat, 28 Mar 2026 15:11:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: bernd@bschu.de, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <acfhf-odtr0yw_py@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acfZrlP0Ua_5D3U4@eldamar.lan>

On Sat, Mar 28, 2026 at 02:37:50PM +0100, Salvatore Bonaccorso wrote:
> Bernd Schumacher reported in Debian (report and report from bisection
> in https://bugs.debian.org/1131025) a 6.12.y specific regression of
> 58130e7ce6cb ("PCI/ERR: Ensure error recoverability at all times"):

Thanks for the report and sorry for the breakage.

According to the Debian bug report, the issue only occurs on
v6.12-stable.  It does not affect v6.18 and v6.19.

I note that v6.12-stable commit 58130e7ce6cb differs from upstream
commit a2f1e22390ac in that the call to pci_save_state() is at the
top of pci_bus_add_device(), not in the middle of the function after
pci_bridge_d3_update().

@Bernd, could you test whether moving the call to pci_save_state()
as in the small patch below resolves the issue on v6.12-stable?

If it does, then the upstream commit was backported to v6.12 in an
incorrect manner.  If it does not, I need to dig deeper.

Thanks!

Lukas

-- >8 --

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 429c0c8ce93d..bdb3e10f947a 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -331,9 +331,6 @@ void pci_bus_add_device(struct pci_dev *dev)
 	struct device_node *dn = dev->dev.of_node;
 	int retval;
 
-	/* Save config space for error recoverability */
-	pci_save_state(dev);
-
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
@@ -346,6 +343,9 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
+	/* Save config space for error recoverability */
+	pci_save_state(dev);
+
 	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)
