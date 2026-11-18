Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026931;
	b=ZxV/KViPxATVaQ4fi/6PFn0s+uT95te/dNFC3DywaRqsWU1ziTqp/hbdYEkRCGfPnZX9
	 jvc5EwH606utk9ufK25qNB47oI9OjPbbjUhu2zGcR2/SGxZwtibaAan4uEfuWbU34L1J9
	 V4ixUSAXc4Xey3gWfN+LqsrL7Typz3of0HMDUE2+MLLuNdSDF1KBxbEqsOaYS8ICjOyt6
	 daFBuuaaf25Y6PyEBEuEGHazPEJ0WfwKs7NspoWMfZY6rLUw4Wjq5kAelYKp41UKfj/uJ
	 dsjZr1icGJ5nkenSrORFY6VAMlzKji3xLdpLELnOpqxkDHe9bGpYy0xeE/OwT3iIrUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026931;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B0lS7neeXGXFe3QzmU7KdA4SEjkEDlESBGtxe2LNicw=;
	b=CpP1eLgdz/a3bQNAMXV2lSrXlWsYbLCAbzOJWwJthPT5HQaS8QNsLJ7e0luWkdfhhbTX
	 0u2WsR4dGh/byCA4/MoqCbjxFpxEjkLwowmOO1s5i7PuDkhgbSiddyZ8W9QmUh0SK2y7H
	 ejz7jTVkZvR7FNQWT5kmtUp3Y4aGdX3+WrALrA3e87GIzwmst4QRz0v6JLa76jpWXZsEb
	 JZ8xxt8mdDH0ePcTJVkBpEpjzrqjlKHgadCI3pecbGHQqVUu4o+bh7vPMz1di+bl9PbbH
	 lyDBn7iypW3dDKMfNSJIw+QM1Dw3O7xLT3lq8Lzd+7wKvA0OpnNaWCnPsXu7rGbpQMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VErHkJtY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D24606A325;
	Wed, 18 Nov 2026 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VErHkJtY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220381F000C4;
	Wed, 18 Nov 2026 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026930;
	bh=B0lS7neeXGXFe3QzmU7KdA4SEjkEDlESBGtxe2LNicw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VErHkJtYQGDUZe/9jiqECopRcZqAnEBNOsbdiv3VRJvNuBzSKz4o5KCqV5Li9JYVK
	 5UDxXP78AyHbE2uOBWLkluVjlVa7/ZPmnCeESCsafIFadzOYSuM+jQG1KVkOONoAmO
	 Z3am4icXADNjJwK9S4kMoFj9jTXxlnJdg3CYeOESBG5LnPRqo808Duj1TC5Z/JtZcH
	 w37HNu0fQw+WpxNZnoTz/wVSWPdmY3Hr/QJjw3GSYK/+WzPR+tuL7+fW4PB0L66nnE
	 R5HF6VLjecEqTyK00/NNWiaLN1mOq9CJwBcuPKIL5M/aiw8BfKZltoDPfiakgtMGqb
	 +gfEWFKMah0qw==
Date: Wed, 18 Nov 2026 19:35:24 +0100
From: Thorsten Blum <blum@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>
Cc: Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <av3v7KY64vjxDCk1@kernel.org>
References: <20261106004343.457087-2-blum@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106004343.457087-2-blum@kernel.org>

On Fri, Nov 06, 2026 at 01:43:43AM +0100, Thorsten Blum wrote:
> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
> 
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
> 
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in commit abb2bafd295f
> ("x86/quirks: Add early quirk to reset Apple AirPort card").
> 
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
> 
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
> 
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Cc: stable@vger.kernel.org
> Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> Link: https://zoringroup.com/forum/5/7170/ [2]
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: H. Peter Anvin (Rosaic) <hpa@zytor.com>
> Tested-by: Thorsten Blum <blum@kernel.org> # on an iMac13,1
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
> Changes in v2:
> - Add iMac13,x background information and supporting links (Lukas)
> - v1: https://lore.kernel.org/r/20260807094601.263450-2-thorsten.blum@linux.dev/
> 
>  arch/x86/kernel/early-quirks.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied to blum/for-7.5 for linux-next testing.

[1/1] x86/early-quirks: Scan all functions in early_pci_scan_bus()
      https://git.kernel.org/blum/c/83e3892f2aadca0123a3b7d452e3f39e74cf5126

I plan to send it to Linus during the next merge window unless there are
objections or the x86/PCI maintainers would prefer to take it.

Thanks,
Thorsten
