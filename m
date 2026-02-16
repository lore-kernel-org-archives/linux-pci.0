Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F9286D72
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262392; cv=none; b=L5bn0SLQyQGc/OU73ER3/kzNY72l0KBsIy6CsBk7V5VJ1hYfbZ/rlPr88abtqKHF4p1EqXUzgtDhjctM3suKHnNWUPavWXSGXT9j6Q6mBJXk+E+3iCAOi1SG6EC9cIlqNl0qBMHiTrD+HttW5pV9wswO+81P6TZhIj86CfHg4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262392; c=relaxed/simple;
	bh=ga8bFx44y5iHuBGB1mwGqWfMHjMxGLHos9sO3Y6x/f0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oZSVohtQhBe3pRitN1wewMrrGziyyfvhktp1X99VAolSEhS+Vz0xB5qNdzDZJgMU7CdyRN8cWx+qlnVttakJ7bgROXEADnNmY7bk/1EqyLNLW6zqbwVdkcqG7/T9RaISoOXjW+T1l3nDZCOlkg35ImgDK0T9uX/fldEGrTbEH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ouscKI7n; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ouscKI7n"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-483770e0b25so28965345e9.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1771262389; x=1771867189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ox2zOip8ex/pPOz0MZ66YdomhlQUxEYWyv12vdPkcRw=;
        b=ouscKI7nRWgutqDs3djCZalbPdY3KKPAX3HU8E/wYE7M4Um+sF8DflDyPXUnOoTK4k
         ZYAvn1TK82QUQRHXaS/gieKaRxsOkBUbvkfX185CWX1m8D/0/puUi3v+aWMH07H9idVG
         +OK1sGS1zXzVxu+wrzAC0TbNwSk3deJvUNJyZAG9J8Rzfusd/siRn1Crg2fpjyIYREKX
         phC5sx6sqEOjWOLZE9QITN37NJIqBZeBXBQEfQIHrqD81g+ibXibemNqG8xgv2iiy5Df
         QZ+WYNmJtp4oLmZN0AZhtoNYaWVtSqIuCxpaJh7aYASfCAekdzrmOAnTNoDY1tEZr1+D
         rkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262389; x=1771867189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox2zOip8ex/pPOz0MZ66YdomhlQUxEYWyv12vdPkcRw=;
        b=I0JpxVt3AzWwFaNE0MldhnB+UkizfYlCF5ekhtJRXkrxuESZ+vMZCTekOc2QJbAW8W
         VPsbrNocWXi8k9yPjqC/lAMzS2iHlEpjf+JDyvs3upSqvRo2L4eh+4IrX22nxpXrb4D2
         YcLa7xlnxVdB26QRBcREiO/uLB5TspYuHpBs7fF7v6l29k1nm0tJYWBkGUC4roRWdbc9
         DHFHpui+0y3pR59A+f4U4kgJXolhZOtIKDUGBY5mQ83LAZBeQofT1H7QZB+ffE/uioCj
         QVq9hpp4qA4V9+8nSyP17F5767fB8SfmLkTYp1th/w1WUGAAw0+kHOgDp7eYSkGQiGDn
         LPng==
X-Forwarded-Encrypted: i=1; AJvYcCU8MrhQW4W+gvGSyAJi5yZqUzTopbtPrBuLaXv/txubzCBc3e95bcH3+GY1AdpSx55eDxToaPTZaGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tjBXkzMi/unGTKK5A83ozBEvYgKcffUgSbwInIhhLgKilYGc
	XBTw9/ZeMOeCrNAbcBktjy4NWFMiSmrPOHIYEb8OsOKuZg2dimnhtSr33C9NzAVMXEo=
X-Gm-Gg: AZuq6aJd496NaWjCsgfMU4S7G+LdfNrBVgcYPfRKMCbVrPZt5bPkjJ4+oK7XY0NfuYm
	tqrFhCbWXB3ud2abyzB2DppsgK/8WS7I0e35RahD0AqWSj4v8E2qiWL9XGFWfiXWRijyq8PTwEs
	nkJBMK0c+lSScrnU398kAHiFExPyxWXC6IhEy98rf4B8A7PrG1PYHtMXQCP/fuBAsBjiDArji5/
	wzsIMNChnGRsHLPS2GuXMZAr+CXMl1BJAb9HkYik6nTg6W2N2dCYF3Kz5ZWMOy7tcf011gxdEWv
	m36ZV4rtZXHCjdmdkjQ4LL6eaSpUn4kZtNBnqzuD5GRMnk3C88wBwmPA3te1yaYyrEiASUyB1i0
	6/GR3blei1ildWgCV805dGy58PE2rr5OF76jujZUPtxhD8+WW9wSyyvRnJ2aCACJRSVhc4WLce5
	9VTJAHk7E9KVVbB0VVZ+T7kmvUoUJU5/adAOMSm3ya4Q==
X-Received: by 2002:a05:600c:1547:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483710858c8mr218566385e9.21.1771262389276;
        Mon, 16 Feb 2026 09:19:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm502143425e9.7.2026.02.16.09.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:19:48 -0800 (PST)
Message-ID: <ccf3bfd6-c060-4b88-bf4d-37425aea4cfa@tuxon.dev>
Date: Mon, 16 Feb 2026 19:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, John Madieu <john.madieu.xa@bp.renesas.com>
References: <7306256a-b380-489b-8248-b774e6d3d80e@nvidia.com>
 <20260122152903.GA1247682@bhelgaas>
 <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
