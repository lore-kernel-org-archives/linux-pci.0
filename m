Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974618;
	b=cbvapd8r8VxTV1q/0/Cmvo7Kn3jIobiZfX/FXOes9+uECMSVzw35dz6GoKeeG9DDpo0d
	 iZlMYf7Xt6zDocDv8KSWRf8uLKInpAqr0acn/AsQFah+84IaV44nIgKqTOd3HQkrYCcjl
	 +/UQsDXQnlTa5sj3fI5i43Hbu8MyokkUs29R4CCpO9XgRqADuj9TMAXCbMNgapoLohQB4
	 yVWDoe+YnrABpxeEbzXLtjhXCQPdl3RtrZf6MerT+wHzVwf6RaxjuQgC0ZUqLw3gUUCrh
	 pentkRfZAvGw2ePYNF+ERY6PlK0oIQxusefp477FyqLapGqOAxXfXl7BGzwK3Pm7zsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HFAi3Ck3oqfHpkhYIzqIUwVXcbMDo5P/kjQIcWeGUpQ=;
	b=4Da24DLmb65P/GR7V3PXDpm7hrdP2vrY8tU6aCMP0kYRVmutec2xz+Jvze4R4/TdjBGp
	 OPTxk+asEVlKRiD3P8ABI7YqvGn5Z7SQw9GmSSa08dg8gXEKshjhl9Fpf0XP945xfPmtD
	 b30wptlaFLf6x5y/aBJQzBJw8VoDcedg1SFR6laDvN1qOf5ZMcZ8pgcJ3LiXllRLVkDCh
	 PLTSpxnz8QEVNZCLZCzp19qx+bJ8i8lfa/OCZ/842rxhiKfd6042iA0QwI0TBGlz3/SR3
	 mV8hmnQTEFolOqbqN19Weks5TZ10Y3cJG+cUz5X1eN5+mvvQdo/dzcdd6j4CyCH17hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cvq1FfyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EED606A32F
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cvq1FfyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0896B1F00900;
	Fri,  6 Nov 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974618;
	bh=HFAi3Ck3oqfHpkhYIzqIUwVXcbMDo5P/kjQIcWeGUpQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Cvq1FfyDtpo7eLD8f0mlv8VSiYGgQjFE1ABflW8YZHMYb6//DD3d/isFMxFLUeByG
	 7r8SmN/Bsu2eYEYOrRi2RXe0hCmdI72ZfLIOl9S8CsHnv9+H9tSXlHCo38RTE25tfi
	 3LKvZq/KWScF79bJI96qKSBTrAYo5XwefTd83ScwxHXZXoiJrBmu5k9C5XJWHtdJIW
	 /IIiafyYzxbeT35oymS8pjgiRyYlhZ9wdJqJSWOFcI9CmYkLb5GWhFstcl7tYXAY0O
	 jy/J6QCloKDzq92YsVVyznr5guSiTH/Qefm1dkcH+Rb19z/hcPypatImoio8mf4yPO
	 f0AhlnY4m7qvQ==
Message-ID: <sashiko-outbox-201556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/14] PCI: Prevent zero align from reaching
 __ffs64()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-6-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:16:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The bridge window sizing algorithm calculates order from alignment
> using __ffs64(). __ffs*() is undefined for zero input.
>=20
> pci_resource_alignment() & resource_alignment() have a number potential
> ways ways to return 0, in fact, resource_alignment() intentionally does
> that if neither SIZEALIGN nor STARTALIGN is set.
>=20
> Thus, ensure zero align is always properly dealt with in
> pbus_size_mem(). pdev_sort_resources() already has a similar check for
> values returned from pci_resource_alignment() (though it is not using
> __ffs*()).
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D5

