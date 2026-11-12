Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.53.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467392;
	b=bl4k0/jDmkDtBtXOmtqyiyvKeGcURKFRJJ3ZShLLZoKxHu7A/k6mO1rECZiLQ7z5L1MF
	 XMqqozXU42QEF76ebkawtO956EOMbnGn+DDdCFcQeO8KkvK3rBI1+y0eDQnFcdEiki7Om
	 hXknTq7UaD4rPQWgcFDed0dWQj9vCrHHAJ2gxMPrP5omMNK2UW0kd3tBN1HsT/ddUj+Vt
	 1xSDQFMnVka6mnlovGz2R1Jj27wielvjJfm3rv25BiC6ezZubvHmKB9TiiHUs0dNtAAUP
	 +8p5cr9jQ2scfxP4ocdwKSCYCWrsTgtVkGejCH8xTPxsM+gkJIg4egFgKG5VTu5dPdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467392;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=8mucxYKJYBwqJKDbsfQpDDCpVs3/pBmp8Rts+MRAkyQ=;
	b=JaCf99W0wF55bbuSiT6caXGBQt+6Oq4FlIpeW28hm+mXM3IY/BtApQaMVoCGYCLvo1Qb
	 ukjPbGYFd0kzTNPrmToncB7mcqsN4pdYoriuXCbxPmoARfSjdxGhuV0B6zSymqsXIT4qv
	 X1WQHh18pG/SKZ5hDlrYMCX6E6yue8w0EvIFX1VhdcR1xuqUmQDTPvSqoF8K/TQXeRtGF
	 la8f9OaKZCvu5DUdyoHqLn0gCcIGoKIuhPu41HOnAUDCA1rP57ZHsz1IMD8S8QRtaZ56P
	 TUOnWB2AM3n6oSemypIrstH5Heax6EpJe0PmDqcOoberKIaccEFMlalzH+JmcrAtlAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="O/iMBATN";
	arc=none smtp.remote-ip=160.236.53.6
