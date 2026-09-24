Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917F4BD7B2
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275617; cv=none; b=PjDWqVmoD16FggSOjHU4iGixm8JxNhT7fRteFDwn7Xrhn67T1E6iruWAZ60Y6yyiQyyRO/dRQPMLDH6oQDmEMrlheLZ8QgPM/HoM5FmHHCxXpn2ruWQdYkev1eetyLfxH1G2uVS+0WEu5hGtaNQ5R/zUl31OxDPutViQyeKmNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275617; c=relaxed/simple;
	bh=p4mZSDS9tAk2YPlZyee9k1JLOp7Pc913om9DKmqyzFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJFU8IHmg3vAfaM9DS7X/EJvFRqfoIT1Fft2EAf7tnzglRfoeogbR1TcAZjbxiqc14uVMmlbjsXeJVg+py+iSsFGxtPzu9rtn2vfmCCtwCoZhRqd7wQ1bLrDAgIXVWIzv5lHL+VmfHCz4KK/amipxa/eKuPhOo696TEtYgwTg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/8urfGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/8urfGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDB11F00893;
	Thu, 24 Sep 2026 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790275605;
	bh=p4mZSDS9tAk2YPlZyee9k1JLOp7Pc913om9DKmqyzFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/8urfGEqzxKIYdVBzMzAdGLiNVL6VvhxWjGMxVBmvG9L91iJTIdkXm8p+m1FJERe
	 ZMaAnFU1xHh4MsNdXkUkd8VnEQZCU2lb0ikYV2igM42Ho8m8EbPAAjbcDKEejeyHr6
	 dxD98lksF1bKrGrGklZDizw7a1H9BaWZfLw4xnM+XRZf3n6YE2tlutQvKjtwHQZh2l
	 3xSYqxoIw8wpTCFNLLTRDeHPkKRfZxa13mU6RLnfhkblFfySFU7Cnjnu4/iwUG8Wci
	 6qpPQP9MI/h92g88Ey+qydP0+EoN6X9MqlDbODKzQ6n5pUXC7AS3IO3nfU7gTCUSdm
	 jjqDvQ6ytBrDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] PCI/VC: Save VC state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-14-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:46:45 +0000
Message-Id: <20260924184645.8DDB11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the Virtual Channel registers, including the VC and Port
> Arbitration Tables, through the per-device saved capability store instead
> of a private pci_cap_saved_state buffer.
>=20
> Walking VC configuration space is complicated, so sizing, saving and
> restoring it were all folded into pci_vc_do_save_buffer() to guarantee th=
ey
> agreed on the buffer layout. Keep the walk shared: because the store is
> addressed by configuration space offset, the three passes now only have
> to agree on which registers exist, not on where each one lands in a
> buffer. Drop pci_vc_do_save_buffer()'s dual size/save/restore return
> value, its running length, its buffer cursor, and the sanity check that
> compared the two against each other, and rename it to
> pci_vc_do_saved_caps().
>=20
> Rename pci_allocate_vc_save_buffers() to pci_vc_reserve_saved_caps() and
> make pci_save_vc_state() void, since neither allocates anything now.
>=20
> The arbitration table offsets and sizes come from the device, so what it
> reports later need not match what was reserved during setup. Save or
> restore a table only if all of it was reserved, which keeps the request
> for hardware to re-load the VC Arbitration Table tied to having actually
> restored it, as the old code did by only walking the tables that were
> present in the buffer.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D13

