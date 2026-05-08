Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68F2D3EEB;
	Fri,  8 May 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778224125; cv=none; b=cR/RcFkVUxw0mToDQ5OnVDBFyJObeUp20d5hHxkQ7Q4LMDzfrKNu3+n14hSRK6Ocstj5wRgEiEcz0lKqpIuoMus1o/8Y3DpqBxxFCJ4vdm+U92X0V5OlE7WNw0JuZ2RgtzFUcznSlkJwtwaUgliPwVKO8ZsSnLlm/rPRtnvDZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778224125; c=relaxed/simple;
	bh=W3VXFu/ead0FlgXUw8o2hqAjkstrOA2p78DckiXmvXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttXlmwJ8p0bMxjhUUFamEFTNUNllb5bww9poODk6LspbAiHcGghPhC+S5Kjwfl09o8he3iMnZQcyoiGOs6/rSBYS8hXgS4Qvj0SGQTsYwQAJ7wbwB59w/Dq6hmTW7+vnUPqWI3P7wegy9Or9pNbdhMiZn6P0XKSTK1aQ6A58Mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S/3F46vf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S/3F46vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pu9CmN3sv5Rp2YzGRkYfPe222enr6Cqw7gt8SiPcazU=;
	b=S/3F46vfY88rItcgOW3kY//zVivmAoKeNKbLThnlim4+RmX/sFmGUslsxWIHHG
	Cf/np+t9I0tTUxLpbeVWxOe8uG9kbl5Ngcpj/3CDZ2pYRHqPCom9H118FGQ5Pt6C
	eaRCCN3JbqR22MgF9lfoMrmfTSVYBtljizT2d1od7nL/4=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3Xw7Xi_1pSOumAA--.34512S2;
	Fri, 08 May 2026 15:08:07 +0800 (CST)
Message-ID: <12c2c868-a734-49f9-9938-77319b35da3d@163.com>
Date: Fri, 8 May 2026 15:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Aksh Garg as PCI CADENCE reviewer
To: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, s-vadapalli@ti.com, hans.zhang@cixtech.com,
 vigneshr@ti.com, danishanwar@ti.com
References: <20260508060951.840233-1-a-garg7@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260508060951.840233-1-a-garg7@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Xw7Xi_1pSOumAA--.34512S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4UCr48Gr45GrWDurW8Crg_yoW8Xr1xpF
	W8KFyfCF1fJF43Zan5K3WUCa4rW3WDAFyIg3yv9wnxXr9xCw1jqw1aqa4ayanrXr48uw42
	yr1a9Fn7tFs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR6wZ3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxfxlWn9i9ffJwAA3A

Hi Aksh,

Let's wait for one day, or two days, to see if Vignesh is willing to do it.

For drivers/pci/controller/cadence, currently Aksh and Siddharth hope to 
become Reviewers. Manikandan believes that he can become a Maintainer. I 
myself also hope to apply for the role of maintainer. Then let's review 
the common driver related to Cadence PCIe IP, as well as the driver of 
the product.

Siddharth:
Depending on the frequency with which we are able to Review patches 
consistently, we could eventually take up the role of being a Maintainer 
as well.

Best regards,
Hans

On 5/8/26 14:09, Aksh Garg wrote:
> I wish to contribute to the review process for Cadence PCIe IP drivers,
> hence add myself as a reviewer.
> 
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..e2c188a358ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20315,10 +20315,11 @@ F:	Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
>   F:	drivers/pci/controller/dwc/pcie-armada8k.c
>   
>   PCI DRIVER FOR CADENCE PCIE IP
> +R:	Aksh Garg <a-garg7@ti.com>
>   L:	linux-pci@vger.kernel.org
>   S:	Orphan
>   F:	Documentation/devicetree/bindings/pci/cdns,*
> -F:	drivers/pci/controller/cadence/*cadence*
> +F:	drivers/pci/controller/cadence/
>   
>   PCI DRIVER FOR CIX Sky1
>   M:	Hans Zhang <hans.zhang@cixtech.com>

