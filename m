Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D6511183;
	Mon,  7 Sep 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799040; cv=none; b=mZtwD/78VufS6HsdgPFdRUyf15dOjaYgl9RbMSppAbZVSBcO3qythEVd9Kr1SydXHm1WcNTfBKqmjOTXQVTNKZhqsmdKyYpf2WHVHlwfGOnjVPNQ4Tcu5xhzAJJg0RRWePBdXK193nvQex90MmvxvmcvqZeYMJT1W3iuVy7mnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799040; c=relaxed/simple;
	bh=UJz0BMlueFcTLCBsx7BKtzx+n057uHd6hR5eA/JqBpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OexpKTyY3ModGbWU1OeBUB5Zque7oOT21TdglOEnFBghL343PjEnshwqNiL8ujjpIdeYDuW8Ro2CWoA54WsKLVnXx0VHtXvNdD31it/iiTFLu4TLc1GAS0t4Bn9fQOzCg781AAKWyP2ngJpTPPH8ySUcIpRrFrdvGMz0gNj9Gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MP9pjKvl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MP9pjKvl"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hdt5Q5TtkzMlBb;
	Mon, 07 Sep 2026 18:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788799034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAzas1ZOf+kzfSEIHtAh3M5ujl/9RpSQV1bU7cg15SQ=;
	b=MP9pjKvlA+kGKsbT309k+18uSyCkawdURcPuxp94TaGbtLbB5hjs2M7SQydoP02CHYYvOj
	Nuo98TcmUC84SNXEssWvQhHd2PrmY+tKC/IieeJU4I+bq0S1je4Yfzqo3m5JgUo9PgBSZE
	pR0OBLho6UudGlPkiAFmT62tKc7n8Z0PpSp6TcYAWVRtt91O8hTyvlJ0CHe2DlZaeqkkmB
	VwE8q/VqLp/Cj7nqvjCw/n2Lg22YwMWcSvBOrndz5zdCaMNGpSq00T8vT7Vogi/ZpHsC+1
	E335Or0EjjKEinc3DibsCDarNeL2k1DBoyiqlHVzczGJOGkJtAhOaXh3n5akEg==
Message-ID: <e64a81ac-0038-4123-9c6b-b020dd299bf2@mailbox.org>
Date: Mon, 7 Sep 2026 14:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] PCI: rcar-gen4: Add missing PM ops
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Koichiro Den <den@valinux.co.jp>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260906173234.522400-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdWLxG8xSHwTneu=xT8bxs4io7QSw7ziyPUDo6nc-zx6Qw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdWLxG8xSHwTneu=xT8bxs4io7QSw7ziyPUDo6nc-zx6Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5r3wza39xtgdtbfckwoqagrookw1eq6r
X-MBO-RS-ID: a82e1a47e34e135aa08

On 9/7/26 12:26 PM, Geert Uytterhoeven wrote:

Hello Geert,

> On Sun, 6 Sept 2026 at 19:32, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
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
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks, the output of "lspci -v" is now the same before and after
> s2idle.
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I don't have a setup for endpoint mode, so I could not verify or refute
> Sashiko's claim that suspend will crash in endpoint mode.

Same here (thus far).

>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
>> @@ -952,10 +968,14 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
>>
>> +DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
>> +                       rcar_gen4_pcie_suspend_noirq, rcar_gen4_pcie_resume_noirq);
>> +
>>   static struct platform_driver rcar_gen4_pcie_driver = {
>>          .driver = {
>>                  .name = "pcie-rcar-gen4",
>>                  .of_match_table = rcar_gen4_pcie_of_match,
>> +               .pm = &rcar_gen4_pcie_pm_ops,
> 
> pm_sleep_ptr(&rcar_gen4_pcie_pm_ops)
Will do in V2.
