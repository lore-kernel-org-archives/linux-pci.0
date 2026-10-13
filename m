Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB064FDA5E;
	Tue, 13 Oct 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897520; cv=none; b=dtk2gN/vpKeNHdfvqEzJCa/Q+6r257R35gkBYTPIUo9md+2WJ40j6Hr7HGQElIo5AgJT6i81/ahza1FeSbReDutje0AQqFZrq8Ewx7NhQUt2XAXqgqeyMF78CqEfQptH6dntXaK8ipbfxu+4eu4lIPRjUSLG1Cep+mhGS5qUqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897520; c=relaxed/simple;
	bh=BH+zRxj8aTb3vZIjHI0zEicj3IDzpqtLBnItp2Q2KCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XntiWbKuo3EsHN7YITTtIb7pEINnKippoydLAZk1WVcdBRlC6XCuSUuoHnXOWOm5AcqGjk8uUxmp5YOHodTiTJGPPiHwiwieG87CpK/CakaEyOW3kMYfJjXgO8qA/Hnj0jg5OU98aGTtWrHEjhDEyHotozF4RyRORt3VOHM1g+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI9CC4rE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI9CC4rE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A696E1F00893;
	Tue, 13 Oct 2026 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897519;
	bh=kEE8EV1m/xUrJMDudvHWC0RXaGn5qDDzlMOJvDSz1xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AI9CC4rEkZPHnbMPmNeiyXRxO62quPmGhHsXCHXkURTUy7f46ac+JXpJbogDqxMnr
	 GSNznb+XoRyY9UchyhRW1PTucFEfnTNHuo0ufGlLsevpQp+pJaiOFzCFZyMGbfr0Jm
	 x2z/9rZOhPUz5ht8z9NIXoFQ8J1aKG0qHxO/kVqTGO1o0Fc8nBdGddthAAk87dZNzf
	 RpDFA8k8MbpY3exUjBU41JaCm4mx4qrHlaCNjzYSi2EmqcmC7bU7bZo0WBIzq6mS83
	 hHS3HPoyGkuMJLJGj4GH7e4dhck64k4a2NMQiK7lj8SV4APNtlvX8oMMFT1MVljP1O
	 paMg2MNLvRjGA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 04/53] MIPS: PCI: xtalk-bridge: flush config space writes
Date: Tue, 13 Oct 2026 15:16:24 +0200
Message-ID: <65b97d9c34280ad7f85004641d992115d3af5215.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PIC hangs on a config access issued behind a config write that is still
posted, as when probing an SGI PCI digital audio board.  Read the widget
flush register after each config write other than an IOC3's.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/pci-xtalk-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 18251a68fa06..16c1ac2c2551 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -252,6 +252,9 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (res)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	/* PIC hangs on a config access behind an unflushed config write. */
+	bridge_read(bc, b_wid_tflush);
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -293,6 +296,8 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	if (res)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	bridge_read(bc, b_wid_tflush);
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
-- 
2.47.3

