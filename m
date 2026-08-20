Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABA70830;
	Thu, 20 Aug 2026 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199004; cv=none; b=FZD4PPjJx+Fnp2KnvVoigTAK/X1DlF6M7y8unTfsvwfAUJGESfRcOr9Dh2o5bdvxwF24FA9hgokPdQPX1+XsIY4dQbeMoCpZQNHrtaUv9hSvRwOmXvXHljOsAW7Zyw/rB99+tJdnf3e7akN95s5sQTVgp7vhJW+uzgJffZVW/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199004; c=relaxed/simple;
	bh=S9h2LAaA3goM2LaXs8kQh43CyQ7elr0irBlwBquQi60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9MZxU5180aZhtaqUuQbRqWp4Cby4LviERuoiIUUCtmjMkrAiugvMV/tnqg24OYvwgOcKhLxFO1N1ogZux+CtRorDs655MmqjTF4nricJ6M6muw35xz4hK6abqz3Y6Ofqk+w2N0Aik5oTu72BajK3v3rEol3luXiWAShrC9w6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PLd0/ZiY; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PLd0/ZiY"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hQVMQ0VsBzKmTN;
	Thu, 20 Aug 2026 06:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787198994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5q+QYpqVmLEV0D0dA1ade1zhGHYvvmOK4YtQ0IYvJk=;
	b=PLd0/ZiYTwT/9jvrD9m3l9O2fvWz+ApCIcM11zx2wwiIXUCJlZMySYVoi8A/CsLMRR+AY8
	l1ae06WppyFB0njq95F0kLZ8a7vmm7f/acMTn0YorGCx8c9BczALG2/DL+t7biIKEGhiOA
	/GA9XrI+6J11rAp/5VrjRj7A2ihwx+O0bTFzmQp8pNog67rw836N8n18/pEjzlmgaF9SJX
	9AG9eNZ/kOFORrBBKmf6JIOBcipqT4I0+x89gNhDqgsA3WY9+goST07J/rMLm2Eaifu9Nh
	JnH5Q1xnPPZWVJLQESu8BapO+IRkhd/f4Fp2lseh7jpnZSA8oaACZ6PfGQmcCg==
Message-ID: <6dfc406f-0dd1-44a6-8277-e89f43c2853a@mailbox.org>
Date: Thu, 20 Aug 2026 06:09:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in
 rcar_gen4_pcie_ep_deinit()
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
 <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5c9997c9d2627fa25ca
X-MBO-RS-META: ahztides5xi3xwy7wc3e4qggam78esku

On 8/18/26 7:55 AM, Koichiro Den wrote:

Hello Den-san,

> 2. It seems to me dw_pcie_ep_init() can fail:
>     - before pre_init() has run,
>     - from inside common_init(), or
>     - after pre_init() has succeeded and written PCIEDMAINTSTSEN_INIT (e.g.
>       pci_epc_mem_init() fails)
> 
>     The caller cannot tell which case returned the error. In the first case,
>     common_init() has not run, while in the last case PCIEDMAINTSTSEN is not 0.
>     So this seems to me different from what the commit message says. Is
>     common_deinit() intended to be safe in all three cases?

I hope this is addressed by the introduction of .post_deinit() callback, 
which makes the endpoint deinit safe in all cases.

The commit message was poorly written, and is rewritten since.

-- 
Best regards,
Marek Vasut
