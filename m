Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444593;
	b=TwMH73SUoO6sYiOIkOEDql7qASBqFUIUGOkWrnAu/ZtmOtyoDY0PyuWB+e6dnwBn9f/5
	 bnwpa5j0Ipx3naBvjkSjcGt/QZNossfbiCT2g+wASBF65to83s2dX/72DOm+IR3W2mX19
	 CoNbn6qlLp/tnjM7YLqadJX/A/JpJLoNopY4PT01Ibywh6yivfDxCyro0CwW4FoQiruZf
	 LKfKwc8kU6gz8M5Mq/sdRoN5tYxDNdnfRlY9tp39pwkid+4qIUEWJ1wLLKGshUXKjxC/x
	 0ffiMBOnfKrrwXFTqNOq+ffcfs9R1JD6OGhbK70GqrzEMHSyg8RoI0rqYMw5JC/tDaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jgtUknoDH3FZsXM4n8QrE86+N8BKczlf2RGSNuULytA=;
	b=vDexXBzsaTnaOo33KbqBJhBaSQJSQ9SV/4QpQMVdmZuz0hDlYFgfdAcatH7c2vvRsRil
	 F17kVPzFvBSfHzWXLLnlLD2tcbv3hi+dz0QgY1/VMHvZmUyjboQFfscc00tbZMI5AjTIK
	 Z6cmr7pmQx9JcHZnYiDxM5Baza8vwND2TYXslyucIhfl+pJzx+2aW1kke+jUSx6H4frKu
	 I65bocgfFFoEAGj2QGSDiWRRLHVDjSJj6laTNB5Mclg9co14HbDYxEFe3wSXBarnvcYAq
	 2lbEAp1zKxpX5z5Kr4LCApPL4Ud9b09o4RY1fXOYvnUQNUlbOyQsZFZCA1kJATLei1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5LHFLHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FD606A31C
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5LHFLHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799021F000CA;
	Mon, 19 Oct 2026 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444592;
	bh=jgtUknoDH3FZsXM4n8QrE86+N8BKczlf2RGSNuULytA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n5LHFLHQOLzDyBNyRcOIBkTrBCkHppS9/ygf9c0ijuND+vrQqFTEwq0cHaOD1Zotu
	 EmwTfQ5W6OcxBmkKxS+/X0561qrELHUnqAxsLFWiLYYkagHT3hqTEbolKcaoVUW26s
	 VSJuxMkqZ362B6+2iQkvGI8uNZu5oPLfr3+D4vHfM23cqJFqoN6uxUwgrcvGGIVZfe
	 SHiVn8fnmlO8vbFIvktEKeSBvtM0qWLYZ/r5+OiiTDQxq5/Ji/D2O/SU+XKuXUo0cv
	 hlBseneFG7tRO6CiP/qlhvj5yicve0N7puxDqOUCyG2b44XHbr+l6sKAvVrGR21YGC
	 TcgcOS84YYQ0Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, Manivannan
 Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
In-Reply-To: <d6becae5-df39-422b-8d2c-f15efb4ef4a5@rock-chips.com>
References: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
 <atRLsp1qUA_sGS-0@debian> <87y0bubws7.ffs@fw13>
 <d6becae5-df39-422b-8d2c-f15efb4ef4a5@rock-chips.com>
Date: Mon, 19 Oct 2026 23:16:29 +0200
Message-ID: <87se21bdci.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19 2026 at 08:25, Shawn Lin wrote:
> =E5=9C=A8 2026/10/19 =E6=98=9F=E6=9C=9F=E4=B8=80 4:04, Thomas Gleixner =
=E5=86=99=E9=81=93:
>> On Sun, Oct 18 2026 at 10:05, Manivannan Sadhasivam wrote:
>>> On Tue, Sep 29, 2026 at 02:54:58PM +0800, Shawn Lin wrote:
>>>> Leverage the interrupt redirection infrastructure to enable CPU
>>>> affinity support for the legacy INTx interrupts. The INTx virqs are
>>>> demultiplexed by the chained handler of the "legacy" interrupt, whose
>>>> affinity cannot be changed, so affinity control for the INTx virqs is
>>>> achieved by redirecting the handler to run in IRQ work context on the
>>>> target CPU.
>>>>
>>>> Mask the INTx source in .irq_pre_redirect() before the handler is
>>>> redirected: the legacy interrupt is level triggered, so an unmasked
>>>> line would keep re-firing the chained interrupt until the redirected
>>>> handler runs.
>>>>
>>>> Same approach as the DesignWare core, commit eaf290c404f7c39f2 ("PCI:
>>>> dwc: Enable MSI affinity support").
>>>>
>>>> Test was done on RK3588 EVB1 board with an NVMe with pci=3Dnomsi
>>>> parameter. The /proc/interrupts columns are trimmed for brevity.
>>>>
>>>>    # cat /proc/interrupts | grep INTx
>>>>    51:  137 0 0 0 0 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>>>>    # echo 10 > /proc/irq/51/smp_affinity
>>>>    # dd if=3D/dev/nvme0n1p1 of=3D/dev/null bs=3D1M count=3D200
>>>>    200+0 records in
>>>>    200+0 records out
>>>>    209715200 bytes (210 MB, 200 MiB) copied, 0.182021 s, 1.2 GB/s
>>>>    # cat /proc/interrupts | grep INTx
>>>>    51:  137 0 0 0 946 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> I'd like to get an Ack from Thomas for this patch since I'm not an irqc=
hip
>>> expert to decipher whether this patch is valid or not.

Yes, the patch is valid and uses the redirection mechanism correctly.

Acked-by: Thomas Gleixner <tglx@kernel.org>

