Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794015728;
	b=MSv5xqrgmoCyOgJupPs/uA70vnfDUt28mgymoUFet4KIy936eJjxRatyXyeuZpAQlGq4
	 zMTUwpYMTvPzCCzT9y9yRsOqEjLeaz7NYznV5isURdmzmBTkEAzt+m+J0t2uJl1FEPmlQ
	 X8mmuT4pc1FRdqsQlXNplpXgc0rO2JfrFLAHG4YoKO3DfxC5HnNJd1GenPawuFPvgTjYj
	 CimeC/L1KJvvdJP1NOqlr2zLOW9T+S6vTRNooc050JgKa07FGGlX+Z0B+ZkPm6vCy4S2Q
	 02JtF7mlQ6moO1M7HxM3Z2x4VZ8r2Ek75zf5I1qZqdsjDb8Gx5pPsEVzUPjIaIqPtsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015728;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O7bVopwx5l+uCFIzzBjwy3PVWjV8Mb7Aip9Q8J+MAmo=;
	b=Iuurm50NUqTkF6ktlit5TWlHZU90T48q6uPBGwauYDh79VE9VKvXanpTrppwPk+rUqZB
	 kGXcvCIBcDY0b6nTNviFAMcxPosecxzQSalpguyI3aNdAz4uSBGORhddvnIUTSRbZ35jo
	 KnyegHfaCm48f16kXTRjPpDI7UyrL8aFK8l98oAgZRgPI6zM4RoHZnEW8YbFCuVkonbC5
	 GiVfqi/WsnehEmANrqHLyko1DNpznz/TM9eOkVsCIIEqowOlikDaY+J+U5EIHSmVdGwR1
	 QTm/I7iU40nULBoAB7QgvdxcCBnYcmz1BbgpE5ipc8XjfryJyuyGsNYLRsNcZiBXoQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b="FQDp3X/1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E517606A326;
	Sat,  7 Nov 2026 01:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E517606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=FQDp3X/1
ARC-Seal: i=1; a=rsa-sha256; t=1794015689; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=e2brhpj8A9dBddC81FdSHTW3MCxt7B+/xYvr6ca1LF4quscdSbf16uaMwrNW6C2O7vstBEmKvlImC9Y35OVty3HdeOA9tASC3hV8oBTxFdg2cHV/Ip4MitEhRfeh9C8TM0xrI8/Qhy4gMKaEoj0jzU4lgX8aOBhc5zJr+ZtP9eY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794015689; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O7bVopwx5l+uCFIzzBjwy3PVWjV8Mb7Aip9Q8J+MAmo=; 
	b=gIvGKe0VQsrISA1gbb7Nn+G7DE/JZzRjii8z8J77rXmAVMeGyus8xjsjHH3QL2e8MMrOGCx02jxyQd8aLQmS+t3r9qKIdgVDt7ahJ3aHp3XX+2eHK370cNFo+zkiJ8tX2Shw75eXyoUs20UAZmdD4UAkQgJ1vQibWY4VPF0uDp0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=FQDp3X/1HdXeZbvwM0b9ecMMEycmE6OoWSIP5e+Zf4wX90iH205lsZCeaWOOaC+y/Nhn50RbR9KHJEDcJwEm9kex7gOj1/OjJAXJ6wxOQ26mJTMhVrsmQWoF94znQdgWAIRNn0EI/QQJ88KbfomPWP8Vy5eAWUJyutsIpXyJeZ0=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=O7bVopwx5l+uCFIzzBjwy3PVWjV8Mb7Aip9Q8J+MAmo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794015686878202.4386126026909;
	Sat, 7 Nov 2026 02:41:26 +0100 (CET)
Date: Sat, 07 Nov 2026 03:41:24 +0200
From: Igor Velkov <iav@iav.lv>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: iav@iav.lv, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v9 0/9] PCI: dw-rockchip: add system suspend support
Message-ID: <20261107-dw-rockchip-suspend-v9-tested-by-1@iav.lv>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
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

Tested on ODROID-M1 (RK3568, NVMe on pcie3x2) with 7.3.3, Jonas'
EHCI/OHCI clock patch and f845c1e2d2d4 ("PCI: dwc: Add suspend_poweroff
flag for platforms with RC power loss") backported: s2idle 10/10,
deep 10/10, the NVMe stays usable after resume.

Tested-by: Igor Velkov <iav@iav.lv>
