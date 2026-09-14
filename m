Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA70348C77;
	Mon, 14 Sep 2026 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386711; cv=none; b=vEfbMHmBnNIFH+IGetxIkotTa29pjh2yc65NLsOrXTp5DMJ9gf5/wkhs+Jv/NO0BoXUNaddbIk2OuQ0nMxnduKCo5bdRnDQP9B738B8+HKwmtPUfq651MJCJXsBYQ00Ja/RCMlOnCnVlVxFCHs9EVCbB249LPmp20c4MewJk89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386711; c=relaxed/simple;
	bh=LK9oiszB9E+gFbWwOkvJKEyq1iH2IEtWQQ7QCmi7isc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Tm++qMesUFCzjGtacomq+/Uqdg0ovAG/Lz9TSCb9w4jjBch46QgWI6VijF8QlTm7QcNXpILUyN7fP74A5wDRNGVZwOh/tgD74IV+KmKROq5VsiHdJ7gog8IGa18r8IL5ZLVEonGU7a/AKJzLdPklxhpXN/cUy04RZdi5idogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV5v/s6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV5v/s6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0111F000FF;
	Mon, 14 Sep 2026 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386709;
	bh=R7+L0DS/i+DsiPCK294YRFFlGBSviuyUaFNf79SZZmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BV5v/s6Ovk+D6wQt7lAW7VvxwNapnxy859ARewOJYGvT9LiLkWeHTRW84L70HS3/+
	 Ud1hn+k70Sl4tlLJU6I19fmutJ5k7vTedG/uqVYCjh3apn2B0ecJ5rpNowrtWAd/+o
	 4L5DY/CVobpsOtdB4nLm8SXKhsGePL41l0oT5UxbjpsjNGs3SmyE1SsHMM3DaKOcmi
	 fclMqI/Se2BSNQyLFNG73xUiYjk/jDXHuM/E3Ucx5CmfjK+rowZgWFBpyFjOzCltnc
	 4QjDuA2+ypUTgEaVSZ+lXwEpA7c33gM50dQKMr7Z9Vzq4VLePiDlGlr3YMoPN20GqZ
	 mFqqk5iimPBcg==
Date: Mon, 14 Sep 2026 13:51:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <aqff0CqBIDeMMTke@ryzen>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
 <apXdm2I33edo8kpZ@ryzen>
 <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>
 <apfPWc09CY2o-P5s@ryzen>
 <zxyr55h6s3tjc6pe23wzwb77dxppsljxcagpqhp4u24cqka2ne@fesick6sneto>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zxyr55h6s3tjc6pe23wzwb77dxppsljxcagpqhp4u24cqka2ne@fesick6sneto>

Hello Koichiro,

On Thu, Sep 03, 2026 at 04:56:18PM +0900, Koichiro Den wrote:
> > 
> > Please share your branch. I should have time to do a quick test.

I did test your patches using pci-epf-test.

EP side:

