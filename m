Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A9233924;
	Tue,  7 Jul 2026 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422266; cv=none; b=T+hbrgrJJ+LTp1PidDwRfF77NmWafO9O/wfiPh5Q0r9/r4UOyXzEMuS0+ZJIUd3JhC7uwn/jFIPCoun5psrnrZvhU/CLrhM/DMit1Ra6kBhYM4ZpV+83TLp/ScV0eGRaopD4KtG2aHHuQ2jgSM5F//wD7s3h9rUxWqVByPQKyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422266; c=relaxed/simple;
	bh=3PIqo57EQNiBHwnGjeGrKifTmx0XH4Xy/8evjz9ZSTM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PCPwmgeXnCImUzy1UuCZ+rWCXvhnTO1xjSuVdksRY3/AwotNftgV21wGAXArqVLDnz4qFXkAaHQN6L+rbm7RYCFJWcdzKwOEleVoEDNUkQY9ryhIRFEl40Y8WUOvKpCCSTlqEYZu+oZCDOBv56tWff1Cf4O3OgJFGfh6w1/IQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=Vte81NdD; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="Vte81NdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783422244; x=1784027044; i=smoch@web.de;
	bh=3PIqo57EQNiBHwnGjeGrKifTmx0XH4Xy/8evjz9ZSTM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vte81NdDzj1CW0jkqIVtonTvzuzIB6LXVXvJiO8kkzz6emcLAl4Wrt95BopmW3rj
	 u4D2sL7yMUBc+fUdHI0VXQ9R9dEu7pgur3UM/gyMR6rCsSSwBadVxGf56VwqVU37x
	 /Wubxg9+y1pWvrspqMJVAFTjzmgM0UcZejVzxdjcfLN/orOt0v1F3+bL9fYRh2ZrQ
	 UsWB54lwGjnmUnWoMO8MriINTvO5UbjrhEvZXFtddFnj+CDrBXC3EpGUavUpTYXnT
	 7V15eDhI7NjNiiKQB8pjuwXhM34rkxlLYm9n6ynbgVSr5n3SdMBBpwDYVtNWTWaQq
	 8SguBNXUy2boKfZOKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1wstIN1eVX-008Hba; Tue, 07
 Jul 2026 13:04:04 +0200
Message-ID: <0c649fcb-f084-4cc2-bed4-cc335b40c599@web.de>
Date: Tue, 7 Jul 2026 13:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
From: Soeren Moch <smoch@web.de>
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
 <4836b6f1-d40d-479d-acf7-a67769e0c8ac@web.de>
Content-Language: en-US, de-DE
In-Reply-To: <4836b6f1-d40d-479d-acf7-a67769e0c8ac@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ZeevbU7RNz769WEsUtX7LWkv/sW7fY8LzIG01kDidKl+Vy6gg8
 EeGHTW5qPAzFL3gMolXHOdVVFGKeSBd0jEleWobELyntrl5y7gOkB6hdhswkVkng3EQLkew
 j1HkxjJV7LZ++9H/sT4d3SgDOsZj69r1oXcPCIWQURy1oKPjdnWSV2SmBAq7i7GjxFj0wrN
 D49z1pnAmM2VP9jXT8GEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8e/KFUIJ6iw=;Mdr4bPjx1HjrHdCVjJaIEIs5bl7
 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
 GC0/hYBZEch+rpPotiFq2Q0QrzAW0k

