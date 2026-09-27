Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05968EADC;
	Sun, 27 Sep 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548673; cv=none; b=TbHyBaJGxVnGarDnnCzD3Lk1IHH7Z6WVS8aKrQu3KoSsX9sHBrdrdG8692ucGkDgeR+pcECaue5dKnHTKNW3SpNRpHAL0RoYAPXC615lQnW96GN7IpB1YDlCguolqVg9es8zLf0rSgXCODyMfxdnSKHSvSVlOV6iWimdP2kUwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548673; c=relaxed/simple;
	bh=N67NUZKb1HwXZygj5d6vUkNwwcymjhaIuEZz990ku2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1feoYHLVdbW7ZA0MUvj5MI0uZuZkA3dj6elX8Kx2BVGBCulXj7Qn7sTJ91cWpoE2tYrah6bNfKJR8fzbYfdYwvmiXu0aMq8PQaNyctwXdmjTlC9YRUCAmlHeSJxUke64xIU80l7DaGI+jY5LfBENblMOlK+OkMmGY3tBo15oJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DplMAnkY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DplMAnkY"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4htK8C6rvwzKp3c;
	Mon, 28 Sep 2026 00:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790548668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6/mirp4Bz9bB7BY3nprZ6AZkmHJzy7o7ZyVgN0DDnk=;
	b=DplMAnkYLUJkFWf2zKvWscayxHIfIB1ByGo1yiYRDfGdQFaYqmAf7JlyuHq+R6HJm03kry
	rdRR7mIJsHQTrmXJPYjhQA1PuVUD0FmI+OCnRp6i+/5vcGDcas7RbRvKyRzJOJtgp6Rk9t
	O/DBmOxaNZzabHt/CTZEdZcmU13DhV66SnSwXIfDKZN5gmEZPbocpzosuB7YmdA40Ijx/r
	j5A8tBBV9Rg5+c0bzuXT7hc5Fp2Y81EWpO2sZIAuCKNMRAHwtWE0Yb4fmV9bYFOAMrvAxi
	d5e5IHaDdTVRsTswcSwo5v3vrU4O3wQIH6vTodiItFERtTUvIketDn6WWN5TRg==
Message-ID: <e70e5f17-35aa-429e-905f-a1990d549126@mailbox.org>
Date: Mon, 28 Sep 2026 00:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <jbekhkl7ywblowemhmm4nhzzvg6bk6vpfciaebwvxe7nitfisc@3hbnpq6uz2rw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: or9mykabccwaz1959ynoid6wt8wg5tsd
X-MBO-RS-ID: e086b13419eefc83387

On 9/24/26 6:15 PM, Koichiro Den wrote:
> On Tue, Sep 22, 2026 at 11:44:02PM +0200, Marek Vasut wrote:
>> On 9/18/26 5:20 AM, Koichiro Den wrote:
>>> On R-Car, intreq_pcim_sub carries both the integrated MSI receiver and
>>> the controller's reset requests (smlh_req_rst_not, link_req_rst_not), so
>>> the generic DesignWare chained handler reads the MSI status from DBI as
>>> soon as the link goes down. On R-Car S4 that is a hazard: DBI accesses
>>> issued within a few hundred microseconds of an unexpected link down do
>>> not complete and hang the host. In testing, the first Root Port config
>>> read after powering off the link partner hung unless delayed by ~300 us.
>>
>> Out of curiosity, do they trigger SError, and does the firmware (TFA)
>> trap/fix those up in EL3?
> 
> I haven't confirmed whether those DBI accesses trigger an SError.
> The BL31 on the Spider I'm using should be based on rcar-s4_v2.5 [1] from the
> Spider BSP (as I haven't updated it). I just checked that this version also sets
> HANDLE_EA_EL3_FIRST=1, plus plat_ea_handler() is empty. So IIUC an SError would
> be taken to EL3

Yes.

> , and the normal path would return to the kernel without fixing
> the underlying error.

That is correct.

R-Car Gen3 does PCIe link error fixup in TFA, it looks this way:

https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf

> And, regardless of whether it's a synchronous abort or an SError:
> - There was no crash report (via report_unhandled_exception) on the console.
> - Once that DBI access in the small window hangs, it never recovers,
>    whereas adding udelay(300) before the access avoids the hang. So I
>    doubt it's just retrying the same access after a transient synchronous
>    abort as well (though I can't rule it out).

( It just crossed my mind, this sounds similar to 0056d29f8c1b ("PCI: 
rcar-gen4: Assure reset occurs before DBI access") )

> [1] https://github.com/renesas-rcar/arm-trusted-firmware/tree/rcar-s4_v2.5
> 
>>
>>> Use the pre-MSI callback to check the APP reset status before DBI is
>>> touched. When a reset request is latched, mask the sources, ack the
>>> request and schedule recovery work. The work calls
>>> pci_host_handle_link_down(), which runs the AER-style recovery and
>>> resets the controller through reset_root_port(). If the reset fails, the
>>> sources stay masked so nothing touches the unrecovered controller.
>>>
>>> Only unmasked status bits are handled and pending latches are cleared
>>> when re-arming, so requests recorded during probe or the reset itself do
>>> not trigger another recovery. Teardown only disables link-down
>>> detection: MSI delivery has to keep working while devices are removed.
>>>
>>> When iMSI-RX is not used (external MSI controller or pci=nomsi), the
>>> DesignWare core does not request intreq_pcim_sub, so request it in the
>>> driver.
>>
>> Would it make sense to request the line unconditionally, to simplify the
>> driver(s) ?
> 
> Yes. The pcie-rcar-gen4 can set pp->msi_irq[0] = -ENODEV just like spear13xx,
> dra7xx and keembay for the same reason. That also removes the need for adding
> .pre_msi_irq addition in patch 4. Some other adjustments might be needed, but I
> believe that is the right and clean direction. I will respin with that in mind.
> 
> Thanks for the review, that helps a lot!

Likewise, thank you for your help !

-- 
Best regards,
Marek Vasut
