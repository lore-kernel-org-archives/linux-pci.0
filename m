Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793848119;
	b=A/PU3NnKoDgOM8X03hnNMiliI/FLn9yi2ctQoMaMk8G96jIo4wxn9WynApaXX8AsZ/V3
	 QrcB1UXl5XKYiliQ3zERValTkTgQ/M42kFQsyMI97/HC/uoa0MoxdjYhW+ARsBMel/vBb
	 /bSOPguTNDjDucZkRHB/qnV2n7lpMui+yO5I8fnrfyS1ntzG9t9ImBLqawvEGCi12ZLrG
	 j3obU7GQo+NLpTGNaIOGGGQojlEOtlH7jb8Lob2FIPReO0SQlEKHDCS5iCWwKTgSp7j+/
	 rab+B4WgwzZt+WGPNBzDqcAxEqGOo45ahvDlFLoZWvsN5ugbxl9rCOJH6IaImWYLZLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848119;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hfEBpFMF8c5rPBNt+LYZXTPFb+iq379xlL3xl7YzuZI=;
	b=C7MhV8kOY/6MT0jzKSHcXXB0N5MMRQMXBPE1Xzb6Ypqn2PlKWpegGT8ST9mbFaBid58W
	 hntNa9PWPYL4WhJOt1uAqnx2FAa1Ou1Z0/u7nbjZL4rHmAE176RivcUC+9mLjSnTFOO0f
	 SHbDaLw844kMx5mm8hBKqZM78SeUc9jmwJnwuvnvbUu1k8NBaimqstwkI+k1s0i+fFr2L
	 kxyV7llKww+hsvppfWqtDnA8+BFhk5sdpe3xna3vSV9QO4uQ91QToQ9RQe2t4SpMKs9ov
	 2RWJ+fLurFzHjwhMDCQfWy165gfxxOSv9F4Xy73tiZRpLN3onxuK1Q+YSZLQ7Tz95Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Ddr5K5OW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB695606A31B;
	Thu,  5 Nov 2026 03:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB695606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Ddr5K5OW
ARC-Seal: i=1; a=rsa-sha256; t=1793848091; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dweLjTptpWryub+u0A2rm7quFnkZsfuwEn1YfeUjSPZrBBhfChz6c0erWuCI+A7SvcMiWdexpGaX1qegXm4dpuNn7KVDYR0Swor3TkoIhlJECNkGFxBm8jUrc5YDYv5S7jbo1HqoMqLF5DTykqk7gacey5ePzX/i1ZU5e5jETX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793848091; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hfEBpFMF8c5rPBNt+LYZXTPFb+iq379xlL3xl7YzuZI=; 
	b=AMbcLk+ZQtnihV0m7CKlXkoNowxS+dg5LRYbh0AKoKvZolGhrPMWR4AAOrcY1YBJeJqU8Cd6BVeEmt+YLvE/ZyNcAcKmyQmurmjcubHNTp8THpeY8w/xyJXwyYXnOZGagUbk2jnkbDwHVBmcbhNxJR3w/AnXDPNft/EiIowOi/8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=Ddr5K5OW/fZiOVFEPxP2Ymmky5SUjWM+dPjGy+g6ixQm46wwKUmENwkvPmh+o2iSYMubHY4bkZyEajHvm6WznO12ENc26bBTyMHQfj3rE5S2p9ukecdP9FmBs/fk8aVPLPS9oel5f7GWbexwhvSLBWNGoxQjzf57IptVaE61rbA=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=hfEBpFMF8c5rPBNt+LYZXTPFb+iq379xlL3xl7YzuZI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793848090260876.9732785997211;
	Thu, 5 Nov 2026 04:08:10 +0100 (CET)
Date: Thu, 05 Nov 2026 05:08:08 +0200
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
Subject: Re: [PATCH v8 0/9] PCI: dw-rockchip: add system suspend support
Message-ID: <20261105-dw-rockchip-suspend-v8-tested-by-1@iav.lv>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
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
