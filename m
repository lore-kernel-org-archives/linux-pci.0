Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EF37F8DA;
	Wed, 29 Jul 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347562; cv=none; b=EtDRDigsmKQvO7Y4Z85Eo/OmmLEx8HkiIZZKrqgG3QMGEEo3sQloDyfFgEEuiJb9LSlzXdZyNDwBKO/x+A2Hde1eDyLrchQaT2MI3Ixcx/KfoTo7SykGzn3l1wXPiketSNlOmmBushhcvqx8z9LEoFxjMqcWt7Nvxty6U0K44vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347562; c=relaxed/simple;
	bh=e3MKdxo+n4j6m2NfIUHP5tXzjQ/YUAlIZwv4KZmDz+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOk7BqpjlnsJID67Kvo3IQKB4P7wckhxQOoFQzhbXCTYhqWQE57sAN7GOHDMCkfwWKhrSn1rSUiwTe3/8EQU0oRSYDIpdMVRVSTnJRvojR6ZsKvVM023A0haTFeUsS9abRWE8JWl6uoDiTXtmdhslqSdAUvaUJkVxOhTDQF8tDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YMXaaqaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYA1SkGa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YMXaaqaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYA1SkGa"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E1EF7A0101;
	Wed, 29 Jul 2026 13:52:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jul 2026 13:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785347558;
	 x=1785433958; bh=D5KLqWCTQA2QDpEdxZuXTTNt/FdG3ghMWYTA5+524n8=; b=
	YMXaaqaS0aQ/zPMUBhOq/ctrW26MTILBE8iUncYt56mdqlvSr4VMhlHiVyBZPzMD
	/xEKORv2KHTpCQqG/y+lsmqnWgfHP/NF1wCulpRUUdGtjT2DHLr5HBSg222j0H0A
	eFdfzylf4SQqBfRb/OYyit+zSfV4vRQWa262ygp87kw4Yg5Qo0v3pHt5EWI71TWq
	2IiJ2nJDWvfGUroACOiMmKuz7WWmqCygttVz6YifZQUS1YWzA/VqGmDPZtxu52NT
	7tNoJcKNxU9yMcW9NNfEE408f3JOGnpTYD1oAlfqMUIpSMOuO8ixdyc780r+VWBj
	YjbjkLJnbMqHS4Uce1YhKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785347558; x=
	1785433958; bh=D5KLqWCTQA2QDpEdxZuXTTNt/FdG3ghMWYTA5+524n8=; b=G
	YA1SkGaZCWjAwMlhAdsQdznHaJNSzaGJY+m0HRWFcSsaMjegcVNJ38TFmZ+/gRfi
	TeZ5RJmdKgFjeD5pNOQ8nraNoiu6s6CxC5BB9Xo+282ZPuVGk+rLDOQHTmNSJqIi
	2y66oG4bgN0Di5Ezv0re5PJLUsEWOOiOfhS4YWPDIDkAQdKXglOSbtNkzCVeMJZU
	l2hnOB+54fjwe4c5Av99e0duKYF0gLwzZPsFLkCzgeVLwa50IIJi9i/1WgjosZOU
	SWHsHxCIFnsUh1InFz56JdoswZ7eqibVS/ZW/ot4EJbh9pnwD00XeXGVnhzj5QJS
	bMt7O5SwTxGlB5wQby8ow==
X-ME-Sender: <xms:5D1qagWYaIIbptzkbmpvs6Y2TiDJqhOcHtPKfwD7BIWvmSe6BDEc6A>
    <xme:5D1qagBKAvkTTrvIhx1mV4Qqhg07O_6eq_9I8YapsFUoARP44LL1f3WLMdQtRkALi
    QubY9Th8VPxkr9FPdPtI9BPmDcCq381g1tj4FFMi_5stS5NAY0sGg>
X-ME-Received: <xmr:5D1qajGoZpya9SQvSSSq2aRIy8lJz3IWwP1920feVBXoNdSiGBJelCXG7kULkw>
X-ME-Proxy-Cause: dmFkZTGl05Q9wRGUWHkduWO3wZl/xrZz4kajZ8zaPjiF9sDpbasCsIvWKG0Kx7MA/yQKDI
    yypxVnOugzA8KvSYDGOF5LXICBeDbAIJ4cWd5Z/vJ0+46K3Ll9oGFrVkBIGhuqTNs8pUei
    eaPGTwi+QY0Q+EYeFhNnXAy/iYAqBfyzTdKhFVZmoaYWH1pLSjKpELRhjRki+hhUPVnXpT
    lWR7CJgsRUir1V3meZuOeSXzV/MghUC0Sqt/s4HkpQCtmYiWr5caV//gMexYRpgKuv7DKv
    Ec9zyKUlMm41GeT/Rmb9aSsA9bh7vDpWwxM8v5VFi+UwyrITdyzWTvJcPLhn85QmG2QEO7
    gpoEhIgmn5R2uhB2eukSpphuksTHZvkADJfJqnb9HmWLyfy7j8FFhT14d72vNTAGWadVme
    Mj9UPDnESUm9IKK8R9JvOIZ/mnK8amdk8E8UsM/pFtnOBl2LQSN5wLzLrBe1i1OI1H0RgG
    TrEtjCaUBGJrecfNb03S4uWUhl++Zdl7tU1p9TXXzPc+KYW0boggANFgmvPNj9+2I5vpD4
    Fv2dD0lZ22pjAPuFar4laEfG6SZLJCKFZI3oqdmQn0N724QI/RVKPy24wvpDOB+2N/sknH
    7w8YAlByGWU/44zrNmYotNTWXQh4y5yQ8xgvyGpVlKZwJdwn5ymgfXg6dAJQ
X-ME-Proxy: <xmx:5D1qasfRn7aCRyKJJAz2PIokAJ5nCuBnSdmv0ND5zghRLsRT9A6LeA>
    <xmx:5T1qag9oQ3Y9LDNx_lBPbN4uImhmdY0Izuqjfdzp6x_VvNsXX8IJgQ>
    <xmx:5T1qaqZjYW2MjbImQjKqqkejcpoU2mOMCrNT3SBeRdinVI_Evl6FDg>
    <xmx:5T1qapdCBeApI_xwR6xzCAqJKOMNVQGbnDTfOqAWiLR9TXTueSCRFw>
    <xmx:5j1qajG_TpQxnxWKc8ezzVQiRV90W1SPZ57tG3676nimiT5N6WSnAWT7>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:52:35 -0400 (EDT)
Date: Wed, 29 Jul 2026 11:52:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <20260729115204.2a9a50b2@shazbot.org>
In-Reply-To: <20260715174737.15287-8-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-8-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 18:47:30 +0100
Matt Evans <matt@ozlabs.org> wrote:
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 9a1674c152aa..e2b4252e7c3f 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -134,6 +134,7 @@ struct vfio_pci_core_device {
>  	bool			pm_intx_masked;
>  	bool			pm_runtime_engaged;
>  	bool			sriov_active;
> +	bool			zap_bars_on_revoke;
>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;

This should be in the bitfield usage group since it's only modified at
init time.  Thanks,

Alex
