Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A037E5FA;
	Thu, 20 Aug 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787198155; cv=none; b=UMhQMrkMizEUCdFkToImoEaCiJhXuSSpgjvdAHIOm4g4EXNIBw5ETPmrm0ZLGv3sp3dJUv+ZGMCt3wETyE6TeDEZHHoq9fUoMBNZqpwRx1JSxnrSWqBFbJ0ysy5FWEoeCj3Jc9akpfwjI8BODpKK361oB5iNE8yunrrZgaEpD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787198155; c=relaxed/simple;
	bh=aPLUg/C004Pk7qdi2uluPwJVJCw4mgOvRK2ZFIsbvus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjUw16CrCHRuCPFIlP6hoOJaiNsDQ6ZDDXGTl6G6wCZmDUu2s95rxqBszIo9xN90QN0U8Wjgp0S7n2W8pLsM6sy/4koybhJvOqWk5jYl44B+dk8bKYmolixxYYi1XG+mdyU7AcUstF1/5xK1fC7KZFsxmU8RbZF5t5dnhalfTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=leYbuI68; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FhbDcsVm; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="leYbuI68";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FhbDcsVm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hQV363hvKz8t0P;
	Thu, 20 Aug 2026 05:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxzeHPzlyVI1KqYMNzNsdVUY8/H+zuUibyC7cz++VlE=;
	b=leYbuI68cGlV04cOZnMzafv3N+NwItQ1nmzVHDA9uiPOBXZIb9nG7pp1YcwVOSz7Tk+ayl
	iWDZAzIhOK6pW9FfDRw6JAHnUbT4JL4wpx8tkZ+CysZ34yN3lFryU/fsmS+5bDg4aSbDt7
	8rSo5GWtlzTwGeW7V4/UGk7L6DTSbWxPkDtXjIePCbU19qrofs5Bn/qRYhx923iEhLgA8C
	dNgnDCgo6Obf7SYY+usnmnArvbgOw/gJ3txP3XEJ+oRHoDe20GxYeMr9l/ZEaw7LQENMP8
	rrNEZ/L++SG80mX4VTmKnafFLCUS3aY6dVLS77vsAATYbWgQW3p5XjcwLQVLng==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FhbDcsVm;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <0a899cb7-bfaf-46b9-bd35-cfacc3861d6b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxzeHPzlyVI1KqYMNzNsdVUY8/H+zuUibyC7cz++VlE=;
	b=FhbDcsVm/mzzmWM5dvgoAti7mld9XYxK4GX/P9Qgw8r1fe8leu8UTds6Twcna9iG8NJ2Qm
	LLW2/8qn533CTbj7jGYLnrboSsuufmQlDA+piQkDXBwLs1D7bHtt4AghPJ4EZX2IUvkPS+
	zYok/EPHeiJbylDGBOn6RgMuLZX4aSCasPHE/b50M+Ee2WGs3JIBOYymp09Co3DHzyVWmT
	/SjOF+2wzvvBVmvluT2Vr9iVB75PsG54qpGnMbtm8rxb2nsEQLIjv0O4oFJYy8maDScD8h
	FhJ8amfFAOc6T25TRTF1LmPMHXQRJpEeYIHiczv2E4Du4SciGoeohP0GQUO0dA==
Date: Thu, 20 Aug 2026 05:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in
 rcar_gen4_pcie_ep_deinit()
To: Koichiro Den <den@valinux.co.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
 <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
 <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
 <zi6an774rs4zsvz4rgvskvchlcz3ontuih7ztime673pw55axf@updaznhtexix>
 <0e5dae39-3ded-4b24-b3aa-7707983ec243@mailbox.org>
 <gnv6rbodtisekx7hvlwdmdzj5r3hdutbeexqde4gw3jodadwoj@rnukrhteykir>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <gnv6rbodtisekx7hvlwdmdzj5r3hdutbeexqde4gw3jodadwoj@rnukrhteykir>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c50c246b64f0bbb590c
X-MBO-RS-META: kfi7jzo7pnzi84fj8445qjebphg7kbwg
X-Rspamd-Queue-Id: 4hQV363hvKz8t0P

On 8/19/26 10:48 AM, Koichiro Den wrote:

Hello Den-san,

>> Finally, if dw_pcie_ep_init() call in rcar_gen4_add_dw_pcie_ep() fails, then
>> with the aforementioned deinit implementation, I think it will be possible
>> to simply do the following to cover (**).
>>
>> ret = dw_pcie_ep_init(ep);
>> if (ret)
>>    return ret;
>>
>> (I am also attaching the entire example as a diff, compile tested only thus
>> far)
>>
>> What do you think ?
> 
> Hi Marek,
> 
> Thanks for sharing your thoughts.
> 
> I think the callback idea is much cleaner. I wonder if .post_deinit might
> describe its role more clearly.

I think it does, and I will include that in V2.

> P.S. I took a quick look through the related call paths, and it made me wonder
> if we could take this a little further. Perhaps dw_pcie_ep_deinit() could call
> the same hook at the end (I use .post_deinit as a tentative name below):
> 
>    dw_pcie_ep_init()
>      -> .pre_init()
>      -> generic intialization
>      error:
>        -> generic unwind
>        -> .post_deinit()
> 
>    dw_pcie_ep_deinit()
>      -> generic teardown
>      -> .post_deinit()
> 
> Then would let the generic init/deinit pair own both hooks, and the
> pcie-rcar-gen4 driver would no longer need to call rcar_gen4_pcie_ep_deinit()
> separately. After dropping those explicit calls, the function could naturally be
> renamed rcar_gen4_pcie_ep_post_deinit() and be used only as the hook.

That is really good.

> This might be too much for this small fix. Even without this wider change,
> however, I think rcar_gen4_pcie_ep_pre_deinit() should do the same operations as
> rcar_gen4_pcie_ep_deinit(), rather than only calling common_deinit(). For
> example, if pci_epc_mem_init() fails after .pre_init() succeeds, PCIEDMAINTSTSEN
> is already 0xffff, and common_deinit() does not clear it.

I will send a proper V2 shortly to cater for this. Thank you !

-- 
Best regards,
Marek Vasut
