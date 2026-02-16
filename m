Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E4303A02;
	Mon, 16 Feb 2026 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248162; cv=pass; b=KFc5ld3aYTYiojQwSHReXYCawYkx/KSEHwnkbXsEQTsN/GTARap+P7Q1pdkl8I9A+5z/EzNjrlKwUSU7IfWNC/yO3U5FGD8HAA9ab4G0E62tNIZizXmaXg2lM8leWSo0LppAfxq4kZyvMEHYFOuxeQdHwEHpiSB3xiv4UieECh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248162; c=relaxed/simple;
	bh=KbfoHwiUYTfn0aGfT4Pi1rTgfaW/JssTGENDraiOZQ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P9CjvYZ/eZyFUIZnQTUI5VqxxjHp2MWHVlOjDFIJaRHU0fUdKr6P9XDhse9sEybFHN4qgKzCqTNc4CuLPANPz+KDXzztgTzbqPnpaHOnb3LLUOMeoFQppkykLBVR+sKFOm6OzpFo7CnQDNSSjT+aBR+LeraBm/PywD1Kxq8GUCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BmSlIgeg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BmSlIgeg"
ARC-Seal: i=1; a=rsa-sha256; t=1771248141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OOIQTuxrd1+7J3G6JDaGYiTFIlhmW0cJxdXi5No/CRHbs1V/aF7CazjotX/fQDW3Ov10fdqSbw5EWP4qggPkSTkN2azp1JTl+7Mkeid7wExubKaYVdOGJDqREwyB4gSjvPZ81Vwj0fWeIeRzNgb6F2yUjy3MeYipibNmSqoDL1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771248141; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KbfoHwiUYTfn0aGfT4Pi1rTgfaW/JssTGENDraiOZQ8=; 
	b=XxOuerdXLV0bmJSIlb/I2iJigD9cbXrlpR0wRyIXSP1d5FtTfuqRg70tDmQtt7rFi48rB5XW+pmYLjJ9l1MHvz0wZHJcq6FJZrzhFey+yTUgD2j+m2LxFh8FD7bnXY4uvENXcUPGH11n7g2EFX0tHpTYiVc0yI8f7QfQrZ1pFdI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771248141;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=KbfoHwiUYTfn0aGfT4Pi1rTgfaW/JssTGENDraiOZQ8=;
	b=BmSlIgegoIcVRaC7EivEQdhZoV+6vbVhVhArqNsgpg3IxeyBTBaCD6jn9T4oqcS5
	OK68k82ZJpevaDs7Rhuwtug9gMx8Y4nvmqEGucIpOmSYjCBnhCwdFw++QL4m7EcSEAp
	2Eqwl7C3ZD97KZd4xF7B5vIzvW/GX0hV0GWq7YKw=
Received: by mx.zohomail.com with SMTPS id 1771248140234149.76169704302697;
	Mon, 16 Feb 2026 05:22:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and
 io_define_write!()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260216131534.65008-1-dakr@kernel.org>
Date: Mon, 16 Feb 2026 10:22:01 -0300
Cc: aliceryhl@google.com,
 bhelgaas@google.com,
 kwilczynski@kernel.org,
 ojeda@kernel.org,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 tmgross@umich.edu,
 zhiw@nvidia.com,
 acourbot@nvidia.com,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <9DD438A4-809A-4DC7-AFF4-44AF7176CBA4@collabora.com>
References: <20260216131534.65008-1-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
