Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017245;
	b=oS/+O7+it3tyxByrbjWrS4V/72P6VYmje3egzpba2RHKGh1LxBYY7nQLTHRJDepj97ZV
	 wM7tOYEF5oXX/M6rnS3T3xJNQqCJJdyunJS6ioK0PnDiVeKa2xzdKdliAnfnORUVQfHWE
	 Q0aksmUCruJB6SDc+pfGVxnaSWuQs9TnCgwDp3CLpkVJxGB1p4hseCDMvXATw92z3T0bd
	 savtPu3n1bn1W/ca4DtJ0np2fJs6MQmb5xX6ko7A7mC3QXdaetahioegLk7XEidWfHzSW
	 UD/wGstTF/XhQ3ys9vtZoX7u4h4NyH5GIW4kvVx067IQHSspw3ffXALsc8A+MuE0YDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m40iEWRtwZCAjivU3/hwK72IalkyKV7facYcyNosAKs=;
	b=0RUNwJbiEchi3pT9KJIFTaoua2I2bFEvCup+ttGvWKdHUMWByauFs0AXkKVv8VrwU/lq
	 whc6LuQ/yaT4dKKZ2ygsPDtDB49slz695QjzI7GfiSFQU+bzXhF3wcbf03F1yjqAt9xQV
	 onorRObIijSBOO1r0aSvJdpKWZhjG9kFkab5m6txCYwBI5GZvjFGVwgJDQ68/9mmRnL8c
	 IS2hKBSjvjGrU9SrmbfJVDbwv+rY8t+ysR/Wric/8GEkjem8EwHmrh9WAVXiGtR6FX4El
	 3zBCG9N6XRVvhPT3JKfb6/xgOO421EBCOgMzXMg6kJeEJGpHnGYHQrxrUHzjJl0UEAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyu12w9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EA606A33B
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyu12w9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B041F000C8;
	Wed, 18 Nov 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017244;
	bh=m40iEWRtwZCAjivU3/hwK72IalkyKV7facYcyNosAKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Iyu12w9uDrgZ5WK8YlIAJNJ1uQI0EMwL7LFTZrqZnuPXAiTENQ4veTFewP4EgRIIN
	 wFc3owHng6OeGzKHPa/4gG180hvRW3N4PbSP2AMWGIUXCBJpnpajDNgcOSyS30qJSW
	 1GS/minSSuvdQ6+7BwVlIXRDpZSktLhmQfGK366XKSdO0tO9w2atHeRUaDtS/+0hY5
	 OUHG17vMDvF1DP17kjEgiH41+4LYJ0UKM/KFZ1RMPF8Sxyo1HKB4FUafcLf1bqoPtr
	 R0Ne0wQA+YXRrm7V+gykccrXO14eqIyP/lF8xoHghth/dLWIG+8En6DZ7Itdicruhw
	 Re9tyteah6mhg==
Date: Wed, 18 Nov 2026 09:54:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: linux-pci@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
	bhelgaas@google.com, kwilczynski@kernel.org
Subject: Re: [RESEND PATCH pci] PCI: Extend ACS quirk for Wangxun FF6XXX NICs
Message-ID: <20261118155403.GA565128@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118083222.45366-1-mengyuanlou@net-swift.com>

On Wed, Nov 18, 2026 at 04:32:22PM +0800, Mengyuan Lou wrote:
> The new Wangxun NICs do not advertise an ACS capability, but the
> hardware isolates functions on multi-function devices by directing
> peer-to-peer traffic upstream, providing behavior equivalent to
> PCI_ACS_RR and PCI_ACS_CR.
> 
> Add the FF6xxx device IDs to pci_quirk_wangxun_nic_acs() so the
> functions can be placed in independent IOMMU groups.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Applied to pci/virtualization for v7.5, thanks for the reminder!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee4..e61b5c96710d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5215,12 +5215,16 @@ static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
>   * SFxxx 1G NICs(em).
>   * RP1000/RP2000 10G NICs(sp).
>   * FF5xxx 40G/25G/10G NICs(aml).
> + * FF6xxx 100G/25G/10G NICs(am).
>   */
>  static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>  	switch (dev->device) {
>  	case 0x0100 ... 0x010F: /* EM */
>  	case 0x1001: case 0x2001: /* SP */
> +	case 0x4010: case 0x4012: case 0x4014: /* AM 10G */
> +	case 0x4025: case 0x4125: case 0x4325: case 0x4425: /* AM 25G */
> +	case 0x4101: case 0x4103: case 0x4105: case 0x4107: /* AM 100G */
>  	case 0x5010: case 0x5025: case 0x5040: /* AML */
>  	case 0x5110: case 0x5125: case 0x5140: /* AML */
>  		return pci_acs_ctrl_enabled(acs_flags,
> -- 
> 2.30.1
> 
