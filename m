Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183139;
	b=CiyN/EAzwSBn1qILW45Xpk8Z9WZ1AB4I1sZWhlGAIPZWxCJyjcljdd49ouSU5Kkrm3FL
	 p501eSFoS0a4wpce+RWD/CXDhPly0JGnoUhZ6l0lVHZdP5Pind4ugNSDXd7z63teYO0eV
	 PQLfTnTc0v9OvdxWjqpd+LFAWdUf3YGpZQQfzOmTX1sEwV7sBJiaypG2vyEp1UOuex6WM
	 F7JKmZoUCzy5c0/WcmYDOGc/euVJ5ZGXWQUXX4g4rFKtNVnhT7cJk6gFM6t7wp0D8gIFC
	 jiqvbFM/XxlikemoFkmidZU+KEyOsy38TxvkxRdLQvJxDJwHQKHs9eweNmhI3FcLDKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/IMdG7I1a1eMOhzU+8ve1hip/5auLKiUFjRWv25olI=;
	b=abYu7YcLerhAA39UKVdVU9+4OKpEqtALcxA4j1/PxGPW7d27ue6RmDR9FgFyy1A6rvQX
	 VKV+F72S0sVT9FXyvLXEf3PBIMFtswSErYT3xiHBiLjuUKM39JI2HPArt5Kp6vddyCSPG
	 LKjZOyh5p5VxS7JQj7erwA6m3vsYOuJ2bEV3kPcUNI5fI5jUUHcxzSXN6JI6tvdGomYMm
	 AOMLguc/vcb3CKIuhbT0K+ctCvCdBHMeli06y3UjYVOQAdAejFLhBChH61rdzaBkot+tS
	 BY21Ag/XLC9d3C0FFUxssYn8CV0kec2JqOULpmZ5UD0UwxyquOAK5b3eCKnF03w5WLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1+6xpxZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0C606B9A0
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1+6xpxZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AFD1F01577;
	Fri, 20 Nov 2026 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183138;
	bh=A/IMdG7I1a1eMOhzU+8ve1hip/5auLKiUFjRWv25olI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B1+6xpxZfUXqG3HLmM640HRFX9KcVtM8rMLTeYuv372oql7JHnfHMud1DebVY0hca
	 1qJPlK4QGimlGpd5Ay5kwbJ9X7ZLWwMKj71wpTpQh6JqYtnXdIoVKhxuA5JsWVvcAi
	 2pUECHOHs7EbEKgiheoDB5GVyb42RsVmjkqIHKESPbC+DlQy3E0XzeAuHQW7XP66mw
	 eiNyX3438qBVyCUAVNpusRNBqcnSZLO+CY19/jg73nxl8pxD3ycE1JRGwRHlTg1CMf
	 e7lU9MU0YqE6YWnisRiUL6u1EK+bv7PfeVZiefLgWo84Hy2XBa8qB/DUIukXq82ly8
	 agDyn6xj3mnfA==
Message-ID: <sashiko-outbox-225308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/16] PCI: octep_hp: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-14-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:58:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Octeon hotplug driver scans a single device and then attempts to
> assign its resources using pci_bus_assign_resources(). That function
> makes bridge window sizing disjoint from the assignment phase and is
> going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be a no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D13