Content-Language: en-US
In-Reply-To: <5z7c25nkb35prvax6vq6ud7eaeuhzsswbf7fqvmlgys3xftgwb@odocboejrdrv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/22/26 19:01, Manivannan Sadhasivam wrote:
> On Thu, Jan 22, 2026 at 09:29:03AM -0600, Bjorn Helgaas wrote:
>> [+cc NVMe folks]
>>
>> On Thu, Jan 22, 2026 at 12:12:42PM +0000, Jon Hunter wrote:
>>> ...
>>
>>> Since this commit was added in Linux v6.18, I have been observing a suspend
>>> test failures on some of our boards. The suspend test suspends the devices
>>> for 20 secs and before this change the board would resume in about ~27 secs
>>> (including the 20 sec sleep). After this change the board would take over 80
>>> secs to resume and this triggered a failure.
>>>
>>> Looking at the logs, I can see it is the NVMe device on the board that is
>>> having an issue, and I see the reset failing ...
>>>
>>>   [  945.754939] r8169 0007:01:00.0 enP7p1s0: Link is Up - 1Gbps/Full -
>>>    flow control rx/tx
>>>   [ 1002.467432] nvme nvme0: I/O tag 12 (400c) opcode 0x9 (Admin Cmd) QID
>>>    0 timeout, reset controller
>>>   [ 1002.493713] nvme nvme0: 12/0/0 default/read/poll queues
>>>   [ 1003.050448] nvme nvme0: ctrl state 1 is not RESETTING
>>>   [ 1003.050481] OOM killer enabled.
>>>   [ 1003.054035] nvme nvme0: Disabling device after reset failure: -19
>>>
>>>  From the above timestamps the delay is coming from the NVMe. I see this
>>> issue on several boards with different NVMe devices and I can workaround
>>> this by disabling ASPM L0/L1 for these devices ...
>>>
>>>   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5011, quirk_disable_aspm_l0s_l1);
>>>   DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5036, quirk_disable_aspm_l0s_l1);
>>>   DECLARE_PCI_FIXUP_HEADER(0x1b4b, 0x1322, quirk_disable_aspm_l0s_l1);
>>>   DECLARE_PCI_FIXUP_HEADER(0xc0a9, 0x540a, quirk_disable_aspm_l0s_l1);
>>>
>>> I am curious if you have seen any similar issues?
>>>
>>> Other PCIe devices seem to be OK (like the realtek r8169) but just
>>> the NVMe is having issues. So I am trying to figure out the best way
>>> to resolve this?
>>
>> For context, "this commit" refers to f3ac2ff14834, modified by
>> df5192d9bb0e:
>>
>>    f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
>>    df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
>>
>> The fact that this suspend issue only affects NVMe reminds me of the
>> code in dw_pcie_suspend_noirq() [1] that bails out early if L1 is
>> enabled because of some NVMe expectation:
>>
>>    dw_pcie_suspend_noirq()
>>    {
>>      ...
>>      /*
>>       * If L1SS is supported, then do not put the link into L2 as some
>>       * devices such as NVMe expect low resume latency.
>>       */
>>      if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>>        return 0;
>>      ...
>>
>> That suggests there's some NVMe/ASPM interaction that the PCI core
>> doesn't understand yet.
>>
> 
> We have this check in place since NVMe driver keeps the device in D0 and expects
> the link to be in L1ss on platforms not passing below checks:
> 
>          if (pm_suspend_via_firmware() || !ctrl->npss ||
>              !pcie_aspm_enabled(pdev) ||
>              (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> 

We noticed a similar issue with the Renesas RZ/G3S host driver and NVMe devices. 
We currently have 2 SoCs where we identified this problem (RZ/G3S and RZ/G3E), 
both present on SoM modules, and the SoM modules could be connected to the same 
carrier board where the PCIe signals are routed and connectors exists. On the 
carrier board we have 2 connectors were we can attach NVMe devices, one M.2 Key 
B and one PCIe x4 connector 
(https://www.amphenol-cs.com/product/10061913111plf.html).

The issue described in this thread is reproducible for us only after suspend and 
only for the NVMe device connected to the the PCIe x4 connector. The device is 
working correctly just after boot. On suspend, power to the most SoC components 
(including PCIe) is lost but the endpoints remains powered.

The issue is not reproducible if the following command is executed before 
suspend: echo performance > /sys/module/pcie_aspm/parameters/policy

The difference we identified in terms of signals connected from the SoC to the 
on board connectors relies in the CLKREQ#. This signal is only connected to the 
PCIe x4 slot.

On RZ/G3E the CLKREQ# is configured as a individual GPIO pin. On RZ/G3S it is 
muxed by the pin controller with PCIe function. We tried on RZ/G3E to not 
configure the CLKREQ# pin at all and with this the NVMe connected on the PCIe x4 
slot started to work even after suspend. We cannot reproduce the same behavior 
on RZ/G3S.

Initially, we considered we might have to update the existing code to do 
specific configuration for the boards were CLKREQ# is not connected (through 
supports-clkreq DT property that some controllers are using).

Currently, the manual is unclear on how to control CLKREQ#.

Apart from the suggestions mentioned in [1], could you please let me know if you 
have any others?

Thank you,
Claudiu

[1] 
https://lore.kernel.org/all/unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h/
