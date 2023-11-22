Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpbEXuuf"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405CD47
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZpbEXuuf+u8+VCVqBCb0zm/A2U
	MgwKt7G5FvMBrFvktM2aRVURk72HXT0uYCs6O2sPZPbjMk5EwAREQ/jZgG2Xxpl246xAe9u4GYcaj
	hzz+PZSiSZtAb2B5niVTuZzwS1Y/NG5pzoRzvJ7GKYBpVT5LM1n3TQG0Mi2on+tOivOO29qRgtNer
	aSWlNYs5olThfTsEyP9aPs0qpKR7Jb/N3GpbZQourQ/nTSefZQAGm5Ow84wN4ggMXp25wb0PIja2k
	N70LuZ8VmGWvBVcy5EWpR/6o+dSHrbuNEM4UTDGFbdCHOVeViCxlFt+gN3CzaApxTtCmi0IE3zHED
	1pJw6S4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gWp-000oi2-0o;
	Wed, 22 Nov 2023 06:16:03 +0000
Date: Tue, 21 Nov 2023 22:16:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 03/16] PCI: endpoint: Use INTX instead of legacy
Message-ID: <ZV2cozZMuHhOdDsj@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-4-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
