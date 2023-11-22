Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ya+jy297"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA691BC
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ya+jy297h61J2vk1Ygenn77W7K
	ium2ux0oGfiV91n2qcEedmv9BEFUzKNFKi6x8sCC1nfBhP8zWPBXXZ2QFp0q1HqFHkkD8NyR/9EjR
	7CRZ3PTfRb7yGgQHRmA+5jMMxZgDlRfreESkU81ykokQwthtROpWKl9yK1HBI5zsi8BFUsoJrLiVc
	ryzLvfyh88HAauD5/orJBLS20ks0DEgy/l7ptipbl8q9huY00JPsOcmQL7JKykdy+lxFszzvmT9lJ
	DAQLwFa5MKItEsS+Difiuj95PnODgEsLMoT9KZ6HVC0t5T5WIR+Gg2ZYMeItXOWEnWqAYQaZiZCLd
	6sfZDYpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gZL-000p0I-1h;
	Wed, 22 Nov 2023 06:18:39 +0000
Date: Tue, 21 Nov 2023 22:18:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 11/16] PCI: dw-rockchip: Rename
 rockchip_pcie_legacy_int_handler()
Message-ID: <ZV2dPyv/jexPijYn@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-12-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-12-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
