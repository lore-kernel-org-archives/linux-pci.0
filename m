Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745D3D3CF4;
	Sat, 17 Oct 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258414; cv=none; b=eu1ujhcvRWV7EEbSqEXNU0JIiGUtqtIHNwcIltQzbPmeJt47I8HlbfK3YVzTh2kpXp2YaZdL7eijfIgx3kSUu4LkR9kOvcPck6ihQrDyPK5do33p8x6bH2UoBFB09jW1exZon68wVuRF1SX3dI/QAunGpmbFqqtgLsF0oZQR0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258414; c=relaxed/simple;
	bh=xwK5rsbQJK7zVeRm428C0VAoKG2nMoZfNSxPA9GrYCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIyfRZUnhHGEaOV03phQgIbcboWMk2veOH8CwU7tpT9Bjc8sRyq1P8yeImR7UMOf3dzl5hpFVwRzEwCgBFrXAhMcV1QDiqDQHQFabY8KBvA4oLoZw/lodFoJ3Tjmz5RiBJ0c6fbOUB2aTGZluLm01/EZFwkVPgNrNNk3V87XyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ls063EPI; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ls063EPI"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6TRs1ytwz8vSk;
	Sat, 17 Oct 2026 19:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOGFnTQ9/fqrY8zHMo3kI5mXZs4lnB9a7vgIihcNr4w=;
	b=Ls063EPI1Ai/QHJz8SWLs4ClOt6tACnc+69Xmx2Bk9vjZ/+uX1eCrc0MUTY4x9gyRRdUv2
	wEIXO6CdEz6sJjLMNeC4CnPYXa+nVhHH+y/o3j+TgZUCeNBz98LxZH5EPZm8XXh9oiqiWq
	zn2w2z6EcKpkvjT0+UGdDApNfq0P/FfAw6TxWbiAK/k4IXIPQdofA1JBUSOl993YcGdB6e
	NKIzEetUeKCpG4UzZU+r3+5n/qLxaAG6ldJ2JXwr92Tl0YvW711Tx/7MY9GEJOunVemfTu
	RkgaQ2W1dJsJFtArkhBO7wfVv1PU30TFiDU4ybguMTCBmEQpZOntluGV7BGbiw==
Message-ID: <ab2bed29-4988-4dd4-9f84-fd489e7a8233@mailbox.org>
Date: Sat, 17 Oct 2026 15:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/18] PCI: rcar-gen4: Recover the Root Port on link
 down
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-13-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-13-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 17d7e4460383189a354
X-MBO-RS-META: jb9mre6f8xdjnqzye8iepmrf85mahf31

On 10/15/26 5:30 AM, Koichiro Den wrote:
> On R-Car, the controller's reset requests (smlh_req_rst_not,
> link_req_rst_not) arrive on intreq_pcim_sub, the interrupt the MSIs are
> demultiplexed from, so DBI is read as soon as the link goes down. On
> R-Car S4 that is a hazard: DBI accesses issued within a few hundred
> microseconds of an unexpected link down do not complete and hang the
> host. In testing, the first Root Port config read after powering off
> the link partner hung unless delayed by ~300 us.
> 
> Check the APP reset status in the interrupt handler before DBI is
> touched. When a reset request is latched, flag the controller as
> needing reinitialization, which masks the sources, ack the request and
> schedule recovery work. The work calls pci_host_handle_link_down() on
> the Root Port, which runs the AER-style recovery and resets the
> controller through reset_root_port(), holding a reference on the port.
> If the Root Port is absent when the work runs, reset the controller
> directly so that successful reinitialization can restore interrupt
> delivery. Hold the rescan lock across the absence check and reset.
> The APP reset-status check also reports a recovery already pending,
> whether started by another interrupt or left over from a failed reset,
> so the handler issues no further DBI accesses until a reset succeeds.
> 
> Arm detection after initial PCI enumeration, so recovery does not
> interrupt device discovery or resource assignment. Only unmasked status
> bits are handled and pending latches are cleared when the sources are
> re-enabled, so requests recorded during probe or the reset itself do
> not trigger another recovery. Teardown only disarms the detection: MSI
> delivery has to keep working while devices are removed.
> 
> Run recovery on a freezable workqueue to keep it outside device
> suspend/resume. Reject suspend while a reset request is pending,
> including one latched after the parent IRQs were suspended.
> dw_pcie_suspend_noirq() would otherwise access DBI, and the queued
> recovery can run once the system thaws. Disarm Root Port events during
> suspend and re-arm them in .post_init() after resume has set up the
> link, so taking the link down for suspend does not start recovery.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
