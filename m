Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9943CE56;
	Tue,  8 Sep 2026 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911280; cv=none; b=SP5i9WUHNKF6+Pr2pZIgKYgXHLOzr1a5zlqPph4SugaaYgV3DCMs2ktCT78sQA4hfkTDBEW5gi1WFDogpRcy1EcXMlfaEh0/VEZU7YVOJtE3syjjsfpWVnbBz7ElS4mZFlsRzjL0S3mB29BauA4+QPgz6mSOr1agapafXXNRaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911280; c=relaxed/simple;
	bh=EaJbgfb2Xp6KjsXfat3qBVZhik7uyAklt1PcZr1OzdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzk454aiHAGP7wxYkjVoDPqChMXPk9G545R9kkW7AxfXpci5MtfPUSoiMZmVniS28T9a9SyZDQxSBr/ELGgjKQoet+Y/0Dw89Xx0oJIjVpQG7UX5BQHFLNxvBoImaOFhcwKzCJKwRuli2+WAzXx7zYGTxaiAWevoLs8PK3NDXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzOeLNv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzOeLNv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206451F00A3A;
	Tue,  8 Sep 2026 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911278;
	bh=7Y1bO6BSKs8lhourNZdBsvXbOFXn4uwlU+fUG4ILrEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UzOeLNv7GkMKf2Mq6br3A1bWbAbJyNTtetHf+gy7lx4yP57gWxB81yEJtgKg6a1ts
	 +FIlSc3YFhawgwdurKtG210kd9INERJ/0ZgbVPMvrAHlwsMQc4fMtdLV1Ws3ALHkRH
	 y3lXfVmmlOvwobT9yyEkAY5kOKCKQaR4gLU/QfR/AiN32qinw2dOqFmpta2S86EUyZ
	 KP0lTP2JZBFV6W2YCZezBlctsp7DsuCYdj7Nn2isCGC5zshrhK+JA1Lku99Icdj/MF
	 I4tKL7eLU2uYTTb6u3HkSkaxPsly+pWBXWJAxZIeQKfAkhVJyuURgVDk6QJP+UmNrN
	 Scq6Aa0ZCePUA==
Date: Wed, 9 Sep 2026 00:47:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 15/21] lib: rspdm: Support SPDM get_capabilities
Message-ID: <20260909004752.6b8a3a46@jic23-huawei>
In-Reply-To: <20260901010347.2614656-16-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-16-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:41 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the GET_CAPABILITIES SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
