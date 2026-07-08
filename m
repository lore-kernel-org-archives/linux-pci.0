Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68E49251F;
	Wed,  8 Jul 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520382; cv=none; b=aCaiZwHTrwAxfB3xdb1RRmhzaGWlT5riukIeGg9woHcrEOeWY3C7L5zAcCGL0RSTH6xq9Ytkb61KTl866BUBJb8Db7F43D/zhFPtIvLSII0jt77z9JJ5FPUMZ+zkvzBhAIshoHz13bSjtCXEdML6wP7NU2Z+gDGPtuIqU0o945E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520382; c=relaxed/simple;
	bh=p7UcU81snsGsdUZMEy/2oUwE+1vlPk75sPcR6pU3K5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IFnOp8iQCFhnTn6GDhS6ws2Hwb1HNL+oRklrBsZY6M2+GX1ztPe6CPHH9NMYDpWGiwWEATnfKXoqkFi8lvQFdY9hR6soy8MjtInwjFrrQDNH6N4JXhPGnICLlMY9APuJiUxe4lMrJMnb32mTfQ6E0OCbFACVWciu/nQTSc23r9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihN9R2kn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihN9R2kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EA51F000E9;
	Wed,  8 Jul 2026 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520380;
	bh=MYMKjnLQ21z7cidLxamDMY/t68Jc2T9j8FrXG+Qu5fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihN9R2knWygm4/B4qdPwh8HbZ/wul4Qtnu+le/5Vs3TGvCdUp2dR6e/mm1huHvCIl
	 9CPWZvKqYhBPJ4Gx+m7H9My3arR8nYVSGOh/GHJzxeZ0DpKO9QDKhAS2tt5NgGzI+1
	 nmIe00pyLMgrkxZooT54ENQPFhVO9/kbFcAwPX2I1ZZp1Q0xaJWl8nRXz+8jRIGCYy
	 E6KHhSFi/oSOYkdINn6YQMuPqKNqvHeQvsUV5mIHzbXF2V5amx2pItAHdCl+I1wACR
	 c3Makf0dnaxkprTmLeCPBEUgVMVGjo+HszZ9PZRwqOJ2joRt4YRrm8qx0fJEqOzTd7
	 CLZviARnhMOEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] ACPI: APEI: GHES: move estatus cache helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-4-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-4-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:19:40 +0000
Message-Id: <20260708141940.75EA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Malicious hardware or firmware can cause a memory leak in the fixe=
d-size `ghes_estatus_pool` by reducing the CPER error status length between=
 the peek and full read operations.
--

--- Patch [4]: [PATCH v7 04/10] ACPI: APEI: GHES: move estatus cache helper=
s ---
commit 838eea76a409eda9e1dc7c8c377f46dbbbad493c
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: move estatus cache helpers

This patch relocates the estatus cache allocation and lookup helpers from
ghes.c into ghes_cper.c. It also fixes a bug in ghes_estatus_cache_add()
to avoid memory leaks and counter exhaustion.

[ ... ]

> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index 4649e3140888c..15305c8be9a74 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -55,6 +55,8 @@
>  	((struct acpi_hest_generic_data *)                              \
>  	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
> =20
> +extern struct gen_pool *ghes_estatus_pool;

[Severity: High]
This is a pre-existing issue, but does the system have a memory leak in
ghes_estatus_pool if the hardware or firmware changes the CPER error status
length between the peek and full read operations?

If malicious or compromised hardware reduces the length mid-read, it seems =
we
can permanently leak memory in the fixed-size pool:

1. ghes_in_nmi_queue_one_entry() allocates from ghes_estatus_pool based on
   the original length from the initial hardware peek.
2. __ghes_read_estatus() performs a second fetch from hardware memory. It
   accepts the new length if it is smaller than the original, persisting it
   in kernel RAM.
3. ghes_proc_in_irq() later calculates the free size using
   cper_estatus_len(estatus) on the copied memory.

Since the length is now smaller, gen_pool_free() would free fewer bytes than
were originally allocated. Could this eventually exhaust the pool and preve=
nt
the kernel from queuing further NMI-based hardware errors?

> +
>  static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  {
>  	return ghes->generic->header.type =3D=3D ACPI_HEST_TYPE_GENERIC_ERROR_V=
2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D4
