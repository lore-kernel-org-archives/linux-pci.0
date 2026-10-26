Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793039336;
	b=ZjzW/PtqzIMnblxV3mE25bBgrgMEOWuLINEkG233ZUMWEAy53VMqE6fJuv3ylFn48Rrt
	 pS2oguEaDD2QWMdYSeMrXjuA46NjWUqV1DgWj/dk6fnvKkZyhlBodR1T9SWjl3RfRWqJl
	 WnyMCa8ph4bvOUBXmxr4TX5bclzOkxOQl8oa41X3AqVHtVl9gWDt2r5cveUJTpQt/9rL5
	 df65sZwOAZPbLuUz79gXbsVjHCJRwcY/5i0DRzYdPvjK8YqEnWucrDtawV1EsSvGA+UjU
	 hp6vbMR5Bev+ceK69rUakK/RR6Ico2VjLKwvq0M2bqa0unwsQVwV5K417QTyMCwV4+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039336;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uazXjT0Ki1xgfLrx287ADuJ6KrWtZacD7vOR4+uIzX0=;
	b=ai16/8Fri3iGwwglGC7PINjrTbeg16CSB5AMW/iLxCrQWT55uwt9n8I10wXHK1QLEP/w
	 moq+AXGkaAN2KpPsaGrzRX2rg1RXOH7UoKOuB/POCKHgCFO9zQWi+t7mfRXG+3u/ljEfV
	 0cVL25HZ6MfSeyWqffh1lzup10oriCeBIERgKHmy3OAJ494lZYeopUcmLztiGSh62kMrD
	 DIhlPLnE8T+aVdgV4XpTVkC6shT+S2fG/v1iqSx5HL/BIYOvhTo/2Dj9nYGZFcb9M6f7Q
	 Gtl754u7o3kJnLPKsBF5AFuPoOGmcCs3J2kMXvvyvLedaQoqPnxTK8k6j+5yV06jd1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XATZ6N+0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFC606A31A;
	Mon, 26 Oct 2026 18:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XATZ6N+0
ARC-Seal: i=1; a=rsa-sha256; t=1793039310; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=At1s0ErSJRojm+Lo5eOE4pf53n79eDl1FaMWOq7H+kMo5gajrHxhJRVGizKSsDNbtF3LX0IKIxR2ONAJ/ZaQP6mg4iy6qWpado2eZHAmAibql8zixLJHFum9BrBw9VeouYp67eNFPQhxJSdGViY4fQXJdmBd8DfR7wuIxth1DBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793039310; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uazXjT0Ki1xgfLrx287ADuJ6KrWtZacD7vOR4+uIzX0=; 
	b=By/GMvLsj0PfbOSqQ7dgE1LhuLBkbosqa1vawrSGb9WUva+hD/QP8suvEhN3JWg8WlifOBcHTv2TSo+0UUsMLc9y4PK/IgtZs/grXQxsQCORbeserLCDX0NNWeqI0MuVJcibP1US+CIcsUVj/XdSIIiUCFvkHAyzw0/4d2CC6nU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793039310;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uazXjT0Ki1xgfLrx287ADuJ6KrWtZacD7vOR4+uIzX0=;
	b=XATZ6N+0WmwnFLaX387iS8Wijyg09PysnImPV9MDgsXJiceNQ+zXB4ZfBb70yQxD
	It4VcbK552OwQdLhaJd6iLZFJ/9oNPW1zG9IED7EW4cr8TAGqOwZ1/VLMXbRSNrx3ib
	hAU8/VKF90+LwVp4QmP4/IQzw6IkzXO8+NnxKht0=
Received: by smtp.zoho.eu with SMTPS id 1793039309417148.69976615563849;
	Mon, 26 Oct 2026 19:28:29 +0100 (CET)
Date: Mon, 26 Oct 2026 20:28:28 +0200
From: Igor Velkov <iav@iav.lv>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Message-ID: <20261026-rockchip-pcie-shawn-reply-1@iav.lv>
In-Reply-To: <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com>
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

Hi Shawn,

On 2026/10/26, Shawn Lin wrote:
> The host cannot distinguish this case.

The controller seems to tell before the config read. On 26 Oct the
link came back 2.9-4.5 ms after a hot reset in ~50 cases, all fine,
and 10.9-35.4 ms in 8, each followed by an abort on the next config
read. PCIE_CLIENT_BASIC_STATUS0 read 0x240 after each of 4 slow links
and 0x1240 after each of 16 fast ones. What does bit 12 mean, and can
the driver rely on it after link training?

> You've tried PERST# with the patch 1 applied. So perhaps it's doesn't
> help.

Patch 1 pulses PERST# only after a training timeout. With PERST# in
the DT a slow link still occurred (25 ms, then an abort).
Re-initializing the port, without PERST# or a power cycle, brought
each of 4 slow links back in 2.9 ms with the endpoint answering.

> I've attached a vendor's debug patch, perhaps you could try it without
> your patch.

It hooks do_serror() only and registers after pci_host_probe(). Here
both SErrors and synchronous external aborts occur, at probe and on
resume (the cover had that wrong), so we will move the hook before
pci_host_probe() when we try it.