Received: from mail-m160236536.xmail.ntesmail.com (mail-m160236536.xmail.ntesmail.com [160.236.53.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BA606A33B;
	Thu, 12 Nov 2026 07:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 853BA606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=O/iMBATN
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 546ae3693;
	Thu, 12 Nov 2026 15:09:39 +0800 (GMT+08:00)
Message-ID: <fc0d091f-2791-4078-a986-7626b239aa02@rock-chips.com>
Date: Thu, 12 Nov 2026 15:09:38 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Check the pme_turn_off callback return value
To: Frank Li <Frank.li@oss.nxp.com>
References: <20261111041821.2259326-1-shawn.lin@rock-chips.com>
 <avUrzss_VTn5m3I3@SMW015318>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <avUrzss_VTn5m3I3@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ce973a4603a4kunm008730b691fe9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUtIVhkZGh4YQk9LSkMaGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=O/iMBATNR672WEFrXS+ncZ9imNCdfGIxaQ34CelqumfvPexpznonCffikf7OW2vvBO6K8xRBVx4kK1Wluis08bXaXvQBF8HaQsGcXerDnmz/OwNGM6mv2z1HOpFPSZWy3Xcq67zWHeCcgxJfoPhqr3CP379U2OEZEcY2srx3MZQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8mucxYKJYBwqJKDbsfQpDDCpVs3/pBmp8Rts+MRAkyQ=;
	h=date:mime-version:subject:message-id:from;

Hi Frank,

在 2026/11/12 星期四 11:00, Frank Li 写道:
> On Wed, Nov 11, 2026 at 12:18:21PM +0800, Shawn Lin wrote:
>> dw_pcie_suspend_noirq() invokes the optional host ->pme_turn_off()
>> callback but ignores its result, so a platform that fails to send
>> PME_Turn_Off still has the link brought down as if the handshake had
>> completed.
>>
>> Turn the callback into an int returning function and propagate its
>> error from dw_pcie_suspend_noirq(), matching how the generic
>> dw_pcie_pme_turn_off() path is already handled.
>>
>> All existing implementations return 0 except:
>>    - the Layerscape PF LUT variant, which now returns -ETIMEDOUT when
>>      the PME_Turn_Off handshake does not complete instead of only
>>      logging it;
>>    - the Rockchip host, which now returns an error only when
>>      PME_Turn_Off could not be sent at all.
> 
> I remember first version it is return int.
> 
> How do you know PME_Turn_off have not sent out at all?  I remember spec
> require continue after timeout.
> 

I don't know whether other dwc instances could check it, but there is a
dedicated register for Rockchip one to know if the PME_Turn_off is sent
successfully or not.

Right, the spec does say to continue about a short 10ms timeout if no
PME_TO_Ack was received from downstream port. So you could see rockchip
driver also ignors PME_TO_Ack timeout to follow the generic path[1].

[1] 
https://elixir.bootlin.com/linux/v7.3/source/drivers/pci/controller/dwc/pcie-designware-host.c#L1262 


> Frank
> 
>>   Its PME_TO_Ack and
>>      L23-ready wait timeouts remain non-fatal and just log, consistent
>>      with the generic path, which does not abort the suspend when an
>>      endpoint fails to respond: such timeouts are an endpoint behaviour
>>      and must not make the whole system suspend fail.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/pci-imx6.c         |  4 +++-
>>   drivers/pci/controller/dwc/pci-layerscape.c   | 22 +++++++++++++------
>>   .../pci/controller/dwc/pcie-designware-host.c |  4 +++-
>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 ++++++++------
>>   drivers/pci/controller/dwc/pcie-eswin.c       |  4 +++-
>>   drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>>   drivers/pci/controller/dwc/pcie-ultrarisc.c   |  3 ++-
>>   8 files changed, 39 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>> index 38a59795f98f..643b591c789f 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1575,7 +1575,7 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>>    * register is reserved, so the generic DWC implementation of sending the
>>    * PME_Turn_Off message using a dummy MMIO write cannot be used.
>>    */
>> -static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>> +static int imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>> @@ -1584,6 +1584,8 @@ static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
>>
>>   	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
>> +
>> +	return 0;
>>   }
>>
>>   static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
>> index 475aea3ef58a..8bd879226971 100644
>> --- a/drivers/pci/controller/dwc/pci-layerscape.c
>> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
>> @@ -117,7 +117,7 @@ static void ls_pcie_pf_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
>>   		iowrite32(val, pcie->pf_lut_base + off);
>>   }
>>
>> -static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>> +static int ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct ls_pcie *pcie = to_ls_pcie(pci);
>> @@ -132,8 +132,12 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>>   				 val, !(val & PF_MCR_PTOMR),
>>   				 PCIE_PME_TO_L2_TIMEOUT_US/10,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US);
>> -	if (ret)
>> +	if (ret) {
>>   		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>
>>   static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>> @@ -179,7 +183,7 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>>   	return 0;
>>   }
>>
>> -static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
>> +static int scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
>>   {
>>   	/* Send PME_Turn_Off message */
>>   	regmap_write_bits(scfg, reg, mask, mask);
>> @@ -195,14 +199,17 @@ static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
>>   	 * to complete the PME_Turn_Off handshake.
>>   	 */
>>   	regmap_write_bits(scfg, reg, mask, 0);
>> +
>> +	return 0;
>>   }
>>
>> -static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>> +static int ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct ls_pcie *pcie = to_ls_pcie(pci);
>>
>> -	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), PMXMTTURNOFF);
>> +	return scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index),
>> +					  PMXMTTURNOFF);
>>   }
>>
>>   static int scfg_pcie_exit_from_l2(struct regmap *scfg, u32 reg, u32 mask)
>> @@ -222,12 +229,13 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>>   	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
>>   }
>>
>> -static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>> +static int ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct ls_pcie *pcie = to_ls_pcie(pci);
>>
>> -	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR, PEXPME(pcie->index));
>> +	return scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR,
>> +					  PEXPME(pcie->index));
>>   }
>>
>>   static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index f531c5b51b3c..eb11556aca72 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -1249,7 +1249,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>>   		return 0;
>>
>>   	if (pci->pp.ops->pme_turn_off) {
>> -		pci->pp.ops->pme_turn_off(&pci->pp);
>> +		ret = pci->pp.ops->pme_turn_off(&pci->pp);
>> +		if (ret)
>> +			return ret;
>>   	} else {
>>   		ret = dw_pcie_pme_turn_off(pci);
>>   		if (ret)
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 0ece9c433229..9836ea9127bd 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -440,7 +440,7 @@ struct dw_pcie_host_ops {
>>   	void (*deinit)(struct dw_pcie_rp *pp);
>>   	void (*post_init)(struct dw_pcie_rp *pp);
>>   	int (*msi_init)(struct dw_pcie_rp *pp);
>> -	void (*pme_turn_off)(struct dw_pcie_rp *pp);
>> +	int (*pme_turn_off)(struct dw_pcie_rp *pp);
>>   };
>>
>>   struct dw_pcie_rp {
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 525a26ee1d07..ea7ef0be1214 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -464,7 +464,7 @@ static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
>>   	pp->bridge->broken_l1ss_resume = true;
>>   }
>>
>> -static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>> +static int rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> @@ -478,18 +478,16 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US);
>>   	if (ret) {
>> -		dev_warn(dev, "Failed to send PME_Turn_Off\n");
>> -		return;
>> +		dev_err(dev, "Failed to send PME_Turn_Off\n");
>> +		return ret;
>>   	}
>>
>>   	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
>>   	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
>>   				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US);
>> -	if (ret) {
>> +	if (ret)
>>   		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
>> -		return;
>> -	}
>>
>>   	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
>>   	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
>> @@ -497,8 +495,12 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   				 status, status & PME_READY_ENTER_L23,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US);
>> -	if (ret)
>> +	if (ret) {
>>   		dev_err(dev, "Failed to get ready to enter L23 message\n");
>> +		ret = 0;
>> +	}
>> +
>> +	return ret;
>>   }
>>
>>   static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>> diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
>> index 5639666d5148..ed498601312f 100644
>> --- a/drivers/pci/controller/dwc/pcie-eswin.c
>> +++ b/drivers/pci/controller/dwc/pcie-eswin.c
>> @@ -269,7 +269,7 @@ static void eswin_pcie_host_deinit(struct dw_pcie_rp *pp)
>>   	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>>   }
>>
>> -static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>> +static int eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct eswin_pcie *pcie = to_eswin_pcie(pci);
>> @@ -281,6 +281,8 @@ static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   	 * the skip_l23_ready has been set.
>>   	 */
>>   	pp->skip_l23_ready = pcie->data->skip_l23;
>> +
>> +	return 0;
>>   }
>>
>>   static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index eba1b2cb30f0..9548c6568c82 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1594,11 +1594,13 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
>>   		pcie->cfg->ops->host_post_init(pcie);
>>   }
>>
>> -static void qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
>> +static int qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>
>>   	writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pci->elbi_base + ELBI_SYS_CTRL);
>> +
>> +	return 0;
>>   }
>>
>>   static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
>> index ee844ff7ed55..493b6c68b42f 100644
>> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
>> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
>> @@ -77,12 +77,13 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
>>   	return 0;
>>   }
>>
>> -static void ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>> +static int ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   {
>>   	/*
>>   	 * DP1000 does not support sending PME_Turn_Off from the RC.
>>   	 * Keep this callback empty to skip the generic MSG TLP path.
>>   	 */
>> +	return 0;
>>   }
>>
>>   static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
>> --
>> 2.25.1
>>
>>
> 

