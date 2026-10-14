Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369F361960;
	Wed, 14 Oct 2026 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960781; cv=none; b=g7NjNNbELr/Bp6OL/OZOzOC3mVMO7wHHu7C7cyIsXDN/RqGsOoeLz6D1ZLiDUgpJ2mobm8Q/STbhbEfqlLYWUT4M21JI1TOO64S5/9vS+IHbBmSfUDxYieyBh1V3ed0v9MJm5gR9FndE3BvUshQ1OXGN1rMnC9yOGH+4l2Hqd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960781; c=relaxed/simple;
	bh=kvjDjhwBqEIHq59YMfhEgAZVWWGxX4WxE1hAwWgLpfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+8h72rpdOJbFs6FJat32WKHU1UfzA5aaAECgUWmRaG3LsvLO3hJGLkNluDjGxQ+2h657CCtBuGYvhe2GYaJZLmA4MBAmbmN0eK0JZ0KUC6I2mL9zUrXLIxWRKQY045Mum1qqAa4QcUBUxjLVT1Jo25BQRuIQo2kJAzf8iCGUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Waj8/XzH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Waj8/XzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=TnNnbmu9YS7sz+a4d+0CADyh+jpQYkGZAne9eMQmnk4=;
	b=Waj8/XzHQxCH9EQsDAWp/c31srgUtnbnD764g/uY6O+wrR0ijoUq/NL2PAlOPa
	MqBoemKPiDALPlGR7UXEcc0h2DJqyGPrJVt0S7pSMDAcjFevzWrJYhy0IqL9+OJ8
	Sq+o9gPzEbCrZP6479Vc6K2H1dAPue9JznjzFd0Li7nKc=
Message-ID: <40c740d4-d316-41af-a878-837615947380@163.com>
Date: Wed, 14 Oct 2026 14:52:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Describe DWC PCIe fields with full masks and
 FIELD_PREP()
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, jingoohan1@gmail.com
Cc: robh@kernel.org, a-garg7@ti.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930013842.82476-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260930013842.82476-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgDX32G1Js9qKCEUEg--.36534S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr15Wr4rZFyUGF1ruw1fCrg_yoWxKw13p3
	W3JaySya1UtFsxuw1Ik3Z5G3W3XrnrArWDX3yv9w1xKFs3Zrn7WF409a95trs7ZFWIqF1U
	Kr4qy34xWFW5AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U53kNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BZF6GrPJrZ3dAAA3h

Hello Mani,

Could you please handle this patch for me? It was suggested by Bjorn 
last time.

Best regards,
Hans


