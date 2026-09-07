Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBA479872;
	Mon,  7 Sep 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795643; cv=none; b=PE1bAK7rZoW43a3V8mFGKqTRiE8LH2xGuPuUJ9i8zx/Awn4SUwh1PwuOjlyRzhornfYa0v4O0OFhz02VfIKoow1drArHLKBmb+Kq3XP1qHg28iTr8z5p2i3X5nfwL+l7dUiNIhhTBPVwDr3EYeqWkKZwrTX7ZbhF0Oy0vFc34mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795643; c=relaxed/simple;
	bh=Sx/HNDVU7WTJR5RalURss4PdH/vG92zJUgDsQSO7JpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhIyHh2qqOzsgQwx1xvbnr95zDRKnQSzNyF0WJoC6P0M8/abaqXn9WHOf/7YEHqw6cDgF+pPnFk8CvrCWG1bYTZRHhS/xHuH2ij//EuSvbj7YH1ZYa0RGahsGUltD8zM46Mc+FtIXkG+sVkitYNO6gMJsNO3q4vHYxMYBnFBkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wtzsGCtP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wtzsGCtP"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hdrr5305nz8spS;
	Mon, 07 Sep 2026 17:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788795637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYi5JP7HfZ3Zs6iqzCL0kQoLXPJOuF3USJISxOoiW/U=;
	b=wtzsGCtPw0xW3CwlO2pFVErr9LcD2GJCO21t1UkF/ALWuF6I27rvwS6f5AXHcw4F1sUAcr
	xb2XF4vNHoT1QYQ5dOGk2vpnrl2cRVMzqYUYu1q8n+Q9RAaLKFCS4VjmvuyIFMeUws4DLU
	ml7OZSkcBcb6Y0TklMDnL8Uil7sLIre7yxsnU2riVTqQkfupVSz/OJKzTKBvYm+QN3AFzs
	rxn0+HidgM1WunwJrHhCF0b4SDeY2Y7+Wm6Acsud1WDbgu/ofQB/7uZ1kD7W5uD1orjkQd
	6BMbG3TQ4aWvf89XFEOg5Fkoto7vopYpZRRHEdt/zBAjocfz5NsiKL2YByCS9Q==
Message-ID: <5712362e-661b-4c99-ac87-39c85af38f72@mailbox.org>
Date: Mon, 7 Sep 2026 17:40:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] PCI: rcar-gen4: Add missing PM ops
To: Koichiro Den <den@valinux.co.jp>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260906173234.522400-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdWLxG8xSHwTneu=xT8bxs4io7QSw7ziyPUDo6nc-zx6Qw@mail.gmail.com>
 <2wbqkglawux4ti5ldjodf2xszq73hwyxln6da62daj4dtc5xp2@fya75y7m54cp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2wbqkglawux4ti5ldjodf2xszq73hwyxln6da62daj4dtc5xp2@fya75y7m54cp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dp1fm7a4o4y6rc89amqc7ceusqit7563
X-MBO-RS-ID: d1e0c79e28b31d7f968

On 9/7/26 3:46 PM, Koichiro Den wrote:

Hello Den-san,

> I have reproduced the NULL pointer dereference at pci->pp.ops->deinit on R-Car
> S4 Spider in EP mode with CONFIG_PCIE_DW_HOST=y.
> 
> (I used next-20260904 with this patch and the following fix applied:
>   "buffer: fix NULL dereference of bh->b_folio in __bh_submit()")

[...]

>      [drivers/pci/controller/dwc/pcie-designware-host.c]
>      1225 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>      1226 {
>      ...
>      1286         pci->pp.skip_pwrctrl_off = pme_capable;
>      1287         dw_pcie_stop_link(pci);
>    > 1288         if (pci->pp.ops->deinit)
>      1289                 pci->pp.ops->deinit(&pci->pp);
>      1290

Thank you for your help with the endpoint part.

The fix turns out to be very simple -- the suspend/resume handling is 
specific to the PCIe controller in RC mode, so I added a conditional to 
invoke those host (RC) suspend/resume operations only if the controller 
is in that mode, and I sent a V2.

This RC-only fix in V2 is also in line with what MX6 and DRA7xx PCIe 
controllers do.

-- 
Best regards,
Marek Vasut
