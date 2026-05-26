Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF53DD521
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794419; cv=none; b=NWjWXPdKtFLSHTJKOwv/thHduQ+ktv4LRN8vrxt2LVNlN8V8bya5rfETTXVAu3rt3frWgfSWKxBKvl+c+4iRh0WHiYCtDX8MQwo2ZQsAKuHmKcA5cOkSefmgZPNhRtufBWczaQhjYjFvPhj9GLvZZ3loED4rwLz0E9kPxf1RwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794419; c=relaxed/simple;
	bh=5Q16x+uPY4T9oiOLDbrBdkXRcaAQ2V294M3vQ78CeqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mIh4XPnJIn1n5WRSDmZsUq0uGAtiwZsgZ5EIv85N2PiqZVC+B2d5Th/8n5HiWFZPeqkupXev6mSCSQMRxE9O6EZmYpIczVvnxNqyT4DHDDHDC2RhQiT70sJuTUdtSOJcAVNtxcwvT8ELN/ySTtv2Y2M8Gs1A9u/5cm+ud/3sP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id D2106C91;
	Tue, 26 May 2026 13:20:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9865C62259AA; Tue, 26 May 2026 13:20:15 +0200 (CEST)
Date: Tue, 26 May 2026 13:20:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mitran Karthikeyan <kmitran@axiado.com>,
	Thierry Reding <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: MAINTAINERS entry for MOBIVEIL PCIE IP
Message-ID: <ahWB7yRchlW_KjEm@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mitran,

MAINTAINERS lists your address <m.karthikeyan@mobiveil.co.in> for
MOBIVEIL PCIE IP, but the address is bouncing:

<m.karthikeyan@mobiveil.co.in>: host
    mobiveil-co-in.mail.protection.outlook.com[2a01:111:f403:cc2c::] said: 550
    5.4.1 Recipient address rejected: Access denied. For more information see
    https://aka.ms/EXOSmtpErrors [MA1PEPF00007264.INDPRD01.PROD.OUTLOOK.COM
    2026-05-26T11:10:41.797Z 08DEB6EF7103D7C9] (in reply to RCPT TO command)

Are you still maintaining this driver?
Will you send an update for MAINTAINERS as well as .mailmap?

Thanks,

Lukas
