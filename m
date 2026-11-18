Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017533;
	b=eDVfW2umo7O+3SriltnTicalHcAAsAEsncq2b3hFt+RJaSbxvxYi93yzg1gba0PjPbxM
	 +VU3xf6cTSeJUtbO2+Azl0y6aTOOfqwtdH81jXaNYsa4bjmCcBYcshuS3mOx4ktS2ms3T
	 Lx84V8nvoRj65/89ZLt9u2HcYF3hyxUMqK5g0JWae8ZIv+/4f1E1LlNa/i2Y90F05E/LM
	 xq28DlHfPBtgrn+HID6DryWU4fTPGeo3GM4xiPiM9hso/ImetKBJTp51Retn8xw379me7
	 99aCIrWEEBrcgQdsJuhq3XkAMdqF6pBF+jWamvf0auEmkZFYDuODXuF9g8e1Ysg6VXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017533;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dwzetc3j/OKIIwzTfVq/W4HU0JhcRbHvF48gZBE66Qc=;
	b=Gzxqxgdne4qMvJuBh7uJ+4IH0pq6A/DwReMNXGxtyP6yXXpc/yguPBUMQATfegO/IW0y
	 T5yjWE6DM9Ax+NCCK1zwFwkidVWjV1vpdOClUfz9Dg/QaazOXhpeJLqPc51UC6Iu2CHNJ
	 nw50kL+jRXSOWug81t6rK8lAe6esSIepP7EpnTdC9kZCSUkT1cyhVNDYNuom9RFt7L0UL
	 f9xcFSFzvNYnX9CCYVE+fQt+q47nZJcTJMdq/HSgmwqxcRI9p9P5xSGeAolStL4VCxOSc
	 EqLQ8rJRihWhLnnZV+gNGbX6MWIUsyoqHPqH4YbsHtEX2KN/hLNta4SlKQuZ4inXZsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/d61Oyz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E3606A32F;
	Wed, 18 Nov 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/d61Oyz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB7B1F000C4;
	Wed, 18 Nov 2026 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017533;
	bh=dwzetc3j/OKIIwzTfVq/W4HU0JhcRbHvF48gZBE66Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=B/d61OyzIAeKGN2O7kaqDOAwzdxsVM5sr6TX4msvg9T15Ck6Hy4jUVP35oPJ9s6uS
	 jAgZJ+Shouds82pUiTpE7WKZnURKsvZGxU1Yk7DXC3XZ3eTpXCxMDkNiGcbCjkU3ch
	 /ZP9RYGw52gBh56wVqHSAtK8LmlyvvSdJSqjxYaQpLRU5sI6bWDkSrVPzV3hnNNCaL
	 IBp9BKZObv5euTPrixF+Bn/tXTAF6E79ygt7bkbrm6F6fQXrvTIPi8qsU6kYrmQG0w
	 Mc1mRKigU1yjuf/zT8Ucu7LOQntms6hOk1ndxMWIocPBNgs/TaUDhr6C2SCqLeYjcm
	 wvt4xIHjUEnGQ==
Date: Wed, 18 Nov 2026 09:58:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Donghui Zhao <zhaodonghui@eswincomputing.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	zhengyu@eswincomputing.com
Subject: Re: [PATCH] MAINTAINERS: update PCIE DRIVER FOR ESWIN maintainer
Message-ID: <20261118155852.GA580285@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118092603.1331-1-zhaodonghui@eswincomputing.com>

On Wed, Nov 18, 2026 at 05:26:03PM +0800, Donghui Zhao wrote:
> Senchuan Zhang has left ESWIN Computing, so replace him with Donghui
> Zhao as the maintainer of the ESWIN PCIe controller driver.
> 
> Signed-off-by: Donghui Zhao <zhaodonghui@eswincomputing.com>

Applied to pci/for-linus for v7.4, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d738990161bd..879a51fe36b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21767,7 +21767,7 @@ S:	Odd Fixes
>  F:	drivers/pci/controller/pci-thunder-*
>  
>  PCIE DRIVER FOR ESWIN
> -M:	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> +M:	Donghui Zhao <zhaodonghui@eswincomputing.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/eswin,pcie.yaml
> -- 
> 2.34.1
> 
