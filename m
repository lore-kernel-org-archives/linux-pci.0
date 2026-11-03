Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700713;
	b=ijCbAnAl21hHveVo9Rwue5HZFWRe6bmo3VeHxH0n2t3QwfzqkK6iA4m9YZqazQgNuTJ/
	 oe9vWqRueE5UJg50yvE+bpFd4hnMlHKwcNqIA1cDTLtXmBtoeyhDV1KrwTxs9hw5bxIhE
	 plcU3Vc/Cv5dVBoDivMUk5rEnResDKrT9DNtE0j6DdEZ72GfiYiKDFrwH1tXOekJ0bc8K
	 BE5ExtAJyFBx0wiuRc5Idv4pZojxQnByErbf3/ztDt6gSLn14mXc0Tvi1j77YC8+iCnyu
	 mE52oJwPD64iuTVnwgiEuMjFHrnh63lC05z7qYi8dLIGMS292VTjsCObV5TwWwm0E2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rArQ1cwBog4g64Ja1ckqjvAp5P2uoxV3lgWKSHh/+rk=;
	b=tjUTh4t45oIGiTFuzMEGLDp8LB+jxicxFZPPR0tkfhcWdgAYohNMPN2rIdJMRLlay/Lk
	 lDykwaGWNnheuz2t4JeZx2i4Gw+GUQ3ZjIIlLnrSuTUCgEt3+nr8pFexttbDV+7/UugKK
	 IskdpjxC+RWknwt9acVV/RW9aowPgmxORmSUpEqbCzYBrldru1meXUcWz/MbrV4c2AJOc
	 ylODjkCNvvo6dT3w4cK12oULO/vlzpUaClJVWuo9CfyhC/SsFRs7t/P7JDj40VN6hK9Cj
	 7GAKwy9mvKHk4+SYCHYYzpGhxeQF9bfege44KV7aQ95639eDq6a6tWQzE/hRJVrxUhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtLvbZ+h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12123606A32F
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtLvbZ+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A095D1F00A02;
	Tue,  3 Nov 2026 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700712;
	bh=rArQ1cwBog4g64Ja1ckqjvAp5P2uoxV3lgWKSHh/+rk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jtLvbZ+hT42hJvsfuAn5Mep8qVxc0S2Nk04oiam2C5H4G71fvJaJL5QeQXcIJOpcS
	 8LBYzO0t+x/qurnvC7j77xd4CSEY2AafqrGMBzx2YHZComhmFaEKbrHWHcfFf+4AJr
	 L2V/7CgSGy6xaLKqbbMX+OKq+Q9ES+690uKYanT35SJdHYxfAZFH8PaO+IOMAgmAYe
	 AaRtTTyZJHcSu59BNMFWcNmn5D0zn+rkvVamoOjVSZqvo+4OaKPt3DiGX+QbVA4WXd
	 jxbEuTY1njTnRBRPLdgw/Ublqk5SBgP6qiGoq9STGXuawT9/1xcX7Z/pvjCnqqZYpo
	 Usxj+tqlaQTjQ==
Message-ID: <sashiko-outbox-195012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <27a3876874161204e7a37ab63e7b27ee9783261f.1793697480.git.lukas@wunner.de>
References: <cover.1793697480.git.lukas@wunner.de>
 <27a3876874161204e7a37ab63e7b27ee9783261f.1793697480.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:11:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI/AER: false Root Port match in is_error_source() skips downstre=
am search
--

commit 4a4627301e6c414f9fd5fc732ea651b5b76f3b16
Author: Lukas Wunner <lukas@wunner.de>

PCI/AER: Check validity of Error Source ID register

This commit replaces the bus-zero heuristic for detecting invalid AER Error
Source IDs with a check against the Root Port's subordinate bus range or an
RCEC's associated buses and devices, and logs when an invalid source ID is
detected.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d492c7ce01e15..9957c36bf215f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

[ ... ]

