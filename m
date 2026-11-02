Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628065;
	b=RWKLrlb/bQQDthED5tHy1mW6g8ZlAchgeTxqx9ALS8B5ah9wzlMJdlRHwtq4W2djpQ5H
	 yZHBTvo6qMuNy5c6d34V91pUPXX0JtX1/hW9/uR7L/O5z+RvX6BN+HDtPQ+yNW5WJ7h6s
	 z05ECYCeUl2LCnB8rZOkOwH7ODcyT6GgDeKZFmmbWNrGP1d63X1llsLFkxr4C7v0digDQ
	 uOTvPOsUdMU4776Idh4TQbgFIGBgciGnUmC9l5v/lDy14G+98twh64yq6Rc8wYoXUj+Iw
	 CHtfY1L8e72RXJI0qAp0yX3CjzRLPOa9seRpdQNMy4F/NWh6WaNf6UfAH0YWYOIEI7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dqc3cnjszQIOY6lECKlzxxp5vFSzlM2aUarFFoblubE=;
	b=27t942aWGi/j4S6Ado+0dUiJmzknSpqBUXsH8RF4n/k4ghGhModGL8i3KJHrCS1MozQk
	 xzarh5fScmNOB7g+QS36EJly16ZfjMFg/E5ivw+a/6RFQELZBvwEKAzFeC6lwwM8fBaIx
	 7q5buSmBn2H3tKe0ytRIXL4WlsiSdSRRhDnoAFV3PZXNv5DCsXMmeXout/zUh0B2/hrXq
	 K5GKtp+GQAoChKzZUAKrFGG5KQHIAwC65Hh+tS46vHmIRs9RC7JE9J+QMdVNFogghcP4+
	 UaPyNK/iA6aGbH3tVTzbJGFlnaJfePXIIQMM/ocpmi1iNstMq3L/aIOKZxSvT+/SKMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB3HIl1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37E606A326
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB3HIl1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0491F00A17;
	Mon,  2 Nov 2026 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628065;
	bh=dqc3cnjszQIOY6lECKlzxxp5vFSzlM2aUarFFoblubE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BB3HIl1fpF9cKoiJbRd82alpmjw1AMnLY8Su46wpgj5WUS96/18syd+gnBnK7qG0M
	 vsb+LSzRdZuuxQ5vL8NcRrRT3lZwASozbqgUAdjGQrIGZttA8dHbccQQ90DNf28o4e
	 cDdhbsy8ck+gzM/4uIJ+dtAhRIcLzyyoRt4PlfuoBqCFC8//PeT+BoGAxCrA3MdANQ
	 ZHa/EPEYi4sq2L4tNyeYJqujTw4bf3jE9sTJu8os4LaHHag6GviodO19ULtQBVs8Wv
	 spIXRCAsmhqfyxX7BtOGtNrws2qqgsXWz49U71nx3NHG6wElYi5/m9UTuvLbJfylY8
	 SAM6+HZaHGr5A==
Message-ID: <sashiko-outbox-193514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre
 M90n-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261102-superm1-kbz-222179-v1-1-c91a664ba251@kernel.org>
References: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
 <20261102-superm1-kbz-222179-v1-1-c91a664ba251@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:01:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On the Lenovo ThinkCentre M90n-1 (board 314D), suspending the empty
> Root Port 9 turns off a clock needed by the onboard RTL8168 behind
> Root Port 12.  The NIC becomes inaccessible and r8169 fails to probe
> with "Unable to change power state from D3cold to D0".
>=20
> The RP09.PXP_._OFF method gates PCH SRC clock 1, which also supplies
> the NIC behind Root Port 12.  Keeping Root Port 9 in D0 preserves
> that clock and allows the NIC to probe.  Commit 4d4c10f763d7 ("PCI:
> Explicitly put devices into D0 when initializing") exposed the firmware
> bug on every boot by ensuring that the first runtime suspend executes
> the power resource's _OFF method.
>=20
> Add the board to bridge_d3_blacklist to prevent bridge D3 transitions.
> Check the blacklist before platform_pci_bridge_d3(), since ACPI allows
> D3 on the affected hotplug port and would otherwise bypass the quirk.
>=20
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Reported-by: Joshua Perry <josh@6bit.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222179
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-kb=
z-222179-v1-0-c91a664ba251@kernel.org?part=3D1

