Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94B39CD11
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381043; cv=none; b=dKszJOpVcBzSORoWqR6fZq2CQJD/kE9wJUkrlVFy8ipquIMSnYZuerbzL+mjsyBpNE3W4cGNs2obI+xMO1fwNFJztVThG59qUaUXEeEigsrUu+earHeGsEwugJ+m+3alo4FEJ2vJ1BGOuENdi75BfsjaZGwe3kJopFIH1XdEh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381043; c=relaxed/simple;
	bh=vkUoOE3/1pehXtUZv/hPbdrU/VNnY6sVFHb1lUeU2dA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TYA5k0gur/PgBm/e1cgwBqgU6uLLAIqPtYE2WHcWkOXtCLcyoK09k0qDnep/doAw6e8vBSGC/EuCQ0ZMh2PnpP0D12m1UWzivaD7V3Eqh1E5E/1zMByYtvmAdy9NmdeHmjeybHQa/HJnHrcVkCg8RKTaAdmOpd/LKRrTwVT8M8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW8MGM6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW8MGM6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6417B1F00A3D;
	Wed,  2 Sep 2026 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788381040;
	bh=vkUoOE3/1pehXtUZv/hPbdrU/VNnY6sVFHb1lUeU2dA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kW8MGM6pFblF5adTa3Kf3KE7qCeZevlW+UPq98FvHgMoG6SYw8oYEhX4MOQ0KolIW
	 5YbzpHROZAKyBlxhsZ0dUZUzmrj+IxYsoz/NjFr/NhxJsedwtK7fsGNhekDda9Ic47
	 hoOH69TFQxdJvQnaUbEcfyU4XK3SEUTAH8cduU8zIpto50P18/IAt7sEcZp+82pq87
	 gTXvCs8uWS8kPNwtqrSQJWtfjZUDK8zUAgyxM/OdMthFADyssyf+qWQG58k/4IMh29
	 nnBLMylRIvtUMngT0X4jVg7ya/6zRRvJUIqIZXTncRJjMGZbIbkmQX7ZfIC7JoaZu0
	 PXLQ0jxj6U1ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] ACPI: scan: Adjust and rename acpi_bus_attach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9686682.CDJkKcVGEf@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
 <9686682.CDJkKcVGEf@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:30:40 +0000
Message-Id: <20260902203040.6417B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> After previous changes, the second argument of acpi_bus_attach() is
> ignored and none of its callers checks its return value, so rename
> it to attach_subtree(), add a void wrapper around it called
> acpi_scan_attach(), and adjust its callers to invoke that wrapper.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5144065.31r3eYUQgx@=
rafael.j.wysocki?part=3D5

