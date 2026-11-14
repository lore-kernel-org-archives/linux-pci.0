Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616894;
	b=dTIl6E2mZr2jHPTi2Oafe1PgsBZIv1sJ7sdY87NbgkdW/B0BkfMP4GOSbDFIPqK76/DN
	 9zLN1eJDIlOrDdXfOm5aWlYAXzvbuZ8sImmGMcj2kyLX5644QPCuHudpJCP6ttj180tiv
	 qcjfB99Bhmka+CoOZllKlaDdNUe1LZXS0uNrZgPA545MqK4SIeoAbAgGTgbw6PxQNveSD
	 QKEyHYzy/IIdrA0A5vjsxLXnP6VN0SY9X/4XDLScdMq8T43t7krBbQUNmSkvyKm+9wi+o
	 QAq6g/W3aYgIU/YtS8UdhF/GeFGncUfuFnBMdzCDwKYMhicZiw/csqDG08qhm1KzOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z4uAM36ERz7CPf7OGOZjAKK0ACf/5zJe3fik0YMMseE=;
	b=B2Fq8q3hSvzW97luaRXW5x9nmZ9hi7P11wsbzMdp8Xqc3M/+zGwcWbu8x+aaqTL+cSFg
	 6nAMM2doaBMQouSxXTWjmlOEJVodcel3CGyUeAqAZOSIV13RLH8G76ietkLQVw3VDXWHc
	 ZcOwyzZLdk+JVRFLgiPiRvF6tcqgWj7DQPXVYQxI99g44zcrPTSi6F4WISReprj/yhGID
	 UuXm9n37W705hWEsRE04FKQSJjx0YY9Nj2Ti0N7ibzKl1AEmVzCYDznBM7CyHST68oXQz
	 ctg98FmyqaMWg+PWoPN0HhBewNTExzl3ThBKSUM7BTI0lGjjI2JEBIx57MI0uNTAydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7xX0iNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1F606A886
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7xX0iNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9D91F000C5;
	Sat, 14 Nov 2026 00:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616893;
	bh=z4uAM36ERz7CPf7OGOZjAKK0ACf/5zJe3fik0YMMseE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7xX0iNZ8y4bcIdxkuDzJ/sI3dCw451tRxPHgkeu2advZY+RHtS03rXEAPq7QYebv
	 /ZX7EYY0hgtpznUgoMb4foPewb4/VywNEc/AhiRU5XEyoPuNpRCaoOVdowqsUaJDkw
	 oEa41Dpj72q/8QYdQZaW+DOA7Ehx3yv37AgJRGS0h1NKDnw1VI1CZ9oncES7lOO+hP
	 Cn/B0+1KDhbku8KsJBLBJZ9A4OSdlYhUvGD86VcFhLhHWsFy6GvfMb9v7MWlEoN5RD
	 SAqgHEqMlScCINx2U95kHorRZ6xpKNmShj9LahEw9tQPfNJHEl3ZP2R7s4V/xwiRNR
	 fXo4to6twYFig==
Message-ID: <sashiko-outbox-213942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] arm64: Allow synchronous abort fixups for
 guarded MMIO reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-rfc-b4-v1-2-b91dcb502250@boondocker.io>
References: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
 <20261113-rfc-b4-v1-2-b91dcb502250@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:41:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] arm64: extable: fixup_exception() and insn_may_access_user()
  match non-SEA faults
- [Low] arm64: extable: missing __DEFINE_ASM_GPR_NUMS in
  _ASM_EXTABLE_MMIO_READ_ERR_ZERO()
--

commit 1c63c0d5426ef0604198833160287cf9aa8cf068
Author: Matt Thompson <matt@boondocker.io>

arm64: Allow synchronous abort fixups for guarded MMIO reads

This commit adds the EX_TYPE_MMIO_READ_ERR_ZERO exception table type and
hooks it into do_sea() and fixup_exception() to fix up synchronous
external data aborts on guarded MMIO read instructions.

> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/as=
m/asm-extable.h
> index d67e2fdd1aee5..ed80aec162798 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
[ ... ]
> @@ -123,6 +124,14 @@
>  #define _ASM_EXTABLE_KACCESS(insn, fixup)				\
>  	_ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
> =20
> +#define _ASM_EXTABLE_MMIO_READ_ERR_ZERO(insn, fixup, err, zero)		\
> +	__ASM_EXTABLE_RAW(insn, fixup,					\
> +			  __stringify(EX_TYPE_MMIO_READ_ERR_ZERO),	\
> +			  "((.L__gpr_num_" err " << "			\
> +			  __stringify(EX_DATA_REG_ERR_SHIFT) ") | "	\
> +			  "(.L__gpr_num_" zero " << "			\
> +			  __stringify(EX_DATA_REG_ZERO_SHIFT) "))")
> +

[Severity: Low]
Should _ASM_EXTABLE_MMIO_READ_ERR_ZERO() emit __DEFINE_ASM_GPR_NUMS and
use #insn, #fixup and EX_DATA_REG() like _ASM_EXTABLE_KACCESS_ERR_ZERO()?

Without __DEFINE_ASM_GPR_NUMS, any C file using this macro fails to
assemble unless it defines the .L__gpr_num_* symbols itself, and callers
have to pass pre-quoted string literals for the labels and register
names.

> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 299a244f68e60..c9b59449fbb24 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -100,6 +100,7 @@ bool fixup_exception(struct pt_regs *regs, unsigned l=
ong esr)
>  		return ex_handler_bpf(ex, regs);
>  	case EX_TYPE_UACCESS_ERR_ZERO:
>  	case EX_TYPE_KACCESS_ERR_ZERO:
> +	case EX_TYPE_MMIO_READ_ERR_ZERO:
>  		return ex_handler_uaccess_err_zero(ex, regs);
>  	case EX_TYPE_UACCESS_CPY:
>  		return ex_handler_uaccess_cpy(ex, regs, esr);
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index b22736853fcd8..148f7c98ab444 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -877,8 +877,19 @@ static int do_bad(unsigned long far, unsigned long e=
sr, struct pt_regs *regs)
>  static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *=
regs)
>  {
>  	const struct fault_info *inf;
> +	const struct exception_table_entry *ex;
>  	unsigned long siaddr;
> =20
> +	/* Only a synchronous data abort on an explicitly guarded MMIO read. */
> +	if (ESR_ELx_EC(esr) =3D=3D ESR_ELx_EC_DABT_CUR &&
> +	    (esr & ESR_ELx_FSC) =3D=3D ESR_ELx_FSC_EXTABT &&
> +	    !(esr & ESR_ELx_WNR)) {
> +		ex =3D search_exception_tables(instruction_pointer(regs));
> +		if (ex && ex->type =3D=3D EX_TYPE_MMIO_READ_ERR_ZERO &&
> +		    fixup_exception(regs, esr))
> +			return 0;
> +	}

[Severity: Medium]
Can fixup_exception() and insn_may_access_user() still match
EX_TYPE_MMIO_READ_ERR_ZERO on non-SEA faults?

The ESR check is in do_sea(), but fixup_exception() handles
EX_TYPE_MMIO_READ_ERR_ZERO unconditionally and is also called from
__do_kernel_fault() and do_gpf().  A translation or alignment fault on a
guarded MMIO read (such as a NULL or unmapped iomem pointer) will be
silently fixed up to -EFAULT instead of oopsing.

In addition, insn_may_access_user() returns true in its default case for
EX_TYPE_MMIO_READ_ERR_ZERO:

arch/arm64/mm/extable.c:insn_may_access_user() {
	...
	switch (ex->type) {
	case EX_TYPE_UACCESS_CPY:
		return cpy_faulted_on_uaccess(ex, esr);
	default:
		return true;
	}
}

If a guarded MMIO read in process context faults on a mapped readable
TTBR0 address while PAN is active, do_page_fault() treats it as a valid
uaccess instead of calling die_kernel_fault(), and handle_mm_fault()
returns 0 without advancing regs->pc, causing an infinite fault loop.

do_sea() also calls search_exception_tables() before calling
fixup_exception(), which searches the exception tables a second time.
Checking esr in a dedicated handler in arch/arm64/mm/extable.c and
returning false for EX_TYPE_MMIO_READ_ERR_ZERO in insn_may_access_user()
would restrict the fixup to synchronous external read aborts across all
callers and avoid the duplicate lookup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rfc-b4-v1-=
0-b91dcb502250@boondocker.io?part=3D2
