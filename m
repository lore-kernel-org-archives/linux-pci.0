Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1D2264C7;
	Sun,  2 Aug 2026 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641728; cv=none; b=PXnLpCSfkr9X+D1ZfFTjxkxEOJhqW4QK6TJ+w/32gSEE0e5HjnSEKZoS3A2h+WWxvwb5sELjw8yo2PCQuFrpjjmnIsvZl7ynaoAS7gvkj6khKmWSxM6RAlf2Oe/lb7fonNuuxjw/6JV3bn7tvS+q+gYYCRUyoO8mWwF13iSzPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641728; c=relaxed/simple;
	bh=e2Ih7/pLbIQa1dZnAmhodAgPWbgowpTJcib0y3Z9m0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEjWwDJIY5nQjryXj2zWyNS7Pz9AatO05ULJFT6JPKNQd08FtCxOTzTDyX3+FfbiHIXWS2P14chgLVZzFj959DZsaaBhujXglV/PxZE3Jt4RUHKOQgtTWOZwxAh8lM8vNbw7dK/9fOC394mX70OT/4AM06imIGp/kMXC7p8zvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rubFXbbu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=USfeQc3o; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rubFXbbu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="USfeQc3o"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCQRv0bWRz8v0l;
	Sun, 02 Aug 2026 05:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785641723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVPeKhaHWKeMLtse7Q5iobdF9p3FH5JM+sg86VV22fM=;
	b=rubFXbbulXs0seI5f5oy2kYBvHVM13YDVZDRyY5LPQZax3jSN3kPEyw/1wF1kwP0X1ROMG
	9KdBIu9ALUoLorhPLjZWksswPsW6+AivPot9xW5XzCkLwWORbwN5F4WpnlviSQmN7xoJ8G
	1oYxEDwZclRyTsBRsf1q5bxEr3WbKtIF1/3ZOXnfYx3tWXGS3i/hYBCoEdA7ZI199Lgbys
	ZDVM23hrPKSiLHn0Nr4Rh94RZ0D0DUdh2TIBX4rr3EIJduatAP/PoSH4BOfhc/m+K1oZSQ
	yZ0MhRp7l7HBaNfcBtrED4ZfhMwgvgZWPp7G7JoEu9CzRqOndnmLV6jR6TV1lQ==
Message-ID: <5caff653-3681-4025-9be0-946778d33f8e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785641721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVPeKhaHWKeMLtse7Q5iobdF9p3FH5JM+sg86VV22fM=;
	b=USfeQc3oj4IbfmamuGW1sbZaK6z1gRzvh3gWyNZN0WXZ/BAhBwRm6U56RKns6jJoKLY9Hy
	gotEyfAg4+WFDo0z1BEUxENhkTvg6V3aIt/AqUq0eN2z2qoILyPYtWMseagAQdCECkBcOY
	jYhkqP2XIe7+xRei1ExKlRmFGIn9i/NXyMhax4N+8z8jLH6nMolTcjC7AX3l05zHgxMT0k
	N1kD6SMdrWuUFffW7nHeFV3ULS9dK0+jD4reyfHIcsS23gWU6bC1qp/osDhfmABTvk2vIS
	UF2MzjPK6l9V5J3Syr+2vamsPeVZCUFl/n1unjGAF6e+TVazahG148sTDc7Ymg==
Date: Sun, 2 Aug 2026 04:20:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] PCI: rcar: Release temporary device tree node
 reference
To: Yuho Choi <dbgh9129@gmail.com>, marek.vasut+renesas@mailbox.org,
 yoshihiro.shimoda.uh@renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
 geert+renesas@glider.be, magnus.damm@gmail.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260801233841.469826-1-dbgh9129@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260801233841.469826-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: s3nfjg4dd1z3jhk9ozg8rg9p6r1mpky1
X-MBO-RS-ID: ade40aeb752d7899818

On 8/2/26 1:38 AM, Yuho Choi wrote:
> of_find_matching_node() returns a referenced node even when it is used
> only as a boolean test. Keep the result in a scoped cleanup variable
> so the reference is released after the match check.
> 
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>   drivers/pci/controller/pcie-rcar-host.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index cd9171eebc28..7ed1bc0732ce 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -1122,7 +1122,10 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
>   
>   static int __init rcar_pcie_init(void)
>   {
> -	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> +	struct device_node *np __free(device_node) =
> +		of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
> +
> +	if (np) {
>   #ifdef CONFIG_ARM_LPAE
>   		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>   				"asynchronous external abort");

How about this simpler version:

"
diff --git a/drivers/pci/controller/pcie-rcar-host.c 
b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa58..a4a42e435947f 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -1123,7 +1123,9 @@ static const struct of_device_id 
rcar_pcie_abort_handler_of_match[] __initconst

  static int __init rcar_pcie_init(void)
  {
-       if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
+       struct device_node *np = of_find_matching_node(NULL, 
rcar_pcie_abort_handler_of_match);
+       if (np) {
+               of_node_put(np);
  #ifdef CONFIG_ARM_LPAE
                 hook_fault_code(17, rcar_pcie_aarch32_abort_handler, 
SIGBUS, 0,
                                 "asynchronous external abort");
"

Also, and this is more of a question for DT maintainers, would it make 
sense to introduce of_find_matching_node_and_match() variant called e.g. 
of_test_matching_node_exists() which would return boolean and would NOT 
call of_node_get() on the matched node in the first place, and then use 
it here ?
