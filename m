Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1C38B7D4;
	Tue, 22 Sep 2026 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043354; cv=none; b=kNJ9hxwCOVN5q7/hMVPLLiq+BnPjANEVTYcTjD0ZpawPUjSTeOrP34Fn6TAQPSQ1hfxUUXgfhA/INDcMj9S+vX7Mv3Ox8rxecxEzWsA9wQLXDMTuKPleYwzYSS9hksGHdUMjYpfOLmNq77H8u2OdpoRSzmVZyQkRe28FMYoBpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043354; c=relaxed/simple;
	bh=xZtAZWkxrPhP4R+vbODxymesry5oITw3ExgATBHrf7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTP7nbwLS73pmVzs7HcZzeQJ/u6/d7s5xOtdkWYOGveKGclOs2/4EMFKIB8n1i2Ha+CfPV1L9dvwNpVUKkV8ievEAmi3Cn+1jJvoN8yXjR0BS9OwLRTWrx+uMcDhL9xYuYu0PUTp4zbRqA47BqyZF6aCf0JPs/67s06I2C8v9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=M78zqSLp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hM7JB+n2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="M78zqSLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hM7JB+n2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 779C87A0040;
	Mon, 21 Sep 2026 22:15:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Sep 2026 22:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043350;
	 x=1790129750; bh=upvvBuxVwXRX90tyuZmxGms0qXnjEY0+L0/TUuWGmDk=; b=
	M78zqSLpb3sJ1fHc5zOHCfxqJpYXeTpvy6Gj79/YY3xOmFHtYf/n8ZMvcrsNWeFu
	TAU04Qlf80Xy2YcJQrPz1nOSqrmXUH+F2YCbCTQ9BJ29KqucOFPH0+HOgG6fZ9aR
	QUQYDdhNvF0OCxjEMGvr2TDNdHTTfOq/PG6EAJj4xzejJpZwvEk3eXyVEQhzTgI/
	UflJl2KJYDCVwGOF09LmCVKmAcwcv9N4nD6UPFadcsEW8J3U0ok1CSMfwkZm/020
	34nHW59Rqr9Hc9WfWqbtO+L5OE5faMMpqNrkgwcjAyRqqmNOsOsYQ3C+wnPEg1KR
	jUaZsw8UcGr6L0oqOGMLfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043350; x=
	1790129750; bh=upvvBuxVwXRX90tyuZmxGms0qXnjEY0+L0/TUuWGmDk=; b=h
	M7JB+n28BNcwbDO+6+kEA9IJMEHT+P8wt+iDXMvPoMaxDAhpkLnJCU8z5rA4vel1
	UCrqv7n12gckkMf+TMNu6s6PDh8Qyd0Ct3g33FiZLsm/aGf64+/skwoBCfZU7WwM
	t72q1d7IFqYijt48uDjIXbONMFEkv7GzA8R/s04QRURem6DfEO1NT1EgW+/wfn7z
	FEu5kPmrf+QK2n/931fUj72RLVlk2eNDRK9xN+f0egXAF0SZcKF2GhFt9jyHzHXb
	t+kxSq+kHRQJsVrGKH8FlktbbBfCZjgQKnkhzM/ixJ2E+QbnhBdb5rTqKIE/P7zz
	tvDiEPBpV8Qom0Q4X+nJw==
X-ME-Sender: <xms:1uSxajWKP6xu8f7BTTG9nv3Lviprs8ZyGFXqAbMNSjhajo2qYlPnRg>
    <xme:1uSxapMxtRkZKkvQ8afs8xEMTJquyaOs6-F0NhpFtAkGY_O3r0Y2HemGL2w45tjHZ
    dfO8wpwf5eUNmGwT1NgTUzo1Xt7I5N9Rp1NPSCe273yWeOx7KWKWWI>