> @@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e=
_info, struct pci_dev *dev)
>  	return 0;
>  }
> =20
> +static bool source_id_valid(struct pci_dev *root, u16 id)
> +{
> +	/* The Root Port or RCEC can itself be a valid Error Source */
> +	if (pci_dev_id(root) =3D=3D id)
> +		return true;
> +
> +	/* For RCECs, @id shall be in range of its associated buses/devices */
> +	if (pci_pcie_type(root) =3D=3D PCI_EXP_TYPE_RC_EC)
> +		return pci_rcec_associated(root, id);
> +
> +	/* For Root Ports, @id shall be in range of its subordinate buses */
> +	if (!root->subordinate)
> +		return false;
> +
> +	return root->subordinate->busn_res.start <=3D PCI_BUS_NUM(id) &&
> +	       root->subordinate->busn_res.end   >=3D PCI_BUS_NUM(id);
> +}
> +
>  /**
>   * is_error_source - check whether the device is source of reported error
>   * @dev: pointer to pci_dev to be checked
> @@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, s=
truct aer_err_info *e_info)
>  	u32 status, mask;
>  	u16 reg16;
> =20
> -	/*
> -	 * When bus ID is equal to 0, it might be a bad ID
> -	 * reported by Root Port.
> -	 */
> -	if ((PCI_BUS_NUM(e_info->id) !=3D 0) &&
> +	/* Some Root Ports report an invalid Error Source ID */
> +	if (e_info->id_valid &&
>  	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
>  		/* Device ID match? */
>  		if (e_info->id =3D=3D pci_dev_id(dev))

[Severity: High]
Can this cause a false positive match on the Root Port itself and skip
searching the subordinate hierarchy when a buggy Root Port reports 0x0000
(or loses the bus number of a downstream error source)?

Previously, in drivers/pci/pcie/aer.c, when find_source_device() checked a
Root Port on bus 0 via find_device_iter() -> is_error_source(), the check
PCI_BUS_NUM(e_info->id) !=3D 0 was false whenever e_info->id was on bus 0.
As a result, is_error_source() never matched the Root Port on bus 0 by ID
alone, and instead fell through to check whether the Root Port actually had
an unmasked error bit set in PCI_ERR_COR_STATUS or PCI_ERR_UNCOR_STATUS.

With this change, aer_isr_one_error_type() sets info->id_valid via
source_id_valid(), which returns true whenever pci_dev_id(root) =3D=3D id. =
On
platforms where the Root Port itself is at 00:00.0 (such as many SoC PCIe
controllers or VMD domains), pci_dev_id(root) is 0x0000. The same condition
also occurs if a Root Port at 00:xx.y loses the bus number of a downstream
endpoint at bus:xx.y (the failure mode described in commit 28eb27cf0839), or
 similarly for an RCEC on bus 0 with slot 0 set in rcec->rcec_ea->bitmap.

When a downstream device signals an error and PCI_ERR_ROOT_ERR_SRC reads as
pci_dev_id(root), source_id_valid() sets info->id_valid =3D 1. Then in
find_source_device():

  find_source_device()
    find_device_iter(root, e_info)
      is_error_source(root, e_info)
        if (e_info->id_valid &&
            !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
                if (e_info->id =3D=3D pci_dev_id(dev))
                        return true;

is_error_source() immediately returns true for the Root Port without
checking its AER status registers, and when e_info->multi_error_valid is 0,
find_source_device() returns early without walking parent->subordinate:

  drivers/pci/pcie/aer.c:find_source_device() {
      ...
      /* Is Root Port an agent that sends error message? */
      result =3D find_device_iter(dev, e_info);
      if (result)
          return true;

      if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_RC_EC)
          pcie_walk_rcec(parent, find_device_iter, e_info);
      else if (parent->subordinate)
          pci_walk_bus(parent->subordinate, find_device_iter, e_info);
  }

Subsequently, aer_process_err_devices() calls aer_get_device_error_info()
on the Root Port, sees !(info->status & ~info->mask), and returns 0, leaving
the downstream device's error unlogged, uncleared, and unrecovered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793697480.gi=
t.lukas@wunner.de?part=3D2
