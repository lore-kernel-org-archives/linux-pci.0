Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452503;
	b=ERUJIAu7YxHmFWqUu1O6UqV+oCcUJeIW/Px7Ti/WS81yyAU8rTllGugA14kb1NgllE6+
	 JZWunzY7nMpI779cgpzgjB5DZRfVJJYFiG9yhApmG2/0UgtdC20lNT+MBjKXS2yn/0Av+
	 k5OHaQyP32TruMPszjM4sqwW3o56FPa2iL+TpUb7OP+k+flHSyYh3b/e41cXNOQHBA1eK
	 BfwkZT00sEHux46b+hJso716K4GFe/lI12U4AgTURLznMJadBu8MeD/5H/wijuc51p4eZ
	 Hwx/Tu+wjyAPsJaY6Mo/Qi1XgHXB1D1+9GiosJcpLKW7YvaXTRJ3oy0F4Zt5QlzpXAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452503;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=mfqw0Szp0ZQ6xYRIyk+DFZw+eQ0wewSh/eb/WKajXfY=;
	b=tCxRr8+ZWbOOhXGigYS0hlEhDLUkigK+QrYhWpRHBwV3Y38uwsuME/7LQ+a3Z4VV+e09
	 9zTc+1eegHTwKtyqy5AKh0g4DM+HHpZmtyf8fN6oYxli+b8NGEt7OdMtWaKQMLMHd4jkA
	 IRG2yvlzL9dP7E/IeAgXhPqwQS4USlJxGAgJ9op5Op+JgskBFXp9vjVbape0z11ODfoGi
	 AjAvhNOJ9lNslwDbifKjeV6C8i4IkKBZVMiq9/2wmQ4ebO76OS3ndvIhwMqHdw7RroBss
	 4fawS2uRjufT9aLFqOptl620Ml4QYvwC0mAS/PWRRXC4t2YC22bGp3H9/BP/ptOkH6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WZVjOCYt;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B36606A321;
	Thu, 12 Nov 2026 03:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B36606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WZVjOCYt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mfqw0Szp0ZQ6xYRIyk+DFZw+eQ0wewSh/eb/WKajXfY=;
	b=WZVjOCYt0LZUOOBZv3uPGv286LAJgkF4imL2O1C8FFVWxti4G7FHhdLgUHjHgy
	lyVrd3M+ajNgrAdSOnojtBlkXdXvRU1HlsaO6CLlpZerZ7NLuB8HLxUts9diqPbj
	8dDsfHpsnaZAGyf2ohFAvrLbDjRDbXR5ACy/pXq+XLSkM=
Message-ID: <f14dcc5f-09a3-4c0d-9936-41fe5f912bf8@163.com>
Date: Thu, 12 Nov 2026 11:01:21 +0800
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
Subject: Re: [PATCH] PCI: pciehp: Use PSN macro for Physical Slot Number
 consistently
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260315154507.126524-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260315154507.126524-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X0YLLPVqGoibHQ--.26691S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw13GFyrXF18uw4DWF13XFb_yoW8ury5pr
	W7KryjkF48Krsrua1Sv3WDCr1fW3ZxCrWDCrWDCr1a9FySyw18AFyjkw4aqw4SgF4UXryr
	Gr90v34kCFyq9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKYLPbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AwmyWr1LAzcFwAA37

Hello Bjorn,

Gentle ping.

Best regards,
Hans

On 3/15/26 23:45, Hans Zhang wrote:
> Replace open-coded bit shift in PSN macro with FIELD_GET() to improve
> readability and consistency. Additionally, convert a direct FIELD_GET()
> call in pciehp_hpc.c to use the PSN macro instead.
> 
> This makes the code easier to understand and maintain by using the same
> accessor everywhere for the Physical Slot Number.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/hotplug/pciehp.h     | 2 +-
>   drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index debc79b0adfb..e0d5d24b3351 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -159,7 +159,7 @@ struct controller {
>   #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>   #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
>   #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
> -#define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> +#define PSN(ctrl)		FIELD_GET(PCI_EXP_SLTCAP_PSN, (ctrl)->slot_cap)
>   
>   void pciehp_request(struct controller *ctrl, int action);
>   void pciehp_handle_button_press(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 4c62140a3cb4..8f6c583a96dd 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1059,7 +1059,7 @@ struct controller *pcie_init(struct pcie_device *dev)
>   		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
>   
>   	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
> -		FIELD_GET(PCI_EXP_SLTCAP_PSN, slot_cap),
> +		PSN(ctrl),
>   		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
>   		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
>   		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),