X-ME-Received: <xmr:1uSxamy_bLnpvaZAj2zgL-TbUiWtnlwAsCelK2yBIIHJtmwtV7XA-MpqdvekYA>
X-ME-Proxy-Cause: dmFkZTGoxwBj3gMs8aP3OtSmH8fpa7GIvf4hOnqoko3B7f8pxqS5H7LxH77IXdR6d3WuI+
    Z9z3CfoUQKhUFniD7Rf7fiqvJvZaxwi23b3LKCM1FYo0YHUqTk8Ph54TXb76GBBy5fGyB3
    oqC5JJGe5LoDDFzfoji7WB0jMmg4fksDOtYNR4RWwGVFKCKNqGSM8QOjrKGULyw+HiamTo
    t8iuP5PRmNKtxUV0UzEwx799GdCwOuUjbS84g95p799m8GpkwTsVGsDH/1sUaqdQLLvc9D
    Z2z27IHWdZ/KXQJuUCkXpOXRK1wImm+otqigYdSypL/jkRx+L2NChAfP8UHBNbtB8aiQk6
    UwN6r0PTg3bI19MSRu6pRBbgjjW99RlCH6ZHL3p9c0RTAWnXBfoA3ABDIqDDEf0g+hxi2i
    VWMRAKp2b6Xq2xMdwaP5mfMKuOvWv2q69bRhqCJBJczFQqWfrs2Avb0j1AigJmrY9shbzb
    EH8/CuofhCGVlu9iXVGICfPw+gV/YJaWjZEXsNhUmdnd08hclyxOamiY57gvF/BU/0iYuX
    L6Wx34w7J3igwQlEh1fFIjcU35pf1dchRa4XK8yc7Yd/lieAso6/oeZiMCw1MYfCre8ZEL
    M4q7AgP+bHJvmlUB7p+hauGN3Cyj/8udArNCfU8Of/qeEEBu1kHvsuuZP6yQ
X-ME-Proxy: <xmx:1uSxamhVAJnmYI99DzoUY2DTnxzb28QX4RfjeV9Tpwepz5if6xFzIw>
    <xmx:1uSxalSFp2cWpHHInZ3WyQUABGxkxGIltcu9XdqK2N5Go3JNz2c0xA>
    <xmx:1uSxarO9HEmr_L4XrqySu5DPNcymXLyuVU4ZzlDyH0Jcnk3FmcyAfA>
    <xmx:1uSxaiHijRnV0ulxNs3Qz2CWIBEq-WmRyOwPzWnd5wPL0LxzJMEiJA>
    <xmx:1uSxalc-1wQsU7A5uU_8GO1p2czIGplnw3ade_LDeIqcsz3WEWBiXWrF>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:15:42 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:15:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 08/27] vfio/pci: Fall back to plain vfio-pci when CXL
 init fails
Message-ID: <20260921201502.0ed59b5a@shazbot.org>
In-Reply-To: <20260916183540.3813685-9-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-9-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:21 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device is also a valid plain vfio-pci device. If the
> vfio-cxl provider cannot bring it up as Type-2, failing the bind would
> regress a device that previously worked as plain vfio-pci.
> 
> Make a non-deferred CXL init failure non-fatal: log it, drop the provider
> reference, leave cxl_ops NULL, and continue driving the device as plain
> vfio-pci. The -EPROBE_DEFER path added earlier still retries rather than
> falling back.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a63a4f5228b8..9a75c30b67e2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2271,9 +2271,17 @@ static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
>  		vfio_pci_put_cxl_ops(ops);
>  		return ret;
>  	}
> +	/*
> +	 * Any other failure is non-fatal: a CXL device that cannot be brought
> +	 * up as Type-2 still works as plain vfio-pci, so log and continue
> +	 * rather than failing the bind.
> +	 */
>  	if (ret) {
> +		pci_warn(vdev->pdev,
> +			 "CXL init failed (%d), continuing as plain vfio-pci\n",
> +			 ret);
>  		vfio_pci_put_cxl_ops(ops);
> -		return ret;
> +		return 0;
>  	}
>  
>  	vdev->cxl_ops = ops;

Why isn't this the initial implementation in patch 6?  I don't fully
understand why patches 7 and 8 are circling back to modify the broken
behavior established in patch 6 rather than resolving it in the patch
where it was introduced.

Perhaps rephrasing the message, "... continuing without CXL
support".  "plain vfio-pci" doesn't mean anything to a user that
only knows to use vfio-pci.  Thanks,

Alex
