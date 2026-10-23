Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792175;
	b=3742bi1Y+Av91WmAFUxjl7ZTmVwHTOKWYBNsFhZ6AYpGVkTpRDXwRzzGOeMNnMNXdIut
	 Nqjio8pjEX3eufI4cgdHhwir/Z6Mip5zicW+gqtCh5ZWCoUx+3CREJeU4oNrShp0ThFaR
	 5uWSDtWVIVBEVHO7Pu/V9FCeKn8zLD4xQVJCw9mZCvywWdn1MFwwyXUZUmC9bZx0xN7YM
	 hkgUOufSc62MKasQEVQ0WMcRn1QJaiH0U6/SaGuQPgdzaasav7MxS6msXJbfdgUP3l4F6
	 jqB1uUTg/IR2PdRn39LXTFtaiASyr0Ww2Kgm+akMSxYETqseBFwbbG3kYXywLezSmYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792175;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-MBO-RS-META:X-MBO-RS-ID;
	bh=5KngpcXed5aWBUdjFIqV7E8rIgpXpvuiuzoRT5KhofE=;
	b=s0VtRgU0cKW5RvRkrbbdaUAsk5JrybMRc82v9Dx0ggaxJY3jnkfzlO1Lnzg6/QUmtMLq
	 VnxRiTxYX3ovCTch2NyswdHUb0HRhrr9K/4JqzXhB/8V0tY6h6R39uNhHjuGCCyEJbhJ0
	 nSaW00YkxDVBcISnMdh8DgluGEJHUPYYMnLPMHbUMvQqIFvoViPumzn8lOKF0a7KAKbtw
	 uRlkANmrTHZyYeOyr///wSxhpfzHOyg8mMNtV/8zkxz0OKx/WZREMEys/ptt45mHyQIQ5
	 Dc84k4x2F2G3vXSJEU1e0S1sl7ImyJfC+LZTs6tKRxBWmk+V26uG7qp3+O7ZuGhOlTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZKgLhUkK;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9C606A31A;
	Fri, 23 Oct 2026 21:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F9C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZKgLhUkK
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jBGrP1py6zKnC5;
	Fri, 23 Oct 2026 23:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792792165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KngpcXed5aWBUdjFIqV7E8rIgpXpvuiuzoRT5KhofE=;
	b=ZKgLhUkK0tUytJ5rp2+efBcSBuJdz8hZEcwy6g0CcEF5qm+xmBXuowDRePdy9lXUUHDqjx
	cKHAH6N9t7eHpSSkAAocdF3VLe5A5SNl8CuhXsHpn3BLVhEaFiti1u45AGVlrnNJtsnaun
	DEJMryrjqReX0BXgalcKpKRcLFH4GEx1DZ5PFe5L5B+Mx6VyU6XoaVx08YxLaKvARpviHc
	UCDhFihU9tmbHTeb636XBF04Mi74L4odx2ERtohuxWuAI/fjoGER+DxdJ4UGcYzwZ6K9k+
	rt9iBL9aEUvQ+xY2hHbloz276W9SVp9IK/u4d35yybJqPnSO+MEXXQAu31cBgQ==
Date: Fri, 23 Oct 2026 23:49:22 +0200
From: Anthony Ruhier <aruhier@mailbox.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to
 allow ASPM L1.2
Message-ID: <atvQtV71SbtMK-jZ@tour-anthony.aruhier.fr>
References: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
 <20261023182004.GA2796729@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023182004.GA2796729@bhelgaas>
X-MBO-RS-META: kzzqfshna54sztenunnd8hrztg58hpcb
X-MBO-RS-ID: f1e945c354401962b32

On Fri, Oct 23, 2026 at 01:20:04PM -0500, Bjorn Helgaas wrote:
> By "firmware reports LTR value", do you mean that the WCN7850 sends an
> LTR Message with snooped/non-snooped values just below
> LTR_L1.2_THRESHOLD?
>
> And since the reported LTR values are never greater than or equal to
> LTR_L1.2_THRESHOLD, the link never enters L1.2?

Not exactly. The firmware doesn't report a max snoop/no snoop that I could see
in lspci (it's set at 0ns), but if I set one with setpci, the card still
doesn't reach L1.2.
However, if I lower after boot the t-power-on-us of the pcie port by 10탎, the
card goes to L1.2.

I suspect that the firmware dynamically sets an internal threshold from the
reported LTR_L1.2_THRESHOLD because lowering the t-power-on-us in the
devicetree by 10탎 doesn't mitigate the problem. Doing this seems to shift the
internal threshold to 10탎 lower, because lowering the t-power-on-us by anoter
10탎 is still needed.

> If so that sounds like a clue that the firmware went to some lengths
> to prevent L1.2 from being used, which is "interesting."

By disassembling the firmware with an LLM, I discovered that when wake-on-lan
is active, it stops this behavior so that the card can go to L1.2. But I
couldn't find anything else of why it would do this.

So I don't know why the firmware tries to prevent L1.2 when LTR is set,
considering that Windows runs the card fine with L1.2, and this is a Windows on
ARM laptop. I haven't seen any degradation of performance or packet loss in
Linux with L1.2 enabled.

> I don't think we can guarantee that the PCI core ASPM support will
> leave LTR disabled.  I don't see anything there that looks like "leave
> PCI_EXP_DEVCTL2_LTR_EN unchanged."

I don't understand this, can you clarify what you mean and what you would like
me to change?

Thanks,
--
Anthony Ruhier
