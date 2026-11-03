Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725291;
	b=5Z+mVJph9dw3Ba/5gPCCW8NCkcBN76eTMQNdl4jqNlFvf/IEmGZPp5XF+SOKV3WqVduN
	 fe+hw7o6hitBD6eWpXXHNP+5KuW3nzyxq/CYLoHiUgvXR9DumzW6uAcq70jGJjOWWF7BF
	 oY9Y5g/tyzGkR+eY6ACTrmVNXd5DwOfCm5kk6ykZGw9DIv7mpu5Fs9pTBM2rYq+Shs3A0
	 bSG357Db3vZooj/rBg+JICV0IjNLCc+OCBiwrzi7UY2XHfQjqpynjZwBxbnkyL5aTHfb1
	 UmL2mbsjhxUHdcOa2U0WUfJ1v0htsJYn4Izq5Y+GxX0hKgUOaxIgv6TqOtWrXdvaPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725291;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:Subject:
	 X-SA-Exim-Version:X-SA-Exim-Scanned;
	bh=Jr0ImF4W7YU+k2xWA3HFDl78ajPFSfINyrPexxsGO+U=;
	b=oiSfWRlb0ynK1mxIRh7n3yFzVPnFOq+K061UXQvWPopDiWUPKXw2trEB+AEBDiqTvlCD
	 rjt40fzDPTD6bmchisZHubwY96SSR1Oym+l3gnSnaoB3Hj2fFtfKO/B8KjYAvtZiUrNsS
	 JDxkRiHd5jWQaLBk1gnsT+GGRmQaEgMvIi1sO5IdzlMLFamngkiMS/0Z699rcMUbllFVH
	 +VYcC0w0WBsRHvnQgsJPSn6EXySr5qiBORBaU/HVzoK8ARWgpJQrjFqnbYVVZ5dxXw0P6
	 vjg3F5ojDyhiYadNAI6PNc9qCbkhF/4CiS/a030DP+hYATg+T7MO7gCXbY3xwypmY+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=HSVnjF9j;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E7606A328;
	Tue,  3 Nov 2026 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6E7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=HSVnjF9j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=Jr0ImF4W7YU+k2xWA3HFDl78ajPFSfINyrPexxsGO+U=; b=HSVnjF9j7dHtpoFyoE5WwHTPFw
	AUQKGulYUP7Rg1KpdD4Q5k80KSJ+lpb0Vb66N+cLVe20e9NM+s6XdB7ergV3mf6FlrItMaynzxaGP
	zuyzZsSOCJrHSIQ/4A/uxoSjkqlZ/hpfvXzjo7OjZVCUzz85u+EfSwQqEaTxZMdUJ68j3J93YEjDd
	eOLTTYmqpQgIVujCufT14fKo/B9oCVyRbO/UdUNW7QLbq6fKkDPveREv7cvDwGMJ4kD94ueOowTbG
	35QYFYDABzEADRxfNyfXKQBwEmFIwUgQxVhqDfEo0HXb7FRzEx16m+CLfumfFa1YAXHy9vNNnwXMy
	LZF5srdQ==;
Received: from donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOHt1-000000092Tn-2sXx;
	Tue, 03 Nov 2026 11:01:28 -0600
Received: from logang by donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOHsC-00000001yXa-29IG;
	Tue, 03 Nov 2026 11:00:36 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  3 Nov 2026 11:00:31 -0600
Message-ID: <20261103170033.471034-1-logang@deltatee.com>
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

Thanks,

Logan

--

Logan Gunthorpe (2):
  dmaengine: switchtec-dma: Add Gen6 secure device IDs
  PCI: switchtec: Add Gen6 secure switches to NTB DMA alias quirk

 drivers/dma/switchtec_dma.c | 4 ++++
 drivers/pci/quirks.c        | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--
2.47.3
