Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16197544D60;
	Tue, 29 Sep 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704124; cv=none; b=bIVg2GFLOe6j4HVtkDRdlhOWGpNjFMRRvOw4WQgkvXciMa3iAyeQJeZ72Z/NTzDi3PUWEFlxQZBt5+VG3tWp76bmfT4Oi3Ewg2tl/bKCWeuRekHWIBPiTYJXZLwDUXlGuRFXEZRjjxKaMrOLexrBokcKTLNzEaJj/i7CPuVXhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704124; c=relaxed/simple;
	bh=L5BYr1rUXsgcjbsVoFBTLKyCjU/bwGEAQsTPX+aNqNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=adlULs29j054QzjA48FNJCRxd9YbrU1h8neI5lz4OOu8wCHewXxIKXOntX+ZoNlhGlpkN5WlnDvtJ1Z3f7E92TBo30zH/mukdl3EzQCjd5qVQPhH8WsL199/11SmO/OJv3LygNvbI+2SiT81yVGXoAwLNcbcyh/vchMnWL+4hpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/RtGGex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/RtGGex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F89B1F000FF;
	Tue, 29 Sep 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704122;
	bh=L5BYr1rUXsgcjbsVoFBTLKyCjU/bwGEAQsTPX+aNqNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/RtGGexI8ZI+zEpycB4wNldDALxMKUQBu/RWaR9zzBFYy+YI1m/ZfT9Zo+tporjG
	 2NloVhS3RryO2OUomid+DeyYpKpWNDFN4iTN3sZYw16m3RTavyeqF3Tcp5fA0hVAa1
	 wPOXTrQ1/uhx5Fdwj66H2zIQ8duIlEwhytZlnnsypLl7YXrzxphaT9VrST0ZJM1o08
	 odZjteeF8hdj8C0PdR3hLcrl4qc3U/fpEVaB/M0gVMX3YBxjiptdFt9fg5xN0QFVzS
	 jL6UkfJ/0WXoQoHgJMSCknxdta0omqXxFDi6KDW9C9fnDIHLZyysIAl4RAMekLO990
	 dMZMTdL0ZxcXw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/16] vfio/pci: Add a device access gate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-2-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:48:42 +0000
Message-Id: <20260929174842.7F89B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PCI error recovery needs to block new device accesses and drain
> outstanding accesses before changing device state.
>=20
> Add an SRCU-based access gate, enabled by pci_recovery_supported.
> Serialize open and close state updates with access_lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D1

