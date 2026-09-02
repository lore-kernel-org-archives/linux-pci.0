Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCF366042;
	Wed,  2 Sep 2026 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371484; cv=none; b=aELQt+Czu4GA+Hfa/Jb/iOP0HoQKBseh3pFj2xN/k6ns5sCTQH7luE5QtgmZdXf0BoDzOk9DENFxLdLMxoR9SpXLdHYgi3hp2PoP1t1FceHANiiilGY5FWI6NXneGQ6ivSfGACUsW+XeKUYcWm5zOzBKnfPpmqWri8hZ6QKaZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371484; c=relaxed/simple;
	bh=LxOx4KyrI6RK1gGuJuG6n1nqZVEBurxDU6elqjbq2Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioMtPsVW7ZCfto/mBEZJkd9HkOkKShJ32TDazroJBPrSoSMsS3xxC9MngsetKoZEcGyPeqBy7FhUdGNcUSAIC9y3ybQRYHBidd4VMMnTM4ecEkBdZzhXCAm9TfR760r4QNzYTz1Zyag8h8h8I9FvOvPwuW+ZB9IaSe0yvBh/bJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kITNFKye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbFOSFi2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kITNFKye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbFOSFi2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 75046EC024B;
	Wed,  2 Sep 2026 13:51:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 13:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788371480;
	 x=1788457880; bh=25nu+mAM72FWm74neCfGiGekQNAH5/WUm2RaHj6bU+A=; b=
	kITNFKyeqz+6xOyK0vqm/3NcONDqgIA9rG6L+hWSDCCxAW0D0IdmJ/aWy0SlEPbz
	a9/7TTvMPllo72x3tP7jsHKFZpgogFXm9WTXiVkGVOs2GR2C/gIwG2Fpvw90f5uT
	k8QowhyozKlx9pXe5XKQRuYVj6IOywxeUtnGtJhcKMA5gh9k2B52xhee0IOL7w2U
	/oGNBhosgcDxpG0NS+xmuMNlEsSFQjKKqeLvnEMFWMaWXRosptS2SCazlY5UM8Xj
	i848BUbzq3N3AqW/WuP8JEyIBiyvQA02WLq2CwCKRi8+WBSFQt6J7FGlU5zr5+VM
	sKlmW0p5dnYTcmf/MP3++A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788371480; x=
	1788457880; bh=25nu+mAM72FWm74neCfGiGekQNAH5/WUm2RaHj6bU+A=; b=Q
	bFOSFi2ypkDiLsBJ4NNH9Hj6EQshvWlrortDpFQUm8nLTUiBG6GgFwZkeEM7S9e/
	1HQxurkl+dM4wzckPaRkicF9yUCYF3ADGADMng9AxQmgQgWzMxGD6aNclDN5ymG1
	iYHbEdALH1UDbMl4l4VoFBB7OJ1HpKl0Y/3bBcGjrKf4/auSVeb61vOX1S+bIQuc
	12AXIfkLS25vdPmYj4d4L/PEscxlCUIQzTzu6lFO94AWt7Nsr0VoIq1p6mPSk/zs
	4RxEQTo9fw2t8fi+BjmEnRHGwiMkIUHYer40lxqFo64p/uTNqIzEOoLCgs2NWhsT
	9eX7ljFP/gKpYMGKcpn9Q==
X-ME-Sender: <xms:GGKYaphqu7bg1W7Oju-NUAGZQTxOrn-uvvvJVZYwFkock_4jICKBfg>
    <xme:GGKYautgYNIK_xZyw187CCiV5fKKHZlxFPY_JEsauY523t_nli16OkuhInvJyhJm3
    yLKio0yZn3qzeHNd4JHYzhFtyW4GhmJqapmBO2xTQ0bwVSpf07PjQ>
X-ME-Received: <xmr:GGKYanQ6dZRe1fDPFGaRl8Z5Di0qM_opBRTSEkMGxDo5x6p5LX9fE4qHGrwH4A>
X-ME-Proxy-Cause: dmFkZTGDJck7fZxKNC0z+GPhR8KK5JwLKRVzK94YiDSk+UZwDaSfCWjrWafoOviw9ksaDU
    wDfg9nunWQpBX++4+ye668bDpkBPNzzCmWve6NzXEONIxhqZwz27oFAEWy3hsOSE9l8bNG
    gq9yWaQ1cEaI8J5IxmJhx9JDHCt2BT8pa1jDjnvb/CvGBpw4Zt+zHk6fItE8UYZDL7zVSv
    pZCsQdzqAaeEUsNon5yB9pSUqC9KpmaOIP4iL2KzRvj5M2qFhlnoOUxzgPlPD8Nn+06bhm
    nru+LSRIVvuXWYNPW/dXG6n4x6u0XOFbuuIxgXTY9xzypa66DfEhLxs6kQNfPTu2rr5gmX
    JSLO5Hve4YWZSg2aj5OkCLqL0D+aGmlpwlO/QsK4aNgV+nOMIa46Pt1/g2W5pUx/gQYE5Q
    hvcOhw1Lnlp75uAPghfwliyHwWmQfpcGRCxwER1/Ljbdcw3IEo1rifnYqOWvAwrCrtDko+
    O1u9g5HX7dax9dNRlkIuYgZSyc05bdPnHGHqNpcYyutUMyWX7ZVKRTZ3QUudH7QmCLgjZo
    SpAfu+f+NmAGJqU8Yo4Sm5eReTW5fGWFeL4YhsC6dr6mZHvSUHLFUcuDrpX9ZBKdWDiOk/
    ZomG6vgeJuX3oUiJyPDexW5h0xN83O59x+lJSM6kWw/geJZnTJvS3DmOIatA
X-ME-Proxy: <xmx:GGKYai17q1X66vd34caVwTCSI5MMjnnf8ZbDUBMu-rGA7VkESygZ7w>
    <xmx:GGKYass7BJI8nXgnwIhXLLKAnY7SzCHOX4B81bcQun9tDHlEG1hs8Q>
    <xmx:GGKYaojSErFCdojuw3Noba-LxRhYgZg4hLDkqeZbBrPy56IoamVOGw>
    <xmx:GGKYat-RFudpiF5oGfVub4_pEqWUsFnxFKyvhzmeWh5mefobjNBUwA>
    <xmx:GGKYaud6Z4RRPUG19liIjEHooklGWuQR3L5i338sZkKBrtgVoZNqrlAY>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 13:51:19 -0400 (EDT)
Date: Wed, 2 Sep 2026 11:51:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <20260902115117.34a30084@shazbot.org>
In-Reply-To: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
References: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:54:47 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> 
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary and it can cause a page fault or kernel panic on architectures
> that enforce strict MMIO boundaries.

What are those architectures?  The bug and fix look correct, but the
risk seems overstated.  Thanks,

Alex

> Fix this by increasing the mapping size to include NVME_REG_CSTS.
> 
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..ed03892cc960 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
>  	if (!bar)
>  		return -ENOTTY;
>  

