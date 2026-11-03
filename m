Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739660;
	b=RtPlMWwVm4VhKCkZRt8lATCQzpOOGk2/JpdFvl1scVkChAep0YNXvcngSGmB51fay+UK
	 8AY3CemVdGiXTSPALiF0MfFs5bt2O5GTZmFdJvY5315mpCzydxcFtSh4BXGkjBphZgDwf
	 P8VxTKGaVs2M5J4v2PDp7BOXCQ0Hx9YOD1e7sS6FPsJ5Tq4CrfdUNotupuQwFQqljM33e
	 SGt4VUIJv4MTJsdaoxIfNh85A7rkh1arnszXe1qlJDUWpget1csw+HYRUoRSU0X2LeWjz
	 J6FdE5hp3Ci44IhdCJRg3ilUZHWLv7xtHyNvfJRyLeiR5sSk4WWqOiyHOE/PoWND/dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739660;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1B9Ti0mHjMGcindYLdY+dSAo+e+P8beU5FH39pEmpTo=;
	b=NdppLBQmoSHxGjGgv5wXtMVp3b5KMKEDj1qQa+dmqSqg3ROxOY/w3L7IHPbLGUGA7MZd
	 iwD/LKIiTXQc9KmnTlG/KKT8SRaMCG7XwkEr7wO+eTkMrj01P+uhimY/xwIYodC00i9p3
	 2wnKUX+vJmhu5Xa456iOPl/NXD9eDznDut3hw+ReVjf517xoRCPovaZHHS/3wSJgpx0C/
	 CyRmxzQVw2PuiHWQDheyMwMsiTvQgKImvMyKecgHZqdiN4BP+5GRNU+Wp1SKovhWPpIES
	 aVDv2r+2w//IevorVOakevvuhLGiGJDtM4sKrDrAFAzJMuzciXSUt02L1yZ3doKky0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61CC606A331;
	Tue,  3 Nov 2026 21:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61CC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id F08C42F50;
	Tue, 03 Nov 2026 22:00:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ACA986247E29; Tue,  3 Nov 2026 22:00:50 +0100 (CET)
Date: Tue, 3 Nov 2026 22:00:50 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] PCI/DPC: Avoid access to non-existent AER
 capability
Message-ID: <aupLgpJXw0Rk3E7E@wunner.de>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261103194734.GA314988@yaz-khff2.amd.com>
 <fe6ad028-35b0-462f-a2df-d3f9c6af66dd@linux.intel.com>
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
In-Reply-To: <fe6ad028-35b0-462f-a2df-d3f9c6af66dd@linux.intel.com>

On Tue, Nov 03, 2026 at 12:25:58PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 11/3/2026 11:47 AM, Yazen Ghannam wrote:
> > Did you settle your question from here?
> > 
> > https://lore.kernel.org/all/74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com/
> 
> No, not yet.  Lukas hasn't replied, and v2 carries his patch unchanged.

I'm rebasing my patches on v7.4-rc1 right now and will resubmit
them with this issue and all the others fixed.

Thanks,

Lukas
