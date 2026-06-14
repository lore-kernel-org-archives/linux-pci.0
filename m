Received: from ferryfair.com (ferryfair.com [103.227.96.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5502FFF8D;
	Sun, 14 Jun 2026 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.227.96.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781413216; cv=none; b=flLuWh7nJvCTxuG+3BbUOdTTndw0DSOyafDqYypKtTMybaPbiXcASrXPdnFnr0Jfnpm9bDqx9dSiV3WK0vVXLuvh81gKGhbqtpfP3SMmLuRQJIcPCxhtO5XhwKlXJ+olVtVBK+n7Ok8/5fA67YTfIdf/zNkP9vlrATWsyH6g+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781413216; c=relaxed/simple;
	bh=aQW4pkp873SZXOFpk84tQmpDL3hTlQ+oJ7lYSqU5UkE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BUiocc1oTQS6QnWXstSB6zlzy2T0ywZuOdRQGPn+MZHl8gelcsbgjon7cmcacfkt+jeGJAba7WRo9vRJUi6kQEhq6qKiJuT+8gPGNxz79ViR+Jyti1zaCNfqOuc/ejjag2nfcexvTegtNpdkyFILbo8DuYKe31JhKXs6xwSGgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ferryfair.com; spf=pass smtp.mailfrom=ferryfair.com; dkim=pass (2048-bit key) header.d=ferryfair.com header.i=@ferryfair.com header.b=mvXJEWI6; arc=none smtp.client-ip=103.227.96.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ferryfair.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferryfair.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferryfair.com header.i=@ferryfair.com header.b="mvXJEWI6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ferryfair.com; s=s1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XFGLMoBlVOgugds4B4DTTXS16Xixz4tT84fPGswN8Ic=; b=mvXJEWI6UpzgfvqvHVy87Iz3Km
	fkBPoJHS/0a97dvjriiqAHaeEYUWIWGvKph2WidStxldEWnQ7ou2ndzdFv7L3fRuR5olepT4D57VG
	Uxrd5MIKyLxg3RlVErkHvfDTYiZ5lVymqug5cPsh5bZvaBrVuetdCrOdjteApjuaFYqQGWwjQYqqU
	g5wF3ye0xi8DIb/ZfZ6cnFjfLrC6NtGkZYBWe7B0kVsEAzSUvHiTI6jrcFv360iD51ddM1+m94xmm
	+/+xYrdZSqGrMDs6xF/h4QoPxLJFKH0wIfhN4VahLANf08CC1C9MFccFps6ifTKhSbknqv5D9wQ9U
	6YUzxYhA==;
Received: from console.gl-inet.com ([192.168.0.1] helo=slick.ferryfair.com)
	by ferryfair.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.3)
	(envelope-from <gowtham@ferryfair.com>)
	id 1wYcx8-000000002tk-2mc6;
	Sun, 14 Jun 2026 10:30:10 +0530
Date: Sun, 14 Jun 2026 10:30:09 +0530
From: gowtham <gowtham@ferryfair.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 yue.wang@Amlogic.com
Subject: [PULL] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
Message-ID: <20260614103009.0a37953b@slick.ferryfair.com>
Organization: FerryFair
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit
bb532bfaf7919c7c98caab81864e9ce2646e11e3:

  Linux 7.0.11 (2026-06-01 17:54:55 +0200)

are available in the Git repository at:

  https://github.com/GowthamKudupudi/linux.git
  tags/meson-pcie-warm-reset-linux-7.0.y

for you to fetch changes up to 852811b11795ee389ea6a953ed0db69b76722469:

  PCI: meson: Fix PERST# timing by asserting reset before LTSSM enable
  (2026-06-14 09:41:01 +0530)

----------------------------------------------------------------
PCI: meson: Fix PERST# timing by asserting reset before LTSSM enable

On warm reboot, the PCIe controller's LTSSM starts link training
immediately if PERST# is already deasserted from the previous boot.
The driver then pulses PERST# for only 500us, which is too short to
properly reset the endpoint device that has already started training.

Fix by moving the PERST# assert/deassert pulse BEFORE enabling LTSSM,
so the endpoint gets a clean reset cycle before link training begins.

This was found on Amlogic G12B (A311D) with NVMe on an M.2 slot.
Cold boot worked because POR held PERST# low; warm reboot did not.
The fix was confirmed on a Banana Pi CM4 with Waveshare IO base board.

----------------------------------------------------------------
Gowtham Kudupudi (1):
      PCI: meson: Fix PERST# timing by asserting reset before LTSSM
enable

 drivers/pci/controller/dwc/pci-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
