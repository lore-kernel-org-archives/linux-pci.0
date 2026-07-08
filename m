Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264063C3BE6;
	Wed,  8 Jul 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507434; cv=none; b=SAjWguu8ftPu9qdbYmBHVJXeirNcXLnj9KNbFOzeaXrbF8gmq6bOIIe3T1VDdfUOYMeCYYxgX4PqE6km9JneYTez/+8NTgnwQkw5WKUCFGJnproojCpBFAPiFD/KdDpyMlCNe4Tv2+P+0tYsESQUe+lu2/zvA5fls/4taGXE2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507434; c=relaxed/simple;
	bh=rHD0IwUNq981mA0PVMFQ5BdKdI98wlrPCt7mYw9yu8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swmDbxeG5j13F4e1/ygYsUM8Y3aD5pTW58cX9igzlFfLzXSqfQfgd2OGNJGN3Q7zF6mXMyWQGQ2yDNmA9fPUX5yQpY23IDOzAJMS6qhFbTkwfPMfXP7ya9s903dxEpOMs7/nmTuGm/MGXkNS1Ra1yUfz4Vz33DtQ6uyf+NRqk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=HmvSYbVG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="HmvSYbVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783507392; x=1784112192; i=smoch@web.de;
	bh=98rENIB3mGoVN8IzGK5+Rv/mhcjDzkejvD/k8HXEbKY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HmvSYbVGsxRsgzkFyCHKY11mw7awZ6ax2mPPLLHmDK2UyiR5KmdcM3JSgBMWF4nM
	 y5gb0mCvvdiV37QH0GaXOXpVAtLDRTNnnv+UXZUooPdGecUIRLfc18joPYewUkHWg
	 abp/x3Lf77/vNa6J4vMM4UfCi2hM812UisyYKpJKmokJjBXVXx/lqigH3qaAy04Na
	 b293HYtXB4I/ldabkmVV5+YaMI4416WXFG7sCzjcAN0kx9ZMSvVFfbLQYWTTmiUWu
	 ZMvrgwiSx91wjLGa3TphOELQqukIuAu1u2A4iApYJiONKqV7NBkybOrW6o7hjc7xh
	 52mf5r65GVDe1a+wIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB80-1wmKLh42DW-00Bg5x; Wed, 08
 Jul 2026 12:43:12 +0200
Message-ID: <04ff27d2-2b9e-4ca5-918d-8c4211685eae@web.de>
Date: Wed, 8 Jul 2026 12:43:08 +0200
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
 <4836b6f1-d40d-479d-acf7-a67769e0c8ac@web.de>
 <0c649fcb-f084-4cc2-bed4-cc335b40c599@web.de>
 <GV2PR04MB12019244AC0F11642FA466DE78CFF2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <GV2PR04MB12019244AC0F11642FA466DE78CFF2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O4IzZMH8IYa+aCtKatLsZYQxcvdLppHR6JLxIrgPN5Zh0ZxGm3K
 SikqpQSdkwWXLSwudfvLiNMKEj10lxoXc/18mb9ZezMuT8jkjYMC907hhs3ce8aczp2j5B4
 wNZyES7EUFTn+QiCRxY5efypH7yTcG5kaxChIohk3EDxvkXhOFkv6ygKSB4R49tm5pn7Fev
 2efztF8wMB81wFseQamIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OCK1sjmDm5I=;JM1uVIehAE6HRnOpa7OpVta2g/a
 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
 sPxTBaDuQS7n2KmKFiGDr0yVnTSgS+



