Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5A3998A6;
	Mon, 28 Sep 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620209; cv=none; b=WCUw7mgj3Sh1R0LeN6MHBxlA1OGFAT//BFaLyECpo9g+TfR0Syf0NLUvbxol+6yDafyBw5fe9QFOspycPghTPKQszZvwW7ZYkNTTOYfo8e7FHc4dc9xIhVSlUA775Az791qTWKe+edGrhsCbMyLD9JDe9uzWswJUx6+bIHBs0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620209; c=relaxed/simple;
	bh=JVnM2khualDMDnEBNrCOXNHaaT7d0wbSgXchy0kacUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3mi5jCtdCOb2C2Odi+xT7LwQfu3z4tJm4Aon9Onjx1DdUmyw3MKrbR6NrtIdAS2vAwcU1M9K29/KGBfziSMIBptiINVP9Tjo3cuC2XGomW0pxel+crJWU9xuMKrIDCCh1bBinbJ1Ru0ATiP19TIv1EIZMHY4NDIpXD4FRjlFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D04mIrLG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D04mIrLG"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4htqbp2nWFzKp6C;
	Mon, 28 Sep 2026 20:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790620198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BH0qv2Ftw0HiIyMMGiXJU0u/XgiyZqiXPDLSbHsr6/U=;
	b=D04mIrLGPdK2W2o62sNniR8O4uEfLdsZ4caGMJ6PMhFYvcwwbtfmDmENG8XgAApByaS2ev
	hngIA7Ek6kv+Wi2ZDj1oRc2PRUaK4ZSit2jnSakNX8tOOzb6iGrd24QIINKCXG+U3EWtHd
	cmJsoZ+0t1owwoCaFn3QjLmUPzMq0PO464RtG8CBRj0+2J0f6o6hrKNPH8jo1+CrdFING2
	JzeXWiJMWIYLFYIcZc99ap+Q/hjeXgJgD3lVR92SX8nLORwkNDtjo2DkGVYk8Vc2UcZEfD
	B+oG1TmrISJ5LqYBs+Io61yAnCatzUq5lsQitmKfmWuHbZ96cAyhqB94ZPwsDg==
Message-ID: <851a0e28-380d-4ee4-adcd-f63ae1e78d0c@mailbox.org>
Date: Mon, 28 Sep 2026 19:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] PCI: rcar-gen4: Recover the Root Port on link down
To: Koichiro Den <den@valinux.co.jp>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-8-den@valinux.co.jp>
 <e9a60e4a-95ac-4e49-a16d-a8eca2196d4a@mailbox.org>
 <jbekhkl7ywblowemhmm4nhzzvg6bk6vpfciaebwvxe7nitfisc@3hbnpq6uz2rw>
 <e70e5f17-35aa-429e-905f-a1990d549126@mailbox.org>
 <hq4dtjhols7fawrtejjvrgp52bl2qclin6jhv2cne7xiv2hywm@zpe2pp66uhze>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <hq4dtjhols7fawrtejjvrgp52bl2qclin6jhv2cne7xiv2hywm@zpe2pp66uhze>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hwawurufoitgeyyt49rcrgzcqs3it8su
X-MBO-RS-ID: 393f564464dbb5a6557

On 9/28/26 6:06 AM, Koichiro Den wrote:

Hello Den-san,

>>>> Out of curiosity, do they trigger SError, and does the firmware (TFA)
>>>> trap/fix those up in EL3?
>>>
>>> I haven't confirmed whether those DBI accesses trigger an SError.
>>> The BL31 on the Spider I'm using should be based on rcar-s4_v2.5 [1] from the
>>> Spider BSP (as I haven't updated it). I just checked that this version also sets
>>> HANDLE_EA_EL3_FIRST=1, plus plat_ea_handler() is empty. So IIUC an SError would
>>> be taken to EL3
>>
>> Yes.
>>
>>> , and the normal path would return to the kernel without fixing
>>> the underlying error.
>>
>> That is correct.
>>
>> R-Car Gen3 does PCIe link error fixup in TFA, it looks this way:
>>
>> https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> 
> Thanks for the info! It does look similar, so now I'm wondering about (*) below.
> 
>>
>>> And, regardless of whether it's a synchronous abort or an SError:
>>> - There was no crash report (via report_unhandled_exception) on the console.
> 
> (*) I checked that CRASH_REPORTING is enabled in that version, but there might
>      be a separate issue with report_unhandled_exception.

It could be that the DBI access triggers some other type of exception, 
not SError.

>>> - Once that DBI access in the small window hangs, it never recovers,
>>>     whereas adding udelay(300) before the access avoids the hang. So I
>>>     doubt it's just retrying the same access after a transient synchronous
>>>     abort as well (though I can't rule it out).
>>
>> ( It just crossed my mind, this sounds similar to 0056d29f8c1b ("PCI:
>> rcar-gen4: Assure reset occurs before DBI access") )
> 
> Yes, exactly. I'm almost ready to send v2, with an explicit mention of that
> commit in the cover letter.
> 
> A delay-based approach might be an option here, but I suspect it would involve
> about the same level of complexity in the end. The reset request shares
> intreq_pcim_sub with iMSI-RX, while AER arrives on another IRQ, so we'd still
> need to coordinate both paths to avoid unsafe DBI access.

ACK

-- 
Best regards,
Marek Vasut
