Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84241DEDE;
	Thu, 30 Jul 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422847; cv=none; b=dcS6jizhai5sPG+kTcgW0gnsxRx8QwSpd9WyEsQ0M+TsyY12hWm14xEZbezp316IHmmafKePCRvJTHUkJ7AjrDb4oATtJ7dsNYcpfHksJL5aIxqA9vJYXycYL9Aaamx8MsWaIObHFYKbX42LNaIbkna1twrjKGp1L9dLG1nMFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422847; c=relaxed/simple;
	bh=SE7lcAvVCvL/HcQZIhyYm6vgXGHGXrK+eE8HQ1iqwlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq202INHLP3oJdIxKjuSPdEKXpX5MQ/IstkOVqDLmgGZr9S1yjQKKY1lMJXhBqKT195QJTupuyIpi+3kSg9PXYa6sm5+c3OmR0hBtjlgRZTh4Cxy6EAbFvXaV82D1ALTcrnL/OFCC8nH5pfDOj52e8yRd7GmbPpJC0QUa1KKV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=c6mLmqmV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="c6mLmqmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785422842;
	bh=up5uBX9JP5C7GHIB1MRUeBHI/rYXor2ncjNZjOZCc9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c6mLmqmV0L0tBY+JmyBs0GJBidz+yLfItDTyFvOvLNQN0YXySfK9ICb7Zlw3jV4So
	 /0R2zmUQaQ9UJemKA/9fEeHDW09EiwvgBJPxkne1AkLIMYPWIeEX8ebHXZNSqMVukh
	 NtP9lkLDAELpc+ceknNyz3YhWlaqFGi4ktBV+vcXQO6BZb/zdwRi1YlJHSG6sDikO2
	 aoGne0yDq2eAWMoOku8Z54ZU9UArL+7RnuUWMv++AEz4ZejWk+XmqsMDBzWZ7doo+3
	 4+T2lmnP8gIz3TuoqlDeruw7/b6hXwZmQgivLA2cTm2wt2tXDWU/ehGQAont/UjdRa
	 CMBD0fHXQUJLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h9sVW2Pm2z4wMG;
	Fri, 31 Jul 2026 00:47:15 +1000 (AEST)
Message-ID: <6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
Date: Thu, 30 Jul 2026 15:47:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
 <20260729115204.2a9a50b2@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260729115204.2a9a50b2@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 29/07/2026 18:52, Alex Williamson wrote:
> On Wed, 15 Jul 2026 18:47:30 +0100
> Matt Evans <matt@ozlabs.org> wrote:
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 9a1674c152aa..e2b4252e7c3f 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -134,6 +134,7 @@ struct vfio_pci_core_device {
>>  	bool			pm_intx_masked;
>>  	bool			pm_runtime_engaged;
>>  	bool			sriov_active;
>> +	bool			zap_bars_on_revoke;
>>  	struct pci_saved_state	*pci_saved_state;
>>  	struct pci_saved_state	*pm_save;
>>  	int			ioeventfds_nr;
> 
> This should be in the bitfield usage group since it's only modified at
> init time.

This was intentional, but happy to change it if you're certain ofc.  Is
it inconceivable that a sub-driver could set it after init?  I'd say
they _shouldn't_, but only review will stop them and this placement
intended to be cautious.  It seemed a low cost way to avoid issues
around synchronisation on the bitfield.

Thanks,


Matt
