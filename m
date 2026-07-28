Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4135975;
	Tue, 28 Jul 2026 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280577; cv=none; b=DU0XQ55lvrxn7q4zis7kdKEMC2wAOCHe+cXxLV5JAhwgJ/YImFOp5eR3zrOFaie5GqGF3FRF1FU6Wdsg59ovRPhi5XP5Il0dn2603VhO7kjVEpa/XRYyv0UhJWBVMEM9bRj+Hi7iRt/O9pj1pjeyERtHA0gjrGKwHtzy9fXw0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280577; c=relaxed/simple;
	bh=gKUOlczMHWIuTLty2NpxtV7J6oEf6dDR/kM61R9vUGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjVnRpODpNn6K1DehrO6SUlzA9R/Dw9rryO5k74t1/QiPdUaIBjjvDizCF30YQ2GvomQgLu7v1Vlb2y1PUFT/HwmUuYkPC3Wets4LxWj5IT4IJGPmI39P8mufMzOIQvWjPRQKNbK6TcqEITrcET6+w5Q0uIjazeSA/lDssbAL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOeooqZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOeooqZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183BB1F000E9;
	Tue, 28 Jul 2026 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785280576;
	bh=6p8hD6i5w4Tp9jWWRVEsc2RgHWgv+05SO3FiSuemI/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iOeooqZzrfzwX65rQIVaupzgcLtbPJxodfctHuiav0ezP9p4usJCVXI+BuauheiN0
	 IBsbaf56fPuc73jNDZC2uK2zaDr/8A64Pwxwy1G1VtgGOLSX7Gt0kUnRkeqGlBnurr
	 J5GouQT36+w9zK2619Qorrpi1aUQ9+asA3N+JWylTJM17gbdsu6aFKjgpESWJlvT5o
	 98SsxM0isieZL/I7U3zUFTokGZX9Pra5IH31LzguyDip/ySwKjLzhHAEpcHOM7u4C7
	 1lXn/kM8cyIY4EG9VeF5haS5O5naVOkfFgQ6woTctxjjTzxOkl722BW0bXKM5XUPgY
	 X4yYfeteLRhxg==
Date: Wed, 29 Jul 2026 08:16:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] PCI/proc: check user access return values in
 proc_bus_pci_{read,write}()
Message-ID: <20260728231419.GA825941@rocinante>
References: <20260504022231.15501-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504022231.15501-1-kartikey406@gmail.com>

Hello,

[...]
> Changes in v2:
>  - Use get_user()/put_user() and drop access_ok() (Krzysztof)
>  - Rename label to err: per kernel convention (Krzysztof)
>  - Simplify error path to release runtime-PM and return -EFAULT (Krzysztof)
>  - Apply the same fix to proc_bus_pci_read() (Krzysztof)

Looks good, and with changes to the commit log per Bjorn:

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof
