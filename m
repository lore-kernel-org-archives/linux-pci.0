Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F001F16B
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786252614; cv=none; b=q1ZVMs1lI+MmfsoET98FkwHi2YSJtw4tHbAIyYwRaFeG5Ux1xf+1CjBY4GhjEnY69HdykyLGodek0YDHqG30t5Aw7uVxLO0Pr6PSXymkaMwU9tMaw/7PXQftXa4gbsbCng62f0T7TPPohsXpjInQTdWM+f1zmTJyoSV0JVdn1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786252614; c=relaxed/simple;
	bh=e3NXT56jov/YXHNllaRe/Frdpa4+K+yN9wf/iOO4i+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IDLn7mu2yWHbyDSBZHaec2u5nvX2+2YujXJR3csRQlEQ6x3wo4ZLQL+aap1l5wIFvsDkG2H6f5Vegjy8qTDf7dKmv9SzO2zpCrAdcdQs65rLyBGqUGVkakxNOgoSwPJ8/Q+ffFaTJV4R6aYcdJs1u9KMLE5fhUB583PdWqo0KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5BsQ9X8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5BsQ9X8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BA31F000E9;
	Sun,  9 Aug 2026 05:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786252612;
	bh=g/SrY+628knRzdMLqZmaKm1TLrfle2PsxZtWARRaZCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5BsQ9X8xVgquUXTDt6e+NMkvk4SPzvapj0oAUBpQ5x6uRp95BsERS+lhvjt9/xzv
	 vBya+IItO6seV8wdRrVzuR/uteNCuxWcPYvrACdSt6TNOXTVlGPR2bwFUYOHJ5IQmr
	 JrewU45ZkaHrdS2+CSwncOOrYSKmFcBZqihYe3FS83vG5fku7R2QWFVw/YZO/2rCoA
	 xLey7kt8d/YN5MirEWj85ZQae7RmeH8d9CrUGX5yUARvOAQ5V0THjqneg2D/GpCp1Q
	 MJSPzRbjaOY7psGlO4vgjeG7ab2hRcNpUA6TrZzSB1CYXZbFVHil5aAr6Sshx7xF7y
	 vii8eBpX8Pd2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260809045946.15638-1-kartikey406@gmail.com>
References: <20260809045946.15638-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 05:16:51 +0000
Message-Id: <20260809051652.36BA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `IS_ALIGNED()` macro is invoked with a user-controlled argument=
 (`count`) that is not guaranteed to be a power of two.
--

--- Patch [1]: [PATCH] PCI: sysfs: Reject unaligned resource I/O port acces=
ses ---
commit 5ca53d551b5755e8c03169b8a70d53f035905df7
Author: Deepanshu Kartikey <kartikey406@gmail.com>

PCI: sysfs: Reject unaligned resource I/O port accesses

This commit adds a check in pci_resource_io() to validate that the requested
port is aligned to the access size. This prevents alignment faults and kern=
el
oopses on architectures like arm64 when accessing Device-memory mappings.

Closes: https://syzkaller.appspot.com/bug?extid=3D7134530b25073b4ef373

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69bd..72f0404a34e99 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1175,6 +1175,9 @@ static ssize_t pci_resource_io(struct file *filp, s=
truct kobject *kobj,
>  	if (port + count - 1 > pci_resource_end(pdev, bar))
>  		return -EINVAL;
> =20
> +	if (!IS_ALIGNED(port, count))
> +		return -EINVAL;
> +

[Severity: Low]
Does this code call IS_ALIGNED() with an unvalidated user input for the
alignment argument?

The IS_ALIGNED() macro strictly requires its alignment argument to be a pow=
er
of two, but count comes from user space (via pread or pwrite) and could be a
non-power-of-two value like 3. Passing a non-power-of-two value results in
meaningless bitwise operations.

While the subsequent switch (count) statement catches and rejects invalid
sizes by returning -EINVAL, would it be more appropriate to perform this
alignment check after validating that count is actually 1, 2, or 4?

>  	switch (count) {
>  	case 1:
>  		if (write)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809045946.1563=
8-1-kartikey406@gmail.com?part=3D1
