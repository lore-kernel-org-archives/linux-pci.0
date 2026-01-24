Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C31917FB;
	Sat, 24 Jan 2026 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215096; cv=none; b=CSJrS0ZHeBWBKam6aldoPeqKwnH/QtzvRWEvjrSrxDcvgIO1dV8b7BK7AJzNPnMkdulIwj6ioC+NYMizf3LHQTbeFgY0NMfnP9pMJcwELQHObG/03SA8efYG49+7fdIhR3KPKfdEc1b80PS7wsi+CvwcLJuC2hczPPRBAkWftC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215096; c=relaxed/simple;
	bh=SKU1yfScL5Ypu0iWedIQIdD7r8yBxY0fWN6TWzp0MKI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kGFqzmLC9MtWytCRTnTVVpdMy5lS8r+ChDb4k/+RAfnqHTfMZ3/RVSBjJ8/BeMyel2NxheWdOMUf6DRpe4t6TkXWm5qZCVP7XzSFdr+GjBKMqxRHOD4aoEnZNncnfNn1urlhnt3lD0Q7tNSCVCWl8SMDTnXGocWCux2qzJWrVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD6fNIem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD6fNIem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92899C4CEF1;
	Sat, 24 Jan 2026 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769215095;
	bh=SKU1yfScL5Ypu0iWedIQIdD7r8yBxY0fWN6TWzp0MKI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XD6fNIemkael3Wl0CUNOOv+vM3wXROyhoFtICdSN8ldI8t/+67a7rUbzt/fWHawnD
	 LsQzlLltw3AYWjDZAyfIEuQLeugIhn3DDXOz3+108QUspx0WahHtkBbqofw3umddfq
	 tq73FR+KTpQZ3F542+ewZm5eH5hN+ZTLht7C7zXuuyKdpPvdjwOpsOIQVNm9LNIjej
	 3hMA9llES/V6NZmFlI9cYcNVvCuq/DvfmoInN2I5RjksQArFWYZnMElGheq3YckEcZ
	 427rmA3pFY6wYnI/qUx7yyZV+PCtWXQ3N6ByjMuogHViIjAUeH+dx6r5nmOsKujer4
	 3KBYRVZRr6/Hw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Jan 2026 01:38:10 +0100
Message-Id: <DFWEEOEMK4WG.3GES9U2HVQN5G@kernel.org>
Subject: Re: [PATCH v2 2/8] rust: pci: remove redundant `.as_ref()` for
 `dev_*` print
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260123175854.176735-1-gary@kernel.org>
 <20260123175854.176735-2-gary@kernel.org>
In-Reply-To: <20260123175854.176735-2-gary@kernel.org>

On Fri Jan 23, 2026 at 6:58 PM CET, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> This is now handled by the macro itself.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to driver-core-testing, thanks!
