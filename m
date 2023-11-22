Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kIjieEuc"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5DB19E
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=kIjieEuc1Wy6/tDx2FbaW6Y9C8
	q+enUIeBODJZUho1no+HUkKxaDZLvnURvzRNTy94A/H4cNZ8mWTC+RoGhVKYvqFo+bHDe5v86Ipce
	wtq5AqzaXzUkOBDwrryzz7h/2iOWyH2HlwpOxVmoC8i236vhhhuJd2+a6fcFkFupwVLWHnYRAqIEI
	t3vi/8cjJN03yqbTchJpVbgRtbcgnlkB/T6SO7Vs5EsksTYXnDRsFdfLTjEW4ZdNjRk2NpYeHwUyB
	4xnJpDCYQmppTBccgULBFeN7VbghGOObsr5nAdTEp/o348Lm4rQ326P38W02BR7DeMCUQfTlR+1Zu
	F9xDTVpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gZl-000p6v-2i;
	Wed, 22 Nov 2023 06:19:05 +0000
Date: Tue, 21 Nov 2023 22:19:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 13/16] PCI: uniphier: Use INTX instead of legacy
Message-ID: <ZV2dWc1VRfGsbIac@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-14-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-14-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
