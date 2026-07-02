Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06433E36A;
	Thu,  2 Jul 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007977; cv=none; b=p5X3/ZTtSou8KJ37R3dNMPtaZkCV06fFP6MiQoO+66Lnq3Z7JUPjqj/qoK9tWPoNP7BLv6jaUMxCPqzJeGLiE/pHWXTpcFGVCHzsf/KpWZK1HQDhQTV2iqv/KymUAKoW0QClhXFw97FnWDYuK+pykdueyEiBL9LvxmPWqEGTh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007977; c=relaxed/simple;
	bh=owhvQVuJSMgo0cOWgI78J4TVOua7Gdx/oiTUQxVqhQU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=pBMdblvnk7aLOrlY4uzgqnPYiKZhpyH1np+Ez45ejQx8c7+TggYjL89qTArueEvi7bENjDkSZDAtDKMWvHe6/ujPeC+DpycaL3DYbYpfazVjjvnWjkShq6L+n3u2uzG+3GktPDkXFJfr8wGQWdg35v6U++2l/Ssz6OhdMMrB/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=DujUo9We; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="DujUo9We"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=/hjDwdAgOedsNd0NqOzOzJU5th0d9lvFyladwqf85no=; b=DujUo9WeBTeCmnsWoBB6b3CIYG
	P1Voct4LheNy1r1Z7lUYuY3xX+tBK0dfVj0pqqNmA2fQAR4avVJHBksfW0RRBQ9gRkKw/BiH7Ck2M
	jq/5XDDbWPX6Zj7e1StnRXs00D8Vr28HU3QbnX9f3Lqlutan1f4Cz/rIZ6ymnjx4DJmnbq2KeJ6vc
	wPtCmHSPpLcNXNGOzyZv+eJvZQZfo/6edPzq/qZ+JbfrZmH6HPwq5GYl/cUxOLotYJrJYSKCfKDfL
	t2TFa3x449m2pRH6ZFRFeneSImtheUPu9MLEMYeuE4CjMYotwf7tqzvGAfImiytBhtnckzeb7gdY4
	UAkXiFQA==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wfJ7q-00000006y6u-3ltf;
	Thu, 02 Jul 2026 09:14:51 -0600
Message-ID: <1b2cc341-5be4-4b24-940e-284c950fb730@deltatee.com>
Date: Thu, 2 Jul 2026 09:13:26 -0600
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
 <20260701171245.90111-2-matt@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260701171245.90111-2-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: matt@ozlabs.org, alex@shazbot.org, leon@kernel.org, jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com, kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org, ankita@nvidia.com, apopple@nvidia.com, vivek.kasireddy@intel.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 01/10] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-01 11:12 a.m., Matt Evans wrote:
> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
> 
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Looks correct to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
