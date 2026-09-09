Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A614A60F;
	Wed,  9 Sep 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913909; cv=none; b=nFSlpKx94333ZIOYPRrDQHbmOuzxwKKqWZmwzDDWe0y03/jvCobSitB0xM2G8coSUnKyY/plfxe7XOjaV2QQRzpmrCzx06tcoY+lXXB8sudMwLwi+vmAspOih1M9n1GwzmVhYSE0hunXUTjhwGEn+gZXDB1AjfKmDkjMRE4KlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913909; c=relaxed/simple;
	bh=OdxVRyViT8qd8aNfIxcJTXm0RGXtOrMqT9FZVkVEbA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/yV4/vUScfujGUhzV61K0CkDZdhUQrcUpnd18aD+pJAjAjvaK0913075YfYuIfAd/I7aO3YHvGNKt3jyNs5bp28myb38WjWT8fOQevgsAtsCtPlOMmolYOtUYia7gwadbYUA69sH1Rs/nRha4ji2wMUCWaa4SCKlC8NUzh2xRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6JpoG2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6JpoG2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96FE1F00A3A;
	Wed,  9 Sep 2026 00:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913908;
	bh=IJUtrL8up/h7b4D3LUoCpPL5As/ef1JMSKBMMW3rWj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g6JpoG2JeHDhJJ3haho6V8VxAWNaXFwboo4XEUMSTa3YvjPNYitNUVvbTo1KB/ECn
	 +q9PYI26hFY1sbXSbNAUJaWca470AI0rrjpCvsCUB+MHE0QxBX2eiGYsYGNTfhDHBt
	 UPICEP+K1Ku993j/nSOiTPz5BUaYSJoefHw+yRRvE9z0tTRboEbV+yB3tZnTsk42SK
	 qNpikUxoXe5PGS+ytlxORrzCbGwtKH9iHKGx6Lco7wTPxbKavQTu0IH9l80aIb4166
	 O5MkQ0jdUjri40WcM13zQxzK8eAboaiQULjZt2XMduA1FhiECgG106FzkAPY5ItTq8
	 7PzMKQU2ursaw==
Date: Wed, 9 Sep 2026 01:31:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 17/21] lib: rspdm: Support SPDM get_digests
Message-ID: <20260909013140.11117c3e@jic23-huawei>
In-Reply-To: <20260901010347.2614656-18-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-18-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:43 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the GET_DIGESTS SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Subject to my current standard - "as a non rust person"
