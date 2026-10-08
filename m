Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B43BE172
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457715; cv=pass; b=OlkryXndVIfQnGXcn5r+kco3fUUOSrGpJGNf1YtLIUVAzGtUNR8Gn/udi/MERwPkpFQBTOKLL5nLpdYwd5hracCl9EeR8LwrHGfXCVIRzQacC5W0nARpprfNeV/aLc0iN1nI1rbsUV30osZn6gru9EjM/aX6DLVHNbAPR0kb0HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457715; c=relaxed/simple;
	bh=tS8GOr7rQWkYMwitY30VlxqC6IwwevxTL76E8/wWKyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhtuU6+X8dPUl+MQP/chyRIlVNNp5MW3oKFMbVfSqeBN++UqRJDmLuu8Rs/9TnsKFtIaEOLxUesPbX6dELeOlZVZToDdxD28KtJzqHxj/WSv+vw3cour9kW9lx3d0ua/dAtsnzHLVJ/Hk/G8fpVi4zhFB08LqxjI5pKryC/bR28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK0aaaSS; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK0aaaSS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a49623b865so3174959a91.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 04:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791457713; cv=none;
        d=google.com; s=arc-20260327;
        b=PVuAU2a7rAW1diYps9kWYxBFyI6BlXsCdneILQ+PK/lee611ZN3XYxls1z8XABYIO8
         K8F7DQud86rlYkcQDmkhqsQNaWJ00AH8WiXBfxgp1oKaFg6MqdWgQl9TM1q9VlgZBA/s
         HoYS2ek1VsILvFRbG7s6Ujumv8gpzSZzT9fN02A8nmoAghhIy4735O/lwBxwlw8DLKMV
         caVUlIuF7UH3Sx0xL03MkIoChNuWFf8AAlSu8TQyl+1tT1DsThG5J1tMfAGeBayCvukH
         GU+i3iPmTz5pauXg6XfjFpfSdJ9cK5SwUJt1xbrT3DGsw/zmlcx2D9S5Hk3SXrOGL6NQ
         754w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B38Tn5bOZ4ypk6OTVOr1ifEvTd0RxYUIpSKcn2uioac=;
        fh=Zsy/fsWMkMzdzlTBCgu7kh/scK22GKVsKvVZHg9UPnU=;
        b=NqOid0vBkeSLqCqIOkJHiFggiT2YJwzksi68zw3St9EFrez7cuvJIWZ5lEjGwKceOe
         YSLuFYfR/eSg6vgJIvWm2bVdIZ1yICurvUmWQVmpuqdqrJmTDTpS2OFm0C7u4lZ6SS8D
         EVMpP3ObibydVF1iL+7um5sKPT8QQYRZdxOysjRe3g4ojkEBSq6zD6qG8OAtnlbDAJ8X
         0vzo3HgGVj7GqR8gm6sqUZloSf2IqtEDJOIu9Mj3hzRO5QtJsHb75pDTjOKhRlyJa3hR
         7aXmlU79aBSgxAraWeE74xJZC+QeIiCUDv+T1mNNt3Ye0i5/u5RcV8ydwEugDojIzm4a
         LE4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457713; x=1792062513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B38Tn5bOZ4ypk6OTVOr1ifEvTd0RxYUIpSKcn2uioac=;
        b=CK0aaaSS95cFam8fOvFIAL03LolLwH9M92v2paGpuvzZWVLGifDh5pelUa4fX8M2Vl
         EmGlcUcUI1xtwYtUxU+4W+dLbIOPmIPePnpWkSJ1wNgmStzopQa+Zserq9TXeh+bXQya
         1Urn/ymmiMSIPXlC97tJvP3LRbZKcEaaJd5kAPa/aM6MhnDkLcGqjD4mWiRXH5tPbpr/
         22vNHaBvvj0TNMecngRyslMw2fymouAe9cR7ddFAqSM84UflBxTS9UiRZlmjz1uIugUS
         R2IFl9nzG9sgz6i6fey9cFbklIdM2vLeZ7QpHzyig2iJcAbESUF7gaZMhGS4txGD9IJo
         8+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457713; x=1792062513;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B38Tn5bOZ4ypk6OTVOr1ifEvTd0RxYUIpSKcn2uioac=;
        b=olsm0XHBccT5MLp9ozO2aG9B8Xl1b77ErnECAIJBCbJWE68cn118rqUz86cMDA6ufk
         inS/bRUOeN0JlOaBDzuTGHb6+b+8AqsDEcHlnypn96S35VwmAWxdJBHGTUMHxC6cIn5L
         Jk4gjCUK4OhjBWAUePy9YjbFvTu9x5uewEMl3mzoEitWjivPFB8MA/Z6kOcFL5zNnT+Z
         iW1mWdD4QloRZ47PcO28Sr+PKa/tGnYEEBiJEh3QlWMasBxPKH/nHO1VgumirIU1dbxe
         aRVvD1s916sfo75VQnoQOEPzurDGlfFuHCLKYZqVtjQMtuBwKJjwpT09fNvN2wyCqcmv
         bcIA==
