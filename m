Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D0307AF0;
	Thu, 23 Apr 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968640; cv=none; b=YaLxkOc+MbqTHk4DNhemU0zomyKVCWn79VkVoQux+NNVV8h6rMbSMYUw9Q21FATL/nrkldM8QyXzEWFoOJwL0GjNqgY5mk5n5cB/7upvlL4bIXr0WimIe0yiJaPbb4RQgnMdlAw1f3iHWmdnaCdOaVBD5e6hGe34+lfadUd3uV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968640; c=relaxed/simple;
	bh=3d8ZmDarkOjA6NU39EQhXgpDDN9j4UEKZX4Zr+EHhQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F/b1fy96NTfqYbqxRd/xqx9mr3ZQ2KcNV1l0nvVoHH7CG2Wh/is1d45031ZqceITpR9dEIWHtSsX8Cuco1NJuFp10TWCbWxw6DbFxBql97XLEGTDwdA6rq3YAzu6TdFMVjDlVc9i0Y7rANbgnF8rhMgendZtNJQqgR1lcZ1n1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQQ3e4R1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQQ3e4R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CDC2BCAF;
	Thu, 23 Apr 2026 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968640;
	bh=3d8ZmDarkOjA6NU39EQhXgpDDN9j4UEKZX4Zr+EHhQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QQQ3e4R15vnbbLmeHFfc8Fgth2tXRh//j2AAnWfZE1Io/yra+UAMjc/h5nO9Rvf5B
	 gHCVH2SxYRYuHnmibB4mqBxdstkQWH/o/mrJ7dm9gvAJY1mxdbuAS55UWccXnbC50i
	 Jw/32ZWL+qsezg+VzVMRQBpho0mGoyXtL8E3aJ8SsMDxUWnusoZH/TAePrVSW4bsjh
	 VXABUT5WE9kgNyP+T5kTfZkoc8viylzymJLKRsSGkPpPhd3HifSqoEB9HifV46PFCI
	 0flrXvdE9rmgPAis8fozbhynnW+fHNXqf9Dr7Xn35QLdWsGg0sQmGHjhyvI7mUwK8/
	 26rN80B7YH3qw==
Date: Thu, 23 Apr 2026 13:23:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260423182359.GA33696@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423172200.GA2271460@rocinante>

On Fri, Apr 24, 2026 at 02:22:00AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > This series converts every dynamically allocated PCI sysfs attribute to
> > a static const definition.  After the full series, pci_sysfs_init() and
> > sysfs_initialized are gone, and every sysfs file is created by the
> > driver model at device_add() time.
> 
> A note on testing:
> 
>   0-day bot (recent test runs; newer builds will arrive later):
>     - https://lore.kernel.org/linux-pci/202604231622.DgR0zih3-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202604161928.DzuHQmeM-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com
> 
>   KernelCI (for the "for-kernelci" branch):
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/941dd7c3e16840724dc961f10b84e193d13cdb57
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/683e66b11da157f730101f6919c7468a09cf3e3f
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
>     - https://dashboard.kernelci.org/tree?ts=pci
> 
>   Sashiko's feedback:
>     - https://sashiko.dev/#/patchset/20260422161407.118748-1-kwilczynski%40kernel.org
>     - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
>     - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
>     - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org

Thanks for all this work!  I think this will be a great step forward.
I assume you've probably looked at the sashiko feedback and concluded
that no changes are needed, e.g., the feedback is out of scope for
this series?  Your thoughts there would help me out.

> I sadly do not own any Alpha or PowerPC hardware, so when I was testing
> these architectures while working on the series, it would be only under
> QEMU.
> 
> That said, Magnus Lindholm was able to test the series on the Alpha
> hardware he owns, see:
> 
>   - https://lore.kernel.org/linux-pci/CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com
> 
> Lorenzo Pieralisi did some testing reported outside the mailing list (we
> talked on IRC), on the platform he had issues before, and while the issues
> were more with procfs races, similar to the sysfs ones this series aims to
> fix, he didn't notice regressions when having this series applied.
> 
> Thank you!
> 
>         Krzysztof
