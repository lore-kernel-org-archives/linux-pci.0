Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625674;
	b=xRBNBEwUWKaE/pAmKoJh487LV6l/RzpEhDvrQtMg9WAC+PDWJBFb2wHdZp3nIeybFv25
	 cZVwTmGfSL9UZqUzhIN0CvuLq+3ylWc39JdcO2/gTZtn6JuPPIS/m9/1BuJlYAEwnlEHt
	 iG6Ohc1oQm5QL04iLqyhx4wqHaCffe1Ndzov32/fAURUMArccv5agsJFW70IfR2TU7cGl
	 wWnnq9XBWuzrFXpim9EVkc6L6JWiVFshuN3HBhH4WRID6HaUQifrh9Z68XtK7iutZzvg2
	 0qFgtFjLzVpL8rN6XoOVTNd6bcbM8Egg7TtVijoIMUmCaTrEXhnR057qu+6ToF1E28Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625674;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=jr2lASo3LHhhQY05x8Ui7GbgCZ7rkwICfoFLdbyY6ow=;
	b=E9g/d525Yd4ry2E4d4iAEpIZKgPbdLmdDyeejxkaBKrfHMYNB7CbcrPYEoINi7leXEwF
	 driPxgFfF2BP95OEaE4xKzgnBQwnSW/VDI5fJLBRkR5iGGkjE5vidiyCsVa5iDv38Mc+P
	 KYKSoamLTjuDDY3SGL4q3a21B8X28SXAxY/iSVwtqlTE2ooM8SYZBp4LoKB9b2pNVRuGh
	 JxlPnRZTJoxrQENS8y84IcwKZNBVsPUrOmbB/l+NgZnUO7eXM8JNOSTGFUywE3NxF0w1U
	 NJl5u8IG32XubV0oCTdklyLrN6yqUyFd835z0V5m6eZnqvlj6LYDm0p4935vRu8nKTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121FB606A321;
	Wed, 25 Nov 2026 16:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A0B1F000C6;
	Wed, 25 Nov 2026 16:54:28 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 08/14] PCI: rzg3s-host: Drop nop instructions
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-9-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-9-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:24:23 +0530
Message-Id: <179562566319.5580.8113747221186721413.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=587;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=l4lWft3rtL1DKNOv8bvA9rRRDUu3sRlxk1cqvDTck9A=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBxLDFjeNpP2Vvf2wo7Ol1WzXkNuYiHv1ftaoB
 1IQsnQOWRWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcSwwAKCRBVnxHm/pHO
 9cALB/9rmTJw0PYqsu5UNEgD7v19D5VLwXcIrneY7whMCTLJvf9evLZee1jV79M1uneaW7iVAHZ
 Hx+oABx6Ca4ZqwYB2JhZDSh60yEEI/L2GeBxlbdQjt3l1KAeA501K9cKBKNZBZU9LDQy6+81wBX
 cJ9t06632YUx2RtAnBXJS4n7M6IbCPAIEY8vLrV9o9jQd+kRGDPofVUFUU5szwGnBHieC4KY/AO
 W/d09frz03GsuPO3t8PlmK1eV5U7E3OkkDRWza8bzc2KT17GMyGCtO+Tmh9Dg+WTrAIQBoBH6QH
 v+V7cVG1IJmRvOsrzogg5aCJ2ilLIA6nnu3NkK/EVixncymN
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> On the RZ/G3S PCIe IP variant (which is similar to those used on the
> RZ/G3E, RZ/V2H, and RZ/V2N SoCs), access to the PCIe Type 1 registers
> requires setting the PCI_PERM.CFG_HWINIT_EN bit. Since this bit is not
> set on the code paths where rzg3s_pcie_set_max_link_speed() is called,
> the writes to PCI_EXP_LNKCTL2.TLS are nops. Drop them.
> 

Shouldn't you ensure that TLS is written by setting HWINIT_EN? If not required,
please state the reason.

- Mani


