Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD503A4523;
	Mon, 22 Jun 2026 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143929; cv=none; b=VIMxG/CmOnAjOE5+67uecKlSKXDk4/F0j5fj/pgF9eA201Fo0TkLN2BqJS3DMQ1QhPJNcbcbx73jsaLc2oRNmfs4aQZSxFcdfDjjkFq3FrWPhjmd4K1VeqNodtPvl3gMWjXbgLM349fpvQ3Wv4Uqvpo+R21ti2SLYD2urb8turk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143929; c=relaxed/simple;
	bh=hyK7VI9ek/Q0KoB72o8ShPpFmRCgmSf3BFH7etHp8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFrt+7ptNNbvR6+urwhVtIUCYJEeRXNRIjxQu2bMUsLY/AyM/TCY4vZmOSFim4l/G6S48xC7SEJhhvs1s/WNupTSZc6AGTxIBz3wYxgSdIcwrJoAbNfXMC5AIofxdPtbVJHguRLQY4V4xPy5T6FDc4swaujm0rzgqOmmn8/Ip7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOArqTVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOArqTVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169121F000E9;
	Mon, 22 Jun 2026 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143928;
	bh=UkLwf4/QyP1Yi6wvnPkjGleUk0Fd5AHHFeNFSuwbkvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOArqTVY8dxdyrbj8R264+4IzWm9EqpHZ+kDQNK4SSKP/LvTJwRcQUrBrV3idAEom
	 dGUfDxuabwKyRZ7l5YqeNoH22AnMS1VYRNLAudVVo7aq+cg8dm6uGFpob4lcdx7VE1
	 Ev/c0EnaFKPa/rmXkHgq+o+k2scb+vXRwl+6ZeV73/OPVjkS+Hisfn5nhUdWBYUnok
	 munwLR3PVvTuHxUzxsuN3XkATfUJ7EPBVrRuXte+dLDNVJKv/3qzjOpWfV1cC08aBN
	 ofzCWNqIGVa33s+RPwHTwOwDZD1M0l0jj9H8X0s04UkLe8DSLi80nn9nYZXJCwNtKQ
	 Z4eUUz62/qSpg==
Date: Mon, 22 Jun 2026 17:58:38 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: pnv_php: Use common error handling code in
 pnv_php_alloc_slot()
Message-ID: <tlemzejir3wi3rff2x65bbqqknzel4nwy3fnlvruyg7fll4p44@zqrf3z2cxhuu>
References: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>

On Thu, Jun 11, 2026 at 11:25:12AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 11 Jun 2026 11:16:49 +0200
> 
> Use an additional label so that a bit of exception handling can be better
> reused at the end of an if branch.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pci/hotplug/pnv_php.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index ff92a5c301b8..e448f1802002 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -791,16 +791,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
>  		return NULL;
>  
>  	php_slot->name = kstrdup(label, GFP_KERNEL);
> -	if (!php_slot->name) {
> -		kfree(php_slot);
> -		return NULL;
> -	}
> +	if (!php_slot->name)
> +		goto free_php_slot;
>  
>  	/* Allocate workqueue for this slot's interrupt handling */
>  	php_slot->wq = alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->name);
>  	if (!php_slot->wq) {
>  		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
>  		kfree(php_slot->name);
> +free_php_slot:

Really? What kind of coding practice is this?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
