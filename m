Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941784A0EFB;
	Tue,  8 Sep 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903721; cv=none; b=huYY3oVWOTO0IgNJBzpRg9XREfpzCvfPAjhZX1IP+6OJnfCa1QN7tgxQGuJd44bD2XVhebAUPppIzYf7kpuvNb7EnsVFj/gfsUfPFNMFSpgLn76WYvor3L2AVQ8v6NzlxVoBfVNqBOOfhNDCXipbOYvzqVqJx4BrpoNeIcm3bV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903721; c=relaxed/simple;
	bh=4dNan55tob2LOF4ICRiPwaJKoCoLQny5O3PU+Yv8Qvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8i1pnP+xF1ehMqn1tLkGscV4pRj+SbpYpJErmNr4ESE9//1Zc7j7hVFtGPd5Ct4uRRtlDUxL5gnVEevCi/EuAx3Z62nZPqz1OkwIhQaObKeQNtm6CmIXmQq5JQL9up4c9azN4/6g5egX1TRufFbLaNbAtYBzfM8xrlSc2C4dAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c8hh8DVj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c8hh8DVj"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hfcfk28JFz8tb0;
	Tue, 08 Sep 2026 23:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788903310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPRewbRjUY6AxemfQFvb3JMr40Wk83tULzwCS3eA65Y=;
	b=c8hh8DVjXTUksj1nzMqKlJitW8Q1dBKDcSsIw3R0irgSq55BYQ+2/NVplJe53H+4zS+e+/
	Oahmeq3IunayEHEOJHIbOmrOYyfgYlrn41FLU66Bm5ZZXEw1PUUuLEax2JmrdBq1HJC+ZI
	I0NdMYWuScdFyllvRDoAVahns4l4uVmGb7QfUk3upZNSNS0+q36ziaTEVBkXkn9YPUE0fH
	dpY7fRfXx4synD74tDIiMe497sPOyagpgjYwhcGgjAx17D4F4PxVMtVPJRIkd3GfocW2Tf
	7HaKb0LoVQrFtMoXBdUEXKobqB+fA99DHsFA9Zca3eU0U0nNkhMv4usfp+wusQ==
Message-ID: <de8e26a0-cd05-4448-8392-0fb3953e7d3f@mailbox.org>
Date: Tue, 8 Sep 2026 18:29:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
 <74il3j2dzfdt4xhqrfjkifhnpnmgqtplon2mtzfjzkbszwegi7@vou6a5rshcvr>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <74il3j2dzfdt4xhqrfjkifhnpnmgqtplon2mtzfjzkbszwegi7@vou6a5rshcvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: br9gyjqousy31kxahj56zaqan7ipmphb
X-MBO-RS-ID: 8d8dffee87eec16168b

Hello Den-san,

On 9/8/26 3:05 AM, Koichiro Den wrote:
> On Mon, Sep 07, 2026 at 06:35:22PM +0200, Marek Vasut wrote:
>> The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
>> and V4H, this is an always-on power domain which is not shut down in
>> suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
>> which is shut down during suspend, and the controller loses state,
>> which prevents the PCIe from working after resume.
>>
>> Fix this by adding generic suspend/resume noirq ops for the controller,
>> which tear the link down on suspend, and restart it on resume. Use the
>> same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
>> PCIe link on V4H and S4 too.
>>
>> Test case which demonstrates the problem on R-Car V4M:
>> "
>> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
>> $ echo s2idle > /sys/power/mem_sleep
>> $ echo platform > /sys/power/pm_test
>> $ echo mem > /sys/power/state
>> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
>> $ diff -Naru /tmp/pre /tmp/post
>> ...
>> -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
>> +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
>>                                            ^^^^^
>>                                      Class 0604->00ff
>> "
>>
>> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
> 
> The s2idle test with pm_test=platform now passes in EP mode on S4 Spider even
> with CONFIG_PCIE_DW_HOST=y. Thanks! Feel free to use the tag for it if it helps.
> 
> Tested-by: Koichiro Den <den@valinux.co.jp>
Thank you for your test. I would like to ask -- is the EP side of PCIe 
link behaving correctly during suspend/resume cycle on your S4 setup ? 
Does the EP require any special handling during suspend/resume ?

Thank you for your help !

-- 
Best regards,
Marek Vasut
