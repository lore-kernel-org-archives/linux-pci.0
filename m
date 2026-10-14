Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AB37C90B;
	Wed, 14 Oct 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001279; cv=none; b=nbuaUGpenui8bbHfx7CJ8cMIE3/kf68Lg56OnrSPIvITShZZPSyec6I1FHopc4dUpDClzKP97qz4d8sQCCVdH+V9YoYsCCh5C/Cs6c2aIE085d9stNp4Cor52MFQTMNSOR3Vdyc5bfY/wpWsyHsl1ZPLuiX860oYMA5v7bLkaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001279; c=relaxed/simple;
	bh=y+Nd+kuMcNDghQJ+k5iJOCUpJlukDHtSE4PiH33+90U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGDvNoB3j8Oxe/L3+fAV8bVgBjcxLmxn0gDREo79xRryXtV3hOwmDfeF65fMs77MS5J14MkEVbrpnzr5Kc19Win5imfhcOkXN83M4NrMjTn1w3Ozc6PWQxS4PzM38UWjQdv8gOIqa+KtdI0r1LtizenEJCI5Wb0rxAIpE9kMNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=G3P/Joh8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="G3P/Joh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1792001275;
	bh=DBsylmieXlH7jN4lQzs3+azlJUaS53ZlHvjnKa/pZyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G3P/Joh8VxsWKZD77wjVjEsdrEuCe0iMj5OoD+01Tc4snAwR0d0ut2CGkYADYIVWO
	 lVd3paktWgKEkNFfCS04XvlDnw9WXH6ROInP1ff43Unn3dN2s6jGQLj3Y8/CLt/Msk
	 6hbpzuGQ5lvJQW2Lii1rTzFnibHWD3vW3pHbmjhhaxQFlyt/ui4tRbNU/JPW0mXamJ
	 lotdYno1jCLuv2jbaY0cSWgxE5d39w0RS+qczN9qArNLXkR96A0igpzLbjtkHtXGdK
	 pMyiWuQTz9WB/VYpj62fiSVbURyvFTF85lIr7NbPrDnfh1kg8rzS1tKDwltF6piA5I
	 AN+3ZbullBfyA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j4fLr3nYgz4wDf;
	Thu, 15 Oct 2026 05:07:48 +1100 (AEDT)
Message-ID: <2d454220-61e1-48e2-8515-112393ffb3ad@ozlabs.org>
Date: Wed, 14 Oct 2026 19:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-8-matt@ozlabs.org>
 <20261013171352.1c467040@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20261013171352.1c467040@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2026 00:13, Alex Williamson wrote:
> On Tue,  6 Oct 2026 20:36:35 +0100
> Matt Evans <matt@ozlabs.org> wrote:
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index cb0e4865d110..986852b1d44f 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1337,13 +1338,18 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>>   	 * have NoSoftRst-, the reset function can cause the PCI config space
>>   	 * reset without restoring the original state (saved locally in
>>   	 * 'vdev->pm_save').
>> +	 *
>> +	 * The zap is done after making the device accessible in D0,
>> +	 * because a DMABUF importer could access the device as part
>> +	 * of its revocation cleanup.
> 
> Nit, s/zap/revoke/

Doh, done.  Also cleaning up a "zap/revoke" in the 
vfio_pci_dev_set_hot_reset chunk.

Thanks


Matt


> 
> Thanks,
> Alex
> 
>>   	 */
>>   	vfio_pci_set_power_state(vdev, PCI_D0);
>>   
>> -	vfio_pci_dma_buf_move(vdev, true);
>> +	vfio_pci_revoke_bars(vdev);
>> +
>>   	ret = pci_try_reset_function(vdev->pdev);
>>   	if (__vfio_pci_memory_enabled(vdev))
>> -		vfio_pci_dma_buf_move(vdev, false);
>> +		vfio_pci_unrevoke_bars(vdev);
>>   	up_write(&vdev->memory_lock);
>>   
>>   	return ret;
> 

