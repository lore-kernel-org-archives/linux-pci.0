Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13922DF153;
	Mon, 27 Apr 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332844; cv=none; b=NptzeSmLXDIQtHUefVgaHMnPaE3Rm7blg3RTfPFHKkW11jxxN+WXSe+9/eT7ChBl2JyoOJqY/Wgt7++SEl0ziIjlrf+QFjcaLPKPW+x5fs1uOwDRrOUHBMqrFx9elbqM9i0cWCFQbFJ45P+D5tJMXy9iLUN6HpAdNwi6B/YGwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332844; c=relaxed/simple;
	bh=+Mz+K9V9xVnzkN7jC1vFBVIkFBsNppLIc/gwkfZtBgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OztgCuiWgYHKBaMDcA99vCuPyxR5SawQEHhpjDoQ4WaxlyggV3Elaan/kxxQK9mPjWv9ITlXQgww3OopIhAU1eZSMe+IwMj0ZlVfElpbPbeUcbfih+uZt87H9kpwDu5rgcKfpbEbnhfZO+6bnU48ggox2aG+PuRvWp8o48r9d4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+mRV2AS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+mRV2AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7C5C19425;
	Mon, 27 Apr 2026 23:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332843;
	bh=+Mz+K9V9xVnzkN7jC1vFBVIkFBsNppLIc/gwkfZtBgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+mRV2ASzEe1cwMUzJcq40wHQOH8FRWxflpZrmvVnBTQ1fOl8fCWS6FHJqKhQO5Pg
	 UYYsiK58BIxOWwjZLHEjS7P0xRfZKXtMg7FfR7yMSLIEWGkd46SMd8IGxx58zp3cPB
	 OKvnPDfWDpkdFMQ/z40YvvQRhhV2LzOM1KgWYeWYfK280OO7pML+nPcHQ2ovjtElkY
	 IF12LfpwalDJkDrtZPhkdW+jy7RBVGjuIgQqtlUasppV9J2EFUUokyspv4WhKFYM9d
	 iqJjIvqMHQ8tv+vynUPHqhBSHs4iIG/KUffr+xlzxliv9VshLYpjaEI9dmBtZcOrMt
	 YdPINto2m8qfw==
Date: Tue, 28 Apr 2026 08:34:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Dexuan Cui <decui@microsoft.com>, Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260427232320.GA865293@rocinante>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
 <20260423172200.GA2271460@rocinante>
 <56ce57ca-b5ce-415c-b17e-bdcddf93770e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ce57ca-b5ce-415c-b17e-bdcddf93770e@linux.ibm.com>

Hello,

> > I sadly do not own any Alpha or PowerPC hardware, so when I was testing
> > these architectures while working on the series, it would be only under
> > QEMU.
> 
> I tested the patches on PPC64 machines running as pSeries(on PowerVM and
> KVM) also PowerNV.
> 
> The sysfs attributes looks normal on boot, and on hotplug/unplug of devices
> and SRIOV use cases.
> 
> I see no warnings/errors in dmesg during PCI scans, initialization.

I appreciate that you took the time to test this on a real hardware.
 
> Tested-By: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Thank you!

	Krzysztof
