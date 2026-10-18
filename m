Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725030F95C
	for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792353873; cv=none; b=uophMO7hj4cjltsZBs36CL8xO2K0kS2XWPN7f8x8bTW2cSLlFKBo7c981V9kBAKC14NJjy39xwIwbtco22Ox1f5S1izt4elpDI3R4dzyu2q/e+BLiPbTIJL8Jyyef93yAljy5/g7ufm3hhsYMOoNBaNozKMD6XErak1eCfJ4yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792353873; c=relaxed/simple;
	bh=7TlQsGW8Ky4gB3RUb3lx8U6PzzZvkGGwhy8ltKRWrDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qsaTtGSofMOwREVAMRjz8nBFZybNM0oNKRnfvU+JAdnIL0x6bMjn7vNhQEJkFx6prrUgFcq4sBb7FSuoDM41OTTjEGv+vRr+u5lIbUIIAS+jFdukJbU0hWCk8R9fnqsw1qZD7wEQkebliDaHHj3CBGMDgeTWu/59YbBRE22nJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTLME0r7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTLME0r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7582C1F000C5;
	Sun, 18 Oct 2026 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792353868;
	bh=gMSKwfEUvy76tp19EXY6DU7m5XMqNAf5LjZmGXHDufw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nTLME0r7ugQMR3bx7GO1a9UK9dBkIkrbG9Q0ZnHrOMWeE3s0r7zgfhdvvh3VrQJZB
	 QShihuGuW7obaY8TW8GvFkdlhgHtOSC4ryJY363163F1fJzQGVNbQEAMKYomT1T6ju
	 G/zKsCr3ddiJkgYBERfwKJRr+LwA2YVz2YuNs3iA9JNXLlpT30EoL96bFOmIwCQc4j
	 O7sDgvegd4coN/t4/cw7g9Rcrft/T4bNaY3TCRM1FlDSdm1ZdTJ/JG+LdpzSrlZP9q
	 08x6EpPBCELxcg9+AjtQ5Whwoazxyr+fkn6fi40V20ZnU/JhpIK+utysDGOKKdgHTX
	 11Rx9dTf4X8tQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin
 <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
In-Reply-To: <atRLsp1qUA_sGS-0@debian>
References: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
 <atRLsp1qUA_sGS-0@debian>
Date: Sun, 18 Oct 2026 22:04:24 +0200
Message-ID: <87y0bubws7.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 18 2026 at 10:05, Manivannan Sadhasivam wrote:
> On Tue, Sep 29, 2026 at 02:54:58PM +0800, Shawn Lin wrote:
>> Leverage the interrupt redirection infrastructure to enable CPU
>> affinity support for the legacy INTx interrupts. The INTx virqs are
>> demultiplexed by the chained handler of the "legacy" interrupt, whose
>> affinity cannot be changed, so affinity control for the INTx virqs is
>> achieved by redirecting the handler to run in IRQ work context on the
>> target CPU.
>> 
>> Mask the INTx source in .irq_pre_redirect() before the handler is
>> redirected: the legacy interrupt is level triggered, so an unmasked
>> line would keep re-firing the chained interrupt until the redirected
>> handler runs.
>> 
>> Same approach as the DesignWare core, commit eaf290c404f7c39f2 ("PCI:
>> dwc: Enable MSI affinity support").
>> 
>> Test was done on RK3588 EVB1 board with an NVMe with pci=nomsi
>> parameter. The /proc/interrupts columns are trimmed for brevity.
>> 
>>   # cat /proc/interrupts | grep INTx
>>   51:  137 0 0 0 0 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>>   # echo 10 > /proc/irq/51/smp_affinity
>>   # dd if=/dev/nvme0n1p1 of=/dev/null bs=1M count=200
>>   200+0 records in
>>   200+0 records out
>>   209715200 bytes (210 MB, 200 MiB) copied, 0.182021 s, 1.2 GB/s
>>   # cat /proc/interrupts | grep INTx
>>   51:  137 0 0 0 946 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>> 
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> I'd like to get an Ack from Thomas for this patch since I'm not an irqchip
> expert to decipher whether this patch is valid or not.

I'm happy to look at it, but I can't be bothered to fish it out from a
mail archive. Can you please bounce me the original submission?

