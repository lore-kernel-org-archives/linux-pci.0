Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305777;
	b=kCzd4oAQ5qtS1WthZq56acn69lhL4Jstk8Ir3Z+9viREE17sSzIhpoC86EBzNqcBvANe
	 8/3gNBZzRLoVbvAHKABY76Bj7S5WcypWURjY9NYMHPIOsnCQN4mwjecbYoVZKerL4XF7Z
	 VUpX6ssQ0/nVbzwbBLz3Ws78jAwq4pwvsyVruZ6Gr4xeLOW4amUFyR/9Ih90nxu0d8QM/
	 2M6pcv5mIIxZj0hRRMmU0VzXVVMxCoPHs7qkEQ6XXzBY7vMaKr26HiC1nok+3k7OnUa5P
	 5JW38aq4N4UAUFEUVsFbo5IXzEWgAlCbqWt2hWFXw+TfpGF97FqZo9FPiLgeBPKVzYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305777;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e73/BOUrVOwtVUc63+9l8lmB3YYHxybhTd2jvPEdO9A=;
	b=uEaBhWNUI11gWrNFJb6CDcBJDGy7abbFjIXIA+gQ92631PR65WDkOoQBqZr1pq+uPp+B
	 936IJSBTGImN5Q1gzqm7opYHl16ofW3l3P2D0l6ycRrGqPLBkXqW6rElcSCJkQQY7OCdL
	 w4SZ1hPzYuEYC0IygKRWot2fFva2ijOTivPLtuEdCEWgI2dhmku6t+Doptvo8BLNNtFVx
	 O7JaHXLx+bIuVGpKfImarHVrPnIDxTXV9Tt5SI6V6AJ4BdsBHeegBp3yQnzjlYuEH5rHF
	 6ftEKxwNZ/VlIj0FGy9NGdYenqcpgeXYzUCMsZpNSsDWW5CXiRqtU2+7tW4ewEqiPKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E404606A31C;
	Tue, 10 Nov 2026 10:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E404606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 459FE1447;
	Tue, 10 Nov 2026 11:16:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4214C60FC73F; Tue, 10 Nov 2026 11:16:14 +0100 (CET)
Date: Tue, 10 Nov 2026 11:16:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: lirongqing <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Save the Root Port state before a platform-specific
 reset
Message-ID: <avLu7sdyMGhig7_5@wunner.de>
References: <20261110053348.2419-1-lirongqing@baidu.com>
 <20261110053348.2419-2-lirongqing@baidu.com>
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
In-Reply-To: <20261110053348.2419-2-lirongqing@baidu.com>

On Tue, Nov 10, 2026 at 01:33:48PM +0800, lirongqing wrote:
> pcibios_reset_secondary_bus() restores the Root Port after
> host->reset_root_port() without ever saving it. pci_bus_reset() only locks
> the devices below the bridge, so the bridge itself is not in the saved set
> either. Save the Root Port before the platform reset.

The state is saved on enumeration in pci_bus_add_device(),
see commit a2f1e22390ac.  Please explain why that is not
sufficient for you.

Thanks,

Lukas
