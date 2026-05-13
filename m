Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700538CFE9
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703544; cv=none; b=MvEk+S9nXeNyYggWWSYlkhhFrgCmyDSFkxm665OXdhHfxrZMh6PRm2j3CK8ALvPz1DtXS5HYU5UUOCRAtHdLoGs6F2xJWrRAFDCFaTJotz4EXWbftn35420qXKozs35Hup7eH8j4UQCn9EjiWu7o9YMOR8QoM+pYYzvsZXKEjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703544; c=relaxed/simple;
	bh=HPahXOTOfqqzxfO/3Y20EBKQUIYHMc9TxRyDMQg3sBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0qhXrEhGjU3EUa1jPHV5pSMxJbXj3/7qsxBKOuMr5RmfU5T0TZxYLCXzKaGPCSmzHjBxLZU2fzLf4skp+UViUOe0tmWsG6wMboOjmwr15A2hXcgXM16z24WAx1VkpsOirPxk2kgPh32rk+JDQOOyuUkmspopjBqMKBLGYE5YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyVc4Pcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyVc4Pcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E6DC19425;
	Wed, 13 May 2026 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703543;
	bh=HPahXOTOfqqzxfO/3Y20EBKQUIYHMc9TxRyDMQg3sBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jyVc4PcfW1IXgPeRcelT1DaHiVua05VhAnRWQj9kgfKqgyAVxP8f+xu3fgHA0VS9A
	 kRJeD0TOikibgRMBTkpjP7npM9Fn1RZ0VWFaMXhab5vloMkLrm6JcAw9PmwnGKibxy
	 CTWwQzQO8Q6BP3k/PCTGm6NEK5Dj2qU9mtJfWO7vGdcqQYbYg6wjj76zPm4sD16QKk
	 MU/0fBFR1mNeI0Tnrldq02+urzxg3lkJRABZHJQdZVfOZAfS4J4PkZjUxpLaEKZYPG
	 1Ip/cXLGwqlln5drYLkmo4P5y4Kd49S1zs155mBm3qXSanshtNhlPJFBuaE437C0Yt
	 7th9JSt4YZMpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix signedness bug in fault injection test
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Carpenter" <error27@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <agL-Uwfn26SI4Gb0@stanley.mountain>
References: <agL-Uwfn26SI4Gb0@stanley.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:19:02 +0000
Message-Id: <20260513201903.71E6DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Register accesses without ensuring active power state (missing pm_=
runtime).
--

commit 4899a9300a95dd54caf44bf07153849d88f68ae7
Author: Dan Carpenter <error27@gmail.com>

PCI: dwc: Fix signedness bug in fault injection test code

This commit fixes a signedness bug in the fault injection debugfs handler.
It ensures that negative error codes from kstrtou32 are properly handled by
storing the return value in an int instead of a u32.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drive=
rs/pci/controller/dwc/pcie-designware-debugfs.c
> index d0884253be97e..4bfc1748f2d73 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
[ ... ]
> @@ -327,10 +328,10 @@ static ssize_t err_inj_write(struct file *file, con=
st char __user *buf,
>  			return -EINVAL;
>  		}
>  	} else {
> -		val =3D kstrtou32(kern_buf, 0, &counter);
> -		if (val) {
> +		ret =3D kstrtou32(kern_buf, 0, &counter);
> +		if (ret) {
>  			kfree(kern_buf);
> -			return val;
> +			return ret;
>  		}
>  	}

This isn't a regression introduced by this commit, but is it safe to access
the hardware registers immediately after this block without ensuring the
device is in an active power state?

This function handles user writes to debugfs, which can happen at any time.
If the PCIe controller is runtime-suspended, accessing its memory-mapped
registers via dw_pcie_readl_dbi() might cause a bus hang or kernel panic.

Would it make sense to call pm_runtime_get_sync() before interacting with
the hardware registers later in this function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/agL-Uwfn26SI4Gb0@st=
anley.mountain?part=3D1
