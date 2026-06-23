Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43332FE56F;
	Tue, 23 Jun 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232297; cv=none; b=k1LrgLONJGU1YwAIVVSjrKZ880w7kK8wq1B/ZHF1Ws8poO+jVMYhrK7yvfBuH7JH22RoVuLEBZT60oKQF49gHEwLVWKS+FjgOVZEj8RwTBEJxHAL0jvs4kVi7OKyrRhm7JWY+AJbvEmKtIUCEyzx1gqR2wsWyyrBYLRm4JUpMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232297; c=relaxed/simple;
	bh=VlgUc80un1XQ/6YKqaqYosKOUN5356Fe04gal/+WyEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gJSAVMfkt9s4nLp0nDyrgtZfOCntuo/pOwkthLmIfFUmV1yn3Pf29gYabn7rRZJbCX9OF3HT4s4wqFUFSCHk/+5p7V/xmvq6vodOrAK3oqBJ2GKTquOykicETCqjTgAqEL9l1hWPw2SktVYu3ze2eBmJFsjTyRAsrFD85a4QaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZvp6gca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZvp6gca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7621F000E9;
	Tue, 23 Jun 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782232295;
	bh=+gl2YP9DMrs4ERLIfu+0S4LkjE4WZh85GltKXGn3Lwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XZvp6gcaEqh3iFSYf3xfCJI0OVDAFQo1Dy6e18VCI8aIa6B3Tm28nT9nlPGUbnrSp
	 rFP7oUr1pgNjrx9/6BVUeXEH4ugXU0teBbuKcJRMQN6940iTr+rxXoYcee5/NWB0Br
	 XJZde5vKvFkBjZ/CgbZSnquCNiVEURThPcCHpB2gpP/kMXrzysMt5Vire+bKu6HpCs
	 M1TsOBd5nzFpSUbwoOA9i3wUTWGYnfGNn178nVeAHG2tYi8nP01tach0Xx3khnSc8h
	 Sjta60t1i8z/Sn1z/EF3jODrUORyoGRCRB6vg1gqswyxhsjcRjWK3QaOmdO2TlQjXe
	 H8PiSbzs8Kh8w==
Date: Tue, 23 Jun 2026 11:31:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v4 12/12] NTB: epf: Implement db_vector_count/mask for
 doorbells
Message-ID: <20260623163134.GA813775@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-13-den@valinux.co.jp>

On Wed, May 13, 2026 at 11:49:23AM +0900, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can
> map doorbell events to per-vector work.
> 
> Report vectors as 0..(db_count - 2) (skipping the unused slot) and return
> BIT_ULL(db_vector) for the corresponding doorbell bit. Use
> ntb_epf_db_vector_count() for bounds checks in ntb_epf_db_vector_mask(), so
> the same lower-bound guard is applied before building the bitmask.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v3:
>   - Reuse ntb_epf_db_vector_count() from ntb_epf_db_vector_mask() for bounds.
>   - Return 0 when db_count is below NTB_EPF_MIN_DB_COUNT.
>   - Drop Reviewed-by tags due to the changes.
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 10618e462229..af5755472842 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -434,6 +434,36 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->db_valid_mask;
>  }
>  
> +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +	unsigned int db_count = ndev->db_count;
> +
> +	/*
> +	 * db_count includes an extra skipped slot due to the legacy
> +	 * doorbell layout. Expose only the real doorbell vectors.
> +	 */
> +	if (db_count < NTB_EPF_MIN_DB_COUNT)
> +		return 0;
> +
> +	return db_count - 1;
> +}
> +
> +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	int nr_vec;
> +
> +	/*
> +	 * db_count includes one skipped slot in the legacy layout. Valid
> +	 * doorbell vectors are therefore [0 .. (db_count - 2)].
> +	 */
> +	nr_vec = ntb_epf_db_vector_count(ntb);
> +	if (db_vector < 0 || db_vector >= nr_vec)
> +		return 0;
> +
> +	return BIT_ULL(db_vector);

This all ends up looking slightly different from pci-epf-vntb.c, and
it's not obvious whether the differences are essential or superfluous.

pci-epf-vntb.c:

  enum EPF_IRQ_DB_START                           # value 2
  #define MIN_DB_COUNT  (EPF_IRQ_DB_START + 1)    # value 3

  vntb_epf_db_vector_count() comment says "db_count is total number of
  doorbell slots exposed to peer, including reserved ones".  But it
  returns "db_count - EPF_IRQ_DB_START", which suggests that the
  reserves slots are not exposed?

  vntb_epf_db_vector_count() comment lists two reserved slots

  vntb_epf_db_vector_count() returns "db_count - EPF_IRQ_DB_START"

  vntb_epf_db_vector_mask() comment mentions "two reserved slots"

ntb_hw_epf.c:

  enum EPF_IRQ_DB_START                # value 2
  #define NTB_EPF_MIN_DB_COUNT  3      # value 3, not based on EPF_IRQ_DB_START

  ntb_epf_db_vector_count() comment says "expose only real doorbell
  vectors".  I guess this *excludes* the reserved ones?

  ntb_epf_db_vector_count() comment mentions "an extra skipped slot"
  but apparently actually accounts for *two* slots
  (NTB_EPF_MIN_DB_COUNT==3)

  ntb_epf_db_vector_count() returns "db_count - 1"   # should it be -2?

  ntb_epf_db_vector_mask() comment mentions "one skipped slot"

I don't want to change anything during the v7.2 merge window, but if
there are any actual bugs here, they could be fixed after v7.2-rc1.
If there are no bugs but this could be clarified to reduce confusion,
we could do that for v7.3.
