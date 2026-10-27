Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793063759;
	b=bsyEg45h7sDyx6YftcYOIR3w5IrqoOkLFkMMoFoPylzQ5GFyjvRDS+ElFokChQ1Q2Emd
	 MgJJJdOtJ3SZmqvlr6EliqLpxSoKQaC8WESBDceu3vSY3LZRCRfQJEu49Ge+W8MwR77Tm
	 //XlbUocDuhSq00fzhlXMZTXbjoIaWCthHg9ckVKLDWBFOqvMxBouyXmtGpGquFEo5Bjb
	 ETsrPeOYxCQQlaZWu6piMbflUGAX9p/36NjGovBXiD7e0kRc4E3FqSr/4rLkI1BwBLbsy
	 b836bhsUZeIAAXM/H9Lkn/DptWOKc0XJfXeciqstvoLX5U98mhaizmPtZxpoSgNKw6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063759;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lTMF+Ye/9ru0PwM1rkxYWIfp6fw7+rkFRN5JrEh61e0=;
	b=LOGpIbLr1LUzcOdKRhl7Zaa/Y4xtFg7ZJhhEaHAyh7GOTz2/aI1MYwg3eufikuh/+WYM
	 zboIhgjDAJWYtfND6DyXLLnshc79e7B8Oql2F/doeOnUpyragCKdKu0lq3IPk2oC5Hab6
	 JdGQdBnrPZUMdcZ3gW9JwqGbhIkzyUBWR4AnO4SAPW+2j8KGDRSL4xCfuDjQZvuaUFtg9
	 4pZCGmZGC9o4AuaQpsL4Bllqucm1PZ9NWWfB71JxREl4rsLQDutEiiAiaupvw6a2VzLOs
	 SOgED+Wv3vaPoGPMwOIMLYIQM90QAktxG9mlEU/kj/L35EW1Us57IkwI1Zz/JoL8qAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=cpnVcb0t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87740606A32D;
	Tue, 27 Oct 2026 01:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87740606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=cpnVcb0t
ARC-Seal: i=1; a=rsa-sha256; t=1793063722; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DMZCR4pSyeWgpcpL0bBp/FA5mjRDuUidhoTxldiINgrXg7V138YfbklFljmziWe3/N+pVxD9M9zQqyEbpFXV7bF9GIRODRXnvGZvTHRPDODNqhny/I3O2wIIu4DlzKI3JetYMK+/dD/mFdJ9jZIshPUxGwWNT6kRmxK4GnQKHg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793063722; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lTMF+Ye/9ru0PwM1rkxYWIfp6fw7+rkFRN5JrEh61e0=; 
	b=PTNCU1Ri48ndRN3JR301KsTY2Mu2fnTX0kUt5uAj1vXOHqko/0lytAzYoUa5aqVZrqwDhHpsdDf0MgiM7T/G53LT+m6ClChDtBWk5cTo/XAynZtViuJyXNLwfM/wBZK0Ua15C1stsyzl4t0kXOi2ZK349BkRiPnvVH3C3tRB71E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793063722;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lTMF+Ye/9ru0PwM1rkxYWIfp6fw7+rkFRN5JrEh61e0=;
	b=cpnVcb0tbEmRGZcpIVyDqvqRfLgdIg+lWsSYKzMGYoZgeyvVwiDHjmTvvnjbg8/g
	1t7yjwmCGzUY4TPtv79X19lX6NYxv3ZrX5qfFz/PoxkuZ0yMF9FvWGOKi9agtj0dhsC
	C+qjrllJAeI+9sMGQsc6kdbUqkrPtMS6nqTx4zPA=
Received: by smtp.zoho.eu with SMTPS id 1793063719788794.024080307071;
	Tue, 27 Oct 2026 02:15:19 +0100 (CET)
Date: Tue, 27 Oct 2026 03:15:16 +0200
From: Igor Velkov <iav@iav.lv>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Message-ID: <20261027-rockchip-pcie-shawn-mps-1@iav.lv>
In-Reply-To: <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com> <20261026-rockchip-pcie-shawn-reply-1@iav.lv> <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2026/10/27, Shawn Lin wrote:
> I have no idea about it. The PCIE_CLIENT_BASIC_STATUS0 says:
>
> 14:12  	RO  max_payload_size
>
> So you are saying different MPS in different cases, not linking status.

You're right, thanks. Our two reads came from different points: the
slow-link one before host_init_port() sets the MPS to 256 bytes, the
other after it, so bit 12 says nothing about the link. The link-up
time after the hot reset remains the only signal we have: 2.9-4.5 ms
fine, 10.9-35.4 ms aborts.
