Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11810F2
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977147; cv=none; b=Ze162fowaycM4XbDltBFKArSBAs818XMCrRjCxvnYT6tHcMzQVpp6oQn9OVhJydk/l4miCO/4kEDluL/cS2IOwofOqrEqbxJHEsJEX6sE7UlKbwT2YNKj7btbNqobjSJe3cFVxWa/XqDW8J6+u14rVA86Qmu/5m9fTwmxAxCQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977147; c=relaxed/simple;
	bh=LLCxreRgS0ilvvTsRJazgHapdRKRfH9eHszDqJVp1F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXvD8sdj66ef9qF5x4MwGyyaJHGIp7q48WlQbDWDuR94dJakkVpF+2JHNfTWWd4tHorRrAVuHcSuT7IRiABlk9+QWqB0I/C0/zN5W5fEA5LHgm2SPYbHMbY1xQy1IclaqOTOUlB7EiFaj7fg1ayVyFKIK0vkO4J+XbdCVMCaMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB/SE36X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB/SE36X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1CBC19425;
	Sun, 17 May 2026 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977147;
	bh=LLCxreRgS0ilvvTsRJazgHapdRKRfH9eHszDqJVp1F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VB/SE36Xatgs5OzKjm6/FYaida/AFxfhgrRayrvyuBVPhJZuI7BJQ4rgWURH8vKR2
	 pi2P3jXChNAirDQTz7iXxMEOe2Rfsd83NBqQfl3kkJUQm0uLi4OFac1P96bE/XhhSR
	 ydip8/9bEFPnBtLvc44NM1NA7IIj2bGO9Q/N9YIeNk8YffvOATDFdWBuPECKwvcl4r
	 n6g1hMTNgYBhJc69QnFuaNOuDDP2NgYK2Sx6rXnOrrBXDv9f25EEXdZXdCiST00bxf
	 wwZeYQFjIiUoySu8/VoCaPf+jZkCmKT5zrE9rKjAgWF0EQa3aJmCNGUqXuSI08kTzD
	 LQl8zPgIGdMvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/27] rust: driver: decouple driver private data
 from driver type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-4-dakr@kernel.org>
References: <20260517000149.3226762-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:19:06 +0000
Message-Id: <20260517001906.EF1CBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new `Data` associated type on bus driver traits lacks a `Send`=
 bound, allowing safe Rust code to store thread-unsafe types in device `drv=
data`.
--

commit e138a8068792e58e92b3ef6ae49ec5c3c073f8c9
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver: decouple driver private data from driver type

This commit adds a Data associated type to all bus driver traits,
separating the driver's device private data type from the driver struct.
This avoids a global lifetime on the driver trait and simplifies
bus implementations.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 17a33819dc0ab..ffaf05bf9aaaa 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
[ ... ]
> @@ -300,6 +301,9 @@ pub trait Driver: Send {
>      // ```
>      type IdInfo: 'static;
> =20
> +    /// The type of the driver's bus device private data.
> +    type Data;
> +

Does this associated type need a Send bound?

Prior to this change, the driver data was restricted to Self, which requires
Send (as seen in the trait definition above). By extracting it to an
unconstrained associated type, safe Rust code could potentially use a
thread-unsafe type like Rc for the driver data.

Since the device core can trigger unbind operations from arbitrary threads
(for example, via sysfs), post_unbind_callback might drop the driver data
on a different thread than the one that created it. Could this lead to data
races or memory corruption if a !Send type is used?

>      /// The table of device ids supported by the driver.
>      const ID_TABLE: IdTable<Self::IdInfo>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D3
