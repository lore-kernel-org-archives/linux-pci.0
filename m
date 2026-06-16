Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEC211A14;
	Tue, 16 Jun 2026 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607230; cv=none; b=C82OO8Z1XNGYSMwC4lUubF6b1iC92hd6dsSxCBc7TmxL7FQro+OW6lGSwvufEEFfxzuJKKRGMUoeCr5Ft9W6Y+CJw/urJMgKRJHPN8DA/4FAc3kxBYoTGkm+hNxuWGXiRXZ+v9JcONOYDWIsVdBWPSrtEpDCye7AZnYsZbGN0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607230; c=relaxed/simple;
	bh=0zVt4t5csplNTnptFSLf/+U+/EVP2Z8zpX+wKaXs3jE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s9o11BYnVZ9eF0tww4zlmCMBD2sUwbIK4bEoCRSP46Fb1v1X7pOAO+KaYLPc5guI5ta4SL4Um8aZ36fzc3UN5DzgmZwCtZx8RpN5gSWkYEIDhELRHTkaIpWw3Q7kkUCoTGLt5KtaKaHYrmzdLM5ZUXEwSY3ADiz5KwrlMVBlfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7oArYru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7oArYru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D7B1F000E9;
	Tue, 16 Jun 2026 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607229;
	bh=i5AErCDKah2o4KEj48RdEyz64FEBii4mqvzj/h3xr98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7oArYrui6UKQixrB0d7INj2EMZEyb7zMk/95RIrkpyJosI9TKsA527nTyKhxBjy2
	 BlyprgQbtfypH/66tC9CpFNZXTNw+ZYRc/2AOYM2xIzJb3lmA7jDgdi7bAMqDxCzhN
	 5n3+JMYL5ZF3JZtzk7jFzbm8h6lChLRSNighbyZte4VcshS0S8UsFmp2MeCDzqvLF0
	 ypRyBWa7uIlvbW5ZAPW2bRI+1sOSk/a+21OTx2xi1UnzHQe6EkYd0tXMXxWR0gUigM
	 xfpC9u6EeiEoc+0NM+/EixxXQzhDgWVzjk1PPwG5GO4ahEkN1PNPM/FkjVq+R3clW1
	 jsJr5MCPmXZMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/12] PCI/TPH: Refactor pcie_tph_get_cpu_st & add
 explicit variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616104621.41915-6-fengchengwen@huawei.com>
References: <20260616104621.41915-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:53:48 +0000
Message-Id: <20260616105349.53D7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor pcie_tph_get_cpu_st(): extract core logic into static internal
> get_cpu_st() helper accepting explicit requester type parameter.
>=20
> - Preserve original pcie_tph_get_cpu_st() unchanged as auto wrapper; it
>   uses existing pdev->tph_req_type automatically, existing callers require
>   no change.
> - Add exported pcie_tph_get_cpu_st_explicit() with bool 'extended'
>   parameter for manual STD/EXT requester selection, consumed by upcoming
>   VFIO TPH code.
> - Add capability check: reject explicit EXT request when device does not
>   support extended TPH requester.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D5

