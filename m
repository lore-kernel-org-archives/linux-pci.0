Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728587;
	b=p4E/o9aVHuWRAbS4OgzdX39DzN7BZhpFuWti5hsf1iTKARtKX05NNrMdy7lDoIVoyivg
	 FEchS4TcK9alWqIuZvt08INICGYBBJPvVsoHKGberkMu6Tnbkpn3ri097yszOwx5qUL8n
	 ehyb4mTk/lyGZsb/7aM+MJmFAuOShqyUxnir5mVrZLomOg4QJs68ngF/4NY1rx21vr+K/
	 i4o8ct5czqtmQIAyEs+YQZn4AAONOa6uTpWRwvsrquYIs8KgfGYSZGzxZ1TU7+qnRN80T
	 h/SePM3mE+U0aoGxZH8UsOBxNMyI/M2QVBwxx/O88yOnDLk931RyFd2Xw0Pn+SswFdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728587;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:Subject:
	 X-SA-Exim-Version:X-SA-Exim-Scanned;
	bh=D9M9k03lE3UbuyYu++CpT6BPaggF2Hrl1m3nny9I9ps=;
	b=p6HbgX5MyR/hsF0GwvfnjCg+2Ah7EFBLCLL0epdur4qUVI9/sN++bJGbSglTttxcZVA2
	 frBT75vFmAYQ4LWx3e3ssXM2d+ZdylMBhXeyo875B5Kj8vkqmCGdHFnk0/9tk7q/M2QoC
	 XcPJ7y1PDDei0W4dJnzN18pCEmQooVHtv1BK0eR/HfJ6+m6R572gXOKI4axp8ou7QtWio
	 w4MpNg4ktFYXo7S+V6abx26n9ulRwvm8Hutis8stDOjl9uYxcdYzNFvCJ8f+R6RQf8ISD
	 XcP+bEWA/DvHMjLbYM9/Ml44bna97ANCVt3KPGN+pQ/r83LSbcXDXeHgRzc9R/FrPGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=QBgUITBz;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA1606A32C;
	Tue,  3 Nov 2026 17:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBBA1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=QBgUITBz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=D9M9k03lE3UbuyYu++CpT6BPaggF2Hrl1m3nny9I9ps=; b=QBgUITBzuEPMaSWe9paUbIh3dF
	I+bKnjn6x1lnShB+hprBO/pDpBOyic+u9oCvmYS5k1kYv7/R7vUXYMsfdd3ZBI1YLsrdxZyKp0sdL
	Se7yWDxo8tLnhEX+OlsFl4zAQAFg1GiJPODznXOTTdkWG+ClA2ua+p6Aa716Y2WJTq/T6cpSIQqZh
	cy0+d6OL+X3WPfRlJGrJWr7JqRDAjeNi0L0VxvsmYgxUa8RmNtJfWZ1ErtdWUW/IknIXPueRaYLqm
	5dIqv65gcy9JU9UIOEqbquv6yvMychi7IAgRefa/C5CAQHqo2MX5qyEAAr2sAiAyHLtMRUe3nRAjA
	9EglVBTA==;
Received: from donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIkC-000000093Nf-3ifv;
	Tue, 03 Nov 2026 11:56:25 -0600
Received: from logang by donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIjx-000000021CT-17IS;
	Tue, 03 Nov 2026 11:56:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  3 Nov 2026 11:52:06 -0600
Message-ID: <20261103175208.481170-1-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: [PATCH 0/2] More switchtec device IDs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

These patches add some missing device IDs to the PCI quirk and the
dmaengine driver. The same device ID was added to the main PCI driver
back in commit 5e6c21c56998 ("PCI: switchtec: Add Gen6 Device IDs").

As, like last time, these patches touch both the PCI and
the dmaengine tree so I'll humbly suggest that they
go through the PCI tree again.

This is a quick resend after Sashiko found a bunch more missing IDs
that I've added to the quirks patch.

Thanks,

Logan

Changes since v1:
  * Add the rest of the Gen6 device IDs to the quirk so it
    matches the switchtec driver's ID table (per Sashiko)

Logan Gunthorpe (2):
  dmaengine: switchtec-dma: Add Gen6 secure device IDs
  PCI: switchtec: Add Gen6 switches to NTB DMA alias quirk

 drivers/dma/switchtec_dma.c |  4 ++++
 drivers/pci/quirks.c        | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

