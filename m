Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450497;
	b=0c92DjzVSdEcdaxvaLUwJnSO9hgF8Ft6duST9VpyWtYHOYfdLjBjynzSERwXmPSY9Saz
	 7c7Pia3XxLwEymqTympWo2iVsSA1EtUNS4IdjxXKINc7xFNYIB3RF2TgvJSgcRBNVGy9y
	 0ZCARnUxCXsv5JsDnQSnaSrRhybiBdy0RLdmmwsprBoDP/P6Snhfa75ZRIYaERZVEuzNN
	 k7sHqYQB+ZTMZusjZdNeobX31RSreY8P281Kfj/tBmjZxC9/6rCxj+S1aPcNQGbNm105r
	 1PLOxtSmU/h7z05TsIBevfRFmcfDbd5/yJhAFzIHU4WD5qM5cy1Gy3Lz7sayS9T/h8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q7bhftfsdfFELoISfAjNVEd1jZJW2ymTGKYm8nzx1v8=;
	b=LpNcQFP4AWOv6viTC+XB/ebt+yWruj3rygZeO3VkHCDsolNIvsQdubnukhMHJFg0njCa
	 ONlaj15O0ZoSoJpjKl9gqHlK0mHGqIj1np3Hb6ZjDsn90Ld5cz3vskKMxindMIrQZioI7
	 KO25SyNW5WmPJu+K34fGsDbdi25jDn7AYLKXAXxV3/s5Kl82gIKCATS84PiK0OHQtS62r
	 /u1nh5XkcJhK6SEMPNd0XTRfggxE4meiKP4M4os9AiFf+rGo8e6QuG5p2FuT1IkziX0Bi
	 IhCYCJkx7D8LBj0fAki7QvItOYGBhoY4UwyNI2qQeEKVCx+6o4kDNQQj9RsWKElzGPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gc2iEFvn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB62606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gc2iEFvn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FDD1F00A05;
	Thu, 12 Nov 2026 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450497;
	bh=q7bhftfsdfFELoISfAjNVEd1jZJW2ymTGKYm8nzx1v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gc2iEFvn6BW4tEF9uNXCVay955olzTbj3A8+MRQSoca4THjWtDtFVMvGkjZAoixuo
	 TYeAC4z4vtt3MVV4PbbadEZjIGHi9oAo1aw4SQFpNdo0f4sADAk0zw3Y134eQ6OYkB
	 aaNwJ92cEv09h8q/IC5Z2ODclS5r7ddiIGihcxz9TT+tc2ChF61bP6wVxmkhFm7txj
	 VaQTOsVJlzxhvXgeNU7Ns9PxFIaTFa3yFy3Mm1/0/mCfWvWpXbbzrJG/M4Rjf3xf2M
	 PTk8GORqBPzgRTfCh1nVVWd5Of6/HdH62acgedyCmZpyKC3+RJsphOPfcJ2e49QM61
	 cT62UkIE3JNLQ==
Message-ID: <sashiko-outbox-210192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Use pcie_get_link_speed() in pci.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112022405.1230200-2-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
 <20261112022405.1230200-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:28:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
> pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
> the now-unused wrapper.  pcie_get_link_speed() performs the same lookup
> with bounds checking and is already exported.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112022405.1230=
200-1-18255117159@163.com?part=3D1

