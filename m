Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372C41DEE8
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432452; cv=none; b=CgFpoWhGGL/ItJL+kxVRb6xglpt1BrsvWWMJPH+WYyD98NvdgFiylBwBSey91k7E+HJysXxaI6Pvr5jWT2khfDiRg3/ZAB+BPtiUCHGbLX81KxGhwmb86o7rdhSR/8VYP9jhdJcF8gZgGqt5mkjjQnIDlhwlQSakyfnkv1cOUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432452; c=relaxed/simple;
	bh=JgKqENFoGD+r2HcLqI6QzwLYU+u5xX6ykNoGtdPOJIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOXLVEx8MgQSqK8THQdHZKC5RP6V2vL31JrtKhpyKU2vux0Wg1a06JOV3zZez5LLYVSZ2YUSwbwPQEFzLFDiyOwCnXYfs11gD6YxRD2+ENrdaHxqnjjJi5IPmJgl6sma6i9RgbAzTpk4096xjALHkPV0hMvW1VSZV+3LrbKHAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQbX3A4Z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQbX3A4Z"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493bdf90adaso33509395e9.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783432450; x=1784037250; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3qQIydnrntueQidkz9seiThuCHjKGkJFQ1LDomdEzU=;
        b=fQbX3A4ZaodvJ1La3wwChslkioo/rIVWvNeYFFhns6QuH6mOQFBckhNwRdHITr3Vas
         345AHVZK863Pt+XgvnpBwpK54/UQ/Za6gTOcH3Y52qzlqyc6UG7y4Mizml+S/fnlG7jH
         nLn5mKLIA0Pe64wMThbNWojDamTJijGVwvbBdbpNDeBaescoF6gh7ol9gCkhDbyhOC4x
         Ikt7uQgGnR2CkJha4oqzIPLhJt01oOvBZrOr99YTfBInb2SDCV40vGMhAQJhjbwXZ37d
         3dfhIptVGo2ft/f51pEjhRqL8tmN3L+50ZMyj+f5R6tK4mbHp9ykKQlqxhgnu+mUmiba
         e1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432450; x=1784037250;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3qQIydnrntueQidkz9seiThuCHjKGkJFQ1LDomdEzU=;
        b=dbFrJ/YlYJEihVn8BH5Ru4ndBKTZoQB4OffNpcxBg+HTVvNJ9bc5nFBJtrK2Afiam+
         DI0CmQJAZLdU8knmDeY+h4SzjbnckPN2ErmHmIUMYKVJserSHmYa/zMXhYsExOW4yzJ8
         sC9UuT4vO/ZjqclTrWSblxkOJz2O7CY0zZzNL039JviP/xUwgS3hnSvVmusRi4WCsuIW
         NV+u3lierHE4aaT87h9qwssnjFpMAyjZ+/C2bXM4Fb1CMG9RFcf/EMgDcIIz+k8+smG3
         TyVRAqTQKqelfV54187/m2IaY4BWMESLMREuvhU/LosoumF0uLL/Ssr6r6zjaG6bmCh/
         fQcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAY77i1sUJDeuGrIks0ZuGD0iz8TvG6gkarM/1pxA5y1KEKmmhIrxYsmF47yKrNY/6yJ6wqNRqM2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZE4S71/W/8fHzQDNdTAovDz/SnQn6WiuUbxQ/T5F9K/gQBzd
	stroR9YFoiyLpqpMwqjhjBgOoiI57Koj33wxYZXy7scWLEOjjH0AsPrsfndn29QI/YFcwk2yGI0
	+Gr7aSBdHQyuq7ZINmw==
X-Received: from wmph7.prod.google.com ([2002:a05:600c:4987:b0:490:b2b0:c4aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3491:b0:493:c0ec:9a5f with SMTP id 5b1f17b1804b1-493df08ce7dmr67025965e9.19.1783432449607;
 Tue, 07 Jul 2026 06:54:09 -0700 (PDT)
Date: Tue, 7 Jul 2026 13:54:08 +0000
In-Reply-To: <20260703210936.1128698-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703210936.1128698-1-dakr@kernel.org>
Message-ID: <ak0FAGpJtUH7VvHQ@google.com>
Subject: Re: [PATCH] rust: irq: make Registration compatible with
 lifetime-bound drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, bhelgaas@google.com, 
	kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mhi@mailbox.org, driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 03, 2026 at 11:09:21PM +0200, Danilo Krummrich wrote:
> -impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
> -        T::handle(self, device)
> -    }
> -}
> -
> -impl<T: ?Sized + Handler, A: Allocator + 'static> Handler for Box<T, A> {
> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
> -        T::handle(self, device)
> -    }

Why are the implementations for Arc/Box being removed?

Alice
