Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FEB4F30EE;
	Thu,  3 Sep 2026 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454543; cv=none; b=P9rdPhL1cA7wSqQQfG12D2rZOVIQ8EvAQBPT8Pp8o2VNH9XJdfnRbjpiqH5DmUc0JKOm3rhEiu8eVL22y3G4Gz/dlqfCKGitG0l3qFbQw4IyWmU/A8lGudHqKJN1W6q55NTKXZsapBZV5cCqaC2g1iJNRRcmgAedtm38vzsTkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454543; c=relaxed/simple;
	bh=u6FvdSxn0ad/CMlB1Ul3KgmoVrafixaP4BeC0gTupfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZEdiWbZ//Wy24QXyVOB4eP9vmqlUdXXFkGEgeoCJVdqMEXH+RETQXBLYzA9dNV+dMgMLDQGLT2zWkJBX2CRp4EYGsNowCCFga8sLqBzXd44KluEoL1l6TpIs8+2CmdhPsMTOrjZr79VbrFVSj77VWpbUdIbNhSwbYoSbzBqFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ertKBQfG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cE9/O8qN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ertKBQfG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cE9/O8qN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A21777A014B;
	Thu,  3 Sep 2026 12:55:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 12:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788454537;
	 x=1788540937; bh=9lLi1gnVJFhHUszJgS2RLMNzzvcmut5laCzH0LVdPCk=; b=
	ertKBQfGPmLFboJE3GI3ANXJ6sjLIc3tF96ptO3gxYlkw1Oj+JwlHOhvn8HOh1S1
	HcI3ohprpFna4LqIA/hz7+erqTeL41VApuPtKjk8KvfiM1iVZZ/I92ak615yXMFI
	6VcyK97dgRzE6Zj7MAVAUzZFI8fPjqKKrYF6GONrOzYP5vmsFrNcg4gFh8o6Emeu
	1IfLB2W+D/x7O2x/h5P2eNm8Tk2I73d9FvMlRt/Bw9eMq2oK3DTvL30Q7rMHXu4v
	tIfAEoqmYV8BBQisMsWPU4b7nX9P3A1mR+X/SqKuTR0+9FIwwVzWY5CqHunVM1oe
	WLvWup+RcZNg98EUDZj1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788454537; x=
	1788540937; bh=9lLi1gnVJFhHUszJgS2RLMNzzvcmut5laCzH0LVdPCk=; b=c
	E9/O8qN/mn9WQSbw5yZYa8peOAKfmOAEXQvuUq3MsdypdrqILNak+WMYHsj3697U
	q328qv9I1YUFxH2xAHy/ksZNRCvHIUaPc1Ad7FmymMy25ZjF8ViLgMhSoMSnieFw
	+ozjQN/Ngx3cL4cRPpKBH50vIhMDcIwu/4rh1Ho+7Y4hHgZgnYfU47rlWdnNCABW
	X9O+nN9CBzCzSKHZypDDxkkryHVJA4nFYGAhExr9IVCXLeoyn3+5PApsDgUL07oU
	fdjWrj+K694cl+upfUJcah2JhmVuMKCNjAv4H/wAVXRo6V7/QXiz3n01E5zKjA98
	9+eA1wvn1AQ7nz8mZZoGQ==
X-ME-Sender: <xms:iaaZahs1EhbMUdK7Ytme7WxBeN7X1JmfTvVmG03lOT5Lxh22wqo5PQ>
    <xme:iaaZarJMCq8DevVrH8Q_fiZnEiV4IvAUbUfj1MmFtoFocRr2tRrNIz9zJB1zlvRkp
    ymQbO7uU0s8dUE2VTMsTSvJH7Oy0anbYLfpqW-YBp7ndZYL_ylFpg>
X-ME-Received: <xmr:iaaZai9oFyCO87WUK54QXKD3-KGsB566-USjlMF9GHfvivF0LjF3Xuq39K9g-w>
X-ME-Proxy-Cause: dmFkZTF8Ookm6y7tKklVCB2QfanuiteXdC3LYDwlkH/zpT8Goa1lrD1vRkSqupAcJZu7wn
    JWXo38/0QrDq6Fnz2rNqhMuf+B/9iuO1mmDfLscB+oLszOgAdFyBQqID97UfYQtJE+P7f+
    UJiGxZGxchMGvMJKab8Zd/0FxWWPHCeQ48wnKOncMen/2bwGwP9AQyO+/j6CAuwAbxnh/Z
    q66zSkFvOXF9zpnVECs4BS4S3XrgtGUIF0DJv09YUe21GRzYeEdrSVnlxmo0SvZgILqaHJ
    pehp4cQt7yZYDPJ4m39GFxPs+dnygdcoOhRsSH43saUoltOZnLZG8fanxczwFp+vnVJZrN
    liASGdccVdObd1h5r/tRBkq8+uTDe0yGQXkPenR119kkgziARvL2Itlc7MnkOtTFbwYTEj
    Z/oDma25vbqJlT9jXbwPc96gzowlKtkM40cCioPY4jb1+0GJgWCK1g2zmBAs8nm5W4CriK
    +Qn4uMK2UPwhvorLg6VlvIFRXg/V0RiWGxZsMNjyqYYiLQS4KFYh27jKBSusCqs90NKlwx
    lDv8T5WXYOffEA2b2rrUn6DWp7lJ4kjx/FbjJnYOb9/FtfKXVy7G5K9HQYdBBnSHszXwlO
    bXLKLGXm/KN4wVd8r3qqsBvG1chnkWGH/fb06c17GEoDLAtDdDKzYxqZQYOw
X-ME-Proxy: <xmx:iaaZasz1MtFq4vwSxSMZ3K3IN3xdwdV832VUF2COBcazjU142-QGGw>
    <xmx:iaaZan5Lcs-i5yiql9f0m76b9UfD8pfljSACs9lZEw9R09Uhb7yekA>
    <xmx:iaaZar9TDm5KyWV52h6dOwpajjpRloQhU0Oou3HOrBxCkIi2WS3vbw>
    <xmx:iaaZakoA-CS5hp7fX6GWpR6WiD6nw73YCKIdQEtUU6O6YFKkFQTyMA>
    <xmx:iaaZaoB--0ZmUauWYizChrxkggrBEfTRWVb7i--hRT0FOPd3CAkjekJz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 12:55:36 -0400 (EDT)
Date: Thu, 3 Sep 2026 10:55:35 -0600
From: Alex Williamson <alex@shazbot.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <20260903105535.5c0b8fe8@shazbot.org>
In-Reply-To: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>
References: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 22:16:15 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> 
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary. This violates the API contract.
> 
> Fix this by increasing the mapping size to include NVME_REG_CSTS. Also
> change sizeof(cfg) to sizeof(u32) to make the intent clearer.
> 
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
> Changes in v3:
> - Changed sizeof(cfg) to sizeof(u32) to decouple it from the mapping
>   size as suggested by Alex Williamson.
> - Updated the commit message to use "violates the API contract" instead
>   of "undefined behavior" to avoid overstating the risk.
> 
> Link for v1: https://lore.kernel.org/all/20260817092448.4395-1-raizudeen.kerneldev@gmail.com/T/
> Link for v2: https://lore.kernel.org/all/20260903040049.5460-1-raizudeen.kerneldev@gmail.com/T/
> 
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..06436a96db30 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(u32));
>  	if (!bar)
>  		return -ENOTTY;
>  

Reviewed-by: Alex Williamson <alex@shazbot.org>

Thanks!
