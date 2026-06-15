Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD82FA0C6;
	Mon, 15 Jun 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520322; cv=none; b=qj5zRf2g5gW9k4xs6ZVS2Pdd2OLebh7h4R/G2UvvmleigMQTZZMQDL2EAjGcUdZEeACC2blk4tRcrOS8drB0KalA4buJzUalu0k81VBWQ3PKOhaTYqZFpQKERQvZ4hIawQJYGbkkjjs8RQa+wcZJzM3gEydZk0FPgOhH+OAvx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520322; c=relaxed/simple;
	bh=/Q7NtayrvVRmyxiIVTsRX0sWVVQM4Ve6hFR6FbOnq+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0x7cCY396Uh2jw9Vb621tMGAZ+bevqjfmv3YAsZHzkLbJuRlCNJpguuazspoxhld5Wwexa9lBMZFMSupn6bNzPHPxS1LbiqSvuCGbluaZY6mPWX7DGn823E/lysnfQftcJXx7HaMvS9vfG5Xe/DtQ229pa0IGhcrV4fkidEA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=VxhYHQ8j; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="VxhYHQ8j"
Message-ID: <84cc8b0c-da06-4d01-a076-9743c29c91f6@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1781519734;
	bh=/Q7NtayrvVRmyxiIVTsRX0sWVVQM4Ve6hFR6FbOnq+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VxhYHQ8j5sJm4bQZT3JjTsjWDKRMqJqeEzxK3IRtHlmTkQH7+KewdQjRf5JtjZRqk
	 W8kiFSJVljSzuPtR7mY1TWnkfibFxaRGC0aCxVp1z0hdEL8nO0/k4phqhNiW18BYBX
	 qXQWkllFMIjwg2F/R4tYgUP2KfKIs6zZpk9U+fB4=
Date: Mon, 15 Jun 2026 12:34:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
To: Gowtham Kudupudi <gowtham@ferryfair.com>
Cc: robh@kernel.org, bhelgaas@google.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org
References: <20260614015620.20432-1-gowtham@ferryfair.com>
Content-Language: en-US
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
In-Reply-To: <20260614015620.20432-1-gowtham@ferryfair.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/26 3:56 AM, Gowtham Kudupudi wrote:
> On warm reboot, the PCIe controller's LTSSM starts link training
> immediately if PERST# is already deasserted from the previous boot.
> The driver then pulses PERST# for only 500us, which is too short to
> properly reset the endpoint device that has already started training.
> 
> Fix by moving the PERST# assert/deassert pulse BEFORE enabling LTSSM,
> so the endpoint gets a clean reset cycle before link training begins.
> 
> This was found on Amlogic G12B (A311D) with NVMe on an M.2 slot.
> Cold boot worked because POR held PERST# low; warm reboot did not.
> The fix was confirmed on a Banana Pi CM4 with Waveshare IO base board.
> 
> Signed-off-by: Gowtham Kudupudi <gowtham@ferryfair.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 5f8e2f4b3c12..3a7e9f1d5b8c 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -310,8 +310,8 @@ static int meson_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct meson_pcie *mp = to_meson_pcie(pci);
>  
> +	meson_pcie_assert_reset(mp);
>  	meson_pcie_ltssm_enable(mp);
> -	meson_pcie_assert_reset(mp);
>  
>  	return 0;
>  }

Hi Gowtham,

I have a patch [1] that I haven't submitted yet.
This might be related to your issue, what do you think ?

[1] https://github.com/rclaveau-tech/linux-khadas/commit/bee0a02d9756

-- 
Best regards,
Ronald
