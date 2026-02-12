Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC73B19F;
	Thu, 12 Feb 2026 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907280; cv=pass; b=pqIMHTHnsLeDxgsG2z48htcyS12Osu1E+yKboJU15TCfIg1zrkGcE1R9uZCUKkC8J0Y39f+lND+rm/+0vaY6ARvcnNB9NDYoBgpDerhHmupyivNj3Zsuaw3/a95+oWOXP7xkcf+FGV3pM3tw+5vUElqSYwPBy0KFklKhdZQk/yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907280; c=relaxed/simple;
	bh=dvQQBsBQ2yZ1RNMToz4U18kQI9+/xsePem4SI7FnS44=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DcMS/2bhSX38d1XA0I7fMwW8YBXpuW026i/Y2GwpbpnrYZYk0dDIc3U8WrKvmC/fzcIh0F0IAxXi9nvz3+zqvaOLmBIsam7FQzGwglNyL7jTr1gJr9+FgY3u00Z16fQDdLM8MJSkYWwbx5vq4BzgPmAKX8+rREMslgiiJi1pKTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=EV7eV4YA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="EV7eV4YA"
ARC-Seal: i=1; a=rsa-sha256; t=1770907259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O7tH2iA9RVnc36cSs0bNCzSylAcF1RHiqzshjF57macg9wdCXbfJ4hGGPzEpDjK8nEyNVDim68+4R549mWMD0Hq+wKp4JCVAfB2fAr55QiDEx/+wqq6yOzMGT+kdmjrtJA8IBDNOQrKIh5mNiBo9Zax+4wzHOwfr5e6cnHNbcFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770907259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dvQQBsBQ2yZ1RNMToz4U18kQI9+/xsePem4SI7FnS44=; 
	b=RfszTj6d5edP6/BqoIBd0sMinAfoVcb4/yZTthCuXCmVpwkxsXdTaXL2tS1PoXuCnT4yGWWOUzwwlwHB/753CEYrH84UNEUN7XalKpJKMC016Y2G3Y7ODlLL67p8veszJ2NGAbFD7C2djrO4hsnXoLhI5yZ1qNSzHvruYi5J1Rg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770907259;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Content-Transfer-Encoding:From:From:Mime-Version:Subject:Subject:Date:Date:Message-Id:Message-Id:References:Cc:Cc:In-Reply-To:To:To:Reply-To;
	bh=dvQQBsBQ2yZ1RNMToz4U18kQI9+/xsePem4SI7FnS44=;
	b=EV7eV4YAsxo7h2hFRvINmOIviM+YD3/Ja1eYJEaIBre79/GjgANBXbJeiOVfmZCA
	90cnBYfo5zhtIJ8EzWYdlNww+9gVp3hp6ypI4KO413mpwb2/Akyn3cJ/2HEhfsw5Asu
	CRqGyFloHLL0yBfBQl3dqBf5vl1ZMxDfdx7xsgVA=
Received: by mx.zohomail.com with SMTPS id 1770907257830939.3426571428066;
	Thu, 12 Feb 2026 06:40:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Daniel Almeida <daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
Date: Thu, 12 Feb 2026 11:40:17 -0300
Message-Id: <091AF422-90EF-46EE-9A87-FDBBC7E85BFF@collabora.com>
References: <DGCZF7HF09D2.I8ZU6A0KM91M@nvidia.com>
Cc: lyude@redhat.com, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>
In-Reply-To: <DGCZF7HF09D2.I8ZU6A0KM91M@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: iPhone Mail (23C71)
X-ZohoMailClient: External



> On 12 Feb 2026, at 09:29, Alexandre Courbot <acourbot@nvidia.com> wrote:
>=20
> =EF=BB=BFOn Sat Feb 7, 2026 at 4:48 AM JST, lyude wrote:
>> A thought that crossed my mind just now with this patch series while I
>> was working on converting iosys_map over to it: shouldn't we have some
>> unit tests for confirming runtime bounds checking works as well?
>=20
> I guess we would need a mock I/O type for that - is that what you had in
> mind, or did I miss your idea?
>=20

This is probably yet another use case for the =E2=80=9Csystem memory=E2=80=9D=
 backend we=E2=80=99ve been discussing recently.

=E2=80=94 Daniel=

