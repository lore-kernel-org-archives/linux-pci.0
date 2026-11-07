Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069176;
	b=EZRWiEbSwXOWN3Zb8kb4O3ar3iG3F6tbxu32FRVVxsnMy/Ekyh2VpXcXIAL3qNnFJiSI
	 q15AoGBfR6IFL9ECHe2fFYeer/PavrF97TkZGm+z/8GPyEOkrqx57Uw8Lfk1YeWmaz58C
	 Uvm3OIKfTJR1R4lCHViYQgCEMFRJ88J8pHbr0ffmWmcvkBNxumDe3fAg8Xi23y2pVNEKl
	 u6Wxyf5Pp/qP5mWhMXKV0zfnRH4FnKIQehkhtVmcMRH1BVjHZrDF6sm5YXH7VmJ5bTKbF
	 YIbhDKX3RCnn25Bdmyg98dqySiOqlIQwp+zALcSCpvEskgWgOJgElxpv1o4XpOiBiUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069176;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zs5FfJViCFg/tM0lVAlPjBKrGvPI56RE48ujfmXXqM0=;
	b=ONETHPgQT+QLbRFYS8X6tlCInmpuDz3G6QM9xReEe1NHC9xg9rV6qvcaztPfqHpvHksL
	 SSiJS7VFl90y/S4MTmMU11S9lALZdkpinurbVUp0eErB6JQWVzp2E9vAQhhnHBSqN9UjH
	 +0iNtlJOvXwIUCuckNghduTkg42xH/F8qnnea0KdqEyoVAd9UgSFPoaWL4jivu4YZpnYB
	 aJtNUafYeP7fn62kzgpCVFeQaYZ+fBxViZTW+WF9Wa6l7US21e+PbT6zmISozTWgSM2yi
	 iuVXILT+ZybIxwY6zmy6sYB4bPodYgU8fx7szK3Q6vjZ4KoHrdVMj83nMegKQImrq9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E5606A326;
	Sat,  7 Nov 2026 16:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4345F1F0089F;
	Sat,  7 Nov 2026 16:32:55 +0000 (UTC)
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 7/9] PCI: dw-rockchip: Add pme_turn_off support
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <f047dcbe-efa2-4c60-8436-6d001c936467@rock-chips.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
 <f047dcbe-efa2-4c60-8436-6d001c936467@rock-chips.com>
Date: Sat, 07 Nov 2026 22:02:49 +0530
Message-Id: <179406916971.65886.13520937092317191699.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4382;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=S1IECqqIrwBd3k3Fr5mAm2lihZFlAHgQLQIBZRJ7QRA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq71KyRfVqWX3CtO7dsMROvebs50h6vcEg5IdS2
 W1rMFiBT2mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCau9SsgAKCRBVnxHm/pHO
 9UrwB/4+I1ES4Zd9C/2fFs3eQQeARV9e13XPiWzamhcfg0B8YXrs08INU7QM1wwo2fAwGiM90Yt
 OyWU7QYBHJrwCenz4vxvgYe7Gor3kwPrs88ger4KB29Uu+KzyT+nRIaZqNCTtoCnyUTjHLqNzYQ
 M51/zfs8KLMv7HhcsWImH6auTs9cxZWFgH1ujGtPgWD+KpkzQfeMd8OWE38L/quU1r4mdSMaLcM
 W46aHmHXsGLSXvwHngIPXkmXsPGRUcARMPfguJzNLp48Ro5E6k+LyovvAOv0inS6HT3eMu6FbF/
 upDXISlYDN8EU3NYI+jJ8SRHzhhOWEweNZTXb6RcvyB8c99h
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-05 08:51 +0800, Shawn Lin wrote:
> 在 2026/11/05 星期四 7:47, Sebastian Reichel 写道:
> > Prepare Rockchip PCIe controller for system suspend support by
> > adding the PME turn off operation.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 47 +++++++++++++++++++++++++++
> >   1 file changed, 47 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 0e26abc50920..7933c50df340 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -47,6 +47,10 @@
> >   #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
> >   #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
> >   
> > +/* Interrupt Status Register for Received Messages */
> > +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
> > +#define  PME_TO_ACK			BIT(9)
> > +
> >   /* Interrupt Status Register Related to Legacy Interrupt */
> >   #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> >   
> > @@ -71,6 +75,11 @@
> >   #define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
> >   #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
> >   #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> > +#define  PME_READY_ENTER_L23		BIT(3)
> > +
> > +/* Message Request Register */
> > +#define PCIE_CLIENT_MSG_GEN		0x34
> > +#define  PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
> >   
> >   /* RASDES TBA information */
> >   #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
> > @@ -439,8 +448,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> >   	return 0;
> >   }
> >   
> > +static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > +	struct device *dev = rockchip->pci.dev;
> > +	u32 status;
> > +	int ret;
> > +
> > +	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
> > +	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
> > +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
> > +				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_warn(dev, "Failed to send PME_Turn_Off\n");
> > +		return;
> > +	}
> > +
> > +	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
> > +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
> > +				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
> > +		return;
> > +	}
> > +
> > +	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
> > +	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
> > +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
> > +				 status, status & PME_READY_ENTER_L23,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret)
> > +		dev_err(dev, "Failed to get ready to enter L23 message\n");
> > +}
> 
> 
> This is a question for the DWC core: should we change
> dw_pcie_host_ops::pme_turn_off() to return a value instead of silently
> ignoring a failure?
> 
> Looking at pcie-designware-host.c, we have:
> 
> if (pci->pp.ops->pme_turn_off) {
>      pci->pp.ops->pme_turn_off(&pci->pp);
> } else {
>      ret = dw_pcie_pme_turn_off(pci);
>      if (ret)
>          return ret;
> }
> 
> The handling feels asymmetric. If ->pme_turn_off fails, shouldn't we 
> abort dw_pcie_suspend_noirq as well?
> 

Sure. The initial callback implementations were just broadcasing PME_Turn_off
message and didn't check for PME_To_Ack. So they ended up being void. But for
PME_To_Ack and L2/L3 Ready timeouts, we should definitely return failure and
abort suspend as the link may not enter L2/L3.

> Other than that, this patch looks good to me in current shape,
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> We can further discuss the callback's return value issue on top.
> 

It can be done as a separate series.

- Mani


