Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183542D9EC2;
	Mon,  2 Mar 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468290; cv=none; b=eqZgcMOmr/tLLhgMfwx+8FSPIkOMtRBDPKZrqhsm3kFuGWCNICgWbkOKZilmoeQ07buh8I4QZ7TqZE04nJb5IL7VRBrZ62QdMNbo8dIFoCGpPprOS5w0CJzzP1idWHcaJv0bOpEj7X8ik/RLBPDu5V7+kGTIbC17KMopkaQS/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468290; c=relaxed/simple;
	bh=UDPdOuLkxHDttnINoMsAtS36QWhXO4/oWTlJGpDie7w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3Edf4Qw1v0syA3OZ2gPUsi7iigTN88kYIFeNr2uE0jDtqplYUl0IkYoFrZ96A6VMCCXlo4i4LF1hmqPq1qaQJ2K6aGGXsw5D0291mLc1cZbvsnS9AlA8Qyo6EstVFNaqh+HpqaSZpaqomSuOviSTOLDofm99eqIM0pNHwzEiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPkbY3gdWzHnGfG;
	Tue,  3 Mar 2026 00:17:13 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B3FD40573;
	Tue,  3 Mar 2026 00:18:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 16:18:04 +0000
Date: Mon, 2 Mar 2026 16:18:03 +0000
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
Subject: Re: [RFC v3 06/27] rust: add bindings for hash.h
Message-ID: <20260302161803.00001b14@huawei.com>
In-Reply-To: <20260211032935.2705841-7-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-7-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:13 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
> and crypto_free_shash() available to Rust.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  rust/bindings/bindings_helper.h |  2 ++
>  rust/helpers/hash.c             | 18 ++++++++++++++++++
>  rust/helpers/helpers.c          |  1 +
>  3 files changed, 21 insertions(+)
>  create mode 100644 rust/helpers/hash.c
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index a067038b4b42..0075c4b62c29 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -34,6 +34,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
> +#include <crypto/hash.h>

I'm not sure on ordering conventions but this feels odd..
Maybe before the drm inclues?

>  #include <kunit/test.h>
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bitmap.h>
> @@ -60,6 +61,7 @@

