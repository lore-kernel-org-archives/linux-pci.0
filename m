Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7C26E71E;
	Tue,  7 Jul 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414550; cv=none; b=gcWXZ4qJS2F16PxTsfSp/RQQizVSPVLz077c6Sxt2YmMDLfOfNcktA1P5+Gj2BWI8Cwq4A4Zm8DR2lHwQOuJfk2dxTVIVmdJ7QvA8+7hT26pevVoVynjQZLtU+hADPd47XODC3sKg8aIJgEqXsp7YUl3Cv1I9Ji4esnL2MUtC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414550; c=relaxed/simple;
	bh=t241H8Fby9gUNN/o/dRLXYZIif/dvFrYf81DZTQeehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s58cLxza3beBYaiWirGj6eWNRMtY/ow2l6E3YHyyHW8nfGeaeH32TjY9iGBe8BsUNOEEIghY2QQOScO1EyboR73z8KBApfDM26jid96ywCx5rm9S0OkapZoK/4B6ZmrBo4KoxPBxs+oFnX7wAug2hydN6FY5ZKaWMnriqyAs9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=waoyR/9B; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="waoyR/9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783414541; x=1784019341; i=smoch@web.de;
	bh=vd+nnRMHyGsU3KmgANxpwezMHUP8vXgFVUmNLtg6kDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=waoyR/9BKgvyEUHWgVVd5AwiI58aR0OYANJ8kXyIMWe1H+iqg6kDMXjXcaWp5jZA
	 1SuwIx6HUWC4kJ9/H0Cn+2bFb/FX45vEJY8vRyZTOiaszqlNgZRA5luDOrn3POWlz
	 9gs19Q6y2Ra75B/HM6gEEU1/Q48bv9Fu4ps5A/j+DvPzizM9Noa7SRLHGFIK473nw
	 2A71eenXa6NOY0HV45UP6larIDJk9KR8TtdODoSAWx2f2LudTFBP1e5xGLsHFhoyc
	 yasL/IbCH93BiW8iK0nfJtl69feQ/JDH+EAJdpj7R06SHM1XD8ezpchHeQMJSXKAJ
	 HN9aoo1ThjMqniCwlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1wMBLk3Y3Y-00OBJU; Tue, 07
 Jul 2026 10:55:40 +0200
Message-ID: <4836b6f1-d40d-479d-acf7-a67769e0c8ac@web.de>
Date: Tue, 7 Jul 2026 10:55:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>,
 Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
 <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hongxing Zhu <hongxing.zhu@nxp.com>
References: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
 <a42a7e16-1798-4db5-9f03-ba608a700645@web.de>
 <GV2PR04MB120197631BE612B526EAA33068CF02@GV2PR04MB12019.eurprd04.prod.outlook.com>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <GV2PR04MB120197631BE612B526EAA33068CF02@GV2PR04MB12019.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nmcnLEXO7GY/phT0DGDwKsg0Ynvc1CL90x/cdqQM0zVS/Ajv2mK
 XO6/YZYp/HPwYlQr+vLHoESgFn1faIlNLmADmBeLOYPSNUpfIdEme2IipbjbC79QKeqg+F/
 kmiwkcihyWoWZdnjY/6436bClOvyQigduW93r5VSpRIuAi3Z4vG5GPDOfI4xtY2rtQSQQjC
 tfHcymhkvISuo6tov/O2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TEuXNA2cO1g=;upVu3S0O19GWhkoG7RuzMoMuwKy
 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
 bx4btmaD0=

