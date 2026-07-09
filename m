Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78B41166C;
	Thu,  9 Jul 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614422; cv=none; b=bEraJZxo8jVBWKmpd1BBEYnrN2o1RTSssHA8h+XujJnuQa1fbH7rP61UPu6DTO4tytb3UaRDMoD8S/PKSJJUnk9DYqN1r1AZaQKIr0wDFWtq8kOymey45GyzPJCbRM0maqwcrR83PWp2Z75tJ0TwDBcf+FGQ7+ulzErdiFPk/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614422; c=relaxed/simple;
	bh=0tqmk8Tpz1xLWrkV/i4FASNfmGaEw9KxoFnNvgzOptA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=pm3eSNlRa/sdLxJZXvhopnsUb4OifjJSWHwZb4lZ/JILmLZUmktx2tZhW3tbOl+wsF4XI9uaAtKRSPAADHR2QkMQLx5PK0Z7Xv1CutuWcjxSN4fwO1Ca8AE/6My0QergocGq8bNho7ZkmJyh08vR/prNMauBf+qadOf3mU6E1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Nh8jbmKX; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Nh8jbmKX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=cy1QN1NzhHYQz51ULp2Gqf50+XQ1ns+77hhEPNga8rY=; b=Nh8jbmKX6frPNXdTwrWeSUk2K/
	wwAvA+IcRPsu33aWOOpLuL0vijI5DgOV90JCS0vpLno0kjWUzlQOKyS4YwO6k8R8nO7RDwrSMV+dL
	eUNoj0A1PKV5vNYV3esTbqfTeiVKHGkk7+XHxoh+bcruLUDYUxzX5Wd7yRHZ1xiCoknTcW04nSocm
	TcKxahaxu8DLA8ypbE2ArShDLuHPM0Wr6ec/033XdX1AaSEAa6bEKV6ZfKT1F5zkrnnd4htX8lYM5
	87Ax4T2lzLv1AEZrAaLw51M1m/4UwdZNo1vEMAQmEbhUh++xiDpV7Q6oEbp3ERRx1sczH4nnFpYrt
	QnN4V9Dw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1whraJ-00000002TP7-04hO;
	Thu, 09 Jul 2026 10:26:47 -0600
Message-ID: <9b664c05-8e85-4ccb-afc4-91ba807438b7@deltatee.com>
Date: Thu, 9 Jul 2026 10:25:45 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
 <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
 <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
 <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
 <e0ccdfd7-2379-44ae-b579-a0da045d7f1b@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <e0ccdfd7-2379-44ae-b579-a0da045d7f1b@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: matt@ozlabs.org, alex@shazbot.org, leon@kernel.org, jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com, kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org, ankita@nvidia.com, apopple@nvidia.com, vivek.kasireddy@intel.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-09 10:17 a.m., Matt Evans wrote:
> I'm intending to repost _retaining_ the 64BIT dependency (i.e. revert
> its removal) for simplicity's sake.  Then we can follow up separatey
> (outside this series) with a cleanup patch to remove 64BIT, explain,
> examine other dependencies etc. as you suggest.  Works for you?

Yup, that's fine by me. Thanks!

Logan
