Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF554AC157
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274148; cv=none; b=izH4FwEmzHzKBQ8pKhDJS1d5jQ2AvXAGwyGXERkqa5Fa+Vwb3xFubDTpKKd2m2xvZsQU6SJvy3hgAZCLo6vD8eciZuNR1vgEbKBKWqMDZSlxioqFUOOPG74xC8yzFQUqoVCXND7SDMkA8uJoxcfPUSTS5Y82zBYvzBNQCgWzOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274148; c=relaxed/simple;
	bh=bMNEBw24v0V5RyMt1fc1emu6vHoxxGDz6O6NnhOVuXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y39YMb0bbHVwMUMiSqQs3Mz3U8gsLU09i2Pnefih6A6BbJ//+9lq6Ml4B5TBKqy19nIKwpzs93yfzezDwuJtT0UrI1OyXSr4ifH2C0P/cQ6kG9zLriMCbc4fWYmtSO+r5r3zXwizd1nUOs2jSO8EmftCbB9ZDR06o5wvrq46u9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy/lugun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy/lugun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599E01F000FF;
	Thu, 24 Sep 2026 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274146;
	bh=bMNEBw24v0V5RyMt1fc1emu6vHoxxGDz6O6NnhOVuXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vy/lugunPtEbH0Quh1gKwMvYk+0h2A/9023crHNgooAoSAWfSw8Cfyxv3cFjfeSGS
	 QXxjPB+jmRvAoaTSWk/hyfCuGFMv1OZNMb9GnhYCCVA96hP1YToTbQ1F07hbhs57UP
	 lfPF7flmQMshgoeI770Qv7QsQVoiGlijfEOfc5ErrRSODrYMuvU3WI5vdNHOjW5dA6
	 Nh90d/9w/ABelFdEwFsOu6v7E5yNyivwQKbz15C711UhsItzpxuiEuDEsatnKmar+L
	 rfDhNXaRlp6E86tGJW4e0Ubuh+CgYNauG4sxF/WYZxkLD3r+j1tD1JgSiobP7rmLt9
	 FYUKWpca+o5Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] PCI/ASPM: Save L1SS state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-8-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:22:25 +0000
Message-Id: <20260924182226.599E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the L1 PM Substates control registers through the
> per-device saved capability store instead of a private pci_cap_saved_state
> buffer.
>=20
> pci_restore_aspm_l1ss_state() needs both the Upstream and Downstream
> Port's saved L1SS configuration, and had to fetch two buffers and decode
> each by index. Read the saved values by configuration space offset
> instead, which names the register at every use. Add
> pci_read_saved_l1ss_ctl() to read one device's pair, so that the Port
> and the device below it are read the same way.
>=20
> Reserve PCI_L1SS_CTL1 and PCI_L1SS_CTL2 with a single request, since
> they are adjacent DWORDs, just as the old code allocated one two-DWORD
> buffer for both. Skip the reservation entirely for devices without the
> capability, which the previous code could not do because it allocated
> the buffer through pci_add_ext_cap_save_buffer() before looking at
> pdev->l1ss.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D7

