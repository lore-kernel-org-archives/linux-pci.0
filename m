Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDD35DA6A;
	Tue, 16 Jun 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628476; cv=none; b=KVpxOnVtfxOpBaIW9wo4QASkq1SdzQPmSzyMClJ/fYqE5ygBeqWhmUY1iITuNrn7nmnPlPKvxkmUtZsVzM+JbAA4yTSEpqPkbh2F9Vn6TXSvHRi/xsDuoT+JT08dM9vDnqI6qwr/W0+qeCATNPuOO62IpmWbWfX4FNKQeP7f2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628476; c=relaxed/simple;
	bh=L1XpZjCaOyKRpumzV49F0NYsoPsNL50vsehrCj2ihsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp7RcF35/cDoh8IzE23wv2/JpRQPZkbmncSZV9gLv7/GK1/bjIpit2Y1S/Vo0ODlVWxGodu5UNtFUZRmDp3JONhNdUHVvH4Z4a429xTFrA/e+OQfekfzEndqIF9TXWhc5BSXSiKFxjykD8zKAy+sTRHAOHzxDqe6RBZ0jPpGulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJVRMJy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJVRMJy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB7D1F000E9;
	Tue, 16 Jun 2026 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628475;
	bh=BoDHER7EyU0oWbzWrxHJ/W1Eo3i8tJoYjwQsCPy18gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJVRMJy3fxZ4M/Bwv8IN15tsqoxuMGZxqC+9pKg3JB4cr4desMwZQq8tBAGOueUzs
	 iMX6puuc7eGHAZJSOuF/bvKQyxVj7tMij8biTK1CZcJXoWGO5yzQLnSVaZbzIsVt36
	 H1YvRNvQZ8em3NaOX9oHgvqMkj+iXuWCTpewGchbAbqBBMyT60t5SGKN6BJ+S99sk0
	 KuQdWxG6ZJTZjvbs2G8daBy3wGcSeiI+d414XG01TIRy33ir5fbAqMnT2DZMseQUYl
	 BT64wqPCZ0AzLdOjtYmSlSywdC5wQO31ZuG+bJ/zBLEhhAYfNWrONcVx33DC9oJ2zl
	 4t2bfSV169P7w==
Date: Wed, 17 Jun 2026 01:47:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/sysfs: Fix out-of-bounds read in
 pci_write_legacy_io()
Message-ID: <20260616164648.GA320708@rocinante>
References: <20260616163131.2763281-1-kwilczynski@kernel.org>
 <20260616164230.81F281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616164230.81F281F000E9@smtp.kernel.org>

Hello,

> [Severity: High]
> This is a pre-existing issue, but the claim that no changes are needed for
> Alpha doesn't seem quite right.
> 
> Looking at pci_legacy_write() in arch/alpha/kernel/pci-sysfs.c, it calls the
> I/O port functions with the port and value reversed:
> 
> arch/alpha/kernel/pci-sysfs.c:pci_legacy_write() {
>     ...
> 	switch(size) {
> 	case 1:
> 		outb(port, val);
> 		return 1;
> 	case 2:
> 		if (port & 1)
> 			return -EINVAL;
> 		outw(port, val);
> 		return 2;
> 	case 4:
> 		if (port & 3)
> 			return -EINVAL;
> 		outl(port, val);
> 		return 4;
> 	}
>     ...
> }
> 
> Since Alpha's outb(), outw(), and outl() expect arguments in the order
> (value, port), doesn't passing port as the value and val as the port
> address incorrectly use user-supplied data as the target I/O port address?

A known issue for which a fix has been sent:

  https://lore.kernel.org/linux-pci/20260612232400.585195-1-kwilczynski@kernel.org/

Thank you!

	Krzysztof
