Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487464;
	b=WSSxSTIj7WOsY86Ej/LLgZSqNnyh43aNvqk2bc7ojQYwiQNihVsBfE+Lnl6VgMJBO2Aa
	 vn1tWbg8Ojie/59xIbKKbLb+4/uPFyeVEn2eOEjAVaPZsiN8b/aP8YufMNRFLNcrHwZxz
	 ccAtGxkj5oDHVG8wUJ1EzSeGPsvp0PGR8MjAS3syZGhUjJ8I0iUxXNnR2m05r5xnN6fml
	 hvHBqqdyx25KpdBkRD0xXS6IRVtndXlIpTzLSZoqpgxl9GNypJY5qJ63xBkHIOBXv9Srp
	 FeuHD0Tte/1URID/nZqNH2vV9CxbQZWwlMXfXYnYtH7ozG9laDsyaDO7DDNtrmcZvDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487464;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wDZ2KjJtRoYfQnBwEa+Mae6SxtBKX/Ns4UZQjUw46Vk=;
	b=gJ1tF+TvXac4Iji84V2K33JKhgsRIRK7HJ3NPDZgPeNeDd6+3fBmxyWEZWBcGaIeYiS5
	 rXu9q0QmPFSEYDHmrfaTd/b8xEkYDMB9NEES6NMfgZXdb4BP6WYl7OfhGS6Z8L3INsRVP
	 Ejc15dq30Ud3ZCtW8GnZBHWAga/kKCuJ+x/Qqm9XT91NkpBqomq/2+IaGMy+l6mG0shhY
	 ep2RvBf2y75KydVUaeyAQE8gnfIT2wvXKjQEIUDsi+SZMVYtcuy31YS+nIXprIfnTBkop
	 cHnsd/J9PTQ67/JD04mPdGNY8NfKATLe+q7a2UdwgO44PLs7j+yKpqL0ZXW0yKOH6Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBo4bYt+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B59606A31A;
	Tue, 20 Oct 2026 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBo4bYt+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6931F000C4;
	Tue, 20 Oct 2026 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487464;
	bh=wDZ2KjJtRoYfQnBwEa+Mae6SxtBKX/Ns4UZQjUw46Vk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eBo4bYt+nkm0nO5B5NomU+fDUCxptr0IeA3pwdQrXKxHq0o0T3/JIbQWDlT+zRRZ4
	 eaTpuYYtvdfSQPv9tTw5lrdNcI0pfRPSmIwf84cJ/xu8m94/9OR7+D54tHj4rqcpkl
	 +zNruDuTTBCCIqZMUGY7IJ3IAEKpO1shnPUp0ipn0u9E6YbXXzPdraBG7Dr8sjOdo9
	 Czkjyvkoxn2R49PA38iVXww5dnRbvHLE83G3rB6S1NKSo6z1sfZl8YpCrnQbK5JPvV
	 fI1H0ntsd6J4PpfShyDWL/hOuXYOpJ8YbO92jtXOTyhd4+q4PId6a5+bCSEv+wM6/Q
	 DAEMt6USEb3ig==
Message-ID: <7f7c4992-14b1-4cc4-ae6b-8e110be20177@kernel.org>
Date: Tue, 20 Oct 2026 12:10:58 +0300
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/14] PCI: rzg3s-host: Use cached MSI address in
 .irq_compose_msi_msg()
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-8-claudiu.beznea@kernel.org>
 <CA+V-a8sQe-bb7AEagc8QzQYVVY27+aVF2v=x1SxNtXQagpSOUw@mail.gmail.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <CA+V-a8sQe-bb7AEagc8QzQYVVY27+aVF2v=x1SxNtXQagpSOUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Prabhakar,

On 10/20/26 11:45, Lad, Prabhakar wrote:
> Hi Claudiu,
> 
> Thank you for the patch.
> 
> On Mon, Oct 19, 2026 at 7:57 AM Claudiu Beznea
> <claudiu.beznea@kernel.org> wrote:
>> From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>>
>> The MSI window address is already cached in msi->window_base when the
>> MSI window is configured. Use it to fill msg->address_lo and
>> msg->address_hi in .irq_compose_msi_msg() instead of reading it back
>> from the controller registers.
>>
>> This avoids unnecessary register accesses.
>>
>> Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v7:
>> - none, this patch is new
>>
>>   drivers/pci/controller/pcie-rzg3s-host.c | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
>> index b0a150262959..6acb0231a067 100644
>> --- a/drivers/pci/controller/pcie-rzg3s-host.c
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>> @@ -660,19 +660,9 @@ static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
>>                                             struct msi_msg *msg)
>>   {
>>          struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
>> -       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>> -       u32 lo, hi;
>> -
>> -       /*
>> -        * Enable and msg data enable bits are part of the address lo. Drop
>> -        * them along with the unused bit.
>> -        */
>> -       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
>> -            RZG3S_PCI_MSIRCVWADRL_MASK;
> We need to drop RZG3S_PCI_MSIRCVWADRL_MASK macro, as this now triggers
> the below warning:
> 
> drivers/pci/controller/pcie-rzg3s-host.c:66:9: warning: macro
> ‘RZG3S_PCI_MSIRCVWADRL_MASK’ is not used [-Wunused-macros]
>     66 | #define RZG3S_PCI_MSIRCVWADRL_MASK              GENMASK(31, 3)

Will update it in the next version.

Thank you for your review,
Claudiu