On 08.07.26 11:50, Hongxing Zhu (OSS) wrote:
>> -----Original Message-----
>> From: Soeren Moch <smoch@web.de>
>> Sent: Tuesday, July 7, 2026 7:04 PM
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
>> On 07.07.26 10:55, Soeren Moch wrote:
>>> On 07.07.26 05:03, Hongxing Zhu (OSS) wrote:
>>>>> -----Original Message-----
>>>>> From: Soeren Moch <smoch@web.de>
>>>>> Sent: Monday, July 6, 2026 10:09 PM
>>>>> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>; Frank Li
>>>>> <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
>>>>> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
>>>>> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
>>>>> festevam@gmail.com
>>>>> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>> imx@lists.linux.dev; linux-kernel@vger.kernel.org; Hongxing Zhu
>>>>> <hongxing.zhu@nxp.com>
>>>>> Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by
>>>>> separating PHY power and reference clock control
>>>>>
>>>>>
>>>>>
>>>>> On 06.07.26 05:06, hongxing.zhu@oss.nxp.com wrote:
>>>>>> From: Richard Zhu <hongxing.zhu@nxp.com>
>>>>>>
>>>>>> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
>>>>>> regulators") introduced a boot hang on i.MX6Q/DL variants by
>>>>>> changing the initialization sequence.
>>>>>>
>>>>>> The issue stems from coupling PHY power (TEST_PD) and reference
>>>>>> clock
>>>>>> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
>>>>>> managed together, the timing between PHY power-up and reference
>>>>>> clock enablement cannot be properly controlled, leading to
>>>>>> initialization failures.
>>>>>>
>>>>>> Fix this by separating the two concerns:
>>>>>>
>>>>>> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where
>>>>>> it
>>>>>>  =C2=A0=C2=A0=C2=A0 logically belongs with reset operations. This e=
nsures PHY power
>>>>>> state
>>>>>>  =C2=A0=C2=A0=C2=A0 is managed as part of the core reset sequence.
>>>>>>
>>>>>> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset()
>>>>>> for
>>>>>>  =C2=A0=C2=A0=C2=A0 shared PHY power management, avoiding code dupl=
ication.
>>>>>>
>>>>>> - Make imx6q_pcie_enable_ref_clk() responsible only for reference
>>>>>> clock
>>>>>>  =C2=A0=C2=A0=C2=A0 (REF_CLK_EN) control, simplifying its purpose.
>>>>>>
>>>>>> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk()
>>>>>> as
>>>>>>  =C2=A0=C2=A0=C2=A0 proper sequencing is now handled by the core_re=
set functions.
>>>>>>
>>>>>> This refactoring ensures PHY power is controlled during reset
>>>>>> operations, fixing the boot hang while improving code maintainabili=
ty.
>>>>>>
>>>>>> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
>>>>>> regulators")
>>>>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>>>> With this patch on top of v7.2-rc2 I see everything booting, lspci
>>>>> shows the root complex, but no PCIe device behind it.
>>>>> Tested on a i.MX6Q based tbs2910 board.
>>>>>
>>>>> For me it is not clear whether this fail to detect PCIe devices is
>>>>> related to the patches in question, the reset timing, or something
>>>>> else. Needs further investigation.
>>>> Thanks for your kindly help to tests.
>>>> Did you ever encounter the boot failure without this patch based on
>>>> v7.2-rc1
>>>> or later?
>>> Have not tested this. Unfortunately currently I have no access to my
>>> tbs2910 test board.
>>> I used a production system for this test here, but this is very
>>> difficult to recover from boot hangs.
>>>> After applied this patch, my i.MX6Q Sabresd board can boot up
>>>> successfully.
>>>> And the endpoint device can be detected as well.
>>>>
>>>> My Local commits:
>>>> ad5939d49b268 (HEAD -> v7.2-rc2_pcie) PCI: imx6: Add runtime PM
>>>> support for i.MX95
>>>> db7b15f198125 PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3
>>>> stability
>>>> a26735515c076 PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
>>>> power and reference clock control
>>>> d617eadf52a46 PCI: dwc: Add force_l2 flag for platforms requiring L2
>>>> entry without D3cold 8cdeaa50eae8d (tag: v7.2-rc2) Linux 7.2-rc2
>>> My commits (v7.2-rc2 plus my patch to enable MSIs for the endpoint
>>> plus this patch discussed here):
>>> 8cdeaa50eae8 Linux 7.2-rc2
>>> b62414d07e24 PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
>>> e8176c6a27ed PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
>>> power and reference clock control
>>>
>>> I'm not sure what your other mentioned patches are.
>>>> Kernel logs:
>>>> Starting kernel ...
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x0 [=C2=
=A0=C2=A0=C2=A0 0.000000] Linux
>>>> version 7.2.0-rc2-00004-gad5939d49b26
>>>> (nxa08258@shlinux89) (arm-poky-linux-gnueabi-gcc (GCC) 15.2.0, GNU ld
>>>> (GNU Binutils) 2.45.0.20250908) #38 SMP Tue Jul=C2=A0 7 02:36:46 UTC =
2026
>>>> ...
>>>> root@imx6qpdlsolox:~# lspci
>>>> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>>>> 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
>>>> Connection
>>> on linux-7.2-rc2 plus patches (see above):
>>> root@matrix2:~# lspci
>>> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>>>
>>> on linux-7.0 (not tested on 7.1):
>>> root@matrix2:~# lspci
>>> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
>>> 01:00.0 Multimedia controller: Philips Semiconductors SAA7160 (rev 02)
>>>
>>> I guess the new power-on/reset timing is not sufficient to init the
>>> endpoint in time.
>>> Did you reduce the time from powering up the PCIe slot to release of
>>> PERST#?
>>> There is a power switch on the tbs2910 board for the PCIe slot, not
>>> sure if this is available also on SabreSD.
> No, i.MX6Q Sabresd board doesn't have a power switch.
Sorry, I was wrong here. On tbs2910 there is no separate 3V3 regulator=20
for the
PCIe slot, on sabresd there is (reg_pcie, gpio3 19).

At least there still is a difference, which could be a reason for the=20
different
PCIe endpoint detection behavior on cold boot.

Best Regards,
Soeren
>> I found out that the endpoint device is (often?) detected after reboot,=
 it is not
>> (never) on cold boot. (linux-7.2-rc2 plus patches) Could also point to =
timing
>> problems of the slot power supply (or reset duration).
>> Unfortunately I have only very limited time for testing.
> Understand, thanks for your kindly help.
>
> Best Regards
> Richard Zhu
>>> Best regards,
>>> Soeren
>>>> Best Regards
>>>> Richard Zhu
>>>>> Regards,
>>>>> Soeren

