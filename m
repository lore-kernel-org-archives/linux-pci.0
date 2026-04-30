Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA381DE2D3;
	Thu, 30 Apr 2026 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512692; cv=none; b=NwfYZO3JaZO1QL+u533MUETd88639U5IBFLoHBNLfP9eknRuPvxcSfBmu+ZCDkyH9aB/xo49UYUanX2pjBiucpb3jsfx/y/B+XcEk8Z294TCGGzc3TBpc9NMU+GFqD5UGLdh5kgKKQVB6zedaobmXoZCtbJdMmCXdKAoP1zND0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512692; c=relaxed/simple;
	bh=+6AI1AIMBVhMSxwAA+CFoyVM0Rm3EFPwFg6gwl9zXno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u33UymysTgqPyGKZ/6ENAyYciOECUbXuOd7NTIhiiSeex5OrMbyuEuDG2TxfDvGYeDiakH+jxLbYvyL8/zZEDLE94Huz49EmTflJYlUXlvoboy3a/bgtwFJmC0asIYJ/2niok3deMgZKnjwPOSLN2rKJGuRpOZEFolvIlbiVJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlwoye1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlwoye1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C56CC19425;
	Thu, 30 Apr 2026 01:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512692;
	bh=+6AI1AIMBVhMSxwAA+CFoyVM0Rm3EFPwFg6gwl9zXno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dlwoye1hKVvQsM62tnha105SiLWaxrmgMPjEBT2QZOgXqFKo8bi+z5yjr1dhx5MMe
	 yp0qMjc7HBwO6rkSyhpEf0xF2HeDI+6nQeMyqkvDxOIHDGQl7CVlLasnMPLZBLSQZW
	 Z5ycRyFsxB9ZvPoQ0KDQPxb6bjt+r9ifzkwpeEH1uTfHaF2CRMMZVZ/aCvl30r8/8N
	 ZLygWI7AgEsh5w67hzwL4YrLMVFKSBwMnJiHbB/mVbJh7aXhWfhb2EDIisUkRchwWM
	 C8BQs6jwWQSNJjWDEWM3VSLZlInVhFF+AcYOjsQU3r1IsjiL3pLeK/M7R7PO6QpZRr
	 vAxh0v+dU+xow==
Date: Thu, 30 Apr 2026 10:31:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, moubingquan <moubingquan@h-partners.com>, 
	Ian <4dark@outlook.com>, Koba Ko <kobak@nvidia.com>, 
	Koen Vandeputte <koen.vandeputte@citymesh.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Artem Savkov <artem.savkov@gmail.com>, Korneliusz Osmenda <korneliuszo@gmail.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260430005931.GA3872993@rocinante>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
 <20260429200439.GA313340@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429200439.GA313340@bhelgaas>

Hello,

> > This has been reported a few times:
> > 
> >   - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com/
> >   - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com/
> >   - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/
> >   - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
> >   - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
> >   - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
> >   - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
> >   - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-artem.savkov@gmail.com/
> >   - https://bugzilla.kernel.org/show_bug.cgi?id=215515
> >   - https://bugzilla.kernel.org/show_bug.cgi?id=216888
> 
> Seems like some or all of these should be mentioned in the relevant
> patch as "Closes:" tags?

Bugzilla would makes sense.  As for the lore.kernel.org links, then if you
find these useful when included, then add these too.  Surprisingly, not as
popular to do so, as I thought, per:

  $ git log | grep -E 'Closes: (http?://)?lore' | wc -l
  43

Having said that, the following bug looks like it might be out of scope
for us, for this series aims to fix, after having a second look at it:

  https://bugzilla.kernel.org/show_bug.cgi?id=216888

Thank you!

	Krzysztof
