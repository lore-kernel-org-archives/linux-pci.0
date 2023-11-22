Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1ZZlJ30"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2071119D
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 22:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RQ2jQxugAaU85nNTwpWDfqwkP7HR8aPo3VMqhs9LH90=; b=J1ZZlJ300v86kwIJSYf0B7IiP1
	PYYxtHHiECDXjl3zyE/ofY9QaBZDUXYr2uvU/dvckb7XI8W2gMzt/Jb3h/767CAYvoav3sci1v472
	M01HAdubVXQIup/K3OMT6HYpLcG7bunAbsJliWCP2g9nwfTOrRspOtD6rZ7hWZR7vCcFNyXGAmEeB
	hLPey9LrATLlrp3eKicMqYuz6aWov2wgXXfsWQj8KZKopmL657hQ22v+qgU88hYQzYDicaYS0n4dT
	DvnkhnSBKSz/VTAF4NVqicIJUJdV7leIJF7hm0jCRSLm8tpWrfaxBXr+MsWu/jKWK8rJw1H0sJSlH
	dK5gbrnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5h87-000rgG-27;
	Wed, 22 Nov 2023 06:54:35 +0000
Date: Tue, 21 Nov 2023 22:54:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Message-ID: <ZV2lq6PcYwL5uCHr@infradead.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org>
 <ZV2c3oAHtmmYgSGn@infradead.org>
 <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
 <ZV2eY8iH41eOSgIZ@infradead.org>
 <d8e64422-d332-4c99-88bc-85f6e2077c32@kernel.org>
 <ZV2hZ+0jRQUJqMH6@infradead.org>
 <d7c8ff12-279e-4201-8987-92de01e8ecea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c8ff12-279e-4201-8987-92de01e8ecea@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:49:28PM +0900, Damien Le Moal wrote:
> > As mentioned in reply 1 I think this is perfect for a scripted run
> > after -rc1.
> 
> You mean 6.8-rc1 next cycle ?

Yes.  6.7-rc1 is over :)
