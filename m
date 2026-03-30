Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3C3B27E2;
	Mon, 30 Mar 2026 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861658; cv=none; b=Ya95axyUmtLN7e/Z7j/Q7IFQ6iJ8Xywo4XRQ7nSPeUWt3aQBBv8W4+UpWx6m5d2bcReTuyGWf9nZrVI8N0kwpXu2yWs2/kdHOmu3oyiSiLWYfe5DYxnb7KZGYeYDA+lWfje9BEYGxExMRynn4/b+dc2QTXuIuOjVPMgYWYDDFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861658; c=relaxed/simple;
	bh=Ati0WQXsi/BbMty7w9zy15si5sKm0IPY4TkcmlS7Z9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=TwiSOULND/gigdDtBC1biJ6yA5nqb+iL4zhm4D6fRIlu7ueDADawFDI1vVnCe60/ng8g333k3/JlbFITO5O89hmiNV1Tcf1m8T2gBAgUY94RS5Qg66QLeXM/r1gjWMHVexq1iLPOH2z4tsdhO0RI6iTs5sQHGKhNZ0fkApsU1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=kTaggtKJ; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="kTaggtKJ"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w78aq-008YeN-Fd; Mon, 30 Mar 2026 11:07:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w78ap-008YcB-Rg; Mon, 30 Mar 2026 11:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774861651;
	bh=BofokuiPDJZU4b3Xyu05PlOTjPGWqOiC0E9vOzhVtD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kTaggtKJHvwlPslYA1urj+6xWZcviq4exu8SP6+kYfFe8W7Lnn3O8m5f7WBpJeRGa
	 eqgrQsl+4wpN25EytML4Pkd00CRU/rNxN9xd1z1ij5BFIpea85IP30DaPpOHXg1gdC
	 eIeeuBpMy5dybdI/Ydp/GkNjCr1+hkCnBy3NQBgaxSSMa91IFdQeTZQqrylkg3OE7Q
	 owt/a3tEdGKA/QFdkdw0REyFthVPNwCzmcHE8Nn2DZA9hEpeeU3wx/FtripEchd24J
	 ejKtzTD2JOblmg+DbpWDGCMYATiRj590vneD4ZCKqCB90A8dQYyqYhC/DB7omAkrBi
	 gC+zaKAUVG4+A==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 67C15240040;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 5F04C240036;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 29A7B20E49;
	Mon, 30 Mar 2026 11:07:31 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Mon, 30 Mar 2026 11:07:15 +0200
Subject: [PATCH v2 5/7] PCI: intel-gw: Remove atu base assignment
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-pcie-intel-gw-v2-5-8bd07367a298@dev.tdt.de>
References: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
In-Reply-To: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774861650; l=2173;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=Ati0WQXsi/BbMty7w9zy15si5sKm0IPY4TkcmlS7Z9Y=;
 b=kTeDwbb87ZDCFjB4oRXDikxEf8css8e5gSMQkHoRoDrxSAMvbLkmSNkFHdR3WQ72AuM5xJRUV
 foMvxU2nXl3DDPapCb6sGOvsz+EbdiHd4qDMd3eo6wgBb+hx/rdO18j
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1774861652-C6C25842-7B2AD83F/0/0

If no ATU resource is defined in the DTS, the default value is 0x300000[1].
This is set during probing in the function 'dw_pcie_get_resources()'[2].
The driver overwrites this again when its init callback is called in its
'intel_pcie_host_setup()' [3] function. This is because the value here is
'0xC0000' rather than '0x300000'. This callback is called by the dwc core
via 'pp->ops->init' [4].

function callstack:
intel_pcie_probe()
  dw_pcie_host_init()
    dw_pcie_host_get_resources()
      dw_pcie_get_resources() [2]
    pp->ops->init = intel_pcie_rc_init()
                      intel_pcie_host_setup() [3]

As backwards compatibility is not an issue here [5], the value for the ATU
resource is moved to the DTS and is therefore loaded by the dwc core. It
is therefore no longer necessary to overwrite the pci->atu_base address in
the init callback. The DTS must be modified so that the additional resource
is loaded correctly by the DWC core.

[1] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controller/dwc/pcie-designware.h#L292
[2] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controller/dwc/pcie-designware.c#L150
[3] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controller/dwc/pcie-intel-gw.c#L301
[4] https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controller/dwc/pcie-designware-host.c#L589
[5] https://lore.kernel.org/all/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3PR19MB5076.namprd19.prod.outlook.com/

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 24c463781f1e31d5617a5ff81bdbce563ed5a1d0..f41b64ac48d5c05e6b0e5b14c3e0cd7a4c407d16 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -310,8 +310,6 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 		goto clk_err;
 	}
 
-	pci->atu_base = pci->dbi_base + 0xC0000;
-
 	ret = phy_init(pcie->phy);
 	if (ret)
 		goto phy_err;

-- 
2.47.3

