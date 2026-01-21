Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517A42048;
	Wed, 21 Jan 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998365; cv=pass; b=dbFnFsFokhdQdXR5+vPBRvz7iJQm4rxtqZM10QU5d7jFEJGi3xxAj1YpXqZoaTk31itJyC0/G3nhZrKXZYUY5Vrz49FGibmUp5SANFBMQ6c1seg/dSXBh9nMRrGSR2lfHapuon/TNfCGLwG0OsnRc3CyD8ozm59vYhiA3rB02sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998365; c=relaxed/simple;
	bh=3a0p3uMI3Fr6Z1fCHwuK1def/IvnGbhblzEFdg10IWY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mlTNM5JsWQou639wfvRo+9jn172IC598mAnyJugchRSM6/6ypR1wWExxXUqF0+DqUNxMH6Ff4TWgM0L5TdcYG/b+Tb3E+bs5vJW66yflI/0U+5hbtSe0YdCHimhjMxQ48bAtcHfO+OwWtH4LQnJbWygwMW5e4bP/OhPS+ikdFws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=NusVomfW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="NusVomfW"
ARC-Seal: i=1; a=rsa-sha256; t=1768998348; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j6gxz+AMc+Ef4n+nYe88V0M8PERKQ2TT22cSnDINv80xL23plNJQTcezohm9fQtYGqsullpmvLB4xvaZ+CEtV7xHaB0biYcEb7GFRVueUdG6GRHB0DmF2D1fEgYKyDzVFYglPgx4d4FTT8rVWdcmOMyRVcdakfaB1eUWeU9c9Xw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768998348; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ziZ6Zkr6BIi8sGyBnmGeK7WaLH9fF37csTWwS4Uc6oU=; 
	b=AlO9CQ8MV23jxo3AaWlrHpJ/HI2HVCPKhTeZvwYNkkIWOlSpIQ75Yuam7G47NRAky4bwdWJn7VjQw0sOUiU5DmpX1WG4qoYrZCzMqCmfIq1qobsbM76OahfjgynjLQdzwsE58xRRnzGj0tvL+JULLL6D0NC6Tu4J+ksV6gOqdv4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768998348;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ziZ6Zkr6BIi8sGyBnmGeK7WaLH9fF37csTWwS4Uc6oU=;
	b=NusVomfW8mpSfxI+/avCNKVF+boHclRL6UvpGb/mb4N+lLt/UChfFBf7pPSgsoI0
	jaaxJ2nWCSxaisyuSW6eb3hRRdGScq7UTp4/9rMQwBi0AZQ491ndlq5m24QT9NzpnNU
	XLqa+Py1LSBgxQqYfjlu2wPiV2+AU2QU2SxufQCc=
Received: by mx.zohomail.com with SMTPS id 1768998346574839.9172334040906;
	Wed, 21 Jan 2026 04:25:46 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 4/4] gpu: tyr: remove redundant `.as_ref()` for `dev_*`
 print
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260120181152.3640314-4-gary@kernel.org>
Date: Wed, 21 Jan 2026 09:25:29 -0300
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <26F297F3-A93C-4998-9522-CFAD15C9A701@collabora.com>
References: <20260120181152.3640314-1-gary@kernel.org>
 <20260120181152.3640314-4-gary@kernel.org>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 20 Jan 2026, at 15:11, Gary Guo <gary@kernel.org> wrote:
>=20
> From: Gary Guo <gary@garyguo.net>
>=20
> This is now handled by the macro itself.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> drivers/gpu/drm/tyr/driver.rs | 2 +-
> drivers/gpu/drm/tyr/gpu.rs    | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 2a45d0288825..fe991d8cbb4a 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -140,7 +140,7 @@ fn probe(
>=20
>         // We need this to be dev_info!() because dev_dbg!() does not =
work at
>         // all in Rust for now, and we need to see whether probe =
succeeded.
> -        dev_info!(pdev.as_ref(), "Tyr initialized correctly.\n");
> +        dev_info!(pdev, "Tyr initialized correctly.\n");
>         Ok(driver)
>     }
> }
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index bfbf2a1d80e6..04a0a5d5ef3a 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -98,7 +98,7 @@ pub(crate) fn log(&self, pdev: &platform::Device) {
>         };
>=20
>         dev_info!(
> -            pdev.as_ref(),
> +            pdev,
>             "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status =
0x{:x}",
>             model_name,
>             self.gpu_id >> 16,
> @@ -108,7 +108,7 @@ pub(crate) fn log(&self, pdev: &platform::Device) =
{
>         );
>=20
>         dev_info!(
> -            pdev.as_ref(),
> +            pdev,
>             "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} =
AS:{:#x}",
>             self.l2_features,
>             self.tiler_features,
> @@ -118,7 +118,7 @@ pub(crate) fn log(&self, pdev: &platform::Device) =
{
>         );
>=20
>         dev_info!(
> -            pdev.as_ref(),
> +            pdev,
>             "shader_present=3D0x{:016x} l2_present=3D0x{:016x} =
tiler_present=3D0x{:016x}",
>             self.shader_present,
>             self.l2_present,
> --=20
> 2.51.2
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

