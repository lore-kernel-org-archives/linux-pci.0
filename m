Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=218.76.62.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432166;
	b=llGkyp3XqM7g1iV7vggaF6yglqWgvbliJi7A0RiH8GOzJ12QAVjg61b1oFUCLOIMHNRY
	 JP1PDSe0aqut8ohoAAlB+lSWKKvO1laj/h8EdJpAZZKQIgAq1E5sVkgb3AmL52UBQmKjZ
	 oBHhtaqaih6W1QCX7P5VVI451MujhnrFLRBJYyWRfyKZNNRr28WM7pfvyNs2ljbOgxi68
	 IGSzfomTu06Plz++BHDqxBhSLTXL7vTZh/z3/P2yJeNZpMKyjbQGBtfZ1H8e5tTbxTm5f
	 pXooG19fewSJ0U6Rgz//uAD3jm6e2CO146jzSwMMe1ctOz4y6rfOfUIlO+0DEAXUv+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432166;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=+kDopycZnDAP9HA19BBrkkNf4GaSRLyZaHpHCwaxUpc=;
	b=oVSGEvWGDnTuY2Swcyi6IoPysHnFKd0C8fvwG/tlDpYNA46wtHKVpKMG1CBzUf1XGtwA
	 nyn4zf/GVwuBw3y7sA5ZtfgPPngewHq3elO9ML0zLtRxBAlZfcJPnDua5OxS+lOfAqAU8
	 l1anCQzZMi1ek6OjMlKOATmpd9Pi3o4xbrErrEepekd6csHgDPCBMxNRGo0yw0uGXadTf
	 0ok3H4iLwFmciQfYU0N8sBUz2YQQ+qsf71OpBZxKbup3A1/FGIhmwc+QEY4taYkBcFLFe
	 CgMWccQkLRXW3F6riimblQC3iR8sA84EL6yJ/o6xMf+xz7y/DqIAN8nTB70Gbc7Wy5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ultrarisc.com;
	spf=pass smtp.mailfrom=ultrarisc.com;
	dkim=pass header.d=ultrarisc.com header.i=@ultrarisc.com header.a=rsa-sha256 header.s=dkim header.b=R6k8B3wW;
	arc=none smtp.remote-ip=218.76.62.146
Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7129606A31E;
	Mon, 23 Nov 2026 11:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7129606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ultrarisc.com header.i=@ultrarisc.com header.a=rsa-sha256 header.s=dkim header.b=R6k8B3wW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=+kDopycZnDAP9HA19BBrkkNf4GaSRLyZa
	HpHCwaxUpc=; b=R6k8B3wWpsiObveZeoFHed2EGTGDnFK/0MmJcI8iybAPk3FF0
	pJQ0EDMJ5VaLgj7thKOpbCuh8pWZSJlpeyZDf6gQuLeL7oUj8L1WPtMvc/97H09n
	lzYtebxKcWeCSegQDhjBnScZFBSLUxWY4UZRU2J+koaIlXN0oF6ZJY+T3U=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAexHgRrhEgEAA--.2091S2;
	Mon, 23 Nov 2026 19:08:33 +0800 (CST)
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
Subject: Re: [PATCH] MAINTAINERS: Update UltraRISC driver maintainers
From: Xincheng Ji <jixincheng@ultrarisc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
 Xincheng Ji <jixincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, 
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Fei Chen <chenfei@ultrarisc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261118-unimpeded-swapping-6b1b3e5bebba@spud>
References: <20261116-ultrarisc-maintainer-v1-1-f58706ae438c@ultrarisc.com>
 <179501112283.639563.5233054429317576626.b4-review@b4>
 <20261118-unimpeded-swapping-6b1b3e5bebba@spud>
Date: Mon, 23 Nov 2026 19:08:40 +0800
Message-Id: <179543212034.1604484.9462414929447940252.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795432120; l=658;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=2XLgEq6VwPYO3u9Cdwe+eXzTlcnJKcd6VYZ8ir9zoX4=;
 b=aKUFY1rPQkOEW8tfiUw+ybT22Zp6yoFu8w2dZgnGnPlt9ibfbxWWEE9JKWkooBYH/PP4AKZCr
 UTCWh0XY9DvBDMZKPe01jKMlplaefeGjNl2vREUNTEe+gDv5shPr6X+
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwDHQAexHgRrhEgEAA--.2091S2
X-Coremail-Antispam: 1UD129KBjvdXoW5Kr1fJw13ArWfCr1xWF48Zwb_yoWxXwb_uw
	nayFyxA3WUCF1xAanF9F45urnF9rW0gw1UZ34Fyr1xCrWvvw4kWws0kr90vr1Sva97tF9I
	krn5Zr13Kry2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbT8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCCJPDUUUU
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAADmsD4rIADQABs7

Hi Jerome, Conor,

Thanks for the feedback and the clock Ack.

I agree that leaving the company does not necessarily mean stepping
down as a maintainer. Unfortunately, I am no longer able to contact
Jia Wang or Xincheng Zhang to ask for their confirmation.

Following your suggestion, I will send v2 adding Fei Chen and myself
as maintainers while retaining the existing entries. We can revisit
their removal after allowing a reasonable time for them to respond.

Conor, thanks for offering to take this through the RISC-V tree if
the subsystem maintainers do not pick it up.

Thanks,
Xincheng

-- 
Xincheng Ji <jixincheng@ultrarisc.com>