On 07.07.26 05:03, Hongxing Zhu (OSS) wrote:
>> -----Original Message-----
>> From: Soeren Moch <smoch@web.de>
>> Sent: Monday, July 6, 2026 10:09 PM
>> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>; Frank Li
>> <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
>> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
>> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com
>> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> imx@lists.linux.dev; linux-kernel@vger.kernel.org; Hongxing Zhu
>> <hongxing.zhu@nxp.com>
>> Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separatin=
g PHY
>> power and reference clock control
>>
>>
>>
>> On 06.07.26 05:06, hongxing.zhu@oss.nxp.com wrote:
>>> From: Richard Zhu <hongxing.zhu@nxp.com>
>>>
>>> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
>>> regulators") introduced a boot hang on i.MX6Q/DL variants by changing
>>> the initialization sequence.
>>>
>>> The issue stems from coupling PHY power (TEST_PD) and reference clock
>>> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
>>> managed together, the timing between PHY power-up and reference clock
>>> enablement cannot be properly controlled, leading to initialization
>>> failures.
>>>
>>> Fix this by separating the two concerns:
>>>
>>> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
>>>     logically belongs with reset operations. This ensures PHY power st=
ate
>>>     is managed as part of the core reset sequence.
>>>
>>> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>>>     shared PHY power management, avoiding code duplication.
>>>
>>> - Make imx6q_pcie_enable_ref_clk() responsible only for reference cloc=
k
>>>     (REF_CLK_EN) control, simplifying its purpose.
>>>
>>> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
>>>     proper sequencing is now handled by the core_reset functions.
>>>
>>> This refactoring ensures PHY power is controlled during reset
>>> operations, fixing the boot hang while improving code maintainability.
>>>
>>> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
>>> regulators")
>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>> With this patch on top of v7.2-rc2 I see everything booting, lspci show=
s the
>> root complex, but no PCIe device behind it.
>> Tested on a i.MX6Q based tbs2910 board.
>>
>> For me it is not clear whether this fail to detect PCIe devices is rela=
ted to the
>> patches in question, the reset timing, or something else. Needs further
>> investigation.
> Thanks for your kindly help to tests.
> Did you ever encounter the boot failure without this patch based on v7.2=
-rc1
> or later?
Have not tested this. Unfortunately currently I have no access to my=20
tbs2910 test board.
I used a production system for this test here, but this is very=20
difficult to recover
from boot hangs.
>
> After applied this patch, my i.MX6Q Sabresd board can boot up successful=
ly.
> And the endpoint device can be detected as well.
>
> My Local commits:
> ad5939d49b268 (HEAD -> v7.2-rc2_pcie) PCI: imx6: Add runtime PM support =
for i.MX95
> db7b15f198125 PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3 sta=
bility
> a26735515c076 PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY power=
 and reference clock control
> d617eadf52a46 PCI: dwc: Add force_l2 flag for platforms requiring L2 ent=
ry without D3cold
> 8cdeaa50eae8d (tag: v7.2-rc2) Linux 7.2-rc2

My commits (v7.2-rc2 plus my patch to enable MSIs for the endpoint plus=20
this patch discussed here):
8cdeaa50eae8 Linux 7.2-rc2
b62414d07e24 PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
e8176c6a27ed PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY power=20
and reference clock control

I'm not sure what your other mentioned patches are.
>
> Kernel logs:
> Starting kernel ...
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 7.2.0-rc2-00004-gad5939d49b26 (nxa08258@shl=
inux89) (arm-poky-linux-gnueabi-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.=
45.0.20250908) #38 SMP Tue Jul  7 02:36:46 UTC 2026
> ...
> root@imx6qpdlsolox:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Co=
nnection
on linux-7.2-rc2 plus patches (see above):
root@matrix2:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)

on linux-7.0 (not tested on 7.1):
root@matrix2:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 Multimedia controller: Philips Semiconductors SAA7160 (rev 02)

I guess the new power-on/reset timing is not sufficient to init the=20
endpoint in time.
Did you reduce the time from powering up the PCIe slot to release of PERST=
#?
There is a power switch on the tbs2910 board for the PCIe slot, not sure i=
f
this is available also on SabreSD.

Best regards,
Soeren
> Best Regards
> Richard Zhu
>> Regards,
>> Soeren
