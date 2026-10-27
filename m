Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104406;
	b=TfGfCHmR6FKILu2VzvZM4Zg0u0tUDwUcOA8IirRvR0zT3CNtnWGQ2kjZoKcm+tFPW+Zu
	 rhyv2OHuqIJZkMtnzK9TpN071T0FfQAE/DBZkelnANDcjIkT8Rhs5r2lLyssjDqH1z3l6
	 5x20Jppv3M0G4fRzwFcDRpvNOtwDL3NtDjU+o46O+JFKzIgMeG4YCPkzT9pE5wqA4dqF4
	 w0BurW+NDf9IcCU18O9LAE9E8Hb+B74qm0gElM4XviIdk5Eqlj4uA3JN+Akpp6DoEVwfl
	 J3hP+ZEUyNU6RblVihAkWkMnO39wI/sZ4DHmnG4yoBtLdRImmG4Hq5iASQhF5Q7b3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iZwVlV6cZY7/zWoKYzT3qBv4xTJDVgWZ7pnP3hVUkII=;
	b=qabJc4vWcTnCZ8MLcNJY8iqyCE2d7cKhJlmr1mHpGsTw0XDn61C/6YcCypSs79edgkVv
	 2t2X1fV+rrjNpWQh8VHJ4LWnHy8i39wFEp7bbNLZEHxKA+cHSzhvym0DQ2VWvE41GArfZ
	 8zrUXQrMKrAmIWlFLYR+AqaiUDxQ9/bzOaEW99IYNkdtlV8wtLX+Vm/cgTG/j49c12Q2+
	 SKV+iSJS1Z/rQF7gBPpCt6YjUrj+WQBJK0LTxPDqYkq2uqeUgJmFyjDSqbHymwSsKxb+z
	 Ndm442f+ii9ai05FW1dsohm1yoj/4GVvP8rH7PjArgCFmAwTnpNvIpOXODXn2VpN8JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4yQtIoN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489C606A326
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4yQtIoN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D281F01829;
	Tue, 27 Oct 2026 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104405;
	bh=iZwVlV6cZY7/zWoKYzT3qBv4xTJDVgWZ7pnP3hVUkII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4yQtIoNQoJ+hXvdYfzamgTUlYyaeULVEh20X1QKHg6k6OltGr6fazc7MoE5hEEeK
	 KFApMaX/r+y/rFmcJ17+wrMDJVgkvN4bb+0e5+D3IqYCtfmIhZ1cry9/dVWLZDcfOW
	 MmfsyUB/RJSIPgVDKpWo2A2xr5otHwwjvDFmQRvf289UYlOlKb8ZFlzSB4eeLooRpd
	 njzwE4qT7pIZfja+5HNNhApuv6dBjboqoGh2ZiF7LtqWr6YXB+cp3xEwQ5Pxqn54Wz
	 sQ8tkGh3f30qnNGFmSOS8stO0XKjOWawdbzfxUAeMAmlasYidW8e2rCTuqop0Sasim
	 /3DZlWxv/dKfA==
Message-ID: <sashiko-outbox-186561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-11-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-11-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:33:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the three dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> the qcom-ep driver with dw_pcie_get_pcie_cap().
>=20
> qcom_pcie_perst_deassert() is the point where the controller resources
> have just been enabled and DBI becomes accessible, so the offset is
> looked up and cached there. Both the L0s and the L1 exit latency are
> then programmed using that same cached offset instead of walking the
> capability list again.
>=20
> qcom_pcie_ep_icc_update() may run from the global IRQ handler, which is
> requested before the PERST# IRQ. The helper performs its lookup at that
> point of use, i.e. exactly where the open coded search happened before,
> so this change neither adds nor moves a DBI access and does not
> introduce a new race with the PERST# handler.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D10

