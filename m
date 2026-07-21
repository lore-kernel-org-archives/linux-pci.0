Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C843635E
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620238; cv=none; b=Vv5H+2+1znx7jG5ZXVZiLSoqI21gxpe33/pboSFSZ+T4eXhZRsxQ/l4QJ+ZSa+xF/A2CBeNDD8Z4faa6V3qcpTZME4EsCaWqSZnJUScsZIyNkWuspamlq1mkEZS9IyJ9z+ZKdzDyv3TFE1QfNTXihponf6z2+U9Nwm0ZYV9+GUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620238; c=relaxed/simple;
	bh=v1HyQ9w4CQ9GtjNjR+yGGPjV+zdr+mSawSgmUOS7+QY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QNid0F02gOoBK/XJZGZAT3xZIRxdjazkvg5OErAvbpGFP1vvN/aB8R+ZRN+1+MFBwfP+EDu5uWCzvSTdG/9v33bw6qcm86ObqVIx20Xe/cVBkZyzng5yEuIwsPhcBuQywAWtdaNzE5sioCs8MvswEzTaw1SQgbWCiLX5mt1Rq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uusYuBLc; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uusYuBLc"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so146543815e9.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784620235; x=1785225035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZN0cXKJfka9i5ge5e0ezdkYWG8Vmfnfz35ybXd+mtU=;
        b=uusYuBLcah4tK4MNxCg1ZCyK/edOcwoSm0eps5P3xbRoCdCMhQAq/juWwIIajri/r8
         ktUmODgWzrGWoP+7KhMT3iZ7lMsJe2RFnjwkbNT8Z/i2HkwU2/S3zOjnawpRCWc4dUkC
         1qdQp5cBGJbIG8If2h8Mjz48YUlJnEh2TVmW4Q3P2cpoHZ01csnc6LZjU59R+uHDJ9/6
         uBX/uB0cUeTOwUbeQtJTrZBOPAqrmPA/qr2ahVRKdB1gAaM4vPXYQgVKYvqmzWr9nVx3
         PSjUl2CTz2uiiRBXmYKqmec73t+Vv3WHTuHc2V7XibGtm2vCcioKVDa3Dtq+UrFJfr56
         nMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620235; x=1785225035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZN0cXKJfka9i5ge5e0ezdkYWG8Vmfnfz35ybXd+mtU=;
        b=oI6jHZ7jqSdmnyfAzZ/84eH2omXDDIU7vMq3j+dc+CLBEnlC95ZsR9II0bvjT+iWcZ
         WWD//upHOSOoKkMrhPAsR1nU4onvAt22DPzHIDhDa5J0dPogihbd49kcf8foyhljtNFf
         dxxNYenAaqgPrZXBBph+p05RHFBYLK7CxySPkKSrSunylmX+HBdv+gtfqt2dr/YpJdyn
         JedYS9k8ITOnpCMmqpIvV7s8Xzdqg9txi1v8imqSilZzNjuxuixzbVtTaPHJ+yVNt0Sf
         s51ilWafp6oWtXdZIApTdfITv1Vcnr0vRvUTqeUeE72x2x6UMbLcK7OTdEO4bYUKUQle
         VsHg==
X-Forwarded-Encrypted: i=1; AHgh+RoJuMYGAfkyfjA7NZUxPFqm4X0tOf27NuNUBzGS2s1ID0RCtAZ7GdQXg5U3+eor8xZpJdK+40GE5MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2f6rhSznYFFYqul+mlNvBoKczRV0ba6IyTytDdGK6rXiH4iKs
	4CZuolGZq/iq4R67JAOD9scTHM61ybln5BwW8AYXfcFDm2ODY1ZTReSpf+fnhAASlbQZXe38J2z
	vvZDSZTmhryd8GpcHWg==
X-Received: from wrny4.prod.google.com ([2002:adf:ee04:0:b0:47f:4fe5:ede6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b26:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-495627459e1mr65586805e9.2.1784620234926;
 Tue, 21 Jul 2026 00:50:34 -0700 (PDT)
Date: Tue, 21 Jul 2026 07:50:33 +0000
In-Reply-To: <20260719153631.559341-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260719153631.559341-1-dakr@kernel.org>
Message-ID: <al8kyaXILj4oepq7@google.com>
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with
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

On Sun, Jul 19, 2026 at 05:36:05PM +0200, Danilo Krummrich wrote:
> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
> (HRT) device driver architecture introduced in commit 2c7c65933600
> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
> device drivers"").
> 
> With HRT, driver structs carry a lifetime parameter tied to the device
> binding scope, allowing device resources such as pci::Bar<'bar> to be
> held directly rather than through Devres indirection. However, the IRQ
> abstraction required Handler: Sync + 'static, preventing handlers from
> embedding lifetime-parameterized resources.
> 
> Remove the 'static bound from Handler and ThreadedHandler and replace
> the Devres<RegistrationInner> indirection with direct request_irq() /
> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
> stores the IrqRequest<'a>, which structurally ties it to the device
> binding scope.
> 
> Also remove the &Device<Bound> parameter from the handler callbacks,
> since handlers that need device access can embed it in their own type.
> 
> IRQ handlers can now directly own device resources:
> 
> 	struct IrqHandler<'irq> {
> 	    bar: pci::Bar<'irq, BAR_SIZE>,
> 	}
> 
> 	impl irq::Handler for IrqHandler<'_> {
> 	    fn handle(&self) -> IrqReturn {
> 	        let stat = self.bar.read(regs::STAT);
> 	        ...
> 	    }
> 	}
> 
> This eliminates the indirection previously required for IRQ handlers to
> access device resources and aligns with the broader goal of expressing
> every registration scoped to a driver binding through compile-time
> lifetime bounds.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
