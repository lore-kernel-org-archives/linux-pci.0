Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922390;
	b=X4C+cHOeygvsGyuBKnMQ2sNI2Fwp8xUxocNsPR/wnsK3YGeT1cro420dxh9NFPG4lcE8
	 eKD3jC2PsxPjD+/i2TFlZyCtYQ0cRsGnFhZnJTRWFxLZA0CsEn+AE5fLNgmn2topmegzH
	 NnaJ6/kjB4NG3Gl1vVpaXj4yFk59X/REDFZr2HcRPjp5awIngmBayVv6dVVbZpexfLK67
	 t4fF9X7+VFyGoqLSx9OOe6TwJ3kBcPcHSOeB9I7H7F2BrDghWPme5dXL8bZp8JuAuDNOi
	 u1gI2AXYeXPWfPbvnIB3VRQRKjZxGiB4RHyp4QyKmp8uNLS7ihB938YF/jZvD/grSaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x2dyM7YPg9X82mHGO35QN78CKwYix99R7vjyLHrtwD0=;
	b=ewornltsx+N009e4UsyqhkR3uqx7XdvG7IwP5Soxi7l+4gOlQvQrtFVsRKXTkQWbMA17
	 OWezmFdWhvgETqs9peiR08BC1QiTnQIDkorplmXaSUqwYdIa8QOdNd/CEsGlvNO7egKOB
	 i9VWN4kGU02fu40a+f3h1Bh3TVsHcBophGIIoOOUd7rsiuZ+GNwTd/y+5UaGV8kP5XSov
	 5EAL6Vc4EYg4SC1P1dIWUukGl1N808IgEYkT859pd9OSmz+Y/Me6FzBG71wwYPl3Zir+6
	 8cOq6awM+BPrJ/gRO/MeHRPShsTU/TTbnvFMECHxw5eoZFn0oTbOTvqSj8+ifhODW8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSYx4jRR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533B606A31B;
	Thu,  5 Nov 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSYx4jRR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5C31F0089F;
	Thu,  5 Nov 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793922389;
	bh=x2dyM7YPg9X82mHGO35QN78CKwYix99R7vjyLHrtwD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mSYx4jRRjrkeiS7dQtSIOFO8rz7cUj15q/amOhkjUpjTR6pYfsmDNuSk+5cLdkgDK
	 J4PPnPpS6obHquWGzVYKp32nIlRywl8HQkCCituI9216Wqaf+756v0WLcm1+45qBXu
	 T+FWkR5iJLFVdtZnRawyVxOxevERwr/DpTTEsmDKMOGyeESKXCKGa3XHKWGj4BC8Gh
	 C8W6uAU5vaHxN3u1zAY6o+3Rz8Mk0X6WSTWXf6c8b8Cq/2zLeunESE8pqtcGZDy6sg
	 c6stw06/AXbPEnvhOP1ZQP2ikjqQLIwZryMUML9nIO+8WKvNOm7iSEu253yLdJpBdc
	 kXUI82WxK1BWg==
Date: Thu, 5 Nov 2026 17:46:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Poulin, Louis" <poulin.louis@student.oaklandcc.edu>
Cc: linux-pci@vger.kernel.org, ZhaoJinming <zhaojinming@uniontech.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, Kees Cook <kees@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs
 show/store callbacks
Message-ID: <20261105234628.GA1576767@bhelgaas>
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
In-Reply-To: <CAGQButtv-1k9DzOLEBwjoKQP+=-u4obM5bBHZZs=Mw2vd1cBnQ@mail.gmail.com>

[+cc other members of conversation at
https://lore.kernel.org/all/20260727072915.3954329-1-zhaojinming@uniontech.com]

On Wed, Nov 04, 2026 at 03:22:51PM -0800, Poulin, Louis wrote:
> Hi,
> 
> We observed a cold-boot crash in l0s_aspm_show() that appears to
> contradict the assumption in this thread that the visibility check
> always keeps readers out when the ASPM link is unavailable.
> 
> This was on an ASUS TUF GAMING X870-PLUS WIFI, BIOS 1805, running
> Bazzite's 7.2.15-ogc1.1.fc45.x86_64 kernel with InputPlumber 0.83.1.
> The fault occurred about 10 seconds into a cold boot. An earlier boot
> on the same system had the same fault address and symbol offset on
> 7.2.9-ogc3.1.fc44.x86_64 with InputPlumber 0.83.0. Both observations
> were on downstream kernels. The captured 7.2.15 kernel was tainted
> O/E (out-of-tree and unsigned module).
> 
> Relevant excerpt from 7.2.15:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   Comm: inputplumber
>   RIP: 0010:l0s_aspm_show+0x47/0x80
>   RAX: 0000000000000000
>   CR2: 0000000000000030
>   Call Trace:
>     dev_attr_show+0x1f/0x50
>     sysfs_kf_seq_show+0xa8/0x110
>     seq_read_iter+0x132/0x4c0
>     vfs_read+0x34d/0x490
> 
> The faulting instruction accesses offset 0x30 from the NULL register.
> In the corresponding source, aspm_attr_show_common() dereferences the
> result of pcie_aspm_get_link(). The read reached the callback even
> though that lookup had no link to return. The kernel killed the
> InputPlumber main thread and the service stopped answering
> ObjectManager.GetManagedObjects. This blocked the boot-time controller
> setup.
> 
> We are building a diagnostic kernel that returns -ENODEV in that
> specific read callback when the link is absent and logs the PCI device
> and upstream bridge. The device and the reason its link state was
> missing are still unknown. We have not reproduced the fault on an
> unmodified upstream kernel.
> 
> Would this trace justify a guard in the read callback, or is there a
> preferred way to instrument link-state teardown and sysfs visibility
> on this hardware? We can follow up with the device and bridge once
> captured.

I don't think we should add a guard in addition to
aspm_ctrl_attrs_are_visible().

pcie_aspm_get_link() must have returned non-NULL in
aspm_ctrl_attrs_are_visible() for the sysfs file to be visible.

If it later returned NULL in aspm_attr_show_common(), we must have a
bug, like a lifetime issue or some kind of corruption.  Adding a guard
would just hide the bug.

Your next message suggests that the device and upstream bridge are
valid, so possibly bridge->link_state was NULL.  I would instrument
pcie_aspm_get_link() to verify that and add a dump_stack() in
free_link_state().

> Kernel source for the captured build
> https://github.com/OpenGamingCollective/linux/blob/f6857d4bfd614b90302903490796ef376be0a67d/drivers/pci/pcie/aspm.c
> 
> Thanks,
> Louis
