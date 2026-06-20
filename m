Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CE1E7C2E;
	Sat, 20 Jun 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973672; cv=none; b=GcIekAhvF6GvoNcqDO8OI2jELq+fRt8VzfjliIvV/9daXp7StQjiPzL3yAZkXLcLmJdwoQ6TaL3tLVI/DpunKGS26q0r9qJKNvU51ApabKeV3+oveGv5lE9JVQ0zI+QThj/Y9PPdISVYrabiii2fGuDJffzhHoVr9yXU2F+pH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973672; c=relaxed/simple;
	bh=h5z1xRTsT/ov0spmQE+ezGKUtaYB2Ro6pU8tBcQKID4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mt5ohZ8jm77+pHpQ1bMOFP1BrbW1Km69kx0aq3CJcSJmgzcGJM5JRGjdO6qnoJxzjhnJHE3wgpn2sWgmUyFjiTqwFeB43BRsQy73eRm+mBx01Olzw1+9X1z3q97gaxFQHrvR0TwZwSixJwjwtdhf6+iuFyI7uJMCErlERWNXbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=qUWsHhY9; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="qUWsHhY9"
Message-ID: <89c11806-54c3-4c16-b2c0-2558b05d6821@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1781973667;
	bh=h5z1xRTsT/ov0spmQE+ezGKUtaYB2Ro6pU8tBcQKID4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=qUWsHhY96shaBTpVX75Yi/UTQb1Z7+SwdgWswmOxoqqOa3SsGt//AlumCRKWSNo6b
	 RMprXWwSbwVTDmzCzmMYdLejJb9RLALPQnhKVWhpaF6Mcj064Q+X33cD1nGBPG+zhQ
	 qIfwngPaUG5josX6NLfx0LiY5Kl1TeKN1+zepMZY=
Date: Sat, 20 Jun 2026 18:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Gowtham Kudupudi <gowtham@ferryfair.com>, robh@kernel.org,
 bhelgaas@google.com, neil.armstrong@linaro.org, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yue.wang@amlogic.com, lpieralisi@kernel.org, kwilczynski@kernel.org
References: <20260614015620.20432-1-gowtham@ferryfair.com>
 <84cc8b0c-da06-4d01-a076-9743c29c91f6@aliel.fr>
 <qq4dum3xqs2stcrd6ula75snrxy34elhodrtp3gftjgzqhs3ir@ykl54gvrfwxs>
Content-Language: en-US
In-Reply-To: <qq4dum3xqs2stcrd6ula75snrxy34elhodrtp3gftjgzqhs3ir@ykl54gvrfwxs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/26 5:11 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 15, 2026 at 12:34:11PM +0200, Ronald Claveau wrote:
>> On 6/14/26 3:56 AM, Gowtham Kudupudi wrote:
>>> On warm reboot, the PCIe controller's LTSSM starts link training
>>> immediately if PERST# is already deasserted from the previous boot.
>>> The driver then pulses PERST# for only 500us, which is too short to
>>> properly reset the endpoint device that has already started training.
>>>
>>> Fix by moving the PERST# assert/deassert pulse BEFORE enabling LTSSM,
>>> so the endpoint gets a clean reset cycle before link training begins.
>>>
>>> This was found on Amlogic G12B (A311D) with NVMe on an M.2 slot.
>>> Cold boot worked because POR held PERST# low; warm reboot did not.
>>> The fix was confirmed on a Banana Pi CM4 with Waveshare IO base board.
>>>
>>> Signed-off-by: Gowtham Kudupudi <gowtham@ferryfair.com>
>>> ---
>>>  drivers/pci/controller/dwc/pci-meson.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>>> index 5f8e2f4b3c12..3a7e9f1d5b8c 100644
>>> --- a/drivers/pci/controller/dwc/pci-meson.c
>>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>>> @@ -310,8 +310,8 @@ static int meson_pcie_start_link(struct dw_pcie *pci)
>>>  {
>>>  	struct meson_pcie *mp = to_meson_pcie(pci);
>>>  
>>> +	meson_pcie_assert_reset(mp);
>>>  	meson_pcie_ltssm_enable(mp);
>>> -	meson_pcie_assert_reset(mp);
> 
> meson_pcie_assert_reset() itself is wrong as it toggles PERST#. You'd just need:
> 
> msleep(PCIE_T_PERST_CLK_US);
> gpiod_set_value_cansleep(mp->reset_gpio, GPIOD_OUT_LOW)
> 
> but in probe(), after meson_pcie_probe_clocks() as that's when both power and
> REFCLK becomes stable.
> 
>>>  
>>>  	return 0;
>>>  }
>>
>> Hi Gowtham,
>>
>> I have a patch [1] that I haven't submitted yet.
>> This might be related to your issue, what do you think ?
>>
>> [1] https://github.com/rclaveau-tech/linux-khadas/commit/bee0a02d9756
>>
> 
> This patch is also needed as it correctly fixes the PERST# polarity when
> requesting the GPIO. Since the devicetree is defining the PERST# GPIO as
> ACIVE_LOW, the driver should request it as GPIOD_OUT_HIGH to make sure that
> PERST# is asserted.
> 
> So please submit the referenced patch.
> 
> - Mani
> 

Hi Mani,

I sent it here:

https://lore.kernel.org/all/20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr/


-- 
Best regards,
Ronald
