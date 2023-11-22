Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWPr8FO0"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7AB9
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PWPr8FO0gLxFJd2lnN+nIIH8Di
	sFIyhZ6umjPGZ0XVJux2wRKU/EWNqtWQ3HR72VouzDxCG5Y292lriToTJMhIAZJhVZVOa2qOVVuhd
	US/IukaWrvvsta1ipScaMXEEcZqWKyeU1Whu6Priuts7wvvdFGr1RM5+Lwo++Av6b8d6M9cvB9XkC
	8ZUPczUuX9Y8U03OgWK+A4fqRadIXbuKpUQCCN/vIXu9ttQc9bFVm4nUAsRBvTzN48tdLvSIedy1q
	P4LkkrdCVTUMTg1zVElFPaODtBu7C8bO8UDhKrGB0P0etDY//GduKDEax7fzNRPRa+OC/skvgnXzx
	ZlwbJb4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gY5-000onU-1q;
	Wed, 22 Nov 2023 06:17:21 +0000
Date: Tue, 21 Nov 2023 22:17:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 07/16] PCI: dra7xx: Rename
 dra7xx_pcie_raise_legacy_irq()
Message-ID: <ZV2c8Q8djh2625OG@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-8-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
