Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44035A395
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791648812; cv=none; b=UiMet68Ar8HuC4EfmKRSAuP8VAZAKS8A2pzL6Fucs2lwQ3QLK785vYcAzK/AUCcykuT3/8HsOXlyNp9K2747IddUXn8osYQK8OXcWAlaNI59Gu7rOZ4/vOLG/p2jSbVByzJE2Xbg5bAVhUb5/pdcn3G76HFZrZzjWPcPucfQmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791648812; c=relaxed/simple;
	bh=BeMZJ9Q/ZtygO+UumsVXjiO/XyYSZ+ewkAtJ6ozS1aY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Vlbvkdsk1TEpm6YT8g/fwFyAGHd3oRVl9z/Wks5wN1KDiZnjFJq6RhaVOAwnPlR3o/3KbM2AXbnpG+P/iPEq4opuAqyhZfAl3sOe7hsIo2ttox06+LVsLK8XUf7S+E4CjteQJfCVD0CFOFekylmmR531NTN62O5V4y89N+WFQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWz7Dh8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWz7Dh8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F211F000FF;
	Sat, 10 Oct 2026 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791648811;
	bh=9ke1T2goKez+6T/4MlpReCNQIvshyRl1hvs+baFVXn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWz7Dh8Ubrqw/z5moF0Pfxh3hFsBgXL3OyoCCN/q0trpJzhQ4GMhxkX7J7jIO5+h6
	 IyWgLJh+xB1r3K9RRm9RE651uQsz2e1FV3E6WmQViemZtAESyF5BLzE0Bn27baEFGu
	 3sodkTY0SFTzt+9kIU8unPI8g1inXE6louQAFZAWK2faWfcpqfvYlCKFRZUG/K1Mhx
	 QTTGjIPfNUTSjJdvJtytDp0G1r6PDc2icKIKjuqHROtJWavKPD44POpwGTVnGZQbtl
	 54q7zxtYxo+50XjF8/GMpgepVE2UPQCcKMOwtq45/YxDZrlDiVU3DW/1P/bUMgL+cr
	 cxfn7anw9kusA==
Message-ID: <sashiko-outbox-166727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: Wait for readiness after FLR even with
 Immediate Readiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261010160529.27974-3-gruhlke@mailbox.org>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
 <20261010160529.27974-3-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:13:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_flr() and pci_af_flr() skip pci_dev_wait() if the device advertises
> Immediate Readiness.  Since commit 10baa9b4df40 ("PCI: Drop unnecessary
> retries when restoring BARs"), the subsequent config restore isn't
> retried, so it is lost if the device isn't ready after all.
>=20
> The Samsung 990 PRO [144d:a80c] advertises Immediate Readiness but
> returns ~0 for 1-7 ms after FLR, which breaks VFIO passthrough.  Keep
> skipping the 100 ms delay, but call pci_dev_wait().
>=20
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Link: https://bbs.archlinux.org/viewtopic.php?id=3D314833
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010160529.2797=
4-1-gruhlke@mailbox.org?part=3D2

