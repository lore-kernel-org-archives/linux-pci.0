Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8C3446AD;
	Tue, 27 Jan 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510734; cv=none; b=JbN3gL0ZpoDq2Zq7F4rA7SEZcqtr7MeXP10YGeNYW1MlCpkG8WCFJ1EyqrPQ/aJNO5dgsGmBETEC1fnygv4INYq7KOGv6D7cMBkbEeks26YOLJgsfn1Tf3vcxlgjs6hha8i3nfMIEyaZoeMTfbvMD+yCq3v1LZi5QU5eOkwmBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510734; c=relaxed/simple;
	bh=xTtVALUdMr+r7W7dO8MJ0af1qOaq5dM3KGDJHhdyzOY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhBIn9qNJ+NgyCorrcMRZ/63uoEOH5cTwidNvrJa9/YjkolA4ng+eB7nDRBEsP6z3F3LUZoaJbTXE5H8LVj5sMD9t4WcJRLYvIFdV1wpPAE+pCYhMIih16XL7hDPM8b2PhHbC0no8kX2vLNc+H2xLlIIrblA6W04q48rZppzVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0hqp2vBWzJ46dV;
	Tue, 27 Jan 2026 18:44:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E6344056A;
	Tue, 27 Jan 2026 18:45:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 10:45:22 +0000
Date: Tue, 27 Jan 2026 10:45:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <bhelgaas@google.com>, <kbusch@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <terry.bowman@amd.com>, <tianruidong@linux.alibaba.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
Message-ID: <20260127104520.0000579c@huawei.com>
In-Reply-To: <20260124074557.73961-6-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
	<20260124074557.73961-6-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 24 Jan 2026 15:45:57 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Currently, pcie_clear_device_status() clears the entire PCIe Device
> Status register (PCI_EXP_DEVSTA), which includes both error status bits
> and other status bits such as AUX Power Detected (AUXPD) and
> Transactions Pending (TRPND).
> 
> Clearing non-error status bits can interfere with other drivers or
> subsystems that may rely on these bits. To fix it, only clear the error
> bits (0xf) while preserving other status bits.
> 
> Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Similar to previous. Drag to start of series to make backports easier if
we think this is a fix that affects real cases.  For stuff that's defined
in the PCI 6.2 spec, AUX power and Transactions Pending are RO, but
the interesting one is Emergency Power Reduction Detected which is RW1C
and hence reason this fix is potentially needed  + future features using
remaining bits.

I'd be more explicit in the commit message for that.  Talk about it not
mattering for AUXPD or TRPND because they are RO, vs the ones we
aren't using yet in Linux with the emergency power reduction detected
as an example that clearly shows we need to mask this!

J


> ---
>  drivers/pci/pci.c             | 2 +-
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..0b947f90c333 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	u16 sta;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>  }
>  #endif
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3add74ae2594..f4b68203bc4e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -534,6 +534,7 @@
>  #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>  #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */
>  #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
>  #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
>  #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */

