Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955903;
	b=sBwWSwoPTyKDHGWNnVjW02UPV1LgzrzWRtEu7QKQ/+3lQI1E9qgAGyqzHiJe/rBPXtWs
	 K4qR2sdP/nvAx8Rr0gH6pDbDbJ3n2qifnY3ME/oE0V1soPkJaGn9y+C+R8DNmH5MLXNMA
	 8222H3z/I//k5Y542de6+7Q5zRngmtX4rXFQLqlYK2n5V7Jm1fc9t8CH6AmUZK8Qiz0wy
	 I5X4oqKnloqm5XWA3r+1Z+wtdeI/nyh9h5UUOgQiJ4aLaCY4Rw4oZRM1yWz+NPqm7IPTZ
	 3/ekpP0DtN1rB7Y5OJsfLLoAtb/aiNarm909Ckz5md/dRhiObxbWj8ctfeORA8qUoCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955903;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gMrasD3QWlDJaLVL+bUl3nX7Bkhs/DCxxeqO18RDDWQ=;
	b=JO1CZyYfZrxp9wtprWIq81HZOX/NNLKXvg2LIOJouZORhRec1fJIZln+JIr5bdcGJOF3
	 Nskrg5ZGtOKVqpl563E9PMr8PmDZaNKEEznNbTzgJJkNu2lN74kt7nEHzaKcLVGP7Z043
	 cK9Hs+KH2sNJPA6LeDiqpimjOH1XxMUXxwUtEB0dhfiMyTwreYyVMqm1osGAPt0/QT7J1
	 3n/6QZqTeNccuOlxHrpC+NGZASuzks7n/1IzFmBqwL4Ay6n4h+0K3m2ODj+wEXbuqFsV8
	 EK2OkZfVz4x8lS8ZzPK7q1eKtT/QfTJrJZTEP483kwizWAmVYhQqFw0yaSNUmlvldWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0qfa7pS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA2606A329
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0qfa7pS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66071F008A7;
	Fri,  6 Nov 2026 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955903;
	bh=gMrasD3QWlDJaLVL+bUl3nX7Bkhs/DCxxeqO18RDDWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g0qfa7pS9mSfTi/MAxwmNQU42lakW3ViHFYnO6YNl5pKLlwLQlOjOMPS3pIy1wIdv
	 KdVLYQykQmQJd+Z2iwUNOKG7ulU0OPjvtrLJ9FZ8U3WKwwh3qL56T9IVYzj+IvBEXY
	 0jKK8yiavGIoYvLooQbnvrTWUixq92ZzSlnqzDDEnHevBNLJsLH1zNOTYrINMsIZgH
	 ZUpIYlUm0yFohhDKcrO1tjzN/M4ee28qyEyCq6lbARpOTAWDgEcO6ypMrgkH2oJnbI
	 eeBq6dlNPp9sx3Sbuu+lIrwM/xZ3cqZU6xk0/wDmD7va5VBWHT3wKYcw8lQSZyH0Vd
	 O1BUz3Z079sfQ==
Message-ID: <sashiko-outbox-201098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/DPC: Increase recovery timeout to 60 seconds
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Wml5b3UgV2FuZyAoTGVub3ZvKQ==?= <ziyou.dev@foxmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <tencent_BB887B4DB8D2131AF5026893E0FE567D6D05@qq.com>
References: <20261106082612.1840817-1-ziyou.dev@foxmail.com>
 <tencent_BB887B4DB8D2131AF5026893E0FE567D6D05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:05:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: orphaned PCIE_RESET_READY_POLL_MS comment left in
  drivers/pci/pci.c
--

commit b65aa35af6ea60927f9e516408b33a731c59921c
Author: Ziyou Wang (Lenovo) <ziyou.dev@foxmail.com>

PCI/DPC: Increase recovery timeout to 60 seconds

This commit moves PCIE_RESET_READY_POLL_MS from drivers/pci/pci.c to
drivers/pci/pci.h and uses it as the DPC recovery timeout in
pci_dpc_recovered().

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d6590805faeb2..dae2e74e64777 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -82,7 +82,6 @@ struct pci_pme_device {
>   * limit, but 60 sec ought to be enough for any device to become
>   * responsive.
>   */
> -#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
> =20
>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {

[Severity: Low]
This isn't a bug, but moving PCIE_RESET_READY_POLL_MS to drivers/pci/pci.h
leaves its original comment block orphaned above pci_dev_d3_sleep().  Should
the comment be removed here as well since it was copied to drivers/pci/pci.=
h?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_BB887B4DB8D=
2131AF5026893E0FE567D6D05@qq.com?part=3D1