[  105.770736] using HW-defined MSI-X layout!
[  105.770763] MSI-X table BAR: 4 offset: 0x4000 size: 0x1000
[  105.770777] MSI-X PBA BAR: 4 offset: 0x5000 size: 0x1000
[  113.634512] raising MSI-X doorbell for irq: 1 msg_data: 0
[  114.650505] raising MSI-X doorbell for irq: 2 msg_data: 1
[  114.658509] raising MSI-X doorbell for irq: 3 msg_data: 2
[  114.666499] raising MSI-X doorbell for irq: 4 msg_data: 3
[  114.674508] raising MSI-X doorbell for irq: 5 msg_data: 4
[  114.682498] raising MSI-X doorbell for irq: 6 msg_data: 5
[  114.690508] raising MSI-X doorbell for irq: 7 msg_data: 6
[  114.698500] raising MSI-X doorbell for irq: 8 msg_data: 7
[  114.706508] raising MSI-X doorbell for irq: 9 msg_data: 8
[  114.714500] raising MSI-X doorbell for irq: 10 msg_data: 9
[  114.722508] raising MSI-X doorbell for irq: 11 msg_data: 10
[  114.730500] raising MSI-X doorbell for irq: 12 msg_data: 11
[  114.738511] raising MSI-X doorbell for irq: 13 msg_data: 12
[  114.746498] raising MSI-X doorbell for irq: 14 msg_data: 13
[  114.754509] raising MSI-X doorbell for irq: 15 msg_data: 14
[  114.762499] raising MSI-X doorbell for irq: 16 msg_data: 15
[  114.770509] raising MSI-X doorbell for irq: 17 msg_data: 16
[  114.778500] raising MSI-X doorbell for irq: 18 msg_data: 17
[  114.786508] raising MSI-X doorbell for irq: 19 msg_data: 18
[  114.794501] raising MSI-X doorbell for irq: 20 msg_data: 19
[  114.802507] raising MSI-X doorbell for irq: 21 msg_data: 20
[  114.810500] raising MSI-X doorbell for irq: 22 msg_data: 21
[  114.818509] raising MSI-X doorbell for irq: 23 msg_data: 22
[  114.826502] raising MSI-X doorbell for irq: 24 msg_data: 23
[  114.834509] raising MSI-X doorbell for irq: 25 msg_data: 24
[  114.842502] raising MSI-X doorbell for irq: 26 msg_data: 25
[  114.850509] raising MSI-X doorbell for irq: 27 msg_data: 26
[  114.858499] raising MSI-X doorbell for irq: 28 msg_data: 27
[  114.866510] raising MSI-X doorbell for irq: 29 msg_data: 28
[  114.874500] raising MSI-X doorbell for irq: 30 msg_data: 29
[  114.882510] raising MSI-X doorbell for irq: 31 msg_data: 30
[  114.890500] raising MSI-X doorbell for irq: 32 msg_data: 31


Host side:

#  RUN           pci_ep_basic.MSIX_TEST ...
MSI-X1 returned -110
# pci_endpoint_test.c:168:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:168:MSIX_TEST:Test failed for MSI-X1
MSI-X2 returned 0
MSI-X3 returned 0
MSI-X4 returned 0
MSI-X5 returned 0
MSI-X6 returned 0
MSI-X7 returned 0
MSI-X8 returned 0
MSI-X9 returned 0
MSI-X10 returned 0
MSI-X11 returned 0
MSI-X12 returned 0
MSI-X13 returned 0
MSI-X14 returned 0
MSI-X15 returned 0
MSI-X16 returned 0
MSI-X17 returned 0
MSI-X18 returned 0
MSI-X19 returned 0
MSI-X20 returned 0
MSI-X21 returned 0
MSI-X22 returned 0
MSI-X23 returned 0
MSI-X24 returned 0
MSI-X25 returned 0
MSI-X26 returned 0
MSI-X27 returned 0
MSI-X28 returned 0
MSI-X29 returned 0
MSI-X30 returned 0
MSI-X31 returned 0
MSI-X32 returned 0
MSI-X33 returned -22
#      SKIP      MSI-X33 is disabled
#            OK  pci_ep_basic.MSIX_TEST
ok 16 pci_ep_basic.MSIX_TEST # SKIP MSI-X33 is disabled


There seems to be a bug that "pci_ep_basic.MSIX_TEST"
returns status ok, even though MSI-X1 returned -110 (ETIMEDOUT).

If you don't look closely enough, it is easy to miss the
"MSI-X1 returned -110"
and only see:
ok 16 pci_ep_basic.MSIX_TEST


Perhaps this is what I missed when I was doing the same conversion as you some
time ago.

Anyway, I do see the same problem as you. For some reason IRQ 1 is not working,
but all other IRQs are working.

Unfortunately I don't have any ideas.
MSIX_DOORBELL_VECTOR is 10:0 so msg_data can have value 0-2047.
Thus, it looks correct that dw_pcie_ep_raise_msix_irq_doorbell()
sets msg_data =  (interrupt_num - 1);

FWIW, I think you should send out patch 1/7 as a standalone patch, so that
it can be picked up ASAP.


Kind regards,
Niklas
