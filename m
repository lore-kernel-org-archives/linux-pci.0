Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39B336895
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574959; cv=none; b=jvUkIWWYbW4UCOIvUlVhG9S2nFaHc5JxMmJeLqHw93e2K3HEp5MfOr3jOIBKoXHs2LtEzgGswVeUVK+G8ry4e/fzU84Dpw+U/C7DrOAujcK5ZTdq8sr9TQPUKzD5IjYq2vCmMMOoNkTwpJ+gU01tNVZ9kNLbFUttyUTi1GsSqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574959; c=relaxed/simple;
	bh=ukGkgzNoxuFBJf39z4xT7tjmFboDYVMiXMfCc6oEqN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RM3i69QNwG2ZWEy+nCa+1UDy+QDTECVRZuU0j3x38FW5VzUHMmSlmDHSyvwNekmgnK9Tpb4BdkrPRanRg7rTJSNYeEiIcsf5jZAuKMfQy6pVe19qn+CgJiNI1J414OlEChalDlsNO9JfdZI1DMSBtfnOkLVXiJsP3hZuILT/+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiu/1D2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiu/1D2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE7EC116C6;
	Tue,  3 Mar 2026 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574959;
	bh=ukGkgzNoxuFBJf39z4xT7tjmFboDYVMiXMfCc6oEqN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jiu/1D2/8apAhWOun+Nh0jedBnUue0QDnWOy3H2XsLHV2BFNwk/oV3exTcfggX0AP
	 AY0iNI/d77JhblVZQBL4ej5bC+4CHffqKo7oLYRZtAmOHjFie5qallHmsdLqt/w9cC
	 jXMUOu4jg3Bz9pFCSYSoe2xWYsiPYbOF4DlKkfcL8RUvf8Gk3rPFXZ5v1dgDGux5it
	 PmbERezsEVt+YuoyN6jg5TbhPKjymi6/pNsbEm2phVTgJcVKKM1mScWX85WkYL0E1S
	 rxEfi9pNDppu53eL1lQN/3ugXEIQsRe+T3PpWR2ZdmecigZdg67cDa67lXEfM6oNEa
	 53bo1i/Hk8Xqg==
Date: Tue, 3 Mar 2026 15:55:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
Message-ID: <20260303215558.GA4076158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de>

[+cc Yunsheng, author of ad5086108b9f,
+bcc commenters on https://bugzilla.kernel.org/show_bug.cgi?id=218951,
see the email thread at
https://lore.kernel.org/all/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]

On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> On the servers below Linux warns:
> 
>      Unknown NUMA node; performance will be reduced
> 
> 1.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.13.0
> 05/14/2021
> 2.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5
> 09/06/2016
> 3.  [    0.000000] DMI: Dell Inc. PowerEdge R730xd/0WCJNT, BIOS 2.3.4
> 11/08/2016
> 4.  [    0.000000] DMI: Dell Inc. PowerEdge R910/0KYD3D, BIOS 2.10.0
> 08/29/2013
> 5.  [    0.000000] DMI: Dell Inc. PowerEdge R930/0T55KM, BIOS 2.8.1
> 01/02/2020
> 6.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.5.4
> 08/17/2017
> 7.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.5.4
> 10/04/2015
> 8.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.11.0
> 12/23/2019
> 9.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.1.5
> 04/13/2016
> 10. [    0.000000] DMI: Supermicro Super Server/X13SAE, BIOS 2.0 10/17/2022

Similar reports in the bugzilla for:

  Host: VMware VM Ubuntu 24.04.1
  CPU: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz
  Kernel: 6.11.0-rc6

and 

  Lenovo P700 workstation
  6.19.5 kernel

ad5086108b9f ("PCI: Warn if no host bridge NUMA node info") added this
"Unknown NUMA node; performance will be reduced" warning.

The problem is that firmware didn't tell us anything about which CPUs
are closest to this PCI host bridge, so we can't try to optimize by
running the driver on a CPU that's close to the device.

The kernel can't figure out this locality information itself, so
there's nothing we can really do in the kernel, and there's nothing
users can do either other than check for BIOS updates.

What if we just downgraded the message to "info"?  And/or we could
reword this to be less alarming.

I guess we could even drop the message altogether and assume that
vendors will provide the locality information if there's any
meaningful performance benefit.  It could be that it really doesn't
matter where drivers run on these machines, so there's no benefit to
providing the locality information.

Bjorn
