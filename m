Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20793E7635;
	Sun, 18 Oct 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.15.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341652; cv=none; b=rlv9A62uRjPHfrTVhUdf9uCILDjTmhq5aktMnQsseOz7hL7Wx1Bjphn2rnB0JfIdrvPAnKjzyO8RICriclCKUD0QA7p+jMSh/rBy4otBNixJKTsaOjeJPSm3T4TuSK1LT3hKG3c7n1dbXheB9rPdOBnGb7NBTxjzuZ4Wt6DA9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341652; c=relaxed/simple;
	bh=nVV5hLo3lhMdEwNew1hXXqrUuhb4wCfRP6Bk4IDz68I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kudEacZsHnHbReNaGNY8rwD9HSIdkfx5x3qWNKvjEnxa3dhtCGXqC27Dq4HvH8Vo6u9L00n2DOihPyo+QhRW5cWV9SZdsi/uWbELpM8cqpTAcLHH7BYtHR9jKEUH3goMZBggvO5R6S/MHEo11ZIy0j/Yjvfy/ig7vm4GyefIc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs; spf=pass smtp.mailfrom=unwrap.rs; dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=PDOE5Zk8; dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b=LTiWAMzU; arc=none smtp.client-ip=172.232.15.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unwrap.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="PDOE5Zk8";
	dkim=permerror (0-bit key) header.d=unwrap.rs header.i=@unwrap.rs header.b="LTiWAMzU"
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=unwrap.rs; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341500; bh=U7bcq8j8Sw
	Ky1TxDWfDhROsbzUnuOp7UQWlvXe/q4IM=; b=PDOE5Zk8EkYLHIDnzhfQ+6HDACMbRrVQx3Ddk
	vAsK9D9e6RvM+DXbNlX3jHBjcs/zNBEy4jv3c6VLKaIn4nDl2HeYO7ccYnvPgceMvFJQTSfak3F
	Q05hNMHZH606BapN/VzM13wDLBGYUzKhPvsCnzLAEJQvDHn/id1iFHQ1fpNC02AOkpxiBvQYTxB
	x1ft9x6/QG134v1ApCc6+8O/Uct8vAma16Kg5v1VdNZPlAeiLLzC4iEKz+WMrUyqCJ2Nq0CCvAv
	8zlAJ3dtmO5GZ9dab7BWvOp94UogRZn3sed3ORMuZbWJzb23gMtsViA/UDdndLDbz8ZdmFRMfj6
	/m60g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=unwrap.rs; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From:Content-Type; t=1792341500; bh=U7bcq8j8Sw
	Ky1TxDWfDhROsbzUnuOp7UQWlvXe/q4IM=; b=LTiWAMzUfBJA28VcePyw/1R0S8hNJvMxw5KGE
	5+DNCZKHchdmakVILDtgKl+4oOvsdcWvm5URmvFUpNpv8FhCw==;
From: Cole Leavitt <cole@unwrap.rs>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>
Cc: Cole Leavitt <cole@unwrap.rs>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: pciehp / thunderbolt: Fix resume with a slow Thunderbolt host link
Date: Sun, 18 Oct 2026 12:37:14 -0400
Message-ID: <20261018163750.130470-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Lenovo ThinkPad P16 Gen 3 with a discrete Intel JHL9580 (Barlow
Ridge) Thunderbolt 5 host controller below Root Port 0000:80:1b.4,
resume from suspend-to-idle intermittently hangs with a black screen.
The link to the controller is not up in time when the Root Port leaves
D3cold, pciehp concludes that the device in the slot was replaced, and
the resulting removal races with the thunderbolt driver's
->resume_noirq() callback, which dereferences tb->root_switch after
tb_stop() cleared it.

Patch 1 defers acting on the synthesized Presence Detect Changed event
in pciehp until the ->resume() phase, where the PM core serializes the
removal against the drivers below the port.

Patch 2 stops the thunderbolt software connection manager from going
through its resume sequence when nhi_resume_noirq() already found that
the host controller is gone.  Without it every control channel request
fails with -ESHUTDOWN and triggers a WARN in tb_cfg_read() or
tb_cfg_write().

The patches are independent and can be applied through the PCI and
thunderbolt trees separately.

Cole Leavitt (2):
  PCI: pciehp: Defer device replacement handling until ->resume()
  thunderbolt: Don't resume the software CM if the host controller is
    gone

 drivers/pci/hotplug/pciehp_core.c | 26 ++++++++++++++++++++++++--
 drivers/thunderbolt/tb.c          | 13 +++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)


base-commit: 32c52ec87d6245ee2d12ed5dd509e40062939b50
-- 
2.54.0

