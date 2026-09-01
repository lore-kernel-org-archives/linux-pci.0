Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647E45D5D9
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248069; cv=none; b=fxLhZc43dVcPAAmqx4J69vd4uzUy8WY3OgXHGoOJdj5its3wKF912z5je15uUUZ1ORWTHwrfSi0aVex5EP7MZnhuUN4Cmn/GofKz4xlMwNC77ZI142J7W5so1CORQK9opOtIRQo8Cq6z5G9pzMQVwuSTSSL5M+b7Omh1nmud2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248069; c=relaxed/simple;
	bh=3aqF48uKPm/08eEooybh5hp+nVA9s/o3KeDDigvOp+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HeVaP193lCPsyyMki+wFv4Kjhag7Dt3FUL6MbHl4UXlX7p307s9y2/6S6WtttUjW+mDbxuJ9qmfu0TbTir6R58utbPGaTFDAgP3+Lp0iriprzotRJ9hy4HwWnJQ+rwelLIdE2knh7hNeifvah0/VbXt6DX+FXVW7gJ7ZHdCG0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIooRXEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIooRXEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC31F000E9;
	Tue,  1 Sep 2026 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788248067;
	bh=HlsXuySHNKy9nutM3jT2E6V8hIDpaPU8HOdiFTnJzUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIooRXElqbI9xJKkVUdFYURpXj3FkB6GaCe1FMOLQsvVT1SfcaLri4JXRdm9bzC0X
	 8TrmS1/4U3Cf30n/rp86y2Fami5COQ9sGbVf3iKIdcJvqpATQ1RHaYuNF4I5bpwWAW
	 ikgrQYDmHx9d2abATuyjXmSnYLTMf/d8q1eHlCX8vzdLDOrb0dGdytN8C8y1iX7MuL
	 Q9mkUPGJhDdRlieQn+lgAZYy3zWcTfdc19hvsYxcGJ4IaERuxQGmx9MuKV18mYIObk
	 c7wPqUX8+bYRhsBr9m5NCgp2IfuJ6FUeH9shTqs2kxK130w+/u61gfMt0tcUzn1kZU
	 imdqkduz7WOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lin Wang" <wanglin@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901071700.3255382-5-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:34:27 +0000
Message-Id: <20260901073427.BDBC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] amd_smn_init() stores pci_dev pointers in the amd_roots array with=
out acquiring independent references, leading to an under-refcounted device=
 and a use-after-free risk.
- [High] amd_smn_read() unconditionally evaluates uninitialized memory when=
 __amd_smn_rw() fails early, causing Undefined Behavior.
- [High] Kernel panic due to a modulo by zero if the number of PCI root bri=
dges is less than the number of AMD nodes.
--

commit 64cdde27c04c50425e1c00a79b17abd2a38904c9
Author: Lin Wang <wanglin@open-hieco.net>

x86/amd_node: Skip SMN setup on Hygon Fam18h models 0x04-0x08

This commit skips AMD SMN setup on specific Hygon Fam18h models (0x04-0x08).
It prevents incorrect node-to-root mappings by leaving the roots unclaimed,
returning -ENODEV for SMN calls while setup is inactive.

> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 0be01725a2a45..a0cfd74ada036 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -88,6 +88,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u=
32 address, u32 *value, b
>  	struct pci_dev *root;
>  	int err =3D -ENODEV;
> =20
> +	if (!smn_exclusive)
> +		return err;
> +

[Severity: High]
This isn't a bug introduced by this patch, but this patch guarantees it will
trigger routinely on the excluded Hygon models.

Does this early return result in an uninitialized variable read?

When __amd_smn_rw() returns early here because smn_exclusive is false (which
this patch forces for specific Hygon models), the output parameter value is
never written to.

Callers typically pass a pointer to an uninitialized local variable, for
example in amd_smn_read():

arch/x86/kernel/amd_node.c:amd_smn_read() {
	int err =3D __amd_smn_rw(..., value, false);

	if (PCI_POSSIBLE_ERROR(*value)) {
		err =3D -ENODEV;
		*value =3D 0;
	}
...
}

Evaluating PCI_POSSIBLE_ERROR(*value) when *value is uninitialized causes
Undefined Behavior and can lead to information leaks or KMSAN kernel panics.

[ ... ]

> @@ -252,6 +252,18 @@ static int __init amd_smn_init(void)
>  	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
>  		return 0;
> =20
> +	/*
> +	 * Hygon models outside this range, including legacy parts, keep the
> +	 * existing AMD SMN setup. Models 0x04-0x08 group SMN roots by socket
> +	 * instead of amd_num_nodes(), so leave AMD SMN inactive. The Hygon node
> +	 * layer, when built, owns their node-to-root mapping.
> +	 */
> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON &&
> +	    boot_cpu_data.x86 =3D=3D 0x18 &&
> +	    boot_cpu_data.x86_model >=3D 0x04 &&
> +	    boot_cpu_data.x86_model <=3D 0x08)
> +		return 0;
> +
>  	guard(mutex)(&smn_mutex);
> =20
>  	if (amd_roots)

[Severity: High]
This is a pre-existing issue, but it remains a severe flaw for other
configurations (and is not fixed in subsequent patches in the series).

Can this cause a kernel panic due to a modulo by zero?

In amd_smn_init(), roots_per_node is calculated as num_roots / num_nodes.
If num_roots is less than num_nodes (e.g. due to virtualized hardware, a
broken BIOS, or unusual topologies), roots_per_node evaluates to 0.

The subsequent loop performs a modulo operation:

arch/x86/kernel/amd_node.c:amd_smn_init() {
...
		if (count++ % roots_per_node)
			continue;
...
}

This division by zero triggers a Divide Error (#DE) trap, leading to an
immediate kernel panic during boot on affected hardware environments.


[Severity: High]
This isn't a bug introduced by this patch, but it remains a severe flaw (and
is not fixed in subsequent patches in the series).

Is there a missing reference count increment when storing device pointers in
the amd_roots array?

In the amd_smn_init() loop, the device pointer is saved without acquiring an
independent reference:

arch/x86/kernel/amd_node.c:amd_smn_init() {
...
	while (node < num_nodes && (root =3D get_next_root(root))) {
		if (count++ % roots_per_node)
			continue;

		pci_dbg(root, "is root for AMD node %u\n", node);
		amd_roots[node++] =3D root;
	}
...
}

On the next loop iteration, get_next_root(root) is called, which delegates
to pci_get_class() and implicitly drops the reference count of the passed
device.

Since this executes unconditionally during a successful boot on AMD hardwar=
e,
the array holds pointers to under-refcounted devices, creating a
use-after-free risk for PCI host bridge devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901071700.3255=
382-1-wanglin@open-hieco.net?part=3D4
