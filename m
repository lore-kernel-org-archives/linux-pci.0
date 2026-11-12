Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451198;
	b=4UTaDbQQyFNk0C75lWCdMUbfjKBrCYFcm/4nvo1c710XWPVY774j2oGnB3Jw8EwLN8+6
	 4nQStwvm+RpmICrIR1iBdeBp7vT6aah134GJi9SkRWlym5wZVW4NJzBH1Wv+2eGaOVsyt
	 GssoHQFpbLXI3oSxOzjx2uZizR72AgdBm1jWEDD8grXeW/FRH9fVvq36NoXcp59fk8+7R
	 qDGtX4ldYPAD1KPc4q6Pex1ZCDxxShwQmiSYpmqG3v0XIH6Lv7znf9z7O6R1C156eVliz
	 ZXJSYJjtciEb6nop3S9cFjFJ7uD0/DVmztN42KhuZTenEs1i8DpoZKFzk/eN2LhgMSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451198;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RK4bEwQrHPG0m48W79BxWmrKFoNEpmeSjwkpwePfQyo=;
	b=V75dDURWyKUcyeJvWVTBpf0/0yLC1Mf6ZuSTdujTBS8Rxe+2EDjskb7jo21M4LWvZloH
	 jArHoxs/kbb4O7h55cZJZ5fSbI7iaMuvLV6lraaD2uSLmaa+z5pL5QYWzIBh3Ux+FPWDK
	 FCzpSmn6i3RHwzeT3TnQTv2MPdyR1SzVMmTEwVukXrRNNb2N6YIA6vrxsOWwO0bwvFwae
	 a78lDu9gkCvoa0ZwNVwQ+DFgTrhX6el1lT6rkBk5+oI3tD0N2HSbSgbBs6yF8dF6gIx3G
	 JI0VU0RnvITajKGS85aGtKptqX0SiTaFjsNBk7KJJxxzLf/NFsuD0QDHyIiCsPGHBlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z40IR0Hr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48680606A31C;
	Thu, 12 Nov 2026 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z40IR0Hr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715711F00A0A;
	Thu, 12 Nov 2026 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451198;
	bh=RK4bEwQrHPG0m48W79BxWmrKFoNEpmeSjwkpwePfQyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z40IR0HrewToDIjR1nvLv5q/raoqrLKgeZMexbyGp/FwhhGqnsQPZatv5a/eEDr8v
	 +IQQ2en8X3C500qt9zU8Jy5je5bg+NQsfZwsRIILJEhRrsLizGRAW/0HdAooktxOIY
	 SuKGMu1xWS/CbXcZw+u0vO75W8Y8qKu4kRtSChop7OA/lDm36VOCGTtU04urzuUB9L
	 jEQrMqs1pPDPumF4uZRbM6HzE6rbqbuvzSVqqwPZD5rJX5oN078JK5z6s3eePKxZMV
	 jsOFQ9RpXkao9K519ogdK1yRROjS0oXkJBfrpsTGJaj75vSbh8iWwpMPozoM2uNFPL
	 LEVDLWV/hLvqw==
Date: Thu, 12 Nov 2026 02:39:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: bhelgaas@google.com, lukas@wunner.de, bvanassche@acm.org,
 linux-pci@vger.kernel.org, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 jgg@nvidia.com, akpm@linux-foundation.org, gary@garyguo.net,
 a.hindborg@kernel.org, wilfred.mallawa@wdc.com, tmgross@umich.edu,
 ojeda@kernel.org, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 alex.gaynor@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 01/25] virt: coco: change tsm_register() to use a
 const struct
Message-ID: <20261112023948.75462a02@jic23-hlaptop>
In-Reply-To: <20261110041832.1730924-2-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
	<20261110041832.1730924-2-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 14:18:08 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The tsm_register() function takes a struct pci_tsm_ops *ops argument.
> This eventually is stored in struct tsm_dev as a const, so we should
> just change the tsm_register() register function argument to be a const.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
An ops structure that is just function pointers definitely wants to
be const (and it would be a less than ideal design if it mixed
other things with those function pointers!).

Makes sense as a stand alone change.  Maybe one that can be picked
up sooner than the rest?   

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>  drivers/crypto/ccp/sev-dev-tsm.c | 2 +-
>  drivers/virt/coco/tsm-core.c     | 4 ++--
>  include/linux/tsm.h              | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
> index 46f2539d2d5ab..48df8c579c74d 100644
> --- a/drivers/crypto/ccp/sev-dev-tsm.c
> +++ b/drivers/crypto/ccp/sev-dev-tsm.c
> @@ -339,7 +339,7 @@ static void dsm_disconnect(struct pci_dev *pdev)
>  	streams_teardown(dev_data->ide);
>  }
>  
> -static struct pci_tsm_ops sev_tsm_ops = {
> +static const struct pci_tsm_ops sev_tsm_ops = {
>  	.probe = dsm_probe,
>  	.remove = dsm_remove,
>  	.connect = dsm_connect,
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index e784993353d8f..6b735ac2a814e 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -57,7 +57,7 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>  }
>  
>  static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> -						 struct pci_tsm_ops *pci_ops)
> +						 const struct pci_tsm_ops *pci_ops)
>  {
>  	int rc;
>  
> @@ -78,7 +78,7 @@ static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>  	return tsm_dev;
>  }
>  
> -struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
> +struct tsm_dev *tsm_register(struct device *parent, const struct pci_tsm_ops *pci_ops)
>  {
>  	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
>  	struct device *dev;
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 381c53244c835..6ac12de8c4d36 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -120,7 +120,7 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>  
>  int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>  int tsm_report_unregister(const struct tsm_report_ops *ops);
> -struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
> +struct tsm_dev *tsm_register(struct device *parent, const struct pci_tsm_ops *ops);
>  void tsm_unregister(struct tsm_dev *tsm_dev);
>  struct tsm_dev *find_tsm_dev(int id);
>  #endif /* __TSM_H */

