Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5p97bFx"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE05BB
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O5p97bFxh2UDgT3rBf49PWP29A
	xtv7NOhwfSZ7hgARnLyPhGmEZCsp2n/sAyOiYPW9eryiRx6a4I/eKCfirEUwNIvBzjCuftjg1BEpq
	wyGVfAOVlLWuJSxnRjvIc9xpJf/GQEkDviAYQ1vIODQDgsGB6B/a6AVZMHYYAbiz1/PUihjdRLKgm
	mUTFV/9WGzpDtdXvzYVx+Vk24Z1mPNpMW6xPCs87+LxJf//mKa011u+YcAuKehULzPQZ4c9XYgqMn
	ZY6+dvMBhSEhpMPaCZ2ULfoM5vMzeRtZA9GtjKTuJLEYl6U2WLrkSRXY8n2tYFjk1tZgaiR8GwFOL
	uLx7DK6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gYj-000osE-0L;
	Wed, 22 Nov 2023 06:18:01 +0000
Date: Tue, 21 Nov 2023 22:18:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 08/16] PCI: cadence: Use INTX instead of legacy
Message-ID: <ZV2dGXokm+gJNQnm@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-9-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
