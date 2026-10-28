Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793164119;
	b=YhFQAid+EGbkclTn6v91gme7RxUB0bVeDwpMsgutidjuv1wEP1kec3rXvoTjyCYDZ2ju
	 4LedD4b8HF7L/BCAbBue6vVEU0Y2t7k8NjuSItis+uI1s6iZG3+SnxXaoiPszJbofrl5h
	 XNu3USk6mZLCfw4HT/fvtjQ0QUY+O590jvoaLLSKkJ6xqp/mplH4odho4Hw+yxnbgmDxi
	 D6UIL6W692k7m0+UK5txHIkK+sBPDN+lXHIzoKWWpK4KKbszfpksbERNPfl/dwHb+CwfJ
	 jQSRIzxgrBtHOmSI6mSkT6yYfMvtLcJZswDCd513W++CP0llCyoYGLd/ItoHvEtdNkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164119;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pU1kLn/e7S5gHH4LSe4wUg2uRsyVInrWCYyeusC2FTU=;
	b=5CYjvJH4SJl77xircB9qw/Q4vyBZdpYLaB5NKetzHdJDhoaYkjMCvGL+PHhsUofxLPHD
	 L7PolDd2PH+YgXEtmg2s1VSQvrvriyxXz4oW0zu2zxo6Mw1EqKUMKNThS67CdmGNPklyA
	 VwBtwEof2oj4I+oL0KHUOXbfbTTlPj5Vzsy93enVDMmlDwC6yvZCs5PoFk+0gEIiMdecc
	 1A6LTnIbrsC9CexKAX4igYgEjqIz21Cb2HDxXuZn9lWThOVi3olgoUaBOFkvCvoAhvQUn
	 evIIqcZp43UJsaf7TBWJAVb0gakFM/kIhPlFjOGCU/IPjPRJuK4RVDRvUrtduv3Nnlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=DNFiuBby;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F18606A31A;
	Wed, 28 Oct 2026 05:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=DNFiuBby
ARC-Seal: i=1; a=rsa-sha256; t=1793164081; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YxtRGSao/0ViiHH7k1+F6DOeV5dS4qbM78G3BRBGRbpY2aNDK+8x1iBguAIrgdmMFm8DvdVkOcu5tIf5bXYvxuuQZ6f0q5zqc+yc4Bwh7hmNgjzFl0NVIVVGvKyY+pPlTsXMsmzVEBfuHvyOxciFTq3Kp5XcgzZWTQjI/w/jJ6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793164081; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pU1kLn/e7S5gHH4LSe4wUg2uRsyVInrWCYyeusC2FTU=; 
	b=bq7gza7UWXBfvlXnk7Zq1SIGhbbphHJrUCOV99cSnVozr5gmbhNi83812xQI9nEjaWz+ayVCbjZE8wvbWTJXogcZtCbJDmGuZs+jvHE8Jea3dvUtdReiU41BQWxN0DgNlGBRYdVjIc/60CBNqgWzK+hyib44wwZWtEu6CLvA9wM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=DNFiuBbyry0dtEQCG82ninBQPHF20PnwvMwpfxS4EBju8nxnKxWPUVb3+QeqB7fEFtxwBoXVGL/Q5pimjSFB9T8EMdzxXa8Se4NR78rGHnq7LXEyIySrTXW9oG30AIDxE3Buw0BtGstcxBfBHy5AjL8Oyz04Pn/KEda3X55mhx4=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=pU1kLn/e7S5gHH4LSe4wUg2uRsyVInrWCYyeusC2FTU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793164080508149.31550770494346;
	Wed, 28 Oct 2026 06:08:00 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Enrique Hernández Bello <ehbello@gmail.com>
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, dlemoal@kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com, iav@iav.lv
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is already valid
Date: Wed, 28 Oct 2026 07:10:00 +0200
Message-ID: <20261028-h64-tpvperl-ab-skip@iav.lv>
In-Reply-To: <20261028005548.2399155-1-ehbello@gmail.com>
References: <20260911211559.207990-1-ehbello@gmail.com> <179196286749.38040.5597453767131590054.b4-reply@b4> <20261016-h64-pcie-resume-tpvperl@iav.lv> <20261028005548.2399155-1-ehbello@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 00:55:48 +0000, Enrique Hernández Bello wrote:
> If your first resume then survives, the resume hunk is the problem
> and I will drop it

Since the next version keeps the full wait on resume, it no longer
changes the resume path, so I'll skip the A/B and test that version
on Helios64 instead: boots plus s2idle cycles, results in reply to it.

The probe SError is in the cover letter of my rockchip-host RFC:
https://lore.kernel.org/r/20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv

Igor
