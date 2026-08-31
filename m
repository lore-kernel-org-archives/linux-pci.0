Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95D3F4831
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182115; cv=none; b=ScQxhNC99zykq2dhC3m/xmcf8sxB5nWIVEV/2wJGU1Um+z31WIPmzItEB/6qbo3rH3t9P6EulsGmA/ZU9AVDDU3RZGtCFvhUEQAOkpmygmcdZDbB+cVtXyTJxJaeUD7nkKNcck59mekTICWFS5mbq7bJswlviiIMZSbg+aPGuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182115; c=relaxed/simple;
	bh=bkvr+H2u9us8I7giOM7CCyoadvK8SRKu6G8pHIEYyMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccOhgJZpjTUpJuzTV+7wWH9tQwMtTIeah/YZdL2Q8+VwWnfirEiwPyH4YT13YqEz4KMzXzBP9qRrzpCw5ef5AFwlUyCelYogbZPp8CF/VTUurPN0+O4sFMEoZmpyt+/OO8R8vgaSYbqmz7BulnfVSxkyb6ORpVwNqigUZCZSEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7cUXc7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7cUXc7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1FF1F000E9;
	Mon, 31 Aug 2026 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182114;
	bh=9jmSOgSGQhGIoC5jCJ4vcz/luJTq1Yl2VDWUOlfQ+gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7cUXc7Y8qN6MzPiH1WIqJg3rnrzYpyN2T7Erk9AwJV8tu7AixtkDjPGXulDbeH3h
	 vKDAVQ1x+cRKxIOIXQa0+TQHcE93Tl5hS7RvXfYbdSd5KUvpx0IQ4iagO04Nsr8QIP
	 sfHn2LVjhbMi4sn6twsHOsH+4K/rKyJ4oLZG+EPZQs7POIfTd3A27nl81QMqF0vsgm
	 /fdqLM/xaeACj9MTfdNg4lpYly7r0a327KQnWOMS5AeoJ4sZ9Tu59m0kSwVVyvuXFM
	 pE6s1G2aBbhscSH0pq2Di+oNRX+fiXUFy7RLpdfSqsBLfvjGwv3rvkV5s5Yu5v/7bS
	 ph3uRTSwx1WUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v2 1/3] wifi: iwlwifi: pcie: don't infer CSME
 presence from a failed read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831130332.323549-2-navonjohnlukose@gmail.com>
References: <20260831130332.323549-1-navonjohnlukose@gmail.com>
 <20260831130332.323549-2-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:15:13 +0000
Message-Id: <20260831131514.3A1FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of `me_recheck_wk` delayed work in the probe =
error path leads to a use-after-free when the timer fires.
--

commit ff64adc37d4f911609320ae5c3255e7d89218807
Author: Navon John Lukose <navonjohnlukose@gmail.com>

wifi: iwlwifi: pcie: don't infer CSME presence from a failed read

This commit modifies iwl_pcie_check_me_status() to avoid inferring CSME
presence from hardware error values on failed reads. It skips evaluating
these bad values so the state can be preserved and rechecked later.

Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")

> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/dri=
vers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> index 28b276c659526..c6a771e899041 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c

[ ... ]

> @@ -4212,15 +4213,19 @@ static void iwl_pcie_check_me_status(struct iwl_t=
rans *trans)
>  		return;
> =20
>  	val =3D iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
> -	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
> +	/* iwl_read_prph() returns 0x5a5a5a5a if it never reached the NIC, and
> +	 * that value has WIAMT_KNOWN set and WIAMT_PRESENT clear
> +	 */
> +	if (val !=3D ~0U && !iwl_trans_is_hw_error_value(val) &&
> +	    (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN)) {
>  		trans_pcie->me_present =3D
>  			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
>  		return;
>  	}
> =20
>  	val =3D iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
> -	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
> -		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
> +	if (val !=3D ~0U && (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
> +				  CSR_HW_IF_CONFIG_REG_IAMT_UP))) {
>  		trans_pcie->me_present =3D 1;
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does this change make a use-after-free
consistently triggerable on a dead NIC?

Since this patch bypasses the early returns for hardware error values,
iwl_pcie_check_me_status() will now fall through and unconditionally schedu=
le
the delayed work:

    schedule_delayed_work(&trans_pcie->me_recheck_wk, HZ);

If the probe subsequently fails (for instance, if iwl_drv_start() fails
against the unresponsive hardware), the probe function goes to the
out_free_trans error path:

iwl_pci_gen1_2_probe() {
    ...
out_free_trans:
    iwl_trans_pcie_free(iwl_trans);
    return ret;
}

But iwl_trans_pcie_free() doesn't appear to call cancel_delayed_work_sync()
for me_recheck_wk before freeing the trans structure.

If the delayed work timer fires a second later, won't it dereference the
freed trans_pcie pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831130332.3235=
49-1-navonjohnlukose@gmail.com?part=3D1
