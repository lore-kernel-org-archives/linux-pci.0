Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793832296;
	b=K6Y8y9lAXaKBRa08LHHGwvKG2YumXiIMPhEa/P5niBRnc2I11UPemIWDyfo8VZYOoRr3
	 AZGQwn8QgXcY+6iGAmL+uAASNeM4DQ/hhU8r6HShULK9uRc8uxThmiKNNksEdHZjYcCIu
	 lajeAaSzb5GJRTItdE55RNcDQ2DBU7V+WX78gDz5Sfff2L80zzX6wsQBcXzvXKqXPDK4J
	 8NJVWl+gomLvZ7HeIQuR2snN7XP31P9L/W15n5vY+CxB5ntzUAA3qjKnm3FMAvGWma8Vp
	 RewG8Lr8pOuvSQEqBTm6jWZeW9TK9V1mUIaZqCtqm3C+CFFGQAryxoPnpqRH6ApbULA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832296;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hfEBpFMF8c5rPBNt+LYZXTPFb+iq379xlL3xl7YzuZI=;
	b=Ld0iaqfHKyGeUhVk1abTUM/RCYJ+xQ9Nlo12rjVio91k6u/W45JCRkjC9L4iw9wMaM7o
	 BL1aePrpLHD8WcyDupnU8qThx1vrSuHz9hi+9GaEcNLUG5cFXTRRjIGVFs7CKmeBNh+XZ
	 pTaisJy4dA7rBUX41ofUJbFAr2RzmV1hZWONiBSAUvsJEIMUBF6wOprn83esgfLt65TTR
	 FxLeQxkYetDzZsEHlLPFNZbYeUNkBJk45Eljcmzx+MY77jSTLR/6FbdjgLwDJH7aty336
	 88rbrZWuBQYLHn1qOrGdgH09mvgTiY3ABdlhVZe2SD4YEjPIjqQB0ddX4S2MZXnOR0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=BYGnZrOn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78064606A31B;
	Wed,  4 Nov 2026 22:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78064606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=BYGnZrOn
ARC-Seal: i=1; a=rsa-sha256; t=1793832249; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=czcY0hthCcdpo/TlC7/oZP4c135oFGtQ2rnKgsYDTGav7RHuFWvzSIB8gBH+4RqdF8p3m8thmeULrUAHhoTL7ier9zAPyzgvlbZiyXTAgp/rXnyN/plx4tk0+gHb1P1tRV6nP1YrB+v5WIXaz+VmKoprHzQS1yIjVuaqFXFA1Pk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793832249; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hfEBpFMF8c5rPBNt+LYZXTPFb+iq379xlL3xl7YzuZI=; 
	b=Q34j5cG7k69XSj0S0HCHtiAe/peBNU75X9Aiz2NvI1AAlUD5GqTJLP5kE8EZocGWbAcXKK3csinOTR7jxcIgwVUkPErq+GIP8Bs6+gj+8mrh83nXALy74OZhf0Twet/xhwHre1Gf1qaAcw5AHiDBkgse4uoX0ZhBPVKdkN/WAiM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=BYGnZrOnNsNC8iSfDlWmzPc8iCkDgbyVP6wke9/Tg6vGPoDBXjKcMBHOrIgEaZOBnlLUWq/3MxG4ZLYhfmnTpuistWJZqMH8GjbPJhzTa8wU+YNAAt5fRY90rc0Yujiym9mf5TAXC22v6wvJcJhTx57MXLcuvbsIw9GNv1S7Lzo=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=hfEBpFMF8c5rPBNt+LYZXTPFb+iq379xlL3xl7YzuZI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793832247813832.2603239285348;
	Wed, 4 Nov 2026 23:44:07 +0100 (CET)
Date: Thu, 05 Nov 2026 00:44:06 +0200
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
Subject: Re: [PATCH v7 00/10] PCI: dw-rockchip: add system suspend support
Message-ID: <20261105-dw-rockchip-suspend-v7-tested-by-1@iav.lv>
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
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

Tested on ODROID-M1 (RK3568, NVMe on pcie3x2) with 7.3.1, Jonas'
EHCI/OHCI clock patch and f845c1e2d2d4 ("PCI: dwc: Add suspend_poweroff
flag for platforms with RC power loss") backported: s2idle 10/10,
deep 10/10, the NVMe stays usable after resume.

Tested-by: Igor Velkov <iav@iav.lv>
