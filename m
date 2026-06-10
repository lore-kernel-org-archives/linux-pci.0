Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2033F385;
	Wed, 10 Jun 2026 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056226; cv=none; b=IT20jUlnZAeNKXIS3f3zTBhbmCPIs10y/tr0JOdSqTmpZXQkq8qIqvs2W3cmfJksg22rexB3PS01gfMZ94NVVFNKAAZ688TTGQdM3YWkWzxAz2Ms8mTVklB+77WP0umEGNjodP1Dqz8USdeny98K0i3O+Sdw8WdiacbEPNcqzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056226; c=relaxed/simple;
	bh=mNjXD28zjC6Y/Z85yt1dwDqDncq/qNvF1NOMrFc/jAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFa4gTHjVo+FCnFGmRLoP6Ww2F30DIXEIxkJL03oHHnYdypBr0kVZpms4mr6k6uzFa580cBcPJf/MPrA91I9wYPwQeFT/rFHwirrNuxt07WpcDVb16P/LlMA6khj59iCyIMvPAGHKbuwPrOCIg9HNErB+o4b3ZzCqswKQXDsa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=JB6W+tly; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="JB6W+tly"
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D756E20125;
	Wed, 10 Jun 2026 01:50:13 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 4C76F3E877;
	Wed, 10 Jun 2026 01:50:06 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 0B28F400D5;
	Wed, 10 Jun 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1781056205; bh=mNjXD28zjC6Y/Z85yt1dwDqDncq/qNvF1NOMrFc/jAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JB6W+tly3isn/nmSr7D3xcxmsawzmZwXxI/a6q6QlkIRVe+NOn0ZMfk4lQ3SZ/0Dq
	 CitvcpqfdwkxvWIFD8+J3j78n/bjyKJaXuc8HQXlondr4Jn8VWo+niy44XYLNZCMsb
	 i7aJY5obBcDGx4xJc03T8YdSdBDBD5uLWVE3DdZo=
Received: from [127.0.0.1] (unknown [31.223.184.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3948D40B31;
	Wed, 10 Jun 2026 01:49:59 +0000 (UTC)
Message-ID: <9119f9b0-4ddf-4b99-b602-a1b1df24721d@aosc.io>
Date: Wed, 10 Jun 2026 09:49:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: loongson: Avoid L0s on LS7A1000 PCIe x8 [0014:7a29]
 Root Ports rev2
To: Xi Ruoyao <xry111@xry111.site>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Henry Chen <chenx97@aosc.io>,
 Han Gao <gaohan@iscas.ac.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kexy Biscuit <kexybiscuit@aosc.io>
References: <20260609152511.753760-1-xry111@xry111.site>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20260609152511.753760-1-xry111@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 0B28F400D5
X-Spamd-Result: default: False [-0.30 / 10.00];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	R_SPF_ALLOW(-0.10)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Action: no action

Hi Ruoyao,

在 2026/6/9 23:25, Xi Ruoyao 写道:
> Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
> server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
> board using the same 7A1000 bridge chip exhibiting the same issue with
> pcie_aspm=force and pcie_aspm.policy=powersave (ASPM is not enabled by
> default on the 3A5000 board because it's based on ACPI and the _OSC
> method has not been implemented in its DSDT/SSDT yet).
> 
> This seems only affecting the 7A1000 chips shipping the revision 2 of
> the PCIe x8 Root Port: on other two boards with a (persumably older)
> LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> issue does not reproduce.
Tested good on a Lemote A1906 (dual Loongson 3B4000), which failed to 
boot with an Intel 750 with kernel versions >= 6.18.0.

Tested-by: Mingcong Bai <jeffbai@aosc.io>

Best Regards,
Mingcong Bai
