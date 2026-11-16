Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848051;
	b=nlyjEt/7yRT6amAXUuNdqRys85B2HIE4JnA1o2Ejy77ALqADo2uKvZLD4sc1Ue9NVGyZ
	 SYVVxyT8kroGb5Wo+OAeT6v98SghM+x7jN2X3fl3R2xhmsuyumXRWBqWRXzqt/0ULjnfq
	 vaD6h76kfN8d9vmMeWxB/0F2cI7rRITN9s5z+9sAzrH3aXDRdTZ9Atv5PXr9icReFHbvb
	 k9S2aonAx2CcpF9lyo4AdChyjd5HGlaRLhsPF69jiqWTyv3ktnHoMIC/ZWJrO9u5RNI1g
	 hJDHig1+9LkDBtXKRk1zJNL71czaqkA+ItbiJR4kUKPXV8pR2Sl57bFTRP+yyzp/eBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848051;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LLYENQ2KuzrurPfd6Up/el300vi7eM3VvpjLowoKYEo=;
	b=URP6/DMa9qar1sOlcpTFayyrDpdAuin1Eu+arCJLcssJXROH7SE8h3PkH8iKd9+Ezrr2
	 qIk6oYU40jZ4qkIgoI2oADox6mtCLliZfr4Q5mRV7S3VREvobTauZH4qyEna4sBCgUxxH
	 ZxL66MmC9t5PgYLhS6HjmZhmTbAo8MsDmPi3jXo/6z04ahK+rAjJeLN6d6MxzkCP1+B0L
	 EB0PutW+5b1N3l9iRb4cxtGeb8hoqiDNsWgTBiYAavB7f1H/d/LuULrA5s+UBHhZlYXaY
	 gJoB0KVdSqk9WuRMiAAEg9JaghYysgRWQeLFkMuwMLZ+4rh8Yrj5e9NIrVmGT4qMpGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E43606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 16:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E43606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7D79A8AD8;
	Mon, 16 Nov 2026 17:54:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6C0B36035F1F; Mon, 16 Nov 2026 17:54:08 +0100 (CET)
Date: Mon, 16 Nov 2026 17:54:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: "Bowman, Terry" <terry.bowman@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
Message-ID: <avs1MPhrZtf7u_uB@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
 <2604b3c2-4c6e-453c-b7be-d7ff6be1dbb0@amd.com>
 <f6f6c126-cfbe-4e67-8002-c11cf6f84189@intel.com>
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
In-Reply-To: <f6f6c126-cfbe-4e67-8002-c11cf6f84189@intel.com>

On Mon, Nov 16, 2026 at 07:36:21PM +0530, Tauro, Riana wrote:
> Since pcie_aer_is_native() is a generic PCIe helper that could be reused by
> other consumers,
> could we also remove the CXL namespace from its export?

After patch [5/7] in this series, pcie_aer_is_native() shrinks
to a 2-liner:

https://lore.kernel.org/r/6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de/

I think such a tiny function could just be moved to include/linux/aer.h
and become a static inline.  It should also be changed to return bool.

Thanks,

Lukas