On 07.07.26 10:55, Soeren Moch wrote:
> On 07.07.26 05:03, Hongxing Zhu (OSS) wrote:
>>> -----Original Message-----
>>> From: Soeren Moch <smoch@web.de>
>>> Sent: Monday, July 6, 2026 10:09 PM
>>> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>; Frank Li
>>> <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
>>> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
>>> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
>>> festevam@gmail.com
>>> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>> imx@lists.linux.dev; linux-kernel@vger.kernel.org; Hongxing Zhu
>>> <hongxing.zhu@nxp.com>
>>> Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by=20
>>> separating PHY
>>> power and reference clock control
>>>
>>>
>>>
>>> On 06.07.26 05:06, hongxing.zhu@oss.nxp.com wrote:
>>>> From: Richard Zhu <hongxing.zhu@nxp.com>
>>>>
>>>> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
>>>> regulators") introduced a boot hang on i.MX6Q/DL variants by changing
>>>> the initialization sequence.
>>>>
>>>> The issue stems from coupling PHY power (TEST_PD) and reference clock
>>>> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
>>>> managed together, the timing between PHY power-up and reference clock
>>>> enablement cannot be properly controlled, leading to initialization
>>>> failures.
>>>>
>>>> Fix this by separating the two concerns:
>>>>
>>>> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where i=
t
>>>> =C2=A0=C2=A0=C2=A0 logically belongs with reset operations. This ensu=
res PHY power=20
>>>> state
>>>> =C2=A0=C2=A0=C2=A0 is managed as part of the core reset sequence.
>>>>
>>>> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>>>> =C2=A0=C2=A0=C2=A0 shared PHY power management, avoiding code duplica=
tion.
>>>>
>>>> - Make imx6q_pcie_enable_ref_clk() responsible only for reference=20
>>>> clock
>>>> =C2=A0=C2=A0=C2=A0 (REF_CLK_EN) control, simplifying its purpose.
>>>>
>>>> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() a=
s
>>>> =C2=A0=C2=A0=C2=A0 proper sequencing is now handled by the core_reset=
 functions.
>>>>
>>>> This refactoring ensures PHY power is controlled during reset
>>>> operations, fixing the boot hang while improving code maintainability=
.
>>>>
>>>> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
>>>> regulators")
>>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>> With this patch on top of v7.2-rc2 I see everything booting, lspci=20
>>> shows the
>>> root complex, but no PCIe device behind it.
>>> Tested on a i.MX6Q based tbs2910 board.
>>>
>>> For me it is not clear whether this fail to detect PCIe devices is=20
>>> related to the
>>> patches in question, the reset timing, or something else. Needs furthe=
r
>>> investigation.
>> Thanks for your kindly help to tests.
>> Did you ever encounter the boot failure without this patch based on=20
>> v7.2-rc1
>> or later?
> Have not tested this. Unfortunately currently I have no access to my=20
> tbs2910 test board.
> I used a production system for this test here, but this is very=20
> difficult to recover
> from boot hangs.
>>
>> After applied this patch, my i.MX6Q Sabresd board can boot up=20
>> successfully.
>> And the endpoint device can be detected as well.
>>
>> My Local commits:
>> ad5939d49b268 (HEAD -> v7.2-rc2_pcie) PCI: imx6: Add runtime PM=20
>> support for i.MX95
>> db7b15f198125 PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3=20
>> stability
>> a26735515c076 PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY=20
>> power and reference clock control
>> d617eadf52a46 PCI: dwc: Add force_l2 flag for platforms requiring L2=20
>> entry without D3cold
>> 8cdeaa50eae8d (tag: v7.2-rc2) Linux 7.2-rc2
>
> My commits (v7.2-rc2 plus my patch to enable MSIs for the endpoint=20
> plus this patch discussed here):
> 8cdeaa50eae8 Linux 7.2-rc2
> b62414d07e24 PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
> e8176c6a27ed PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY=20
> power and reference clock control
>
> I'm not sure what your other mentioned patches are.
>>
>> Kernel logs:
>> Starting kernel ...
>>
>> [=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x0
>> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 7.2.0-rc2-00004-gad5939d49b=
26=20
>> (nxa08258@shlinux89) (arm-poky-linux-gnueabi-gcc (GCC) 15.2.0, GNU ld=
=20
>> (GNU Binutils) 2.45.0.20250908) #38 SMP Tue Jul=C2=A0 7 02:36:46 UTC 20=
26
>> ...
>> root@imx6qpdlsolox:~# lspci
>> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>> 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network=
=20
>> Connection
> on linux-7.2-rc2 plus patches (see above):
> root@matrix2:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>
> on linux-7.0 (not tested on 7.1):
> root@matrix2:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Multimedia controller: Philips Semiconductors SAA7160 (rev 02)
>
> I guess the new power-on/reset timing is not sufficient to init the=20
> endpoint in time.
> Did you reduce the time from powering up the PCIe slot to release of=20
> PERST#?
> There is a power switch on the tbs2910 board for the PCIe slot, not=20
> sure if
> this is available also on SabreSD.
I found out that the endpoint device is (often?) detected after reboot,=20
it is not
(never) on cold boot. (linux-7.2-rc2 plus patches)
Could also point to timing problems of the slot power supply (or reset=20
duration).
Unfortunately I have only very limited time for testing.
>
> Best regards,
> Soeren
>> Best Regards
>> Richard Zhu
>>> Regards,
>>> Soeren

