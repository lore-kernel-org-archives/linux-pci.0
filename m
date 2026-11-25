Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628694;
	b=dY5pETnKJ3bsdxUfe0QjZe9ZFB2U/po5G6oT9xEPqSjTAct9Sk3zAYt/RIDhyUchCi5u
	 WmtsYwLqY0TaEeKnoP7I1oB8310yqVn55o5Pz1qdCl48xbEMNApbTgW/q33uu2Hr+gMFU
	 gr4ui12g9FnQ0qHfZqC5Ud+MXgUAsgClih5YTo7OaWLxH4LQz6Z0Z7nm5bkVeaUKqU5Nd
	 +7VKSOVkllUup74LKs5EnrFLL+gpriW1Kamgwyc1SH/k4dufQzmgtOJucqQpeQ2bCqDqN
	 sAtaqAjPGPu0xwQW/qMlUO0GipuC61rVdCg+oMwXudat2PTIY5XWlGqzxNJBxWvIpKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628694;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Wj3JhPSHxDH0zNRtHfCEoFUGnDIh9JjFtKfk59svFz0=;
	b=cwSkfPCi2dd8wvVLSOYVj4hzKBU442lMhNAEplAu9ge3do+gHXUkjA4/876FjpMnYxeq
	 JS58uejzY0q/MW4mvJKFTS1Jfln2trnscZziGw8qp7TzGemI9rAILe01mJ/IaB5kyAQdD
	 n8mtqQraBJIeGOYLIIjLgXYzR9vz1AIgUps82Hh1eYPVloM5rt2zbmRjZF26yAXHt/gdr
	 riyei2ykWFJOm4CC6XZZJ5b7zd4zaUNR5Oqio+F2DTI6C/cwyEsiSwcLsa8LR+yejW54v
	 ii0ktDTRSG62amB78lBfzdZtt4aFhYykUdUbCBNCWah2nGlQxyA6KXBkxmc+rbYib8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE78606A336;
	Wed, 25 Nov 2026 17:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA051F000C0;
	Wed, 25 Nov 2026 17:44:49 +0000 (UTC)
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
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 23:14:44 +0530
Message-Id: <179562868433.5580.1979396952125967073.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=2abeH/0GgzPtZMZdPZDPHJoIba8EDvwoGBBRc3lxdT0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBx6QHgA2huRvdQOlBPRm4CfymKGwbF7HxpCCK
 dNubwKVmqWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcekAAKCRBVnxHm/pHO
 9QolB/9RdiERyI1uZ2d8Gq9r53nRgcXEIko6XOHpz2ofOGnzWlwXldPn1aaJuq/cCHXozZZ01f8
 Uwq3GeziZHu1IsA36XXkJPCd9Yg9sSsqOJ/7psOzGgEocI85bONLoPj1knJs+rfIxHxjnYiKr3r
 r5EUloqhQxHxuPl7XuyNrS63KvnZ9vAFSz+3lUvgt4+iAsx8lvHJG34xUj5P20v9NuEP3+XzeaK
 k73QrEQzpBWIo19R9+l+qOza7wGHcnszDZXjFxp5xfnwJLvr5EOq9+h8SOWktmdz6J0nE9FQa1o
 ESO0tss+p7cOC5g5cckWiYa6V2v3qaiIUttHZPrdtIE6NUvP
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds hotplug support for the rzg3s-host driver. This is a
> continuation of the series John posted initially at [1]. Along with it,
> prerequisites fixes and cleanup patches were added.
> 
> Series was tested on RZ/G3S and RZ/G3E boards by generating consecutive
> link down/up events. The RZ/G3S has an I2C device which, depending on
> the way it is programmed, it controls the state of the PCIe link. The
> board has 3 PCIe interface: PCIE_SLOT, M.2 Key E, M.2 Key B. The
> following script was executed for ~9 hours:
> 
> #!/bin/sh
> 
> echo performance > /sys/module/pcie_aspm/parameters/policy
> 
> while :; do
>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xc # Link up: PCIE_SLOT (NVMe Micron)
>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xd # Link up: M.2 Key B (NVMe Transcend)
>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xb # Link up: M.2 Key E (WiFi AX200)
> done
> 

Given that this series is already 14 patches, you should really consider
splitting it into atleast two. Patches 1-12 are mere code cleanups/refactors, so
they can get merged independently and you can post the follow-up series after
incorporating comments for patches 13 and 14.

- Mani


