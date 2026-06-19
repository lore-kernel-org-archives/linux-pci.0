Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E53C1089;
	Fri, 19 Jun 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888705; cv=none; b=fedFNN7XAUi1/RUUUJtBHKzkmh/Z/wgr2XAvH1mbZaKYCTkW5Aa4wAudVZasdEsJpOfS8GMK0qgkoq2FlNF25RTXS0lbzx/JVVu/PWzaerNk6MeuxI/P1Lhj57DFvwiZ+Hbh6U7YG7QSlqNT9/3/WhwQU1adWziA8ir4FMvfU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888705; c=relaxed/simple;
	bh=40r9Lyzv2J11YrFPhy8F/INBoIxP067/oMfxRzDHYbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aSFeieXhKzHvfFNKjJQH1hiV3Jum/PndzSssO0A+XWG5w1RrU8vbMqxPH60fI4AFbjYob8oPxgEnQgOwMU458czfvW7QJvs0g91dzyVObB//kZXIzLrpYP243dE2PmbTSjVCgRWUnkMOBvMCF7eZjHnX5MSVL2ChYStoajxdI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTMSAK8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTMSAK8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518F61F00A3A;
	Fri, 19 Jun 2026 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888703;
	bh=8tM/kR9+I+u/g/G+LwRtgNCMSOL8FvaSl+que3v8KQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTMSAK8arHXpLrJJxWLqZSIqHOCJ+GFNSZWbpk0ejmlQyuq1QaxrLi/KLT8zI1KqY
	 v5ugc8wGV8odfb9NAcxEWV04DUe3wzcWGYJRunKNvOS2GAxcqnTbcegOm9Jb5nZ4Tl
	 iVOrGcFC27fY+vCoa2Ijohc5KoIOYQG/IKdzyAoxMoDv1e9ggO2cbSsYeUJfE46ww7
	 qyKMv8347pw38Oh/f8Ri7IJytqCfCGmvUvV6HYa7ejdLoV/rjnARNCmykChJxy3SfB
	 huMl78lB/1pW7hJ0oFo/rbkX+9aB1qzjS/42SSzsj+UDP9n51Hq2fderkuhVLKjCpt
	 VRwjVuVv7x1nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] rust: pci: use `Option<&IdInfo>` for device ID
 info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260618-id_info-v1-3-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-3-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:02 +0000
Message-Id: <20260619170503.518F61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The dynamic ID matching in the PCI core returns a pointer to a dyn=
amically allocated ID without holding a lock or reference, leading to a Use=
-After-Free if the ID is concurrently removed via sysfs.
--

commit d1889a1b7c5b08bca9b93c95bb95cf7a983ddfea
Author: Gary Guo <gary@garyguo.net>

rust: pci: use Option<&IdInfo> for device ID info

This commit updates the Rust PCI probe functions to accept an Option<&IdInf=
o>
instead of a direct reference. This allows the driver to handle situations
where the driver_data is 0, such as when driver_override is used.

[ ... ]

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 5071cae6543fd..0e055e4df99ee 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -113,7 +113,7 @@ extern "C" fn probe_callback(
>          let info =3D T::ID_TABLE.info(id.index());
> =20
>          from_result(|| {
> -            let data =3D T::probe(pdev, info);
> +            let data =3D T::probe(pdev, Some(info));

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing
Use-After-Free in the C PCI core that impacts this callback.

In the C subsystem, pci_match_device() searches for dynamic IDs under
drv->dynids.lock and returns a pointer to the interior of dynid after
dropping the lock:

drivers/pci/pci-driver.c:pci_match_device() {
    ...
    found_id =3D &dynid->id;
    break;
    }
    }
    spin_unlock(&drv->dynids.lock);

    if (found_id)
    return found_id;
}

Concurrently, if a user removes the ID via sysfs, remove_id_store() frees
it unconditionally:

drivers/pci/pci-driver.c:remove_id_store() {
    ...
    list_del(&dynid->node);
    kfree(dynid);
}

When local_pci_probe() calls the driver's probe callback, it passes this
potentially dangling id pointer. Since the Rust probe_callback() receives
this pointer from C, will dereferencing it (such as when calling id.index()
just above this change) trigger a Use-After-Free crash?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D3
