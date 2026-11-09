Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230221;
	b=nkKAmJneqyVAvsdulthP0aZxou3XicyovXWTkEC0Xhyuh9I3oi4HVuFEbOfoW1Vt7tyP
	 iX5DFxcB8Ka4tFyVO12Zj0h8CKXo7KMXnlMOjBHSeH9+9yBg91kUu84EzaTnyso8I4CFe
	 aTTsGBB/JdD4q+X8q79msMY0D03bXx0mKo3BiQUvBaqONaXRGdWjkhFoCzt24+8dCtnwE
	 R19LLFGvmwjeCe4SGoOFMFZTrwn+NBVPBadI0ZI5YkAIe/wjux/fKojjl1/ewq0FKgG8U
	 j+XvvI1IIckEYP62up/rTXXX/q89kwNSNMVN3UrI6lUNbIRiqn3WIjq5x4nuHH+QmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Kbfzo/4zXn9gnqWOu+bUU55O7jqkKMp1C1psSIfFBU=;
	b=UWj5WE2C9V1cYeHesY+bXF88FdBfBGZY43ul0R5QoryRmxZqZBb3YTz7eMRZwu1tANXs
	 XklasrG8ppXjus+5XZzhOs9v7qnLiiUIcI0BilYBx2lYBH6tU49Xjav8DmsN+0SEwM7Ia
	 abAUPCRC3a/sRUrBPjNp6pjYd0xGlD1qlQWPeGETpE8IC+YkcQGaObFPGCMIgPsKduIsR
	 +Do9c0NKAp/7CnlUtI186IfgUVsOVgRnpCtDINHDIsOVyCufawgOZqNSoCa4bjnj/5tkK
	 cE48284wyju65EBDktoTM5KvlVYAx2ysna//3u5SVd2JlSTO74LT1+IjXiSqtCb2cOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/SXkTjP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACB606A337
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/SXkTjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EFB1F008A1;
	Mon,  9 Nov 2026 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230220;
	bh=6Kbfzo/4zXn9gnqWOu+bUU55O7jqkKMp1C1psSIfFBU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=D/SXkTjPz8k1FvvnXcba4gE1OifzJGiC/D7ElsniDBTJ4aqMt+uVhE/WK7rtdr/0y
	 EopMcjLWYqHjjDXvtHaIJlXqy2WNlr8DCoiYJsu5MzHvYqJQah3Ly0c54406KFldpY
	 D7+c4KfLA3smMQiSGz12ICreWsymdWZuSIj78preAPBMhcJ8XXi2JexwChkqOFRbDW
	 DumzDlNcLc2MzWDpYP+SVN3tEGsf9CAnZ2UL6PCDJauMOhat/fCq9a2zxKTlDXOPxl
	 NsMiVviRnVgOd0YUYnC60876M+50TCqihzJk2rlyjQS472e0LvnYpRPEqEMpwyyko5
	 KTUDKi7glbVdg==
Message-ID: <sashiko-outbox-204995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI/sysfs: Remove resource assignment after BAR
 resize
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109131011.1815-2-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
 <20261109131011.1815-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:17:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_resize_resource() assigns the resized BAR and the other BARs it
> released, or restores the original configuration on failure. Calling
> pci_assign_unassigned_bus_resources() after it is redundant. If that
> call manages to assign more resources in some scenario, the problem
> should be fixed inside pci_resize_resource() instead.
>=20
> Remove the pci_assign_unassigned_bus_resources() call from
> __resource_resize_store().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109131011.1815=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

