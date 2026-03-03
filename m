Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352C3ED5D9;
	Tue,  3 Mar 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549654; cv=none; b=W+mIAxj6hEHcQY9qOPA9FY7TQaLdpvQXu7dwWZnxUk3yurQAy4FV0TFqllKqfAO1MePAVrbMosPbcH7T4KbI2OC8mOTtfjHXZ1Fgw7+p2JOV7PLZS6ojR8EnY2p+aJExl1kNFJP71GlDiRIAzwoesYwNsD36xVsTN165hDaXRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549654; c=relaxed/simple;
	bh=Yq2XoRbqA1C2IbTVqNoUPl+6V3ueLgtKsUrWM/J39Zs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHAVlJDPiVN3xY8JkpmWNVh96Ha2wRzsddGraSSQGo8dRnXPwVDAvo1pbcwhZTh8CZVOTIflAF4I0+ELGhTE5rXlIrpVjFTl+3kigz/RBvvnVM0CG6EyEUjPwuFuNi3CDPl+0fjugl4f23By713RWBDjvdMbWEgp9LYdITJ2E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQJhf4M4GzJ46XJ;
	Tue,  3 Mar 2026 22:53:38 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CCE084056B;
	Tue,  3 Mar 2026 22:54:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 14:54:10 +0000
Date: Tue, 3 Mar 2026 14:54:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 21/27] crypto: ecdsa: Load early in boot
Message-ID: <20260303145409.000033c7@huawei.com>
In-Reply-To: <20260211032935.2705841-22-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-22-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:28 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Work is ongoing to support PCIe device attestation and authentication.
> As part of this probing a PCIe device will require signing via
> the SPDM protocol to the kernel.
> 
> Linux should verify the device before enabling the device, which means we
> need the crypto functions to be ready before arch initilisation (where PCIe
> init happens). Move the crypto init to postcore to
> ensure it's loaded before PCIe devices.
> 
> This allows us to verify the certificate chain provided by a PCIe device
> via SPDM before we enable it.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Whilst others may disagree, I think it still makes sense to check
signatures against the provided public leaf cert even if we aren't
checking the cert chain in kernel.  That will need this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  crypto/ecdsa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index ce8e4364842f..b225911c5266 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -334,7 +334,7 @@ static void __exit ecdsa_exit(void)
>  	crypto_unregister_sig(&ecdsa_nist_p521);
>  }
>  
> -module_init(ecdsa_init);
> +postcore_initcall(ecdsa_init);
>  module_exit(ecdsa_exit);
>  
>  MODULE_LICENSE("GPL");

