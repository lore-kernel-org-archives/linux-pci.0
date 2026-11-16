Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856237;
	b=x0eGy3FHNNpb2LmFSf27Wv9wgisMD7olFlvUzZxdp6O+HUNYoHDA9UyD9ZElyycoPsEC
	 M7mmjmirwkG627+18BI7cJDttnhkbsC7Aani6atT/oTu0c4mISb4sysnF7guhzcNJWQyX
	 4N/8b2ERtWKmT+nwf+yt9TdHpWdA4fUgPn3FHIjE5IdrsPU1FO6aPwt/PvNJH0etub08B
	 P3HN+KuowUu/AYRcY6+1KwsALl0sIIEDJmrMP1TxLSLXe5S2/ifsrYvl/mzg7iw3nkq9+
	 ttTsx+bsLhmhxKsVe2eLSkRdMR80+krPVK8Eo15oxXMxaOePHS+yWE+1jRI1Bl/HsUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856237;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p8qohISl+WTz9/d4v1QRbzQmTV1sBrjKLOynJ9T91A8=;
	b=ROW8o2RsxsdFBUO4Eof9vf+JwRBKkEfeQNFc49n3v5NV/24y/n3FVlyIDwstBPLygZZL
	 rAL1wKVYmHKQp/G7cTyrWSNLc5WXk4w1kN4vFaA6kGeQKro+ZAYrH5u2n/U6/olfObPUT
	 kmrPypS6PRdiT7VuQJ8MdOZBVD9FTtMQz5fQTzCEyTm+CTUzfOKtJYmnWg7IZNiZeCTrN
	 EZdxfic9BsbiuppMwc5koDPL27UjH4OzJtovBPwi7kv83SpdEXBHivUeXBDkVqzMyjl0U
	 UynFBeBZkzQWbavEZBD4jhWddDZK7JXklrKa1bJfuZFi8iLStIMbMAtWOQE+79ssTTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=MS7o8GTI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC63606B428;
	Mon, 16 Nov 2026 19:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC63606B428
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=MS7o8GTI
ARC-Seal: i=1; a=rsa-sha256; t=1794856203; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eE6wGEZKwQIhKmc6ZsU4bjMarp1T+8g3NmGQkul/B71UYk10PUB0USRDH7LHRnp0AWEUGaupiYUx2URyD+Z+VXoR+bA/esepiKnmGebGaJk0NANNfQMUvHDNHTrUHN7kXyjOtAVbA1KcqyM/PKAY+8aVC7tY64/aYPtzec3+mds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794856203; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p8qohISl+WTz9/d4v1QRbzQmTV1sBrjKLOynJ9T91A8=; 
	b=N6mTP6mda6Tfe3INR4Mx3Dagd0GU7SrIja92BNfLdMLWWC8ifggS/npHs5wkgSrpbiY6qY8G4PuDFUNNNksgMuxLK/rFC66jTh3H2VN8LSYFeU4quPJlnCVXVWSx3wHGTCUWQ044DYr0I2SdHJnt6fCkiMXa5HMfrzzR5IzbDEI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=MS7o8GTIQI3HoIALL732EwV6YzEfTOFPhh+cEZ8rkn2U/1/LYMQlFAdtEwVrXA7lUQBokPhIJ7j5IfB8O/OV8+MkmvpwuMMAFYTEokXVIp4NZOdtUdfbhTF4xKFuKEn3zAt9vrBSziqNKiXr+6uJsjejOduL+lMiXVQkxbiEjJM=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=p8qohISl+WTz9/d4v1QRbzQmTV1sBrjKLOynJ9T91A8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794856202137794.1410024266912;
	Mon, 16 Nov 2026 20:10:02 +0100 (CET)
Date: Mon, 16 Nov 2026 21:10:00 +0200
From: Igor Velkov <iav@iav.lv>
To: Matt Thompson <matt@boondocker.io>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC v3 0/6] PCI: rockchip-host: Handle unavailable downstream config space
In-Reply-To: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
Message-ID: <20261116-rockchip-host-rfc-v3-test-1@iav.lv>
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

Helios64 (RK3399 + JMB585, x2), v7.4-rc2, 150 unbind/bind cycles,
alternating A53/A72:

- v3 only: JMB585 lost 5/150 - 3 SError panics on A72
  (rockchip_pcie_rd_conf+0xd8), 1 fixup on A53 (no panic, device gone),
  1 gen1 training timeout.
- v3 + my retry patch [1]: 0/150 lost (2 bad bring-ups, both recovered
  by one retry), no fixup hits; s2idle 20/20.

As with v2, the fixup saves A53 from the panic but not the device, and
does not catch the A72 SError. Patches 4/6 and 5/6 were not exercised.

[1] https://lore.kernel.org/r/20261116-rockchip-pcie-resume-v2-1-a633e279be97@iav.lv

--
Igor Velkov
