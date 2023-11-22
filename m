Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1N6iIFu7"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A5D54
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1N6iIFu76lunX6tBWxjAv/+eX4
	78TiYXm1FcrF8UE9ag6e8A8QNTb2XrfTt6q/FMMFu9IZbsIbLD8nAb+QyQmDEqNtGIOsXszFMfZIx
	0MEgtKC3b6EIfQh8INKhy6uUuaMxnKGyMlauBCY1wEOfQWkXLowb5Lrot65SQDs8y1jrlKLuiHvAj
	aueEymxj+aqJt7PGZmxHtkAbnKV/tBnJvJPzIZN7WqcYCM3FEzS15mf2r/M+0l4Mcr5TVg5Dep5oX
	YD5A9HOrMjIrbDWqo9rw5Rlqq8jOJ5W5G36KSeUWrlJPCv0VW3WXPulfJWCjACse3Y++bAhBMwuug
	jhie2gFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gZY-000p40-2c;
	Wed, 22 Nov 2023 06:18:52 +0000
Date: Tue, 21 Nov 2023 22:18:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 12/16] PCI: tegra194: Use INTX instead of legacy
Message-ID: <ZV2dTFXgpB+Ffy+9@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-13-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
