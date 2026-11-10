Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305635;
	b=xNzXsS6SU5cRqNKEBiAwiAAkdNUe0bkWnaYF1sX8Td5o4l96UPgQbr6bh8D1J+IJ1Ab5
	 JvxNo21tHKKWHwdb8UndZoodwEcumi29Q9D2IEudgL+kLAH2IxINB8yft4EnLbOAsf3rt
	 9p9LlPmfo6HfDWxovJN1uoLUL+fnVmljKGp4xXTC7FizNft87kjOh7yp8NRMZiFn2T6/S
	 7rs0SLZj1/6hrlKizyl1Gnil2dJ5nD74leVBwrT/aNs4BATNW83lY2mWhDeRN8s5mW3nB
	 bCJnzzInbA9u3eCB8bFwIcggnj6lBt2MA+XFflBm6DNuvNjL1TOg+Iuxb/CWo2W6NzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305635;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mFUKZRWYjr06nKYVPuobClmRvFrDal/7C5W1Q6Oof58=;
	b=CQp5iKSFoU1vM9ti7c4tNrGhKBwzKsXNN4tUp6dcxNIlHj0Ib1duQUTyKdpsz24W3XbK
	 I+ynZ8RDFrK1kGQVwINPFjpWZTb8Q6IvsUyUnLNjGcYNhZouQbLywoprtVmsxfBtZ0fKu
	 PzdktS/e3NVb2WXGNgPEpseYhEa1J7BLjRTQq3Si/bLruDxXA5TfovrJ2B+lPE6NcI/mI
	 jGEffD7VSiXSkmZ2FJ3dDYA67AIPD7NN5v6Kn1qd3a3xe0APoC1WMHARQJLBFHHzaAlVg
	 Q8ViyEOrwsOoV2zMz8pku9UhdOgFto8jrNypfR22rMwpoqF5v89FGNsceqVvEXBLT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C9606A337;
	Tue, 10 Nov 2026 10:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899C9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id BB7BB296F;
	Tue, 10 Nov 2026 11:13:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8983C60FC73F; Tue, 10 Nov 2026 11:13:45 +0100 (CET)
Date: Tue, 10 Nov 2026 11:13:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: lirongqing <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Only restore state that was successfully saved
 around a reset
Message-ID: <avLuWagPGyPhLYvl@wunner.de>
References: <20261110053348.2419-1-lirongqing@baidu.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110053348.2419-1-lirongqing@baidu.com>

On Tue, Nov 10, 2026 at 01:33:47PM +0800, lirongqing wrote:
> pci_dev_save_and_disable() returns early when config space is inaccessible,
> without saving anything, but pci_dev_restore() calls pci_restore_state()
> unconditionally and pci_restore_state() does not look at state_saved. After
> the reset makes config space accessible again, the all-zero or stale
> saved_config_space[] array is written back to the device, clearing Command,
> BARs and, for bridges, the bus number registers.
> 
> Clear state_saved when the save is skipped and only restore when a state
> was saved.

The state_saved flag is used internally by the PCI core for
suspend/resume.  If a driver calls pci_save_state() on suspend,
the flag is set and that tells the PCI core that the driver already
put the device into a lower power state, obviating the need for the
PCI core to do that.

Please do not use the flag for a completely different purpose.

Thanks,

Lukas
