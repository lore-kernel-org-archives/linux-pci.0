Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C93093DD
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785698893; cv=none; b=JRbnqAyPFJHbmzmnsdANYqozOYI6d9VWH+sTKidG1m062YouU69tWoClN6M7kB0oY4apv7WG8LiQJBaXtunsFtimo1/U3y8w9/oUlUuDi1KWvuNtiPmzTsEVZC9i3YeH9k4I074BswpX6Edcww+yT6BpTAuWIs1vhPmiNWelZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785698893; c=relaxed/simple;
	bh=ih17u19AEzHyVVPvha5pFDpYhRKd9u+uawUawKr9oxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmtZ2LFIz/zIDKne1Fj4Ak+jGdPcTGv0qLHCBx8WOgA4naZkBaHrApJwXCtLLntNiye7j3UfDl1QBbCjIfYXtpp+GQxpGap0vKQxcsAM2e55dAY7IQ4zr13Yh0ReyM1Jh7EcOTS45iHdtOh0FHVYBh6910V7l4SIDGGdS3SMO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HH4I9Pcm; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HH4I9Pcm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785698887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih17u19AEzHyVVPvha5pFDpYhRKd9u+uawUawKr9oxY=;
	b=HH4I9Pcm/SBcXwV76O4Zr3TEewgiBxIxBBXpqQM8Bxx6pbnHqmdspVGXVoRm/tgt+ZRxhP
	Wkq2QgEeZnDBB73o9s4NOq1KfotlJUZUu9J7K8JDW1REDwfinGozamxxiHbS4lLkZI2pCQ
	7/57U/olWMrrVRTQ9kGqYX0jVopHcEs=
From: Igor Korotin <igor.korotin@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?q?=C3=96zkan?= <work@onurozkan.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Ertman <david.m.ertman@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/11] rust: driver: use pointers instead of
 indices for ID info
Date: Sun, 02 Aug 2026 20:27:50 +0100
Message-ID: <178569887068.1652.14450480404285948832@linux.dev>
In-Reply-To: <20260730210149.1117242-2-dakr@kernel.org>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260730210149.1117242-2-dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Hi Danilo,

Sorry for the silence -- I was offline for personal reasons for about two
weeks from the 16th, and missed this before it got applied.

Checked 6-9/11 now: the i2c bits are correct. Unlike PCI/USB, i2c has no
dynamic-ID (new_id) mechanism, so i2c_match_id() can only ever return a
pointer that IdArray::new() actually populated -- the plain
info_unchecked() (not _opt) in i2c_id_info() is the right call, not an
oversight.

Cheers
Igor