X-Forwarded-Encrypted: i=1; AKwUvBz3WrR9zlUuo3gudNvRInrgM4XE4HodspBRFsiap0XjuR3V7TArRcQhLceTpC+rVgJp9okrY/NH5rQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9J44Jrlpaci7Q0r+s68r+2+4Acir9d1P+4W3MxhSzcR+Z1eSe
	v8plE3L5bsZugiX1hzpc92gQ4AjLz/HWaUScWI7Moz927MX4Yd0zsogl21daZmVDm7yqlqiiW9V
	h69vTimBIW64ZCjVI17nePAZp7Xb58Ag=
X-Gm-Gg: AYBFou2khojQ0U4DMAkukSEalBDzu2FqsYOOSgr8Wkss4NKH1YCNtyidJF5mYxj/XTB
	cSPl5oHXuiH0Z8fvBT0UIknIDPn3ZXgqmypA927/BY821uzkXf0xF0eHKBeP52ZCUD3NBPU4zRQ
	49E94HvuZ/Oa2WJ1aRZmiWSDDdANfxpGUeeESWm8u7huMjQ33eEbsmHR+Ol4Kyag1vWOL5qYn2n
	HD/orzufGYasRQyRFeGABzRRv+PCOF/WeLOpywQ4hxkiNS+dk65ekHwHBbfJza00VPIcDWPdbia
	yjVQOdr+TTnuV21/OqnddvaXwv+eI2dWO9pfelGBV9p7tohEjEU/X+o2THf22ZSOdkNAeynEog3
	X2RdGIqFLFnTPhahQGr5kNRrNh7cg0c2ntX5dCLKMxgovx9B5+NHX7DI1D3AevgIBLxY=
X-Received: by 2002:a17:90a:282:b0:3a0:d651:3957 with SMTP id
 98e67ed59e1d1-3a8a1c7201dmr2864732a91.35.1791457713546; Thu, 08 Oct 2026
 04:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007104847.507776-1-phucduc.bui@gmail.com> <20261007204638.GA785135@bhelgaas>
In-Reply-To: <20261007204638.GA785135@bhelgaas>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 8 Oct 2026 18:08:22 +0700
X-Gm-Features: AclHuK8M_me3PRP7AsYK3GSu3gkXR1O-K2dV5c57zcLYGodZRRQeb5VUpUwH-0g
Message-ID: <CAABR9nGNoaO-CmTcRvXuMMmGbVSWybKZVBRRZmzQCab_N1EzZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: tegra194: use dev_err_probe() for PERST GPIO
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

>
> For future posts, please match the subject line capitalization style:
>
>   PCI: tegra194: Use ...
>
> And style as "PERST#" in the subject, commit log, and dmesg text to
> match spec usage.
>
> No need to repost just for this; we can tweak these when applying.
>

Thanks for the review and for pointing this out.
I'll keep these style details in mind for future posts.

Best regards,
Phuc
