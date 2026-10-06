Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D23B1008
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321022; cv=none; b=SvNRBUCG6PTtTQNqMiSZuFQJvLYpkJI3NjOOgDS1Q5N8CnXzn8wdjPFlsEKhtkyDRnj2O58W18XWlfcaQ3lE5D37SD/2FuYOQ/dmQG5q/aKCbbZtqnAab/n6sJW7yxiSxr6Si9agVPct5cL9NNF4aDzlYxapTf9UvDYTmXhrt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321022; c=relaxed/simple;
	bh=B7TFy6V3wENsn5H2UVU1IlkUzqzf8kBLLcgBJsd2jCU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Jokek1KXKQ8IeiBuxhZfDhIxb1B5BfmePtuYzJqpNI0M2/HukH1zK8q8n8WVH7YpnALLLsobTq5rUBE1M+OE2NGYfW0e63YQ7qNDI8FlVRAzV8q/y5VRsenzy/1ufbhtOslNGx2yco2gzCdYMX+wNsqfObSUdtyqXimv38fKQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoeI44r7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoeI44r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D861F0089B;
	Tue,  6 Oct 2026 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791321021;
	bh=SqF08VykghEh8U+A8wtqkQSrcyMvcfrXV1sVVu9G30c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HoeI44r71RSNXO6D2oS98NXeQU41cTrRwZ3BjyhpL/1YXup03JOm7bxg623qycYYz
	 QuZpFddyoviuQgiXVEEHfZxWPhLMJliBkK69HCiIm8dv808DxSw0w6JUVuF7sOFZTU
	 2ZKnb5Uu/QNrNTveAL6E+JmoM92gyl1+u/qlbm0Jq7d6+kTNYaGmc1qouUQfHDTobL
	 oEYkuAdpF15JKWG0gAspzc9J4jlXmG8juCfBr5X05pfTbL8Bqgb/Urw67uLS2JTXRv
	 o7F2pp+Bqq4RkbOhbKNLTDve2aoRwcjn8MlNdANHIcyAKC3xnWLR6kdCSiCXc/Z7cU
	 fVJRHoKWjkpTg==
Message-ID: <sashiko-outbox-162450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] PCI/LMR: Add Lane Margining at the Receiver
 debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006-pcie-link-endpoints-v6-1-154d71657d32@google.com>
References: <20261006-pcie-link-endpoints-v6-0-154d71657d32@google.com>
 <20261006-pcie-link-endpoints-v6-1-154d71657d32@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 21:10:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] pci/lmr: pci_lmr_no_cmd() fails due to U16_MAX strict match agai=
nst Usage Model bit
- [Low] pci/lmr: Format string mismatch passing promoted int to %lu specifi=
er
--

commit 0a41b591425afa70cf540096078e9a59a614786c
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/LMR: Add Lane Margining at the Receiver debugfs interface

Lane Margining at the Receiver moves the sampling point of a receiver
away from its normal setting, in time or in voltage, while the link
stays up, and reports the errors the receiver sees.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> +static int pci_lmr_no_cmd(struct pci_lmr_port *port, unsigned int lane)
> +{
> +	u16 cmd =3D pci_lmr_word(0, LMR_TYPE_NO_CMD, LMR_NO_CMD);
> +
> +	return pci_lmr_write_wait(port, lane, cmd, U16_MAX, NULL);

[Severity: Medium]
Will this wait timeout unconditionally?

Looking at pci_lmr_write_wait() in drivers/pci/pcie/margin.c, it uses the
U16_MAX mask to wait for the lane status to exactly match cmd. However, the
command encodes bit 6 (Usage Model) as 0, while hardware that supports
margining will always set this read-only bit to 1, as defined in
include/uapi/linux/pci_regs.h:

#define  PCI_LMR_LANE_USAGE        0x0040    /* Usage Model */

This seems like it would cause the exact match condition to permanently fai=
l,
leading to a timeout for all margining operations.

> +}
[ ... ]
> +static int status_show(struct seq_file *s, void *unused)
> +{
[ ... ]
> +	seq_printf(s, "%s %s %lu\n",
> +		   type =3D=3D LMR_TYPE_TIMING ? "timing" : "voltage",
> +		   pci_lmr_step_status[FIELD_GET(LMR_STEP_STATUS, payload)],
> +		   FIELD_GET(LMR_STEP_ERR_COUNT, payload));

[Severity: Low]
Does this seq_printf() call result in undefined behavior on 64-bit
architectures?

In status_show() within drivers/pci/pcie/margin.c, the payload variable
is a u8, and FIELD_GET() evaluates to a u8, which the varargs of seq_printf=
()
promote to a 32-bit int. However, the format specifier %lu demands an 8-byte
unsigned long. Reading 8 bytes for a 4-byte argument can produce garbage
output or undefined behavior.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-pcie-link-=
endpoints-v6-0-154d71657d32@google.com?part=3D1