On 9/30/26 09:38, Hans Zhang wrote:
> Several DWC PCIe register fields are described with a shift macro next
> to their mask, or with only a shift and the field width implied by the
> value written.  Document the field position and width in a single full
> mask and use FIELD_PREP() to encode it.
> 
> No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> - Based on the controller/dwc branch.
> ---
>   .../pci/controller/dwc/pcie-designware-ep.c   |  2 +-
>   drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++------
>   drivers/pci/controller/dwc/pcie-tegra194.c    | 22 +++++++++----------
>   3 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0262d85ed390..198823f105c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1077,7 +1077,7 @@ int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
>   	if (!ep_func || !ep_func->msix_cap)
>   		return -EINVAL;
>   
> -	msg_data = (func_no << MSIX_DOORBELL_PF_SHIFT) |
> +	msg_data = FIELD_PREP(MSIX_DOORBELL_PF_MASK, func_no) |
>   		   (interrupt_num - 1);
>   
>   	dw_pcie_writel_dbi(pci, MSIX_DOORBELL, msg_data);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index aea474ad803c..1ff6ed1f9f0b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -85,9 +85,7 @@
>   /* Common Clock N_FTS */
>   #define  PORT_AFAC_CC_N_FTS(n)		FIELD_PREP(PORT_AFAC_CC_N_FTS_MASK, n)
>   #define  PORT_AFAC_ENTER_ASPM		BIT(30)		/* ASPM L1 Entry Control */
> -#define  PORT_AFAC_L0S_ELS		24		/* L0s Entrance Latency shift */
>   #define  PORT_AFAC_L0S_ELM		GENMASK(26, 24)	/* L0s Entrance Latency mask */
> -#define  PORT_AFAC_L1_ELS		27		/* L1 Entrance Latency shift */
>   #define  PORT_AFAC_L1_ELM		GENMASK(29, 27)	/* L1 Entrance Latency mask */
>   
>   #define PORT_LINK_CTRL			0x710		/* Port Link Control Register */
> @@ -161,7 +159,6 @@
>   #define  GEN3_CTRL_EQ_PHASE_2_3		BIT(9)		/* Equalization Phase 2 and Phase 3 */
>   #define  GEN3_CTRL_RXEQ_RGRDLESS_RXTS	BIT(13)
>   #define  GEN3_CTRL_GEN3_EQ_DISABLE	BIT(16)		/* Equalization Disable */
> -#define  GEN3_CTRL_RATE_SHADOW_SEL_SHIFT 24		/* Rate Shadow Select shift */
>   #define  GEN3_CTRL_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)	/* Rate Shadow Select mask */
>   
>   #define GEN3_EQ_CTRL			0x8A8		/* Gen3 EQ Control */
> @@ -230,7 +227,7 @@
>   #define ATU_UPPER_LIMIT			0x020
>   
>   #define MSIX_DOORBELL			0x948
> -#define  MSIX_DOORBELL_PF_SHIFT		24
> +#define  MSIX_DOORBELL_PF_MASK		GENMASK(28, 24)
>   
>   /*
>    * eDMA CSRs. DW PCIe IP-core v4.70a and older had the eDMA registers accessible
> @@ -278,15 +275,14 @@
>   #define RAS_DES_EVENT_COUNTER_CONTROL	0x8
>   #define EVENT_COUNTER_ALL_CLEAR		0x3
>   #define EVENT_COUNTER_ENABLE_ALL	0x7
> -#define EVENT_COUNTER_ENABLE_SHIFT	2
> -#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
> -#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
> +#define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
> +#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
> +#define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
>   #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
>   #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
>   #define EVENT_COUNTER_EVENT_L1		0x5
>   #define EVENT_COUNTER_EVENT_L1_1	0x7
>   #define EVENT_COUNTER_EVENT_L1_2	0x8
> -#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
>   #define EVENT_COUNTER_GROUP_5		0x5
>   
>   #define RAS_DES_EVENT_COUNTER_DATA	0xc
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 8c610212a180..285a38178da8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -622,10 +622,10 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
>   
>   	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
>   				RAS_DES_EVENT_COUNTER_CONTROL);
> -	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
> -	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> -	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
> -	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> +	val &= ~EVENT_COUNTER_EVENT_SEL_MASK;
> +	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
> +	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SEL_MASK, event);
> +	val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
>   	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
>   			   RAS_DES_EVENT_COUNTER_CONTROL, val);
>   	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
> @@ -661,8 +661,8 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
>   			   EVENT_COUNTER_ALL_CLEAR);
>   
>   	/* Re-enable counting */
> -	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> -	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> +	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
> +	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
>   	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
>   			   RAS_DES_EVENT_COUNTER_CONTROL, val);
>   
> @@ -680,8 +680,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   							PCI_EXT_CAP_ID_VNDR);
>   
>   	/* Enable ASPM counters */
> -	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> -	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> +	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
> +	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
>   	dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
>   			   RAS_DES_EVENT_COUNTER_CONTROL, val);
>   
> @@ -715,9 +715,9 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   	/* Program L0s and L1 entrance latencies */
>   	val = dw_pcie_readl_dbi(pci, PORT_AFAC);
>   	val &= ~PORT_AFAC_L0S_ELM;
> -	val |= (pcie->aspm_l0s_enter_lat << PORT_AFAC_L0S_ELS);
> +	val |= FIELD_PREP(PORT_AFAC_L0S_ELM, pcie->aspm_l0s_enter_lat);
>   	val &= ~PORT_AFAC_L1_ELM;
> -	val |= (pcie->aspm_l1_enter_lat << PORT_AFAC_L1_ELS);
> +	val |= FIELD_PREP(PORT_AFAC_L1_ELM, pcie->aspm_l1_enter_lat);
>   	val |= PORT_AFAC_ENTER_ASPM;
>   	dw_pcie_writel_dbi(pci, PORT_AFAC, val);
>   }
> @@ -881,7 +881,7 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
>   
>   	val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
>   	val &= ~GEN3_CTRL_RATE_SHADOW_SEL_MASK;
> -	val |= (0x1 << GEN3_CTRL_RATE_SHADOW_SEL_SHIFT);
> +	val |= FIELD_PREP(GEN3_CTRL_RATE_SHADOW_SEL_MASK, 0x1);
>   	dw_pcie_writel_dbi(pci, GEN3_CTRL, val);
>   
>   	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CTRL);
> 
> base-commit: 4996364a46e738cc455f5fa9b8b09f2f3348bcc9

