Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468D2EAD15;
	Thu, 20 Aug 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217122; cv=none; b=uwRBNhKCZJUe+3lz5/Cjs2dkZpoHu/YP6aE+vcIML0lkDLC+U54h/uGhpSn3GPmu7NgSqffNpt9nc5RajJLAoUdODfvmS4WsWrs5x7sQNtQS+zEuJ9HnBkm2xOZGZN08PZDWr5z3tFHEz8O64FSyVxioh5ebOzV5awDUc/OtIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217122; c=relaxed/simple;
	bh=P9+cjxBSdpK9Af3GW8lSX4aG0oX5hSql/4xGZNJOtDE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q2Xe2as0G1kC3qtc9TNSCJmRf4zCux61I9fgXn/ugS2CDpaebMnp9eMnQmqk1V3xPFT4y91pwhcYxG+AB1WsWeEImwz2+LmxMRB8fCp6XfwkGcbdgjZqzwgaR2j32BT3/Sfbv7Cy/LvMy3742/ik6BibXejKsJ9G9ac0mSKs2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Hm77un+C; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hm77un+C"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hQd3w35zfzKnDW;
	Thu, 20 Aug 2026 11:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787217116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lWkYEElX6enLA1zCHDYCcVaPif+uQ4r6HEx/6jXHk0=;
	b=Hm77un+CKOelP9d1yfoXhVwbpGNUUHDMoYQtkKfPyb7uyxriabX1akHHY5e8awJ6plol2F
	zCaPQubQEEetMQnSsa1CHYwgQTT9FOGezV9EXXH1jWZMmZBUwT10D2OERtItCQaVSOO9vc
	oUPlZ3CuAkhoHu5oE8mMhMGVARuNOYXpl/4Zx+TFTPopcoNGldtmIiiOWkB0nyPDFtyKSc
	dhwP4CJq5P9faeJFP/qZhxg5ZZfALK9yEhWTzS7u8gLMJ2RruPOU+pjCWDsTlfJOTa05OM
	d56tER372WzSV/0Qs/rrq0pWYbF7iywPKQy74CP2VoH3U6fuPtc6jnuL7N75rQ==
Message-ID: <5be9b098-e183-4401-b1bb-44ce56e96e22@mailbox.org>
Date: Thu, 20 Aug 2026 10:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle
 dw_pcie_ep_init() failures
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
 <20260820035944.163472-2-marek.vasut+renesas@mailbox.org>
 <ymct5mjms65qy3hzlgfopzbrhqwdxk473awdqsguaamltchcur@fydxwbqqe6fu>
Content-Language: en-US
In-Reply-To: <ymct5mjms65qy3hzlgfopzbrhqwdxk473awdqsguaamltchcur@fydxwbqqe6fu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qx9s6cwwreaqrn5auikjbd9fj4tpzmwc
X-MBO-RS-ID: 95f0680095bab10768c

On 8/20/26 10:11 AM, Koichiro Den wrote:

Hello Den-san,

> On Thu, Aug 20, 2026 at 05:57:56AM +0200, Marek Vasut wrote:
>> Implement .post_deinit() callback in R-Car Gen4 struct dw_pcie_ep_ops {}
>> which asserts reset and stops the clock. This undoes start of clock and
>> deassert of reset performed in .pre_init() in case dw_pcie_ep_init() fails
>> after successful call of .pre_init() callback.
>>
>> The use of .post_deinit() callback correctly handles the clock and reset
>> stop, unlike the call of rcar_gen4_pcie_ep_deinit() in dw_pcie_ep_init()
>> which could not discern at which point the dw_pcie_ep_init() failed and
>> might have attempted to stop clock and assert reset twice, remove it.
>>
>> Since dw_pcie_ep_deinit() also invokes the .post_deinit() callback, drop
>> calls to rcar_gen4_pcie_ep_deinit() in both rcar_gen4_add_dw_pcie_ep()
>> dw_pcie_ep_init_registers() fail path and rcar_gen4_remove_dw_pcie_ep()
>> to avoid duplicate stop of clock and assert of reset, and drop no longer
>> used rcar_gen4_pcie_ep_deinit() entirely.
>>
>> Initialize PCIEDMAINTSTSEN early in rcar_gen4_pcie_ep_pre_init() to 0,
>> to make sure that edma_int bits will never be set in case of failure
> 
> I think s/will never be set/will never be left set/, because .pre_init() writes
> 0xffff before later initialization can fail, and .post_deinit() then sets it
> back to 0. Otherwise LGTM.
> 
> (Again, I did some quick tests on an S4 Spider, covering the normal path and
> several injected failure paths. I don't have V4H hardware, though.)
> Please feel free to pick either or both tags, if that helps.
> 
> Reviewed-by: Koichiro Den <den@valinux.co.jp>
> Tested-by: Koichiro Den <den@valinux.co.jp>

I have updated the commit message and collected the tags, thank you !

-- 
Best regards,
Marek Vasut
