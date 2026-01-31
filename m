Received: from mail-108-mta142.mxroute.com (mail-108-mta142.mxroute.com [136.175.108.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FF35CB7B
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869662; cv=none; b=LT/sW0i+CTEavt3SLoiMjVg0KO9nln9x6pRf2hJ72oCGfEiX+zNlIlQVIMpcln2kZTnCeAxXcqYjsgRqiQJ4qgNtrbLucZql9C1v2R6TOanzfWiWZzyK248sY3oKuTiSaipE1CfOrgGycrQ99wueRBWKo1OOCaYy8FFPeka4Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869662; c=relaxed/simple;
	bh=WVUZtrHdQCMK9fLWnTWlzYcBIGRNJYJRFhSBnvqy3A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcVrPcCGpLQsczBTtQW59jgt/WrYogg4d1/bNuUKboJULU9kO+DKoZD8GJCdByKtDoZspBJ0fiHL0ntXnRS29VL7wGtN3sXXrPYenYHbqZJfiEblMnVeEKizVQZIhFu5tMTctF2loWcpyKlKxdCkqrdVj4KxfoGLOpwNVJ85Z0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=KitFCE9B; arc=none smtp.client-ip=136.175.108.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="KitFCE9B"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta142.mxroute.com (ZoneMTA) with ESMTPSA id 19c146efec90009140.002
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 14:22:24 +0000
X-Zone-Loop: 28b9c88c2728ab88f6da89593dfbc0e7abb9124df0d0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WVUZtrHdQCMK9fLWnTWlzYcBIGRNJYJRFhSBnvqy3A4=; b=KitFCE9BFVrYZin3dw98pZEXbT
	kXazrV/YMEtY40KLn5NRgj1ponTqjGkG/NCVPRseRnmbi2/SfSAvF5JY3fdjZc4utK1F2bhTqgoZk
	rwtwFND1E5TcW4ZRaF2FOdE+x/CB5o/2vFuNnyJ3BBxy6WdpDsuLgL/DclvD2gMElV9z7MqEdz938
	CJ12SubfRnVuZI44KNYBPUjvQLCOWXDEl2ZrOTXoxs57aCQhiMf3V9h/FKTEEUAD6nvNoHJnWNQV8
	Jjj1SvmJrsj38GhAMQDVDv7EDXuFeimIXxbN2dBXz506+ibk1eb4jhgyrzgaeqbNhHac7QqmGwdUa
	Y7Dn8utQ==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dirk.behme@gmail.com
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: Re: [PATCH 2/2] samples: rust: pci: exercise capability lookup
Date: Sat, 31 Jan 2026 14:22:10 +0000
Message-ID: <20260131142210.1387871-1-zijing.zhang@ry.rs>
In-Reply-To: <49693073-e49e-4b5f-849b-6dd5fd3de712@gmail.com>
References: <49693073-e49e-4b5f-849b-6dd5fd3de712@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Hi Dirk,

Thanks a lot for the careful review and the pointers!

I agree on the `bindings` usage in the sample. Exposing raw bindgen constants
to users is not ideal.

For v3, I plan to introduce small typed wrappers in `kernel::pci`:

- `CapabilityId` (u8 newtype) for standard capabilities.
- `ExtendedCapabilityId` (u16 newtype) for PCIe extended capabilities.

Both will provide common `const` IDs matching the existing `PCI_CAP_ID_*` /
`PCI_EXT_CAP_ID_*` definitions, plus `from_raw()` / `as_raw()` so drivers can
still use less common IDs without falling back to `bindings`.

I will then update `find_capability()` and `find_ext_capability()` to accept
`CapabilityId` and `ExtendedCapabilityId` respectively.Since the newtypes
provide `from_raw()`.

Real drivers typically know what they need and do not need to validate the PCI
core helpers, thus the intent of the self-check here is mainly to validate PCI
abstraction correctly behaves. This logic would be kept as sample-only private
helpers and refactored.

Also noted on `pdev.as_ref()` becoming obsolete soon, and the upcoming
`register!()` macro; Sample will be updated once those are available in tree.

Best regards,
Zijing
